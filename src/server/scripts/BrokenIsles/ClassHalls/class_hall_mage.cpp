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

#include "Conversation.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "GameObject.h"
#include "ScriptedGossip.h"
#include "Log.h"
#include "Spell.h"
#include "SceneHelper.h"

enum
{
    PLAYER_CHOICE_MAGE_SELECTION = 265,

    NPC_MERYL_FELSTORM_102700 = 102700,
    NPC_ALODI_102846 = 102846,

    QUEST_ARCANE_CHOSEN = 44307,
    QUEST_FIRE_CHOSEN = 44308,
    QUEST_FROST_CHOSEN = 44309,

    QUEST_FELSTORMS_PLEA = 41035, /// after quest 44184 In the Blink of an Eye complete
    QUEST_THE_DREADLORDS_PRIZE = 41036,
    QUEST_A_MAGES_WEAPON = 41085,
    QUEST_A_SECOND_WEAPON = 43441,
    QUEST_THRICE_THE_POWER = 44310,
    PHASE_2 = 5985,
    PHASE_3 = 6543,
    PHASE_PERSONAL = 5854,

    CONVERSATION_FELSTORMS_PLEA = 1264,
    CONVERSATION_THE_DREADLORDS_PRIZE = 3364,
    CONVERSATION_THE_DREADLORDS_PRIZE_THIRD = 1281,
    PATH_THE_DREADLORDS_PRIZE = 4471540,
    MOVE_TO_POSITION = 15,
    SPELL_TELE_TO_THE_DREADLORDS_PRIZE = 203241,///ID - 203241 TELEPORT_TO_LFG_DUNGEON EffectMiscValueA = 1276 EffectMiscValueB = 1187 Location: X: 1276.16 Y: -263.27 Z: 44.36 Orientation: 6.275331 MapID: 1494

    EVENT_TALK_1 = 1,
    EVENET_TELE_TO_LFG_DUNGENON = 2,
    EVENT_BACK_HOME_1 = 3,
    EVENT_THE_DREADLORDS_PRIZE_LAST_TALK = 4,

    ACTION_RESPONSEID_1 = 584, //Arcane
    QUEST_ALUNETH_GREATSTAFF_OF_THE_MAGNA = 42001,
    ACTION_RESPONSEID_2 = 585, //Fire
    QUEST_AN_UNEXPECTED_MESSAGE = 40267,
    QUEST_THE_PATH_OF_ATONEMENT = 40270,

    QUEST_A_THE_FROZEN_FLAME = 11997,
    ACTION_RESPONSEID_3 = 586, //Frost
    QUEST_FINDING_BONCHILL = 42452,
    QUEST_THE_DEADWIND_SITE = 42476,
    QUEST_DAIO_THE_DECREPIT = 42477,
    QUEST_THE_MAGE_HUNTER = 42479,
    QUEST_ALODIS_GEMS = 42455,

    QUEST_THE_TIRISGARDE_REBORN = 41124,
};

struct npc_meryl_felstorm_102700 : public ScriptedAI
{
    npc_meryl_felstorm_102700(Creature* creature) : ScriptedAI(creature), sceneHelper(creature->GetGUID(), creature->GetMap()) { Initialize(); }

    void Initialize()
    {
        m_playerGUID = ObjectGuid::Empty;
        playerChoiceID = 0;
    }

    void AddPlayer()
    {
        if (!HasPlayer(m_playerGUID))
            pList.insert(m_playerGUID);
    }

    bool HasPlayer(ObjectGuid guid)
    {
        return (pList.find(guid) != pList.end());
    }

    void RemovePlayer()
    {
        if (HasPlayer(m_playerGUID))
            pList.erase(m_playerGUID);
        m_playerGUID = ObjectGuid::Empty;
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId)
    {
        CloseGossipMenuFor(player);
        switch (gossipListId)
        {
        case 0:
            if (player->HasQuest(QUEST_FINDING_BONCHILL) && (player->GetQuestObjectiveData(QUEST_FINDING_BONCHILL, 0)) && !player->GetQuestObjectiveData(QUEST_FINDING_BONCHILL, 6))
            {
                me->Say(112317, player);

                if (Creature* alodi = me->FindNearestCreature(NPC_ALODI_102846, 15.0f))
                {
                    alodi->GetScheduler().Schedule(Milliseconds(2000), [player](TaskContext context)
                        {
                            GetContextCreature()->Say(112318, player);
                        });
                    alodi->GetScheduler().Schedule(Milliseconds(11000), [player](TaskContext context)
                        {
                            GetContextCreature()->Say(112328, player);
                            player->KilledMonsterCredit(107589);
                        });
                }
                me->GetScheduler().Schedule(Milliseconds(5000), [player](TaskContext context)
                    {
                        GetContextCreature()->Say(112326, player);
                    });
                me->GetScheduler().Schedule(Milliseconds(9000), [player](TaskContext context)
                    {
                        GetContextCreature()->Say(112327, player);
                    });
            }
            break;
        default:
            break;
        }

    }
    void MoveInLineOfSight(Unit* who) override
    {
        if (!who || !who->IsInWorld())
            return;
        Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (!player)
            return;

        if (!me->IsWithinDist(who, 20.0f, false))
        {
            RemovePlayer();
            return;
        }

        if (!IsLock && player->HasQuest(QUEST_FELSTORMS_PLEA) && player->GetQuestStatus(QUEST_FELSTORMS_PLEA) == QUEST_STATUS_INCOMPLETE)
        {
            IsLock = true;
            Conversation::CreateConversation(CONVERSATION_FELSTORMS_PLEA, player, player->GetPosition(), { player->GetGUID() });
            player->ForceCompleteQuest(QUEST_FELSTORMS_PLEA);
        }

        if (!IsLock && (player->HasQuest(QUEST_THE_DREADLORDS_PRIZE)) && (!player->GetQuestObjectiveData(QUEST_THE_DREADLORDS_PRIZE, 0)))
        {
            IsLock = true;
            Conversation::CreateConversation(CONVERSATION_THE_DREADLORDS_PRIZE, player, player->GetPosition(), { player->GetGUID() });
        }
        ///conversation 1281 ?????!???? ?????
        if (!IsLock && (player->HasQuest(QUEST_THE_DREADLORDS_PRIZE)) && (player->GetQuestObjectiveData(QUEST_THE_DREADLORDS_PRIZE, 0)) && (!player->GetQuestObjectiveData(QUEST_THE_DREADLORDS_PRIZE, 2)))
        {
            IsLock = true;
            events.ScheduleEvent(EVENT_THE_DREADLORDS_PRIZE_LAST_TALK, 1000);
        }

    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE)
            switch (id)
            {
            case MOVE_TO_POSITION:
            {
                //events.ScheduleEvent(EVENT_TALK_1, 500);
                break;
            }

            }
    }

    void sQuestAccept(Player* player, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_THE_DREADLORDS_PRIZE)
        {
            m_playerGUID = player->GetGUID();
            //Conversation::CreateConversation(CONVERSATION_THE_DREADLORDS_PRIZE, player, player->GetPosition(), { player->GetGUID() });
            //PATH
            me->SetSpeed(MOVE_RUN, 1.8f);
            //me->GetMotionMaster()->MovePath(PATH_THE_DREADLORDS_PRIZE, false);

            events.ScheduleEvent(EVENT_TALK_1, 10000);
            player->AddConversationDelayedTeleport(14000, CONVERSATION_THE_DREADLORDS_PRIZE, 1494, 1276.16f, -263.27f, 44.36f, 6.275331f);
            ///X: 1276.16 Y: -263.27 Z: 44.36 Orientation: 6.275331 MapID: 1494
        }
        if (quest->GetQuestId() == QUEST_FINDING_BONCHILL)
        {
            Talk(1, player);
            DoCastSelf(226016, true);
            PhasingHandler::AddPhase(player, PHASE_2);
            PhasingHandler::AddPhase(player, PHASE_3);
        }
        if (quest->GetQuestId() == QUEST_THE_DEADWIND_SITE)
            me->Say(112462);
        if (quest->GetQuestId() == QUEST_THE_TIRISGARDE_REBORN)
        {
            sceneHelper.Clear();
            sceneHelper.SetDefaultActorGuid(me->GetGUID());
            sceneHelper.SetDefaultPlayerGuid(player->GetGUID());
            sceneHelper.AddSceneActionSay(105829, 1000);
            sceneHelper.AddSceneActionSay(105830, 12000);
            sceneHelper.AddSceneActionKillCreditMonster(103193, 1, 15000);
            sceneHelper.AddSceneActionSay(105831, 22000);
            sceneHelper.AddSceneActionSay(105993, 28000);
            sceneHelper.Activate();
        }

    }

    void sQuestReward(Player* player, Quest const* quest, uint32 /*opt*/)
    {
        if (quest->GetQuestId() == QUEST_FELSTORMS_PLEA)
            IsLock = false;
        if (quest->GetQuestId() == QUEST_A_MAGES_WEAPON || quest->GetQuestId() == QUEST_A_SECOND_WEAPON || quest->GetQuestId() == QUEST_THRICE_THE_POWER)
        {
            if (playerChoiceID)
            {
                switch (playerChoiceID)
                {
                case ACTION_RESPONSEID_1:
                    if (player->GetQuestStatus(QUEST_ALUNETH_GREATSTAFF_OF_THE_MAGNA) == QUEST_STATUS_NONE)
                        if (const Quest* quest_1 = sObjectMgr->GetQuestTemplate(QUEST_ALUNETH_GREATSTAFF_OF_THE_MAGNA))
                            player->AddQuest(quest_1, me);
                    break;
                case ACTION_RESPONSEID_2:
                    if (player->GetQuestStatus(QUEST_AN_UNEXPECTED_MESSAGE) == QUEST_STATUS_NONE)
                        if (const Quest* quest_2 = sObjectMgr->GetQuestTemplate(QUEST_AN_UNEXPECTED_MESSAGE))
                            player->AddQuest(quest_2, me);
                    break;
                case ACTION_RESPONSEID_3:
                    if (player->GetQuestStatus(QUEST_FINDING_BONCHILL) == QUEST_STATUS_NONE)
                        if (const Quest* quest_3 = sObjectMgr->GetQuestTemplate(QUEST_FINDING_BONCHILL))
                        {
                            player->AddQuest(quest_3, me);
                            Talk(1, player);
                            DoCastSelf(226016, true);
                            PhasingHandler::AddPhase(player, PHASE_2);
                            PhasingHandler::AddPhase(player, PHASE_3);
                        }
                    break;
                default:
                    break;
                }
            }
        }

        if (quest->GetQuestId() == QUEST_THE_DEADWIND_SITE || quest->GetQuestId() == QUEST_DAIO_THE_DECREPIT)
        {
            if (player->GetQuestStatus(QUEST_THE_DEADWIND_SITE) == QUEST_STATUS_REWARDED || player->GetQuestStatus(QUEST_DAIO_THE_DECREPIT) == QUEST_STATUS_REWARDED)
            {
                if (player->GetQuestStatus(QUEST_THE_MAGE_HUNTER) == QUEST_STATUS_NONE)
                {
                    if (const Quest* quest_1 = sObjectMgr->GetQuestTemplate(QUEST_THE_MAGE_HUNTER))
                        player->AddQuest(quest_1, me);
                    me->Say(112812);
                    me->GetScheduler().Schedule(Milliseconds(4000), [this](TaskContext context)
                        {
                            if (Creature* ido = me->FindNearestCreature(102846, 25.0f))
                                ido->Say(112813);
                        });
                }
                PhasingHandler::AddPhase(player, PHASE_2);
                PhasingHandler::AddPhase(player, PHASE_3);
            }
        }
        //???????????
        if (quest->GetQuestId() == QUEST_THE_TIRISGARDE_REBORN)
        {
            PhasingHandler::AddPhase(player, 169);
            PhasingHandler::RemovePhase(player, PHASE_PERSONAL);
        }
    }

    ///ACTION_RESPONSEID_1
    void DoAction(int32 param)
    {
        switch (param)
        {
        case ACTION_RESPONSEID_1:
        case ACTION_RESPONSEID_2:
        case ACTION_RESPONSEID_3:
            playerChoiceID = param;
            break;
        default:
            break;
        }
    }
    void UpdateAI(uint32 diff) override
    {
        sceneHelper.UpdateSceneHelper(diff);
        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_TALK_1:
            {
                TC_LOG_ERROR("server.worldserver", "EVENT_TALK_1");
                Talk(0);
                events.ScheduleEvent(EVENET_TELE_TO_LFG_DUNGENON, 2000);
                break;
            }
            case EVENET_TELE_TO_LFG_DUNGENON:
            {
                TC_LOG_ERROR("server.worldserver", "EVENET_TELE_TO_LFG_DUNGENON");
                if (Player* player = ObjectAccessor::GetPlayer(*me, m_playerGUID))
                    DoCast(player, 130, true);///SPELL_TELE_TO_THE_DREADLORDS_PRIZE
            }
            case EVENT_BACK_HOME_1:
            {
                TC_LOG_ERROR("server.worldserver", "EVENT_BACK_HOME_1");
                //me->NearTeleportTo(me->GetHomePosition(), false);
                //me->KillSelf();
                //me->Respawn();
                //me->GetMotionMaster()->MoveTargetedHome();
                break;
            }
            case EVENT_THE_DREADLORDS_PRIZE_LAST_TALK:

                Player* mPlayer = me->SelectNearestPlayer(200.0f);
                m_playerGUID = mPlayer->GetGUID();
                ObjectGuid alodiGuid;
                if (Creature* alodi = me->FindNearestCreature(NPC_ALODI_102846, 25.0f))
                    alodiGuid = alodi->GetGUID();
                sceneHelper.Clear();
                sceneHelper.SetDefaultActorGuid(me->GetGUID());
                sceneHelper.SetDefaultPlayerGuid(m_playerGUID);
                sceneHelper.AddSceneActionSayByActor(alodiGuid, 105437, 100);
                sceneHelper.AddSceneActionSay(105438);
                sceneHelper.AddSceneActionSay(105439, 3000);
                sceneHelper.AddSceneActionCastTarget(133464, true, me, 3000);
                sceneHelper.AddSceneActionSayByActor(alodiGuid, 105440, 5000);
                sceneHelper.AddSceneActionSay(105441, 7000);
                sceneHelper.AddSceneActionSay(105442, 9000);
                sceneHelper.AddSceneActionKillCreditMonster(103032, 1, 9000);
                sceneHelper.Activate();
                break;
            }
        }
    }
private:
    EventMap events;
    std::set<ObjectGuid> pList;
    ObjectGuid   m_playerGUID;
    uint32 playerChoiceID;
    SceneHelper sceneHelper;
};

class mage_playerchoice : public PlayerScript
{
public:
    mage_playerchoice() : PlayerScript("mage_playerchoice") { }

    void OnPlayerChoiceResponse(Player* player, uint32 choiceId, uint32 responseId)
    {
        if (choiceId != PLAYER_CHOICE_MAGE_SELECTION)
            return;

        if (player->HasQuest(QUEST_A_MAGES_WEAPON))
            player->KilledMonsterCredit(103037);
        if (player->HasQuest(QUEST_A_SECOND_WEAPON))
            player->KilledMonsterCredit(110559);
        if (player->HasQuest(QUEST_THRICE_THE_POWER))
            player->KilledMonsterCredit(113614);
        if (Creature* meryl = player->FindNearestCreature(NPC_MERYL_FELSTORM_102700, 100.0f))
            meryl->AI()->DoAction(responseId);
    }

    void OnSuccessfulSpellCast(Player* player, Spell* spell)
    {
        //TC_LOG_ERROR("server.worldserver", ">>>>>>%u ", spell->GetSpellInfo()->Id);
        if (player->getClass() == CLASS_MAGE && spell->GetSpellInfo()->Id == 207901)
        {
            player->GetScheduler().Schedule(Milliseconds(2000), [player](TaskContext context)
                {
                    if (Player* player = GetContextPlayer())
                        PhasingHandler::AddPhase(player, 6140);
                });
        }
    }

    void OnQuestStatusChange(Player* player, uint32 /*questId*/)
    {
        if (player->getClass() == CLASS_MAGE || player->getLevel() >= 98)
            OnCheckPhase(player);
    }

    void OnCheckPhase(Player* player)
    {
        if (player->GetAreaId() == 7879)
        {
            if (player->CheckQuestStatus(QUEST_FINDING_BONCHILL, CHECK_QUEST_TAKEN_AND_COMPLETE) || player->CheckQuestStatus(QUEST_THE_DEADWIND_SITE, CHECK_QUEST_TAKEN_AND_COMPLETE_AND_REWARDED) || player->CheckQuestStatus(QUEST_DAIO_THE_DECREPIT, CHECK_QUEST_TAKEN_AND_COMPLETE_AND_REWARDED))
            {
                PhasingHandler::AddPhase(player, PHASE_2);
                PhasingHandler::AddPhase(player, PHASE_3);
            }

            if (player->CheckQuestStatus(QUEST_THE_TIRISGARDE_REBORN, CHECK_QUEST_TAKEN_AND_COMPLETE_AND_REWARDED))
            {
                PhasingHandler::AddPhase(player, 169);
                PhasingHandler::RemovePhase(player, PHASE_PERSONAL);
                PhasingHandler::RemovePhase(player, PHASE_2);
            }
        }
        if (player->GetAreaId() == 279)
        {
            if (player->CheckQuestStatus(QUEST_AN_UNEXPECTED_MESSAGE, CHECK_QUEST_TAKEN_AND_COMPLETE))
                PhasingHandler::AddPhase(player, 9057);
            if (player->CheckQuestStatus(QUEST_AN_UNEXPECTED_MESSAGE, CHECK_QUEST_REWARDED))
            {
                PhasingHandler::RemovePhase(player, 9057);
                PhasingHandler::AddPhase(player, 5390);
            }
            if (player->CheckQuestStatus(QUEST_A_THE_FROZEN_FLAME, CHECK_QUEST_TAKEN))
                PhasingHandler::AddPhase(player, 5402);
            if (player->CheckQuestStatus(QUEST_A_THE_FROZEN_FLAME, CHECK_QUEST_REWARDED))
            {
                PhasingHandler::RemovePhase(player, 5390);
                PhasingHandler::RemovePhase(player, 5402);
            }
        }
        if (player->GetAreaId() == 4183)
        {
            if (player->CheckQuestStatus(42006, CHECK_QUEST_TAKEN_AND_COMPLETE_AND_REWARDED))
                PhasingHandler::AddPhase(player, 6068);
            if (player->CheckQuestStatus(41626, CHECK_QUEST_TAKEN_AND_COMPLETE_AND_REWARDED))
                PhasingHandler::AddPhase(player, 6068);

        }
    }

    void OnUpdateArea(Player* player, Area* /*newArea*/, Area* /*oldArea*/)
    {
        if (player->HasQuest(42006) || player->HasQuest(41626))
            player->KilledMonsterCredit(105092);

        {
            if (player->HasQuest(42008) || player->HasQuest(41628))
                player->KilledMonsterCredit(104766);
        }

        if (player->HasQuest(42476))
            player->KilledMonsterCredit(107665);
    }

    void OnQuestAccept(Player* player, Quest const* quest)
    {
        switch (quest->GetQuestId())
        {
        case 42008:
        case 41628:
            player->TeleportTo(571, Position(3585.935f, 6661.059f, 195.5f, 0.873023f));
            break;
        case 42011:
            if (player->getClass() == CLASS_MAGE)
                player->TeleportTo(1583, Position(3723.76f, 7359.61f, 266.8f, 6.250198f));
            break;
        case 41631:
            if (player->getClass() == CLASS_PRIEST)
                player->TeleportTo(1583, Position(3723.76f, 7359.61f, 266.8f, 6.250198f));
            break;
        default:
            break;
        }
    }
};
/*QUEST_FINDING_BONCHILL*/
class go_finding_bonchill_note : public GameObjectScript
{
public:
    go_finding_bonchill_note() : GameObjectScript("go_finding_bonchill_note") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        ///TC_LOG_ERROR("server.worldserver", "go_finding_bonchill_note %u", go->GetEntry());
        if (player->HasQuest(QUEST_FINDING_BONCHILL))
        {
            switch (go->GetEntry())
            {
            case 250549:
            case 250545:
            case 250542:
                player->KilledMonsterCredit(107586); // QUEST_FINDING_BONCHILL storageIndex 0 KillCredit
                break;
            default:
                break;
            }
            player->KilledMonsterCredit(go->GetEntry()); // QUEST_FINDING_BONCHILL storageIndex 1 KillCredit
        }
        return false;
    }
};

struct npc_image_of_kalec_105917 : public ScriptedAI
{
    npc_image_of_kalec_105917(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        me->DespawnOrUnsummon(30000);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(who, 15.0f, false) && (player->HasQuest(41626) || player->HasQuest(42006)))
            {
                player->KilledMonsterCredit(105091);
                player->KilledMonsterCredit(104551);
                player->KilledMonsterCredit(104570);
                player->KilledMonsterCredit(248375);
                player->KilledMonsterCredit(104752);
                if (player->HasQuest(41626) && player->getClass() == CLASS_PRIEST)
                    player->ForceCompleteQuest(41626);
                if (player->HasQuest(42006) && player->getClass() == CLASS_MAGE)
                    player->ForceCompleteQuest(42006);
                PhasingHandler::AddPhase(player, 6068);
            }
        }
    }
};

class go_communication_device_switch_248476 : public GameObjectScript
{
public:
    go_communication_device_switch_248476() : GameObjectScript("go_communication_device_switch_248476") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (player->HasQuest(41627) && player->getClass() == CLASS_PRIEST)
            player->ForceCompleteQuest(41627);
        if (player->HasQuest(42007) && player->getClass() == CLASS_MAGE)
            player->ForceCompleteQuest(42007);
        return false;
    }
};

struct npc_credit_surge_needle_scouted_104767 : public ScriptedAI
{
    npc_credit_surge_needle_scouted_104767(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
            if (me->IsWithinDist(who, 15.0f, false) && (player->HasQuest(41628) || player->HasQuest(42008)))
                player->KilledMonsterCredit(me->GetEntry());
    }
};
struct npc_breach_of_arcane_energy_106566 : public ScriptedAI
{
    npc_breach_of_arcane_energy_106566(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
            if (me->IsWithinDist(who, 10.0f, false))
            {
                if (player->HasQuest(41629) && player->getClass() == CLASS_PRIEST)
                    player->ForceCompleteQuest(41629);
                if (player->HasQuest(42009) && player->getClass() == CLASS_MAGE)
                    player->ForceCompleteQuest(42009);
            }
    }
};


struct npc_focused_void_104826 : public ScriptedAI
{
    npc_focused_void_104826(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/)
    {
        if (Player* player = clicker->ToPlayer())
        {
            if ((player->GetQuestStatus(41630) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(42010) == QUEST_STATUS_INCOMPLETE))
            {
                player->KilledMonsterCredit(104833);
                player->KilledMonsterCredit(104803);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(who, 10.0f, false) && (player->HasQuest(41630) || player->HasQuest(42010)))
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }
    }
};

struct npc_focused_void_104819 : public ScriptedAI
{
    npc_focused_void_104819(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/)
    {
        if (Player* player = clicker->ToPlayer())
        {
            if ((player->GetQuestStatus(41630) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(42010) == QUEST_STATUS_INCOMPLETE))
            {
                player->KilledMonsterCredit(104833);
                player->KilledMonsterCredit(104804);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(who, 10.0f, false) && (player->HasQuest(41630) || player->HasQuest(42010)))
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }
    }
};

struct npc_focused_void_104828 : public ScriptedAI
{
    npc_focused_void_104828(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/)
    {
        if (Player* player = clicker->ToPlayer())
        {
            if ((player->GetQuestStatus(41630) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(42010) == QUEST_STATUS_INCOMPLETE))
            {
                player->KilledMonsterCredit(104833);
                player->KilledMonsterCredit(104805);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(who, 10.0f, false) && (player->HasQuest(41630) || player->HasQuest(42010)))
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }
    }
};

struct npc_glutonia_107622 : public ScriptedAI
{
    npc_glutonia_107622(Creature* creature) : ScriptedAI(creature) { }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId)
    {
        CloseGossipMenuFor(player);
        player->TalkedToCreature(me->GetEntry(), me->GetGUID());
        if (player->HasQuest(QUEST_ALODIS_GEMS))
        {
            me->Say(112369);
            me->CastSpell(player, 39550, true);
            me->GetScheduler().Schedule(Milliseconds(4000), [this, player](TaskContext context)
                {
                    GetContextCreature()->CastStop();
                    GetContextCreature()->Say(112370, player);
                });
            me->GetScheduler().Schedule(Milliseconds(8000), [this, player](TaskContext context)
                {
                    GetContextCreature()->GetMotionMaster()->MovePoint(1, Position(-673.677f, 4429.2f, 738.1284f, 4.79956f), true);
                });
            me->GetScheduler().Schedule(Milliseconds(12000), [this, player](TaskContext context)
                {
                    player->KilledMonsterCredit(107614);
                });
        }
    }

    void MovementInform(uint32 /*type*/, uint32 id) override
    {
        switch (id)
        {
        case 1:
            me->GetScheduler().Schedule(250ms, [this](TaskContext /*context*/)
                {
                    me->CastSpell(me, 39550, true);
                    me->SummonGameObject(250575, Position(-673.4809f, 4420.087f, 738.1251f, 1.335072f), QuaternionData(0.0f, 0.0f, 0.6190529f, 0.7853492f), WEEK);
                });
            me->GetScheduler().Schedule(4s, [this](TaskContext /*context*/)
                {
                    me->CastStop();
                    me->Say(112371);
                });
            me->GetScheduler().Schedule(4s, [this](TaskContext /*context*/)
                {
                    me->GetMotionMaster()->MovePoint(2, me->GetHomePosition(), true);
                });
            break;
        default:
            break;
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false) && player->HasQuest(QUEST_ALODIS_GEMS) && !IsLock)
            {
                IsLock = true;
                me->Say(112343);
                player->KilledMonsterCredit(107612);
            }
        }
    }
};

struct npc_merina_107702 : public ScriptedAI
{
    npc_merina_107702(Creature* creature) : ScriptedAI(creature) {  }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false))
            {
                if (!IsLock && player->HasQuest(QUEST_THE_DEADWIND_SITE))
                {
                    Talk(0);
                    me->GetScheduler().Schedule(Milliseconds(4000), [this](TaskContext context)
                        {
                            Talk(1);
                        }).Schedule(Milliseconds(8000), [this](TaskContext context)
                            {
                                Talk(2);
                            }).Schedule(Milliseconds(12000), [this, player](TaskContext context)
                                {
                                    Talk(3);
                                    player->KilledMonsterCredit(107705);
                                });
                }
            }
        }
    }
};

struct npc_daio_the_decrepit_107716 : public ScriptedAI
{
    npc_daio_the_decrepit_107716(Creature* creature) : ScriptedAI(creature) {  }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId)
    {
        CloseGossipMenuFor(player);
        player->TalkedToCreature(me->GetEntry(), me->GetGUID());
        if (player->HasQuest(QUEST_DAIO_THE_DECREPIT) && !IsLock)
        {
            IsLock = true;
            Talk(0);
            player->KilledMonsterCredit(107711);
            me->GetScheduler().Schedule(Milliseconds(5000), [this, player](TaskContext context)
                {
                    me->SummonCreature(107691, Position(-11680.36f, -2402.484f, -0.4979841f));//Effects Bunny
                    me->SummonCreature(107740, Position(-11679.38f, -2403.818f, -0.4288194f, 1.783546f));
                    me->SummonCreature(107740, Position(-11684.24f, -2403.012f, -1.125542f, 2.971888f));
                    me->SummonCreature(107740, Position(-11682.63f, -2405.135f, -0.9947917f, 4.516595f));
                    me->SummonCreature(107740, Position(-11681.27f, -2402.535f, -0.6386424f, 1.606214f));
                    me->SummonCreature(107740, Position(-11677.88f, -2400.925f, -0.02951388f));
                    me->SummonCreature(107740, Position(-11679.22f, -2399.472f, -0.15625f, 0.9270826f));
                    me->SummonCreature(107740, Position(-11682.22f, -2400.106f, -0.6012089f, 1.768372f));
                });
            me->GetScheduler().Schedule(Milliseconds(15000), [this, player](TaskContext context)
                {
                    Talk(1);
                    if (Creature* effectbunny = me->GetSummonedCreatureByEntry(107691))
                        effectbunny->DespawnOrUnsummon();
                });

            me->GetScheduler().Schedule(Milliseconds(20000), [this, player](TaskContext context)
                {
                    me->SummonCreature(107691, Position(-11700.8f, -2377.66f, -0.7248644f));//Effects Bunny
                    me->SummonCreature(107799, Position(-11700.45f, -2378.07f, -0.7135417f));
                });
            me->GetScheduler().Schedule(Milliseconds(30000), [this, player](TaskContext context)
                {
                    Talk(2);
                    if (Creature* effectbunny = me->GetSummonedCreatureByEntry(107691))
                        effectbunny->DespawnOrUnsummon();
                });

            me->GetScheduler().Schedule(Milliseconds(35000), [this, player](TaskContext context)
                {
                    me->SummonCreature(107691, Position(-11700.91f, -2394.384f, -1.760968f));//Effects Bunny
                    me->SummonCreature(107800, Position(-11700.89f, -2394.797f, -1.78165f, 0.5027249f));
                });
            me->GetScheduler().Schedule(Milliseconds(45000), [this, player](TaskContext context)
                {
                    Talk(3);
                    if (Creature* effectbunny = me->GetSummonedCreatureByEntry(107691))
                        effectbunny->DespawnOrUnsummon();
                    player->KilledMonsterCredit(107766);
                });
            me->GetScheduler().Schedule(Milliseconds(50000), [this, player](TaskContext context)
                {
                    Talk(4);
                });
            me->GetScheduler().Schedule(Milliseconds(55000), [this, player](TaskContext context)
                {
                    Talk(5);
                    player->AddItem(141330, 1);
                });
            me->GetScheduler().Schedule(Milliseconds(60000), [this, player](TaskContext context)
                {
                    IsLock = false;
                });
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false) && player->HasQuest(QUEST_DAIO_THE_DECREPIT))
                player->KilledMonsterCredit(107710);
        }
    }
private:

    TaskScheduler _scheduler;
};

struct npc_alodi_102846 : public ScriptedAI
{
    npc_alodi_102846(Creature* creature) : ScriptedAI(creature) { }

    void sQuestReward(Player* player, Quest const* quest, uint32 /*opt*/)  override
    {
        if (quest->GetQuestId() == QUEST_ALODIS_GEMS)
        {
            me->Say(112458);
            me->GetScheduler().Schedule(Milliseconds(4000), [this, player](TaskContext context)
                {
                    if (Creature* meryl = me->FindNearestCreature(102700, 25.0f))
                        meryl->Say(112459);
                });
            me->GetScheduler().Schedule(Milliseconds(8000), [this, player](TaskContext context)
                {
                    me->Say(112461);
                });
        }
    }
};

struct npc_glowing_resonate_crystal_99309 : public ScriptedAI
{
    npc_glowing_resonate_crystal_99309(Creature* creature) : ScriptedAI(creature), sceneHelper(creature->GetGUID(), creature->GetMap()) { }

    void Reset() override
    {
        me->SetDisableGravity(true);
        Player* player = me->SelectNearestPlayer(50.f);

        if (Creature* actor = me->SummonCreature(99313, me->GetPosition()))
        {
            actor->EnterVehicle(me, 0);
            actor->SetFacingToObject(player);
            actor->SetDisableGravity(true);
            sceneHelper.Clear();
            sceneHelper.SetDefaultActorGuid(me->GetGUID());
            sceneHelper.SetDefaultPlayerGuid(player->GetGUID());

            sceneHelper.AddSceneActionSayByActor(actor->GetGUID(), 100946, 5000);
            sceneHelper.AddSceneActionSayByActor(actor->GetGUID(), 100947, 10000);
            sceneHelper.AddSceneActionSayByActor(actor->GetGUID(), 100990, 10000);
            sceneHelper.AddSceneActionSayByActor(actor->GetGUID(), 100948, 8000);
            sceneHelper.AddSceneActionKillCreditMonster(99313, 1, 2000);
            sceneHelper.AddSceneActionDespawnByActor(actor->GetGUID());
            sceneHelper.AddSceneActionDespawn();
            sceneHelper.Activate();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        sceneHelper.UpdateSceneHelper(diff);
    }
private:
    SceneHelper sceneHelper;
};

struct npc_archmage_modera_99398 : public ScriptedAI
{
    npc_archmage_modera_99398(Creature* creature) : ScriptedAI(creature), sceneHelper(creature->GetGUID(), creature->GetMap()) { }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_THE_PATH_OF_ATONEMENT)
        {
            //change phase
            PhasingHandler::AddPhase(me, 5390, true);
            sceneHelper.Clear();
            sceneHelper.SetDefaultActorGuid(me->GetGUID());
            sceneHelper.SetDefaultPlayerGuid(player->GetGUID());
            if (Creature* aethas = me->FindNearestCreature(99415, 50.f))
            {
                //PHASE
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101010, 5000);
                sceneHelper.AddSceneActionSay(101634, 4000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101011, 5000);
                sceneHelper.AddSceneActionSay(101645, 4000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101646, 2000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101012, 5000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101013, 5000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101636, 5000);
                sceneHelper.AddSceneActionSay(101637, 4000);
                sceneHelper.AddSceneActionSayByActor(aethas->GetGUID(), 101638, 5000);
            }

            sceneHelper.AddSceneActionKillCreditMonster(99415, 1, 1000);
            sceneHelper.Activate();
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            if (me->IsWithinDist(player, 15.0f, false))
            {
                if (!IsLock && player->HasQuest(QUEST_AN_UNEXPECTED_MESSAGE))
                {
                    me->Say(100999, player);
                    player->KilledMonsterCredit(110409);
                    player->KilledMonsterCredit(99396);
                }
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        sceneHelper.UpdateSceneHelper(diff);
    }
private:
    SceneHelper sceneHelper;
};


struct npc_aethas_sunreaver_99415 : public ScriptedAI
{
    npc_aethas_sunreaver_99415(Creature* creature) : ScriptedAI(creature), sceneHelper(creature->GetGUID(), creature->GetMap()) { }

    void DoQuestATheFrozenFlame(Player* player)
    {
        sceneHelper.Clear();
        sceneHelper.SetDefaultActorGuid(me->GetGUID());
        sceneHelper.SetDefaultPlayerGuid(player->GetGUID());
        sceneHelper.AddSceneActionSay(101025, 1000);
        sceneHelper.AddSceneCast(195544, 3000);
        sceneHelper.AddSceneActionSay(101044, 4000);
        sceneHelper.Activate();
        me->GetScheduler().Schedule(Milliseconds(4000), [player](TaskContext context)
            {
                PhasingHandler::AddPhase(player, 5402);
            });
    }

    void sQuestReward(Player* player, Quest const* quest, uint32 /*opt*/)  override
    {
        if (quest->GetQuestId() == QUEST_THE_PATH_OF_ATONEMENT)
        {
            if (const Quest* quest = sObjectMgr->GetQuestTemplate(QUEST_A_THE_FROZEN_FLAME))
            {
                player->AddQuest(quest, me);
                DoQuestATheFrozenFlame(player);
            }
        }
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_A_THE_FROZEN_FLAME)
            DoQuestATheFrozenFlame(player);
    }

    void UpdateAI(uint32 diff) override
    {
        sceneHelper.UpdateSceneHelper(diff);
    }
private:
    SceneHelper sceneHelper;
};

struct npc_aethas_s_portal_99418 : public ScriptedAI
{
    npc_aethas_s_portal_99418(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        me->SetDisplayId(69861);
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
    }

    void OnSpellClick(Unit* clicker, bool& /*result*/)
    {
        if (Player* player = clicker->ToPlayer())
        {
            if (player->GetQuestStatus(QUEST_A_THE_FROZEN_FLAME) == QUEST_STATUS_INCOMPLETE)
            {
                player->KilledMonsterCredit(99418);
                player->TeleportTo(1480, Position(4084.512f, 2483.943f, 365.786f, 0.030223f));
            }
        }
    }
};
void AddSC_class_hall_mage()
{
    RegisterCreatureAI(npc_meryl_felstorm_102700);
    new mage_playerchoice();
    new go_finding_bonchill_note();
    RegisterCreatureAI(npc_image_of_kalec_105917);
    new go_communication_device_switch_248476();
    RegisterCreatureAI(npc_credit_surge_needle_scouted_104767);
    RegisterCreatureAI(npc_breach_of_arcane_energy_106566);
    RegisterCreatureAI(npc_focused_void_104826);
    RegisterCreatureAI(npc_focused_void_104819);
    RegisterCreatureAI(npc_focused_void_104828);

    RegisterCreatureAI(npc_glutonia_107622);
    RegisterCreatureAI(npc_merina_107702);
    RegisterCreatureAI(npc_daio_the_decrepit_107716);
    RegisterCreatureAI(npc_alodi_102846);

    //fire
    RegisterCreatureAI(npc_glowing_resonate_crystal_99309);
    RegisterCreatureAI(npc_archmage_modera_99398);
    RegisterCreatureAI(npc_aethas_sunreaver_99415);
    RegisterCreatureAI(npc_aethas_s_portal_99418);
}
