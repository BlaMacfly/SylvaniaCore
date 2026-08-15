/*
 * This file is part of the DestinyCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <map>
#include <mutex>
#include <algorithm>
#include "Config.h"
#include "Chat.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "Player.h"
#include "Pet.h"
#include "TemporarySummon.h"
#include "Map.h"
#include "Group.h"
#include "GroupReference.h"
#include "ObjectAccessor.h"
#include "InstanceScript.h"

namespace {

    // Etat du buff reellement applique a un joueur. On memorise les pourcentages EXACTS
    // passes a HandleStatModifier pour pouvoir les retirer a l'identique, meme si la
    // config a ete rechargee (ou le groupe a change) entre l'application et le retrait.
    struct SolocraftBuff
    {
        float statPct;      // pourcentage TOTAL_PCT sur les stats primaires (400 = x5)
        float weaponPct;    // pourcentage TOTAL_PCT sur les degats d'arme
        float effective;    // multiplicateur effectif, pour l'affichage joueur

        SolocraftBuff() : statPct(0.0f), weaponPct(0.0f), effective(1.0f) { }
    };

    // Accede depuis les threads de map (OnMapChanged) et depuis le thread world
    // (GroupScript) -> les acces au conteneur sont proteges.
    std::mutex _buffMutex;
    std::map<uint64, SolocraftBuff> _buffs;

    bool IsEnabled()
    {
        return sConfigMgr->GetBoolDefault("Solocraft.Enable", false);
    }

    // Difficulte BRUTE de la carte, c'est a dire pour combien de joueurs le contenu est
    // calibre. Relue a chaque appel (evenement peu frequent) : 'reload config' en tmux
    // suffit donc pour tuner l'equilibrage, sans rebuild ni restart.
    float ReadRawDifficulty(Map* map)
    {
        if (!map)
            return 1.0f;

        // Mythique / Mythique+ : contenu reserve au groupe complet, aucun buff par defaut.
        // Solocraft.Mythic = 1.0 desactive, une valeur > 1 l'active (ex: 5.0).
        if (map->IsMythic())
            return sConfigMgr->GetFloatDefault("Solocraft.Mythic", 1.0f);

        if (map->IsRaid())
        {
            switch (map->GetMapDifficulty()->MaxPlayers)
            {
                case 10: return sConfigMgr->GetFloatDefault("Solocraft.Raid10", 10.0f);
                case 25: return sConfigMgr->GetFloatDefault("Solocraft.Raid25", 25.0f);
                case 30: return sConfigMgr->GetFloatDefault("Solocraft.Raid30", 30.0f);
                case 40: return sConfigMgr->GetFloatDefault("Solocraft.Raid40", 40.0f);
                default:
                    TC_LOG_WARN("scripts.solocraft", "[Solocraft] Nombre max de joueurs non reconnu (%d), repli sur Raid10",
                        map->GetMapDifficulty()->MaxPlayers);
                    return sConfigMgr->GetFloatDefault("Solocraft.Raid10", 10.0f);
            }
        }

        if (map->IsDungeon())
        {
            if (map->IsHeroic())
                return sConfigMgr->GetFloatDefault("Solocraft.Heroic", 10.0f);
            return sConfigMgr->GetFloatDefault("Solocraft.Dungeon", 5.0f);
        }

        return 1.0f;
    }

    // Nombre de membres du groupe REELLEMENT presents dans l'instance.
    // Les membres restes en ville ne doivent pas diluer le buff de ceux qui jouent.
    uint32 CountPlayersInInstance(Player* player, Map* map)
    {
        Group* group = player->GetGroup();
        if (!group)
            return 1;

        uint32 count = 0;
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (member && member->IsInWorld() && member->GetMap() == map)
                ++count;
        }

        return std::max<uint32>(count, 1);
    }

    // Cœur du correctif d'equilibrage.
    //
    // L'ancienne version calculait bien la taille du groupe... puis ne s'en servait que
    // dans le message d'annonce. Resultat : un joueur seul et un groupe de 5 recevaient
    // le meme x5 chacun -> le solo ramait, le groupe complet ecrasait tout.
    //
    // effectif = difficulte brute / joueurs presents :
    //   donjon (D=5) en solo   -> x5     (le joueur remplace 5 joueurs)
    //   donjon (D=5) a 5       -> x1     (aucun buff, contenu joue normalement)
    //   raid 25  (D=25) a 10   -> x2.5
    void ComputeMultipliers(float rawDifficulty, uint32 numPlayers, SolocraftBuff& out)
    {
        float effective = rawDifficulty / float(numPlayers);
        if (effective < 1.0f)
            effective = 1.0f;   // jamais de malus si le groupe est plus grand que prevu

        // Deux leviers separes, tous deux reglables a chaud.
        //
        // Solocraft.StatsPct  : part du bonus appliquee aux stats primaires. Elles portent
        //                       les PV (endurance), la puissance des sorts et la puissance
        //                       d'attaque -> a 100 le joueur solo a bien x5 PV et x5 AP.
        //
        // Solocraft.DamagePct : part appliquee aux degats d'arme. Indispensable : les degats
        //                       d'une attaque valent (degats_arme + AP/3.5), et seule la
        //                       moitie "AP" profitait du buff de stats. Le joueur devenait
        //                       une eponge lente -- il encaissait x5 mais tapait a peine
        //                       plus fort, d'ou la sensation de contenu hardcore.
        //                       20 vise un total d'environ x5 degats en solo une fois
        //                       combine au x5 d'AP (double comptage compris).
        const float statsPct  = sConfigMgr->GetFloatDefault("Solocraft.StatsPct", 100.0f);
        const float damagePct = sConfigMgr->GetFloatDefault("Solocraft.DamagePct", 20.0f);

        out.effective = effective;
        out.statPct   = (effective - 1.0f) * statsPct;
        out.weaponPct = (effective - 1.0f) * damagePct;
    }

    // Les familiers derivent leurs PV et leur puissance d'attaque de ceux du maitre
    // (cf. Guardian::UpdateMaxHealth / Guardian::UpdateAttackPowerAndDamage), mais ils ne
    // recalculent pas spontanement quand le maitre est buffe : un pet deja invoque a
    // l'entree en instance restait a x1. Chasseur, demoniste, DK impie et chaman elem
    // perdaient ainsi une grosse part de leurs degats -- d'ou l'ecart ressenti entre classes.
    void RefreshPets(Player* player)
    {
        if (Pet* pet = player->GetPet())
            pet->UpdateAllStats();

        if (Guardian* guardian = player->GetGuardianPet())
            if (guardian != player->GetPet())
                guardian->UpdateAllStats();
    }

    void ApplyModifiers(Player* player, SolocraftBuff const& buff, bool apply)
    {
        for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
            player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, buff.statPct, apply);

        if (buff.weaponPct != 0.0f)
        {
            player->HandleStatModifier(UNIT_MOD_DAMAGE_MAINHAND, TOTAL_PCT, buff.weaponPct, apply);
            player->HandleStatModifier(UNIT_MOD_DAMAGE_OFFHAND,  TOTAL_PCT, buff.weaponPct, apply);
            player->HandleStatModifier(UNIT_MOD_DAMAGE_RANGED,   TOTAL_PCT, buff.weaponPct, apply);
        }

        RefreshPets(player);
    }

    // Retire le buff en cours s'il y en a un. Retourne true si quelque chose a ete retire.
    bool RemoveBuff(Player* player, bool announce)
    {
        SolocraftBuff previous;
        {
            std::lock_guard<std::mutex> lock(_buffMutex);
            std::map<uint64, SolocraftBuff>::iterator itr = _buffs.find(player->GetGUID());
            if (itr == _buffs.end())
                return false;

            previous = itr->second;
            _buffs.erase(itr);
        }

        ApplyModifiers(player, previous, false);

        TC_LOG_DEBUG("scripts.solocraft", "[Solocraft] Retrait joueur=%s statPct=%.1f weaponPct=%.1f maxHP=%u",
            player->GetName().c_str(), previous.statPct, previous.weaponPct, (uint32)player->GetMaxHealth());

        if (announce && sConfigMgr->GetBoolDefault("Solocraft.Announce", false) && player->GetSession())
            ChatHandler(player->GetSession()).PSendSysMessage("|cffFF0000[SoloCraft]|r |cffFF8000Bonus retiré (x%0.2f).|r",
                previous.effective);

        return true;
    }

    // Recalcule et applique le buff correspondant a la situation actuelle du joueur.
    void RefreshBuff(Player* player, bool announce)
    {
        if (!player || !IsEnabled())
            return;

        Map* map = player->GetMap();
        if (!map)
            return;

        float rawDifficulty = ReadRawDifficulty(map);
        uint32 numPlayers   = CountPlayersInInstance(player, map);

        SolocraftBuff buff;
        ComputeMultipliers(rawDifficulty, numPlayers, buff);

        // Rien a faire : pas de buff en cours et aucun a appliquer (cas de l'immense
        // majorite des appels -- monde ouvert, champs de bataille, groupes de bots).
        if (buff.statPct == 0.0f && buff.weaponPct == 0.0f)
        {
            RemoveBuff(player, announce);
            return;
        }

        RemoveBuff(player, false);

        {
            std::lock_guard<std::mutex> lock(_buffMutex);
            _buffs[player->GetGUID()] = buff;
        }

        TC_LOG_DEBUG("scripts.solocraft", "[Solocraft] Application joueur=%s carte=%s brut=%.2f joueurs=%u effectif=%.2f statPct=%.1f weaponPct=%.1f maxHPavant=%u",
            player->GetName().c_str(), map->GetMapName(), rawDifficulty, numPlayers,
            buff.effective, buff.statPct, buff.weaponPct, (uint32)player->GetMaxHealth());

        ApplyModifiers(player, buff, true);

        // Ne jamais soigner a plein en combat : sans ce garde, inviter puis exclure un
        // joueur en plein combat de boss offrirait un heal complet gratuit a repetition.
        if (!player->IsInCombat())
        {
            player->SetFullHealth();
            if (player->GetPowerType() == POWER_MANA)
                player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
        }

        if (announce && sConfigMgr->GetBoolDefault("Solocraft.Announce", false) && player->GetSession())
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "|cffFF0000[SoloCraft]|r |cffFF8000%s - joueurs présents : %u - bonus x%0.2f (dégâts d'arme x%0.2f).|r",
                map->GetMapName(), numPlayers, buff.effective, 1.0f + buff.weaponPct / 100.0f);
        }
    }

    class solocraft_player_instance_handler : public PlayerScript
    {
    public:
        solocraft_player_instance_handler() : PlayerScript("solocraft_player_instance_handler")
        {
            TC_LOG_INFO("scripts.solocraft", "[Solocraft] solocraft_player_instance_handler Loaded");
        }

        void OnMapChanged(Player* player) override
        {
            RefreshBuff(player, true);
        }

        void OnLogout(Player* player) override
        {
            // Les modificateurs de stats (TOTAL_PCT) sont remis a 1.0 a chaque login,
            // mais l'entree du conteneur survivait a la deconnexion. Un retrait ulterieur
            // retrouvait alors une entree fantome et DIVISAIT des stats jamais buffees
            // (perso niveau 1 rabaisse a 20% de ses stats -> 28 PV, cf. bug Selena).
            std::lock_guard<std::mutex> lock(_buffMutex);
            _buffs.erase(player->GetGUID());
        }
    };

    // Sans ce script, rejoindre ou quitter un groupe en pleine instance ne recalculait
    // rien : un joueur entre seul (x5) gardait son bonus solo apres avoir invite quatre
    // amis, et l'inverse -- un joueur reste seul apres le depart du groupe conservait un
    // bonus divise par 5, ce qui rendait le donjon injouable.
    class solocraft_group_handler : public GroupScript
    {
    public:
        solocraft_group_handler() : GroupScript("solocraft_group_handler") { }

        void OnAddMember(Group* group, ObjectGuid guid) override
        {
            RefreshGroup(group, guid);
        }

        void OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod /*method*/, ObjectGuid /*kicker*/, char const* /*reason*/) override
        {
            RefreshGroup(group, guid);
        }

        void OnDisband(Group* group) override
        {
            RefreshGroup(group, ObjectGuid::Empty);
        }

    private:
        static void RefreshGroup(Group* group, ObjectGuid changedMember)
        {
            if (!IsEnabled())
                return;

            if (group)
            {
                for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                {
                    Player* member = itr->GetSource();
                    if (member && member->IsInWorld() && member->GetMap() && member->GetMap()->IsDungeon())
                        RefreshBuff(member, false);
                }
            }

            // Le membre concerne n'est deja (ou pas encore) plus dans la liste : il se
            // retrouve peut-etre seul dans l'instance et doit etre recalcule a part.
            if (!changedMember.IsEmpty())
                if (Player* changed = ObjectAccessor::FindPlayer(changedMember))
                    if (changed->IsInWorld() && changed->GetMap() && changed->GetMap()->IsDungeon())
                        RefreshBuff(changed, false);
        }
    };
}

void AddSC_solocraft()
{
    new solocraft_player_instance_handler();
    new solocraft_group_handler();
}
