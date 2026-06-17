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

#ifndef SCRIPTEDSCENEAI_H
#define SCRIPTEDSCENEAI_H

#include "ScriptedCreature.h"
#include "ScriptSystem.h"
#include "WaypointDefines.h"

class Quest;

#define DEFAULT_MAX_PLAYER_DISTANCE 50

enum eSceneState
{
    STATE_SCENE_NONE       = 0x000,                        //nothing in progress
    STATE_SCENE_SCENEING   = 0x001,                        //scene are in progress
    STATE_SCENE_RETURNING  = 0x002,                        //scene is returning after being in combat
    STATE_SCENE_PAUSED     = 0x004                         //will not proceed with waypoints before state is removed
};

struct TC_GAME_API npc_sceneAI : public ScriptedAI
{
    public:
        explicit npc_sceneAI(Creature* creature);
        ~npc_sceneAI() { }

        // CreatureAI functions

        void MoveInLineOfSight(Unit* who) override;

        void JustDied(Unit*) override;

        void JustRespawned() override;

        void ReturnToLastPoint();

        void EnterEvadeMode(EvadeReason /*why*/ = EVADE_REASON_OTHER) override;

        void UpdateAI(uint32 diff) override;        // the "internal" update, calls UpdateSceneAI()
        virtual void UpdateSceneAI(uint32 diff);   // used when it's needed to add code in update (abilities, scripted events, etc)

        void MovementInform(uint32, uint32) override;

        // SceneAI functions
        void AddWaypoint(uint32 id, float x, float y, float z, float o, uint32 waitTime = 0);    // waitTime is in ms
        void ClearWaypoint();

        virtual void PointReached(uint32 /*pointId*/) { }
        virtual void WaypointReached(uint32 /*pointId*/) { }
        virtual void LastWaypointReached() { }
        virtual void WaypointStart(uint32 /*pointId*/) { }

        void Start(bool isActiveAttacker = true, bool run = false, ObjectGuid playerGUID = ObjectGuid::Empty, Quest const* quest = NULL, bool instantRespawn = false, bool canLoopPath = false, bool resetWaypoints = true);

        void SetRun(bool on = true);
        void SetScenePaused(bool on);

        bool HasSceneState(uint32 sceneState) { return (m_uiSceneState & sceneState) != 0; }
        virtual bool IsSceneed() { return (m_uiSceneState & STATE_SCENE_SCENEING); }

        void SetMaxPlayerDistance(float newMax) { MaxPlayerDistance = newMax; }
        float GetMaxPlayerDistance() const { return MaxPlayerDistance; }

        void SetDespawnAtEnd(bool despawn) { DespawnAtEnd = despawn; }
        void SetDespawnAtFar(bool despawn) { DespawnAtFar = despawn; }
        bool GetAttack() const { return m_bIsActiveAttacker; }//used in EnterEvadeMode override
        void SetCanAttack(bool attack) { m_bIsActiveAttacker = attack; }
        ObjectGuid GetEventStarterGUID() const { return m_uiPlayerGUID; }
        void SetWaitTimer(uint32 Timer) { m_uiWPWaitTimer = Timer; }

    protected:
        Player* GetPlayerForScene();
        void TalkToScenePlayer(uint8 id);
        void SayToScenePlayer(uint8 id);
        void YellToScenePlayer(uint8 id);
        
    private:
        bool AssistPlayerInCombatAgainst(Unit* who);
        bool IsPlayerOrGroupInRange();
        void FillPointMovementListForCreature();

        void AddSceneState(uint32 seceneState) { m_uiSceneState |= seceneState; }
        void RemoveSceneState(uint32 seceneState) { m_uiSceneState &= ~seceneState; }

        ObjectGuid m_uiPlayerGUID;
        uint32 m_uiWPWaitTimer;
        uint32 m_uiPlayerCheckTimer;
        uint32 m_uiSceneState;
        float MaxPlayerDistance;
        uint32 LastWP;

        WaypointPath _path;

        Quest const* m_pQuestForScene;                     //generally passed in Start() when regular scene script.

        bool m_bIsActiveAttacker;                           //obsolete, determined by faction.
        bool m_bIsRunning;                                  //all creatures are walking by default (has flag MOVEMENTFLAG_WALK)
        bool m_bCanInstantRespawn;                          //if creature should respawn instantly after scene over (if not, database respawntime are used)
        bool m_bCanReturnToStart;                           //if creature can walk same path (loop) without despawn. Not for regular scene quests.
        bool DespawnAtEnd;
        bool DespawnAtFar;
        bool ScriptWP;
        bool HasImmuneToNPCFlags;
        bool m_bStarted;
        bool m_bEnded;
};
#endif
