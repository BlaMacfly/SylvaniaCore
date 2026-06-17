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

#include "ScriptedSceneAI.h"
#include "Creature.h"
#include "Unit.h"
#include "Group.h"
#include "Log.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "WaypointDefines.h"
#include "WaypointMovementGenerator.h"

enum Points
{
    POINT_LAST_POINT    = 0xFFFFFF,
    POINT_HOME          = 0xFFFFFE
};

npc_sceneAI::npc_sceneAI(Creature* creature) : ScriptedAI(creature),
    m_uiWPWaitTimer(1000),
    m_uiPlayerCheckTimer(0),
    m_uiSceneState(STATE_SCENE_NONE),
    MaxPlayerDistance(DEFAULT_MAX_PLAYER_DISTANCE),
    LastWP(0),
    m_pQuestForScene(NULL),
    m_bIsActiveAttacker(true),
    m_bIsRunning(false),
    m_bCanInstantRespawn(false),
    m_bCanReturnToStart(false),
    DespawnAtEnd(true),
    DespawnAtFar(true),
    ScriptWP(false),
    HasImmuneToNPCFlags(false),
    m_bStarted(false),
    m_bEnded(false)
{ }

Player* npc_sceneAI::GetPlayerForScene()
{
    return ObjectAccessor::GetPlayer(*me, m_uiPlayerGUID);
}

void npc_sceneAI::TalkToScenePlayer(uint8 id)
{
    if (Player* player = GetPlayerForScene())
        Talk(id, player);
    else
        Talk(id);
}

void npc_sceneAI::SayToScenePlayer(uint8 id)
{
    if (Player* player = GetPlayerForScene())
        me->Say(id, player);
    else
        me->Say(id);
}

void npc_sceneAI::YellToScenePlayer(uint8 id)
{
    if (Player* player = GetPlayerForScene())
        me->Yell(id, player);
    else
        me->Yell(id);
}

//see followerAI
bool npc_sceneAI::AssistPlayerInCombatAgainst(Unit* who)
{
    if (!who || !who->GetVictim())
        return false;

    //experimental (unknown) flag not present
    if (!(me->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_CAN_ASSIST))
        return false;

    //not a player
    if (!who->EnsureVictim()->GetCharmerOrOwnerPlayerOrPlayerItself())
        return false;

    //never attack friendly
    if (me->IsFriendlyTo(who))
        return false;

    //too far away and no free sight?
    if (me->IsWithinDistInMap(who, GetMaxPlayerDistance()) && me->IsWithinLOSInMap(who))
    {
        //already fighting someone?
        if (!me->GetVictim())
        {
            AttackStart(who);
            return true;
        }
        else
        {
            who->SetInCombatWith(me);
            me->AddThreat(who, 0.0f);
            return true;
        }
    }

    return false;
}

void npc_sceneAI::MoveInLineOfSight(Unit* who)
{
    if (me->GetVictim())
        return;

    if (me->HasReactState(REACT_AGGRESSIVE) && !me->HasUnitState(UNIT_STATE_STUNNED) && who->isTargetableForAttack() && who->isInAccessiblePlaceFor(me))
        if (HasSceneState(STATE_SCENE_SCENEING) && AssistPlayerInCombatAgainst(who))
            return;

    if (me->CanStartAttack(who, false))
        AttackStart(who);
}

void npc_sceneAI::JustDied(Unit* /*killer*/)
{
    if (!HasSceneState(STATE_SCENE_SCENEING) || !m_uiPlayerGUID || !m_pQuestForScene)
        return;

    if (Player* player = GetPlayerForScene())
    {
        if (Group* group = player->GetGroup())
        {
            for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                if (Player* member = groupRef->GetSource())
                    member->FailQuest(m_pQuestForScene->GetQuestId());
        }
        else
            player->FailQuest(m_pQuestForScene->GetQuestId());
    }
}

void npc_sceneAI::JustRespawned()
{
    RemoveSceneState(STATE_SCENE_SCENEING | STATE_SCENE_RETURNING | STATE_SCENE_PAUSED);

    if (!IsCombatMovementAllowed())
        SetCombatMovement(true);

    //add a small delay before going to first waypoint, normal in near all cases
    m_uiWPWaitTimer = 1000;

    if (me->getFaction() != me->GetCreatureTemplate()->faction)
        me->RestoreFaction();

    Reset();
}

void npc_sceneAI::ReturnToLastPoint()
{
    me->SetWalk(false);
    float x, y, z, o;
    me->GetHomePosition(x, y, z, o);
    me->GetMotionMaster()->MovePoint(POINT_LAST_POINT, x, y, z);
}

void npc_sceneAI::EnterEvadeMode(EvadeReason /*why*/)
{
    me->RemoveAllAuras();
    me->DeleteThreatList();
    me->CombatStop(true);
    me->SetLootRecipient(NULL);

    if (HasSceneState(STATE_SCENE_SCENEING))
    {
        AddSceneState(STATE_SCENE_RETURNING);
        ReturnToLastPoint();
        TC_LOG_DEBUG("scripts", "SceneAI has left combat and is now returning to last point");
    }
    else
    {
        me->GetMotionMaster()->MoveTargetedHome();
        if (HasImmuneToNPCFlags)
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        Reset();
    }
}

bool npc_sceneAI::IsPlayerOrGroupInRange()
{
    if (Player* player = GetPlayerForScene())
    {
        if (Group* group = player->GetGroup())
        {
            for (GroupReference* groupRef = group->GetFirstMember(); groupRef != NULL; groupRef = groupRef->next())
                if (Player* member = groupRef->GetSource())
                    if (me->IsWithinDistInMap(member, GetMaxPlayerDistance()))
                        return true;
        }
        else if (me->IsWithinDistInMap(player, GetMaxPlayerDistance()))
            return true;
    }

    return false;
}

void npc_sceneAI::UpdateAI(uint32 diff)
{
    if (HasSceneState(STATE_SCENE_SCENEING) && !me->GetVictim() && m_uiWPWaitTimer && !HasSceneState(STATE_SCENE_RETURNING))
    {
        if (m_uiWPWaitTimer <= diff)
        {
            if (!HasSceneState(STATE_SCENE_PAUSED))
            {
                m_uiWPWaitTimer = 0;

                if (m_bEnded)
                {
                    me->StopMoving();
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();

                    m_bEnded = false;

                    TC_LOG_DEBUG("scripts", "SceneAI reached end of waypoints");
                    LastWaypointReached();

                    if (DespawnAtEnd)
                    {
                        if (m_bCanReturnToStart)
                        {
                            float fRetX, fRetY, fRetZ;
                            me->GetRespawnPosition(fRetX, fRetY, fRetZ);

                            me->GetMotionMaster()->MovePoint(POINT_HOME, fRetX, fRetY, fRetZ);

                            TC_LOG_DEBUG("scripts", "SceneAI are returning home to spawn location: %u, %f, %f, %f", POINT_HOME, fRetX, fRetY, fRetZ);
                        }
                        else if (m_bCanInstantRespawn)
                        {
                            me->setDeathState(JUST_DIED);
                            me->Respawn();
                        }
                        else
                            me->DespawnOrUnsummon();
                    }
                    else
                        TC_LOG_DEBUG("scripts", "SceneAI reached end of waypoints with Despawn off");                      

                    RemoveSceneState(STATE_SCENE_SCENEING);
                    return;
                }

                if (!m_bStarted)
                {
                    m_bStarted = true;
                    me->GetMotionMaster()->MovePath(_path, false);
                }
                else if (WaypointMovementGenerator<Creature>* move = dynamic_cast<WaypointMovementGenerator<Creature>*>(me->GetMotionMaster()->top()))
                    WaypointStart(move->GetCurrentNode());
            }
        }
        else
            m_uiWPWaitTimer -= diff;
    }

    //Check if player or any member of his group is within range
    if (HasSceneState(STATE_SCENE_SCENEING) && !m_uiPlayerGUID.IsEmpty() && !me->GetVictim() && !HasSceneState(STATE_SCENE_RETURNING))
    {
        m_uiPlayerCheckTimer += diff;
        if (m_uiPlayerCheckTimer > 1000)
        {
            if (DespawnAtFar && !IsPlayerOrGroupInRange())
            {
                if (m_bCanInstantRespawn)
                {
                    me->setDeathState(JUST_DIED);
                    me->Respawn();
                }
                else
                    me->DespawnOrUnsummon();

                return;
            }

            m_uiPlayerCheckTimer = 0;
        }
    }

    UpdateSceneAI(diff);
}

void npc_sceneAI::UpdateSceneAI(uint32 /*diff*/)
{
    if (!UpdateVictim())
        return;

    DoMeleeAttackIfReady();
}

void npc_sceneAI::MovementInform(uint32 moveType, uint32 pointId)
{
    // no action allowed if there is no escort
    if (!HasSceneState(STATE_SCENE_SCENEING))
        return;

    if (moveType == POINT_MOTION_TYPE)
    {
        //Call On PointReached
        PointReached(pointId);

        if (!m_uiWPWaitTimer)
            m_uiWPWaitTimer = 1;

        //Combat start position reached, continue waypoint movement
        if (pointId == POINT_LAST_POINT)
        {
            TC_LOG_DEBUG("scripts", "SceneAI has returned to original position before combat");

            me->SetWalk(!m_bIsRunning);
            RemoveSceneState(STATE_SCENE_RETURNING);
        }
        else if (pointId == POINT_HOME)
        {
            TC_LOG_DEBUG("scripts", "SceneAI has returned to original home location and will continue from beginning of waypoint list.");

            m_bStarted = false;
        }
    }
    else if (moveType == WAYPOINT_MOTION_TYPE)
    {
        //Call WP function
        WaypointReached(pointId);

        //End of the line
        if (LastWP && LastWP == pointId)
        {
            LastWP = 0;

            m_bStarted = false;
            m_bEnded = true;

            m_uiWPWaitTimer = 50;

            return;
        }

        TC_LOG_DEBUG("scripts", "SceneAI Waypoint %u reached", pointId);

        WaypointMovementGenerator<Creature>* move = dynamic_cast<WaypointMovementGenerator<Creature>*>(me->GetMotionMaster()->top());

        if (move)
            m_uiWPWaitTimer = move->GetTrackerTimer().GetExpiry();

        //Call WP start function
        if (!m_uiWPWaitTimer && !HasSceneState(STATE_SCENE_PAUSED) && move)
            WaypointStart(move->GetCurrentNode());

        if (m_bIsRunning)
            me->SetWalk(false);
        else
            me->SetWalk(true);
    }
}

/*
void npc_sceneAI::OnPossess(bool apply)
{
    // We got possessed in the middle of being sceneed, store the point
    // where we left off to come back to when possess is removed
    if (HasSceneState(STATE_SCENE_SCENEING))
    {
        if (apply)
            me->GetPosition(LastPos.x, LastPos.y, LastPos.z);
        else
        {
            Returning = true;
            me->GetMotionMaster()->MovementExpired();
            me->GetMotionMaster()->MovePoint(WP_LAST_POINT, LastPos.x, LastPos.y, LastPos.z);
        }
    }
}
*/

void npc_sceneAI::AddWaypoint(uint32 id, float x, float y, float z, float o, uint32 waitTime)
{
    Trinity::NormalizeMapCoord(x);
    Trinity::NormalizeMapCoord(y);

    WaypointNode wp;

    wp.id = id;
    wp.x = x;
    wp.y = y;
    wp.z = z;
    wp.orientation = o;
    wp.moveType = m_bIsRunning ? WAYPOINT_MOVE_TYPE_RUN : WAYPOINT_MOVE_TYPE_WALK;
    wp.delay = waitTime;
    wp.eventId = 0;
    wp.eventChance = 100;

    _path.nodes.push_back(std::move(wp));

    // WP start at 0, so Last = size() - 1
    LastWP = _path.nodes.size() - 1;

    // i think SD2 no longer uses this function
    ScriptWP = true;
    /*PointMovement wp;
    wp.m_uiCreatureEntry = me->GetEntry();
    wp.m_uiPointId = id;
    wp.m_fX = x;
    wp.m_fY = y;
    wp.m_fZ = z;
    wp.m_uiWaitTime = WaitTimeMs;
    PointMovementMap[wp.m_uiCreatureEntry].push_back(wp);*/
}

void npc_sceneAI::ClearWaypoint()
{
    _path.nodes.clear();
    LastWP = 0;
}

void npc_sceneAI::FillPointMovementListForCreature()
{
    ScriptPointVector const* movePoints = sScriptSystemMgr->GetPointMoveList(me->GetEntry());
    if (!movePoints)
        return;

    // WP start at 0, so Last = size() - 1
    LastWP = movePoints->size() - 1;

    for (const ScriptPointMove &point : *movePoints)
    {
        WaypointNode wp;

        float x = point.fX;
        float y = point.fY;
        float z = point.fZ;

        Trinity::NormalizeMapCoord(x);
        Trinity::NormalizeMapCoord(y);

        wp.id = point.uiPointId;
        wp.x = x;
        wp.y = y;
        wp.z = z;
        wp.orientation = 0.f;
        wp.moveType = m_bIsRunning ? WAYPOINT_MOVE_TYPE_RUN : WAYPOINT_MOVE_TYPE_WALK;
        wp.delay = point.uiWaitTime;
        wp.eventId = 0;
        wp.eventChance = 100;

        _path.nodes.push_back(std::move(wp));
    }
}

void npc_sceneAI::SetRun(bool on)
{
    if (on)
    {
        if (!m_bIsRunning)
            me->SetWalk(false);
        else
            TC_LOG_DEBUG("scripts", "SceneAI attempt to set run mode, but is already running.");
    }
    else
    {
        if (m_bIsRunning)
            me->SetWalk(true);
        else
            TC_LOG_DEBUG("scripts", "SceneAI attempt to set walk mode, but is already walking.");
    }

    m_bIsRunning = on;
}

/// @todo get rid of this many variables passed in function.
void npc_sceneAI::Start(bool isActiveAttacker /* = true*/, bool run /* = false */, ObjectGuid playerGUID /* = 0 */, Quest const* quest /* = NULL */, bool instantRespawn /* = false */, bool canLoopPath /* = false */, bool resetWaypoints /* = true */)
{
    if (me->GetVictim())
    {
        TC_LOG_ERROR("scripts.SceneAI", "TSCR ERROR: SceneAI (script: %s, creature entry: %u) attempts to Start while in combat", me->GetScriptName().c_str(), me->GetEntry());
        return;
    }

    if (HasSceneState(STATE_SCENE_SCENEING))
    {
        TC_LOG_ERROR("scripts.SceneAI", "SceneAI (script: %s, creature entry: %u) attempts to Start while already escorting", me->GetScriptName().c_str(), me->GetEntry());
        return;
    }

    //set variables
    m_bIsActiveAttacker = isActiveAttacker;
    m_bIsRunning = run;

    m_uiPlayerGUID = playerGUID;
    m_pQuestForScene = quest;

    m_bCanInstantRespawn = instantRespawn;
    m_bCanReturnToStart = canLoopPath;

    if (!ScriptWP && resetWaypoints) // sd2 never adds wp in script, but tc does
        FillPointMovementListForCreature();

    if (m_bCanReturnToStart && m_bCanInstantRespawn)
        TC_LOG_DEBUG("scripts", "SceneAI is set to return home after waypoint end and instant respawn at waypoint end. Creature will never despawn.");

    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE)
    {
        me->StopMoving();
        me->GetMotionMaster()->Clear(false);
        me->GetMotionMaster()->MoveIdle();
        TC_LOG_DEBUG("scripts", "SceneAI start with WAYPOINT_MOTION_TYPE, changed to MoveIdle.");
    }

    //disable npcflags
    me->SetUInt64Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
    if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC))
    {
        HasImmuneToNPCFlags = true;
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
    }

    TC_LOG_DEBUG("scripts", "SceneAI started. ActiveAttacker = %d, Run = %d, PlayerGUID = %s", uint32(m_bIsActiveAttacker), uint32(m_bIsRunning), m_uiPlayerGUID.ToString().c_str());

    //Set initial speed
    if (m_bIsRunning)
        me->SetWalk(false);
    else
        me->SetWalk(true);

    m_bStarted = false;

    AddSceneState(STATE_SCENE_SCENEING);
}

void npc_sceneAI::SetScenePaused(bool on)
{
    if (!HasSceneState(STATE_SCENE_SCENEING))
        return;

    if (on)
    {
        AddSceneState(STATE_SCENE_PAUSED);
        me->StopMoving();
    }
    else
    {
        RemoveSceneState(STATE_SCENE_PAUSED);
        if (WaypointMovementGenerator<Creature>* move = dynamic_cast<WaypointMovementGenerator<Creature>*>(me->GetMotionMaster()->top()))
            move->GetTrackerTimer().Reset(1);
    }
}
