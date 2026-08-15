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

// SylvaniaCore - Module "Mercenaires"
//
// Le PNJ marchand et les trois hooks qui font vivre - et surtout mourir - le
// contrat : depart du groupe, dissolution du groupe, deconnexion du joueur.
// Aucun fichier du core n est modifie, tout passe par les hooks de ScriptMgr.

#include "Chat.h"
#include "Creature.h"
#include "Group.h"
#include "MercenaryMgr.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"

enum MercenaryGossipAction
{
    GOSSIP_ACTION_CLOSE       = 0,
    GOSSIP_ACTION_SUMMON_TANK = 1,
    GOSSIP_ACTION_SUMMON_HEAL = 2,
    GOSSIP_ACTION_SUMMON_DPS  = 3,
    GOSSIP_ACTION_DISMISS_ALL = 10,
    GOSSIP_ACTION_EXPLAIN     = 11
};

class npc_mercenary_portal : public CreatureScript
{
    public:
        npc_mercenary_portal() : CreatureScript("npc_mercenary_portal") { }

        // La boite de dialogue du client ne peut afficher qu un texte de la base
        // de donnees (npc_text -> broadcast_text, cote DB2). Le boniment du
        // portail passe donc par un chuchotement, qui accepte du texte libre.
        static void WhisperPitch(Creature* creature, Player* player)
        {
            std::ostringstream pitch;
            pitch << "Lance " << sMercenaryMgr->GetCostGold() << " pièces d'or dans le portail et un mercenaire répondra à ton appel. "
                  << "Jusqu'à " << sMercenaryMgr->GetMaxPerPlayer() << ", de quoi former un groupe complet. "
                  << "Mais sache-le : le lien est fragile.";
            creature->Whisper(pitch.str(), LANG_UNIVERSAL, player);
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            ClearGossipMenuFor(player);

            uint32 const cost = sMercenaryMgr->GetCostGold();
            uint32 const hired = sMercenaryMgr->CountContracts(player->GetGUID());
            uint32 const maximum = sMercenaryMgr->GetMaxPerPlayer();

            WhisperPitch(creature, player);

            if (!sMercenaryMgr->IsEnabled())
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Le portail est éteint.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_CLOSE);
                SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                return true;
            }

            if (hired < maximum)
            {
                std::ostringstream tank;
                tank << "Invoquer un protecteur (" << cost << " pièces d'or)";
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, tank.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SUMMON_TANK);

                std::ostringstream healer;
                healer << "Invoquer un guérisseur (" << cost << " pièces d'or)";
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, healer.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SUMMON_HEAL);

                std::ostringstream damage;
                damage << "Invoquer un combattant (" << cost << " pièces d'or)";
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, damage.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_SUMMON_DPS);
            }
            else
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Le portail ne peut plus rien pour vous : votre compagnie est au complet.",
                    GOSSIP_SENDER_MAIN, GOSSIP_ACTION_CLOSE);

            if (hired)
            {
                std::ostringstream dismiss;
                dismiss << "Congédier mes mercenaires (" << hired << "/" << maximum << ")";
                AddGossipItemFor(player, GOSSIP_ICON_TALK, dismiss.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_DISMISS_ALL);
            }

            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Quelles sont les règles de ce pacte ?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_EXPLAIN);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Rien pour l'instant.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_CLOSE);

            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            uint8 role = 0;
            switch (action)
            {
                case GOSSIP_ACTION_SUMMON_TANK: role = ROLE_TANK;   break;
                case GOSSIP_ACTION_SUMMON_HEAL: role = ROLE_HEALER; break;
                case GOSSIP_ACTION_SUMMON_DPS:  role = ROLE_DAMAGE; break;
                case GOSSIP_ACTION_EXPLAIN:
                    CloseGossipMenuFor(player);
                    creature->Whisper("Le mercenaire te suit tant que le lien tient. Quitte le groupe, renvoie-le, ou "
                        "déconnecte-toi, et il retourne au néant sur-le-champ. Chaque nouvelle invocation se paie, sans exception.",
                        LANG_UNIVERSAL, player);
                    return true;
                case GOSSIP_ACTION_DISMISS_ALL:
                    CloseGossipMenuFor(player);
                    sMercenaryMgr->DismissAll(player->GetGUID());
                    ChatHandler(player->GetSession()).PSendSysMessage(
                        "|cff00ff00[Portail]|r Vos mercenaires sont congédiés. Toute nouvelle invocation devra être payée.");
                    return true;
                default:
                    CloseGossipMenuFor(player);
                    return true;
            }

            CloseGossipMenuFor(player);

            MercenaryResult const result = sMercenaryMgr->Summon(player, role);
            if (result != MERC_OK)
            {
                ChatHandler(player->GetSession()).PSendSysMessage("|cffff0000[Portail]|r %s",
                    MercenaryMgr::GetErrorText(result));
                return true;
            }

            ChatHandler(player->GetSession()).PSendSysMessage(
                "|cff00ff00[Portail]|r %u pièces d'or franchissent le voile. Votre %s ne va pas tarder...",
                sMercenaryMgr->GetCostGold(), MercenaryMgr::GetRoleName(role));

            return true;
        }
};

// Depart d un membre : de son plein gre, expulse par le chef, ou parce que le
// core a retire un personnage deconnecte. Les trois cas rompent le contrat.
class mercenary_group_script : public GroupScript
{
    public:
        mercenary_group_script() : GroupScript("mercenary_group_script") { }

        void OnRemoveMember(Group* /*group*/, ObjectGuid guid, RemoveMethod /*method*/, ObjectGuid /*kicker*/, char const* /*reason*/) override
        {
            sMercenaryMgr->OnPlayerLeftGroup(guid);
        }

        void OnDisband(Group* group) override
        {
            sMercenaryMgr->OnGroupDisband(group);
        }
};

// Deconnexion de l employeur : la compagnie entiere se dissout. Le core sait
// deja renvoyer les bots d un groupe sans joueur reel (WorldSession.cpp), mais
// il attend que le groupe soit vide de vrais joueurs ; ici le renvoi est
// immediat et vise nommement les mercenaires de ce joueur.
class mercenary_player_script : public PlayerScript
{
    public:
        mercenary_player_script() : PlayerScript("mercenary_player_script") { }

        void OnLogout(Player* player) override
        {
            sMercenaryMgr->OnPlayerLogout(player);
        }
};

class mercenary_world_script : public WorldScript
{
    public:
        mercenary_world_script() : WorldScript("mercenary_world_script") { }

        void OnConfigLoad(bool /*reload*/) override
        {
            sMercenaryMgr->LoadConfig();
        }

        void OnUpdate(uint32 diff) override
        {
            sMercenaryMgr->Update(diff);
        }
};

void AddSC_npc_mercenary_portal()
{
    new npc_mercenary_portal();
    new mercenary_group_script();
    new mercenary_player_script();
    new mercenary_world_script();
}
