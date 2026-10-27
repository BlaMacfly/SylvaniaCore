/*
* Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
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

#include "Chat.h"
#include "Creature.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "World.h"

// Klauss : taux d'expérience et de réputation personnels.
// 0 = taux du royaume (Rate.XP.Quest / Rate.Reputation.Gain), sinon x1 à x7.
class npc_rate_xp_modifier : public CreatureScript
{
    public:
        npc_rate_xp_modifier() : CreatureScript("npc_rate_xp_modifier") { }

// Taux personnel maximum sélectionnable (bride serveur)
#define MAX_RATE uint32(7)

        enum Senders
        {
            SENDER_MENU = GOSSIP_SENDER_MAIN,
            SENDER_XP   = GOSSIP_SENDER_MAIN + 1,
            SENDER_REP  = GOSSIP_SENDER_MAIN + 2
        };

        enum MenuActions
        {
            ACTION_MENU_XP   = 1,
            ACTION_MENU_REP  = 2,
            ACTION_MENU_BACK = 3
        };

        // Sans taux personnel, le core applique RATE_XP_QUEST aux kills
        // comme aux quêtes (Formulas.h / Player.cpp) : c'est LE taux par défaut.
        static float DefaultRate(uint32 sender)
        {
            return sWorld->getRate(sender == SENDER_XP ? RATE_XP_QUEST : RATE_REPUTATION_GAIN);
        }

        static float CurrentRate(Player* player, uint32 sender)
        {
            return sender == SENDER_XP ? player->GetPersonnalXpRate() : player->GetPersonnalRepRate();
        }

        static std::string Describe(Player* player, uint32 sender)
        {
            std::ostringstream text;
            if (float rate = CurrentRate(player, sender))
                text << "x" << rate;
            else
                text << "x" << DefaultRate(sender) << ", par défaut";
            return text.str();
        }

        static void SendMainMenu(Player* player, Creature* creature)
        {
            ClearGossipMenuFor(player);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Taux d'expérience (actuel : " + Describe(player, SENDER_XP) + ")", SENDER_MENU, ACTION_MENU_XP);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Taux de réputation (actuel : " + Describe(player, SENDER_REP) + ")", SENDER_MENU, ACTION_MENU_REP);
            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        }

        static void SendRateMenu(Player* player, Creature* creature, uint32 sender)
        {
            ClearGossipMenuFor(player);

            char const* label = sender == SENDER_XP ? "Taux d'expérience x" : "Taux de réputation x";
            float defaultRate = DefaultRate(sender);

            for (uint32 i = 1; i <= MAX_RATE; ++i)
            {
                if (i == CurrentRate(player, sender))
                    continue;

                if (float(i) == defaultRate)
                    continue;

                std::ostringstream gossipText;
                gossipText << label << i;
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipText.str(), sender, i);
            }

            // Toujours proposer le retour au taux par défaut du royaume (x1, Blizzlike)
            std::ostringstream defaultText;
            defaultText << "Revenir au taux par défaut (x" << defaultRate << ")";
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, defaultText.str(), sender, 0);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Retour", SENDER_MENU, ACTION_MENU_BACK);

            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            SendMainMenu(player, creature);
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 uiSender, uint32 uiAction) override
        {
            if (uiSender == SENDER_MENU)
            {
                if (uiAction == ACTION_MENU_XP)
                    SendRateMenu(player, creature, SENDER_XP);
                else if (uiAction == ACTION_MENU_REP)
                    SendRateMenu(player, creature, SENDER_REP);
                else
                    SendMainMenu(player, creature);
                return true;
            }

            CloseGossipMenuFor(player);

            uint32 newRate = std::min(MAX_RATE, uiAction);
            ChatHandler handler(player->GetSession());

            if (uiSender == SENDER_XP)
            {
                player->SetPersonnalXpRate(float(newRate));

                if (newRate)
                    handler.PSendSysMessage("Votre taux d'expérience personnel est désormais x%u.", newRate);
                else
                    handler.PSendSysMessage("Votre taux d'expérience est revenu à la valeur par défaut du royaume (x%g).", DefaultRate(SENDER_XP));
            }
            else if (uiSender == SENDER_REP)
            {
                player->SetPersonnalRepRate(float(newRate));

                if (newRate)
                    handler.PSendSysMessage("Votre taux de réputation personnel est désormais x%u.", newRate);
                else
                    handler.PSendSysMessage("Votre taux de réputation est revenu à la valeur par défaut du royaume (x%g).", DefaultRate(SENDER_REP));
            }

            return true;
        }
};

void AddSC_custom_npcs()
{
    new npc_rate_xp_modifier();
}
