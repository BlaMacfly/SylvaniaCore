/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2008-2017 TrinityCore <http://www.trinitycore.org/>
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
#include "Player.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
enum
{
    ///MONK Quest
    NPC_INITIATE_DA_NEL = 98519,
    QUEST_DA_NEL = 12103,
};


struct npc_initiate_da_nel : public ScriptedAI
{
    npc_initiate_da_nel(Creature* creature) : ScriptedAI(creature) { SayHi = false; }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!who || !who->IsInWorld())
            return;
        if (!me->IsWithinDist(who, 25.0f, false))
            return;

        Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself();

        if (!player)
            return;
        me->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, me->GetFollowAngle());
        if (!SayHi)
        {
            SayHi = true;
            Talk(0, player);
        }
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_DA_NEL)
        {
            Talk(1, player);
            player->CastSpell(player, 194004, true);
            me->DespawnOrUnsummon(5000);
        }
    }
private:
    bool SayHi;
};

enum MonkArtifactChoice
{
    PLAYER_CHOICE_MONK_ARTIFACT = 242,
    RESPONSE_MONK_MISTWEAVER    = 241,
    RESPONSE_MONK_BREWMASTER    = 242,
    RESPONSE_MONK_WINDWALKER    = 243,
    QUEST_WINDWALKER_CHOSEN     = 40638,
    QUEST_MISTWEAVER_CHOSEN     = 40639,
    QUEST_BREWMASTER_CHOSEN     = 40640,
};

// Choix d artefact au gossip de Ponshu (sort 198902 -> PlayerChoice 242) :
// accorde et recompense la quete de la spe choisie, qui donne l arme prodigieuse.
class monk_artifact_player_choice : public PlayerScript
{
public:
    monk_artifact_player_choice() : PlayerScript("monk_artifact_player_choice") { }

    void OnPlayerChoiceResponse(Player* player, uint32 choiceId, uint32 responseId) override
    {
        if (player->getClass() != CLASS_MONK || choiceId != PLAYER_CHOICE_MONK_ARTIFACT)
            return;

        uint32 questId = 0;
        switch (responseId)
        {
            case RESPONSE_MONK_MISTWEAVER: questId = QUEST_MISTWEAVER_CHOSEN; break;
            case RESPONSE_MONK_BREWMASTER: questId = QUEST_BREWMASTER_CHOSEN; break;
            case RESPONSE_MONK_WINDWALKER: questId = QUEST_WINDWALKER_CHOSEN; break;
            default: return;
        }

        if (player->GetQuestStatus(questId) != QUEST_STATUS_NONE)
            return;

        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        {
            player->AddQuest(quest, nullptr);
            player->CompleteQuest(questId);
            player->RewardQuest(quest, 0, player, true);
        }
    }
};

void AddSC_class_hall_monk()
{
    RegisterCreatureAI(npc_initiate_da_nel);
    new monk_artifact_player_choice();
}
