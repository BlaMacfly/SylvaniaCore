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

class npc_rate_xp_modifier : public CreatureScript
{
    public:
        npc_rate_xp_modifier() : CreatureScript("npc_rate_xp_modifier") { }

// Taux d'expérience personnel maximum sélectionnable (bride serveur)
#define MAX_RATE uint32(7)

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            // Sans taux personnel, le core applique RATE_XP_QUEST aux kills
            // comme aux quêtes (Formulas.h / Player.cpp) : c'est LE taux par défaut.
            float defaultRate = sWorld->getRate(RATE_XP_QUEST);

            for (uint32 i = 1; i <= MAX_RATE; ++i)
            {
                if (i == player->GetPersonnalXpRate())
                    continue;

                if (float(i) == defaultRate)
                    continue;

                std::ostringstream gossipText;
                gossipText << "Taux d'expérience x" << i;
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipText.str(), GOSSIP_SENDER_MAIN, i);
            }

            // Toujours proposer le retour au taux par défaut du royaume (x1, Blizzlike)
            std::ostringstream defaultText;
            defaultText << "Revenir au taux par défaut (x" << defaultRate << ")";
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, defaultText.str(), GOSSIP_SENDER_MAIN, 0);

            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*uiSender*/, uint32 uiAction) override
        {
            CloseGossipMenuFor(player);

            uint32 newRate = std::min(MAX_RATE, uiAction);
            player->SetPersonnalXpRate(float(newRate));

            if (newRate)
                ChatHandler(player->GetSession()).PSendSysMessage("Votre taux d'expérience personnel est désormais x%u.", newRate);
            else
                ChatHandler(player->GetSession()).PSendSysMessage("Votre taux d'expérience est revenu à la valeur par défaut du royaume (x%g).", sWorld->getRate(RATE_XP_QUEST));

            return true;
        }
};

void AddSC_custom_npcs()
{
    new npc_rate_xp_modifier();
}
