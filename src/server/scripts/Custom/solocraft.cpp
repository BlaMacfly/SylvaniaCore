/*
 * Solocraft pour ArgusCore — Légion 7.3.5 (La Légion de Sylvania)
 *
 * Portage du module mod-solocraft d'AzerothCore
 * (https://github.com/azerothcore/mod-solocraft), réécrit pour TrinityCore 7.3.5 :
 *
 *  - Pas de sort custom (le système DB2/hotfix de Légion rend l'injection d'un
 *    sort « +X% stats » trop lourde) : les stats principales (Force, Agilité,
 *    Endurance, Intelligence) sont multipliées directement via
 *    Unit::HandleStatModifier(TOTAL_PCT). Sur Légion, PV, dégâts et soins
 *    dérivent de ces stats : le buff couvre donc l'ensemble.
 *  - Couverture générique de TOUT le contenu instancié : l'effectif attendu est
 *    lu dans DifficultyEntry::MaxPlayers (donjons 5, raids 10/25/30, LFR,
 *    mythique...) au lieu de la liste de cartes codée en dur du module d'origine.
 *  - Modificateur d'XP stocké PAR JOUEUR (corrige un bug du module d'origine où
 *    la variable était globale et partagée entre tous les joueurs).
 *  - Pas de débuff : un groupe complet joue exactement comme en Blizzlike.
 *  - Module DÉSACTIVÉ par défaut : Solocraft.Enable = 0 dans worldserver.conf.
 *
 * Limitation connue (v1) : le buff n'est recalculé qu'au changement de carte et
 * à la connexion — pas quand le groupe change pendant que l'on est déjà dans
 * l'instance (même comportement que le module d'origine). Les familiers ne sont
 * pas buffés directement (sur Légion ils héritent en partie des stats du maître).
 */

#include "Chat.h"
#include "Config.h"
#include "DB2Stores.h"
#include "Group.h"
#include "Map.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "ScriptMgr.h"

#include <algorithm>
#include <cstdlib>
#include <set>
#include <sstream>
#include <string>
#include <unordered_map>

namespace Solocraft
{
    bool  Enable       = false;
    bool  Announce     = true;
    bool  XPEnabled    = true;
    bool  XPBalEnabled = true;
    float StatsMult    = 100.0f;
    std::set<uint32> ExcludedMaps;
    std::unordered_map<uint8, uint32> ClassBalance;

    struct PlayerState
    {
        float statPct = 0.0f;   // bonus (%) appliqué aux stats principales
        float xpMod   = 1.0f;   // modificateur d'XP tant que le buff est actif
    };

    std::unordered_map<ObjectGuid, PlayerState> States;

    UnitMods const STAT_MODS[4] =
    {
        UNIT_MOD_STAT_STRENGTH,
        UNIT_MOD_STAT_AGILITY,
        UNIT_MOD_STAT_STAMINA,
        UNIT_MOD_STAT_INTELLECT
    };

    void LoadConfig()
    {
        Enable       = sConfigMgr->GetBoolDefault("Solocraft.Enable", false);
        Announce     = sConfigMgr->GetBoolDefault("Solocraft.Announce", true);
        XPEnabled    = sConfigMgr->GetBoolDefault("Solocraft.XP.Enabled", true);
        XPBalEnabled = sConfigMgr->GetBoolDefault("Solocraft.XPBal.Enabled", true);
        StatsMult    = sConfigMgr->GetFloatDefault("Solocraft.Stats.Mult", 100.0f);

        ClassBalance =
        {
            { 1,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Warrior",     100)) },
            { 2,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Paladin",     100)) },
            { 3,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Hunter",      100)) },
            { 4,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Rogue",       100)) },
            { 5,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Priest",      100)) },
            { 6,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.DeathKnight", 100)) },
            { 7,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Shaman",      100)) },
            { 8,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Mage",        100)) },
            { 9,  uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Warlock",     100)) },
            { 10, uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Monk",        100)) },
            { 11, uint32(sConfigMgr->GetIntDefault("Solocraft.Class.Druid",       100)) },
            { 12, uint32(sConfigMgr->GetIntDefault("Solocraft.Class.DemonHunter", 100)) }
        };

        ExcludedMaps.clear();
        std::istringstream stream(sConfigMgr->GetStringDefault("Solocraft.Instance.Excluded", ""));
        std::string token;
        while (std::getline(stream, token, ','))
            if (!token.empty())
                ExcludedMaps.insert(uint32(strtoul(token.c_str(), nullptr, 10)));
    }

    // Effectif prévu de l'instance pour la difficulté en cours (5, 10, 25, 30...)
    float ExpectedGroupSize(Map* map)
    {
        if (DifficultyEntry const* entry = sDifficultyStore.LookupEntry(uint32(map->GetDifficultyID())))
            if (entry->MaxPlayers)
                return float(entry->MaxPlayers);

        // Repli si l'entrée DB2 est introuvable
        return map->IsRaid() ? 40.0f : 5.0f;
    }

    void RemoveBuff(Player* player)
    {
        auto it = States.find(player->GetGUID());
        if (it == States.end())
            return;

        if (it->second.statPct > 0.0f)
            for (UnitMods mod : STAT_MODS)
                player->HandleStatModifier(mod, TOTAL_PCT, it->second.statPct, false);

        States.erase(it);
    }

    void Recompute(Player* player)
    {
        if (!player)
            return;

        // Toujours retirer l'ancien buff d'abord (sortie d'instance, transfert...)
        RemoveBuff(player);

        if (!Enable)
            return;

        // Donjons et raids uniquement. MapEntry::IsDungeon() inclut les scénarios
        // (MAP_SCENARIO) : on les écarte, ce contenu Légion est conçu pour 1 joueur.
        Map* map = player->GetMap();
        MapEntry const* entry = map ? map->GetEntry() : nullptr;
        if (!entry || !entry->IsDungeon() || entry->InstanceType == MAP_SCENARIO)
            return;

        if (ExcludedMaps.count(map->GetId()))
            return;

        float expected = ExpectedGroupSize(map);

        uint32 numInGroup = 1;
        if (Group* group = player->GetGroup())
            numInGroup = std::max<uint32>(1, group->GetMembersCount());

        uint32 classBal = 100;
        auto cit = ClassBalance.find(player->getClass());
        if (cit != ClassBalance.end() && cit->second <= 100)
            classBal = cit->second;

        // Facteur « ce joueur vaut N joueurs ». Groupe complet => 1.0 => aucun buff.
        float factor = (float(classBal) / 100.0f) * expected / float(numInGroup);
        if (factor <= 1.0f)
            return;

        // Bonus de stats : +(facteur - 1) * 100 %, pondéré par Solocraft.Stats.Mult
        float statPct = (factor - 1.0f) * 100.0f * (StatsMult / 100.0f);

        // Équilibrage d'XP (formule du module d'origine) : plus on est buffé, moins on gagne
        float xpMod = 1.0f;
        if (!XPEnabled)
            xpMod = 0.0f;
        else if (XPBalEnabled)
        {
            xpMod = (1.04f / factor) - 0.02f;
            if (xpMod < 0.0f) xpMod = 0.0f;
            if (xpMod > 1.0f) xpMod = 1.0f;
        }

        PlayerState& state = States[player->GetGUID()];
        state.statPct = statPct;
        state.xpMod = xpMod;

        if (statPct > 0.0f)
        {
            for (UnitMods mod : STAT_MODS)
                player->HandleStatModifier(mod, TOTAL_PCT, statPct, true);
            player->SetFullHealth();
        }

        if (Announce)
            ChatHandler(player->GetSession()).PSendSysMessage(
                "|cffFF8000[Solocraft]|r %s : effectif prévu %u, groupe %u — stats +%.0f%%, XP %.0f%%.",
                map->GetMapName(), uint32(expected), numInGroup, statPct, xpMod * 100.0f);
    }
}

class Solocraft_WorldScript : public WorldScript
{
public:
    Solocraft_WorldScript() : WorldScript("Solocraft_WorldScript") { }

    void OnConfigLoad(bool /*reload*/) override
    {
        Solocraft::LoadConfig();
    }
};

class Solocraft_PlayerScript : public PlayerScript
{
public:
    Solocraft_PlayerScript() : PlayerScript("Solocraft_PlayerScript") { }

    void OnLogin(Player* player, bool /*firstLogin*/) override
    {
        // Pas de Recompute ici : OnMapChanged est déjà déclenché au login
        // (fin de Map::AddPlayerToMap) — un appel de plus dupliquerait l'annonce.
        if (Solocraft::Enable && Solocraft::Announce)
            ChatHandler(player->GetSession()).SendSysMessage("|cffFF8000[Solocraft]|r Module actif : les instances s'adaptent à la taille de votre groupe.");
    }

    void OnLogout(Player* player) override
    {
        // L'objet Player disparaît avec la session : on oublie simplement l'état.
        Solocraft::States.erase(player->GetGUID());
    }

    void OnMapChanged(Player* player) override
    {
        Solocraft::Recompute(player);
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* /*victim*/) override
    {
        if (!Solocraft::Enable)
            return;

        auto it = Solocraft::States.find(player->GetGUID());
        if (it == Solocraft::States.end())
            return;

        // Player::GiveXP teste « xp < 1 » AVANT ce hook puis envoie LogXPGain
        // sans re-tester : rendre 0 afficherait « 0 point d'expérience » à
        // chaque kill. Plancher à 1 (XP.Enabled=0 => 1 XP symbolique par kill).
        amount = std::max<uint32>(1, uint32(amount * it->second.xpMod));
    }
};

void AddSC_solocraft()
{
    new Solocraft_WorldScript();
    new Solocraft_PlayerScript();
}
