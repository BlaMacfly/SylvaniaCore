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

#include "ScriptMgr.h"
#include "PhasingHandler.h"
#include "ScriptedGossip.h"
#include "GameObject.h"
#include "ObjectMgr.h"
#include "Spell.h"
#include "Log.h"

enum
{
    PLAYER_CHOICE_DK_BLOOD = 541,
    PLAYER_CHOICE_DK_FROST = 542,
    PLAYER_CHOICE_DK_UNHOLY = 543,
    SPELL_WEAPONS_OF_LEGEND_PLAYER_CHOICE = 199985,
    PLAYER_CHOICE_DK_SELECTION = 253,

    QUEST_WEAPONS_OF_LEGEND = 40715,
    QUEST_ONE_MORE_LEGEND = 43973,
    QUEST_MORE_WEAPONS_OF_LEGEND = 44424,

    ///DK Quest 

    ///Blood
    QUEST_THE_DEAD_AND_THE_DAMNED = 40740,
    ///Frost
    QUEST_THE_CALL_OF_ICECROWN = 38990,
    ///Unholy   
    QUEST_APOCALYPSE = 40930,
    QUEST_FOLLOWING_THE_CURSE = 40931,
    QUEST_DISTURBING_THE_PAST = 40932,
    QUEST_A_GRISLY_TASK = 40933,
    QUEST_THE_DARK_RIDERS = 40934,
    QUEST_THE_CALL_OF_VENGEANCE = 40935,
};


struct npc_duke_lankral_101441 : public ScriptedAI
{
    npc_duke_lankral_101441(Creature* creature) : ScriptedAI(creature) { }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId)
    {
        CloseGossipMenuFor(player);
        player->CastSpell(player, SPELL_WEAPONS_OF_LEGEND_PLAYER_CHOICE, true);
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if ((quest->GetQuestId() == QUEST_WEAPONS_OF_LEGEND) || (quest->GetQuestId() == QUEST_ONE_MORE_LEGEND) || (quest->GetQuestId() == QUEST_MORE_WEAPONS_OF_LEGEND))
        {
            player->CastSpell(player, SPELL_WEAPONS_OF_LEGEND_PLAYER_CHOICE, true);
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false))
                if (player->HasQuest(40714))
                    player->ForceCompleteQuest(40714);
        }
    }

private:
    TaskScheduler _scheduler;
};

struct npc_zeomus_102403 : public ScriptedAI
{
    npc_zeomus_102403(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/)
    {
        if (Player* player = clicker->ToPlayer())
        {
            if (player->HasQuest(QUEST_THE_DEAD_AND_THE_DAMNED))
            {
                player->KilledMonsterCredit(me->GetEntry());

            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false))
                if (player->HasQuest(QUEST_THE_DEAD_AND_THE_DAMNED))
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }
    }

};

void AddSC_class_hall_dk()
{
    RegisterCreatureAI(npc_duke_lankral_101441);
    RegisterCreatureAI(npc_zeomus_102403);
}
