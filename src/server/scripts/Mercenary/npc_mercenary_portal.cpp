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
#include "MercenaryChat.h"
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
    GOSSIP_ACTION_EXPLAIN     = 11,

    // Manuel des ordres. Les mercenaires obeissent au systeme de commandes du
    // core (BotGroupAI::ProcessBotCommand) : le portail ne fait que l enseigner.
    GOSSIP_ACTION_ORDERS      = 20,
    GOSSIP_ACTION_ORDERS_MOVE = 21,
    GOSSIP_ACTION_ORDERS_FIGHT= 22,
    GOSSIP_ACTION_ORDERS_WHO  = 23,
    GOSSIP_ACTION_ORDERS_GEAR = 24,
    GOSSIP_ACTION_MAIN        = 25
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

        // Les ordres sont ecrits dans le canal de groupe (chef de groupe
        // uniquement, ChatHandler.cpp) ou chuchotes a un mercenaire precis.
        // Le manuel est envoye en messages systeme : le client les garde dans
        // la fenetre de discussion, contrairement au texte d une boite de
        // dialogue qui disparait avec elle.
        static void SendLines(Player* player, char const* const* lines, size_t count)
        {
            ChatHandler handler(player->GetSession());
            for (size_t i = 0; i < count; ++i)
                handler.PSendSysMessage("%s", lines[i]);
        }

        static void SendOrdersMenu(Player* player, Creature* creature)
        {
            ClearGossipMenuFor(player);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Les faire bouger", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_ORDERS_MOVE);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Les faire combattre", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_ORDERS_FIGHT);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "N'en désigner qu'un seul, ou un rôle", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_ORDERS_WHO);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Leur équipement et leur spécialisation", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_ORDERS_GEAR);
            AddGossipItemFor(player, GOSSIP_ICON_TALK, "Revenir au portail", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_MAIN);
            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
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

            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Comment leur donner des ordres ?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_ORDERS);
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
                case GOSSIP_ACTION_ORDERS:
                    SendOrdersMenu(player, creature);
                    return true;
                case GOSSIP_ACTION_MAIN:
                    return OnGossipHello(player, creature);
                case GOSSIP_ACTION_ORDERS_MOVE:
                {
                    static char const* const lines[] =
                    {
                        "|cff00ff00[Mercenaires - les faire bouger]|r",
                        "Écrivez l'ordre dans le canal de groupe : il s'adresse à toute la compagnie, et il faut en être le chef.",
                        "Pour n'en viser qu'un : |cffffd100/w <nom du mercenaire> <ordre>|r",
                        "  |cffffd100summon|r - il vous rejoint sur-le-champ, où que vous soyez",
                        "  |cffffd100follow|r - il reprend sa marche derrière vous",
                        "  |cffffd100stop|r - il s'arrête et ne bouge plus",
                        "  |cffffd100flee|r - il rompt le combat et se replie"
                    };
                    SendLines(player, lines, sizeof(lines) / sizeof(lines[0]));
                    SendOrdersMenu(player, creature);
                    return true;
                }
                case GOSSIP_ACTION_ORDERS_FIGHT:
                {
                    static char const* const lines[] =
                    {
                        "|cff00ff00[Mercenaires - les faire combattre]|r",
                        "  |cffffd100attack|r - il attaque la cible que vous avez sélectionnée",
                        "  |cffffd100flee|r - il décroche et cesse le combat",
                        "  |cffffd100rite|r - il lance son rituel d'invocation, si sa classe en possède un et que vous êtes à portée",
                        "  |cffffd100<numéro de sort>|r - il lance ce sort précis s'il le connaît : tapez son identifiant",
                        "Sans ordre, un mercenaire se bat de lui-même : il choisit ses cibles, soigne et suit sa spécialisation."
                    };
                    SendLines(player, lines, sizeof(lines) / sizeof(lines[0]));
                    SendOrdersMenu(player, creature);
                    return true;
                }
                case GOSSIP_ACTION_ORDERS_WHO:
                {
                    static char const* const lines[] =
                    {
                        "|cff00ff00[Mercenaires - n'en désigner qu'un, ou un rôle]|r",
                        "Dans le canal de groupe, faites précéder l'ordre d'une cible :",
                        "  par rôle : |cffffd100@tank|r  |cffffd100@heal|r  |cffffd100@dps|r  |cffffd100@melee|r  |cffffd100@ranged|r",
                        "  par classe : |cffffd100@zs|r guerrier, |cffffd100@qs|r paladin, |cffffd100@lr|r chasseur, |cffffd100@dz|r voleur, |cffffd100@ms|r prêtre",
                        "  |cffffd100@dk|r chevalier de la mort, |cffffd100@sm|r chaman, |cffffd100@fs|r mage, |cffffd100@ss|r démoniste, |cffffd100@xd|r druide",
                        "Exemple : |cffffd100@heal stop|r - seuls les guérisseurs s'arrêtent.",
                        "Sans préfixe, l'ordre vaut pour toute la compagnie."
                    };
                    SendLines(player, lines, sizeof(lines) / sizeof(lines[0]));
                    SendOrdersMenu(player, creature);
                    return true;
                }
                case GOSSIP_ACTION_ORDERS_GEAR:
                {
                    static char const* const lines[] =
                    {
                        "|cff00ff00[Mercenaires - équipement et spécialisation]|r",
                        "Collez le lien de l'objet (Maj + clic sur l'objet) à la suite de l'ordre :",
                        "  |cffffd100c|r - il énumère ce qu'il transporte",
                        "  |cffffd100e <objet>|r - il l'équipe",
                        "  |cffffd100ue <objet>|r - il le retire",
                        "  |cffffd100s <objet>|r - il vous le remet",
                        "  |cffffd100u <objet>|r - il l'utilise",
                        "  |cffffd100destroy <objet>|r - il le détruit",
                        "  |cffffd100talent 1|r, |cffffd1002|r ou |cffffd1003|r - il change de spécialisation",
                        "  |cffffd100setting|r - il se remet à votre niveau et se rééquipe",
                        "Ces ordres-là sont refusés tant que le mercenaire est en combat."
                    };
                    SendLines(player, lines, sizeof(lines) / sizeof(lines[0]));
                    SendOrdersMenu(player, creature);
                    return true;
                }
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

            MercenaryResult const result = sMercenaryMgr->Summon(player, role, creature);
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
            sMercenaryChatMgr->LoadConfig();
        }

        // Le fil dedie aux appels d API nait avec le monde et meurt avec lui.
        void OnStartup() override
        {
            sMercenaryChatMgr->Start();
        }

        void OnShutdown() override
        {
            sMercenaryChatMgr->Stop();
        }

        void OnUpdate(uint32 diff) override
        {
            sMercenaryMgr->Update(diff);
            sMercenaryChatMgr->Update(diff);
        }
};

void AddSC_npc_mercenary_portal()
{
    new npc_mercenary_portal();
    new mercenary_group_script();
    new mercenary_player_script();
    new mercenary_world_script();
}
