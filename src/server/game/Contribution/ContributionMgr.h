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

#ifndef ContributionMgr_h__
#define ContributionMgr_h__

#include "Define.h"
#include <map>
#include <vector>

class Player;
struct ContributionEntry;
struct ManagedWorldStateEntry;
struct ManagedWorldStateBuffEntry;
struct ManagedWorldStateInputEntry;

namespace WorldPackets
{
    namespace WorldState
    {
        class InitWorldStates;
    }
}

enum ContributionState : uint8
{
    CONTRIBUTION_STATE_NONE         = 0,
    CONTRIBUTION_STATE_BUILDING     = 1,
    CONTRIBUTION_STATE_ACTIVE       = 2,
    CONTRIBUTION_STATE_UNDER_ATTACK = 3,
    CONTRIBUTION_STATE_DESTROYED    = 4
};

enum ContributionBuilding : uint32
{
    CONTRIBUTION_MAGE_TOWER         = 1,
    CONTRIBUTION_COMMAND_CENTER     = 3,
    CONTRIBUTION_NETHER_DISRUPTOR   = 4
};

// A Legionfall building of the Broken Shore (7.2). Its stage, progress and number of completed constructions are world
// states named by ManagedWorldState.db2: the client reads them to draw the construction table and the map. Building fills
// the progress with contributions (100 War Supplies, through a repeatable quest); Active lasts UpTimeSecs; Under Attack
// drains the progress by DepletionAmountPerMinute; Destroyed lasts DownTimeSecs, then building starts again.
// Ported from Titans-Project (f00bd440) onto our world states; everything runs in the world thread.
struct ContributionData
{
    ContributionEntry const* Contribution = nullptr;
    ManagedWorldStateEntry const* WorldState = nullptr;
    ManagedWorldStateInputEntry const* Input = nullptr;
    uint32 LastChange = 0;      // unix time of the last stage change
};

class TC_GAME_API ContributionMgr
{
public:
    static ContributionMgr* instance();

    void Initialize();
    void Update(uint32 diff);
    void FillInitWorldStates(WorldPackets::WorldState::InitWorldStates& packet) const;

    void Contribute(Player* player, uint32 orderIndex);
    void OnStateRequest(Player* player, uint32 contributionID) const;

    ContributionState GetState(uint32 contributionID) const;
    uint32 GetProgressPct(uint32 contributionID) const;
    uint32 GetOccurrences(uint32 contributionID) const;
    uint32 GetNextChange(uint32 contributionID) const;     // unix time, 0 while building
    std::map<uint32, ContributionData> const& GetContributions() const { return _contributions; }

    // GM commands
    bool SetState(uint32 contributionID, ContributionState state);
    bool SetProgress(uint32 contributionID, uint32 percent);

private:
    bool IsAlwaysBuilt(ContributionData const& data) const;
    static uint32 GetValue(int32 worldStateID);
    static void SetValue(int32 worldStateID, uint32 value);
    void ChangeState(ContributionData& data, ContributionState state, uint32 now);
    void UpdateBuffs();
    uint32 GetCurrentBuff(ContributionData const& data, int32& conditionID) const;

    std::map<uint32, ContributionData> _contributions;     // by Contribution ID
    std::map<int32, std::vector<ManagedWorldStateBuffEntry const*>> _buffs;    // by ManagedWorldState ID
    uint32 _updateTimer = 0;
};

#define sContributionMgr ContributionMgr::instance()

#endif // ContributionMgr_h__
