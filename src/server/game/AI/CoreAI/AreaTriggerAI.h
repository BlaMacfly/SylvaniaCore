/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
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

#ifndef TRINITY_AREATRIGGERAI_H
#define TRINITY_AREATRIGGERAI_H

#include "Define.h"

class AreaTrigger;
class Unit;


// Moments d action des areatriggers (compat scripts DestinyCoreNew ; notre moteur
// n appelle PAS IsValidTarget : le filtrage de cibles de ces scripts est inactif)
enum AreaTriggerActionMoment
{
    AT_ACTION_MOMENT_ENTER          = 0x0001,
    AT_ACTION_MOMENT_LEAVE          = 0x0002,
    AT_ACTION_MOMENT_UPDATE_TARGET  = 0x0004,
    AT_ACTION_MOMENT_DESPAWN        = 0x0008,
    AT_ACTION_MOMENT_SPAWN          = 0x0010,
    AT_ACTION_MOMENT_REMOVE         = 0x0020,
    AT_ACTION_MOMENT_ON_THE_WAY     = 0x0040,
    AT_ACTION_MOMENT_ON_STOP_MOVE   = 0x0080,
};

class TC_GAME_API AreaTriggerAI
{
    protected:
        AreaTrigger* const at;
    public:
        explicit AreaTriggerAI(AreaTrigger* a);
        virtual ~AreaTriggerAI();

        // Called when the AreaTrigger has just been initialized, just before added to map
        virtual void OnInitialize() { }

        // Called when the AreaTrigger has just been created
        virtual void OnCreate() { }

        // Called on each AreaTrigger update
        virtual void OnUpdate(uint32 /*diff*/) { }

        // Called on each AreaTrigger proc, timer defined by at->SetPeriodicProcTimer(uint32)
        virtual void OnPeriodicProc() { }

        // Called when the AreaTrigger reach splineIndex
        virtual void OnSplineIndexReached(int /*splineIndex*/) { }

        // Called when the AreaTrigger reach its destination
        virtual void OnDestinationReached() { }

        // Called when an unit enter the AreaTrigger
        virtual void OnUnitEnter(Unit* /*unit*/) { }

        // Called when an unit exit the AreaTrigger, or when the AreaTrigger is removed
        virtual void OnUnitExit(Unit* /*unit*/) { }

        // Called when the AreaTrigger is removed
        virtual void OnRemove() { }

        // Pass parameters between AI
        virtual void DoAction(int32 /*param*/) { }

        // Called when the AreaTrigger is update target
        virtual void ActionOnUpdate(GuidList& affectedPlayers) {}
        virtual bool IsValidTarget(Unit* /*caster*/, Unit* /*target*/, AreaTriggerActionMoment /*actionM*/) { return true; }
        virtual bool CalculateSpline(Position const* /*pos*/, Position& /*startPos*/, Position& /*endPos*/, std::vector<Position>& /*path*/) { return false; }
};

class NullAreaTriggerAI : public AreaTriggerAI
{
    public:
        explicit NullAreaTriggerAI(AreaTrigger* areaTrigger) : AreaTriggerAI(areaTrigger) { }
};

#endif
