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

#ifndef EVENTPROCESSOR_H
#define EVENTPROCESSOR_H

#include "Define.h"
#include <map>
#include <functional>

typedef std::multimap<uint64, std::function<void()>> FunctionList;

class EventProcessor;

// Note. All times are in milliseconds here.

class TC_COMMON_API BasicEvent
{
        friend class EventProcessor;

        enum class AbortState : uint8
        {
            STATE_RUNNING,
            STATE_ABORT_SCHEDULED,
            STATE_ABORTED
        };

    public:
        BasicEvent()
          : m_abortState(AbortState::STATE_RUNNING), m_addTime(0), m_execTime(0) { }

        virtual ~BasicEvent() { }                           // override destructor to perform some actions on event removal

        // this method executes when the event is triggered
        // return false if event does not want to be deleted
        // e_time is execution time, p_time is update interval
        virtual bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) { return true; }

        virtual bool IsDeletable() const { return true; }   // this event can be safely deleted

        virtual void Abort(uint64 /*e_time*/) { }           // this method executes when the event is aborted

        // Aborts the event at the next update tick
        void ScheduleAbort();

    private:
        void SetAborted();
        bool IsRunning() const { return (m_abortState == AbortState::STATE_RUNNING); }
        bool IsAbortScheduled() const { return (m_abortState == AbortState::STATE_ABORT_SCHEDULED); }
        bool IsAborted() const { return (m_abortState == AbortState::STATE_ABORTED); }

        AbortState m_abortState;                            // set by externals when the event is aborted, aborted events don't execute

        // these can be used for time offset control
        uint64 m_addTime;                                   // time when the event was added to queue, filled by event handler
        uint64 m_execTime;                                  // planned time of next execution, filled by event handler
};

class TC_COMMON_API EventProcessor
{
    public:
        EventProcessor() : m_time(0) { }
        ~EventProcessor();

        void Update(uint32 p_time);
        void KillAllEvents(bool force);
        void KillAllFunctions();
        void AddEvent(BasicEvent* Event, uint64 e_time, bool set_addtime = true);
        void AddFunction(std::function<void()>&& Function, uint64 e_time);
        uint64 CalculateTime(uint64 t_offset) const;
        void AddDelayedEvent(uint64 t_offset, std::function<void()>&& function);

    protected:
        uint64 m_time;
        std::multimap<uint64, BasicEvent*> m_events;
        FunctionList m_functions;
        FunctionList m_functions_queue;
        std::recursive_mutex m_queue_lock;
        bool clean;
};

#endif
