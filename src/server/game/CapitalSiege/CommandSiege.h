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

// SylvaniaCore - Module "Siege des Capitales"
//
// Commandant de la horde d invasion. Meme role que CommandBG en champ de
// bataille : il ne combat pas lui-meme, il distribue des ordres de deplacement
// aux bots, qui gerent leur combat seuls via BotBGAI.
//
// A la difference de CommandBG, il n est pas rattache a un Battleground : la
// progression suit une route de waypoints chargee depuis la table aiwaypoints,
// et chaque bot avance a son rythme le long de cette route.

#ifndef __COMMANDSIEGE_H__
#define __COMMANDSIEGE_H__

#include "AIWaypointsMgr.h"
#include "Common.h"
#include "ObjectGuid.h"
#include "Position.h"
#include "SharedDefines.h"

#include <map>
#include <vector>

class BotBGAI;
class Player;

// Cadence du commandant. Inutile de reflechir plus souvent : les bots mettent
// plusieurs secondes a franchir la distance entre deux points de la route.
#define COMMANDSIEGE_UPDATE_TICK 1000

// Distance a laquelle un point de la route est considere atteint.
#define COMMANDSIEGE_WAYPOINT_REACH 12.0f

class TC_GAME_API CommandSiege
{
public:
    CommandSiege(uint32 mapId, TeamId attackerTeam);
    ~CommandSiege();

    CommandSiege(CommandSiege const&) = delete;
    CommandSiege& operator=(CommandSiege const&) = delete;

    // Charge la route depuis aiwaypoints. Les entrees absentes de la table ou
    // situees sur une autre carte sont ignorees avec une trace.
    bool LoadRoute(uint32 firstEntry, uint32 lastEntry);
    bool IsRouteReady() const { return m_route.size() >= 2; }
    uint32 GetRouteSize() const { return uint32(m_route.size()); }
    Position GetStagingPosition() const;
    Position GetObjectivePosition() const;

    // Effectif -------------------------------------------------------------
    bool AddBot(Player* player);
    void RemoveBot(ObjectGuid guid);
    void DismissAll();

    uint32 GetBotCount() const { return uint32(m_bots.size()); }
    uint32 GetAliveCount() const;
    uint32 GetLostCount() const { return m_lostCount; }
    // Point de la route atteint par le bot le plus avance, pour l affichage GM.
    uint32 GetVanguardProgress() const;

    // Objectif final -------------------------------------------------------
    void SetBossGuid(ObjectGuid guid) { m_bossGuid = guid; }
    ObjectGuid GetBossGuid() const { return m_bossGuid; }

    void Update(uint32 diff);

    TeamId GetAttackerTeam() const { return m_attackerTeam; }
    uint32 GetMapId() const { return m_mapId; }

private:
    struct SiegeBot
    {
        uint32 waypointIndex;   // point de la route actuellement vise
        bool   dead;            // deja compte comme perte

        SiegeBot() : waypointIndex(0), dead(false) { }
    };

    Player* GetBot(ObjectGuid guid) const;
    BotBGAI* GetBotAI(ObjectGuid guid) const;
    void CommandBot(ObjectGuid guid, SiegeBot& state, Player* player);

private:
    uint32 m_mapId;
    TeamId m_attackerTeam;

    std::vector<AIWaypoint*> m_route;
    std::map<ObjectGuid, SiegeBot> m_bots;

    ObjectGuid m_bossGuid;
    uint32 m_lostCount;
    uint32 m_updateTimer;
};

#endif // __COMMANDSIEGE_H__
