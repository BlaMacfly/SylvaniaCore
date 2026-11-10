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

#include "ScenarioMgr.h"
#include "DatabaseEnv.h"
#include "DB2Stores.h"
#include "InstanceScenario.h"
#include "Log.h"
#include "Map.h"
#include "ScenarioPackets.h"

ScenarioMgr* ScenarioMgr::Instance()
{
    static ScenarioMgr instance;
    return &instance;
}

// Class scenarios share a map (Violet Hold 1494: mage 1034, hunter 1136): pick the row of the player's class,
// else a row for any class (LegionCore scenario_data.Class)
ScenarioDBData const* ScenarioMgr::SelectDBData(uint32 mapId, uint8 difficulty, uint8 playerClass) const
{
    auto itr = _scenarioDBData.find(std::make_pair(mapId, difficulty));
    if (itr == _scenarioDBData.end())
        return nullptr;

    ScenarioDBData const* anyClass = nullptr;
    for (ScenarioDBData const& data : itr->second)
    {
        if (!data.ClassID)
            anyClass = &data;
        else if (data.ClassID == playerClass)
            return &data;
    }

    return anyClass;
}

InstanceScenario* ScenarioMgr::CreateInstanceScenario(Map const* map, TeamId team, uint32 zoneId, uint8 playerClass /*= 0*/) const
{
    ScenarioDBData const* dbData = SelectDBData(map->GetId(), map->GetDifficultyID(), playerClass);
    // No scenario registered for this map and difficulty in the database: we then search for global scenario
    if (!dbData)
        dbData = SelectDBData(map->GetId(), 0, playerClass);

    // No more luck, return
    if (!dbData)
        return nullptr;

    uint32 scenarioID = 0;
    switch (team)
    {
    case TEAM_ALLIANCE:
        if (!dbData->ZoneID || zoneId == dbData->ZoneID)
            scenarioID = dbData->Scenario_A;
        break;
    case TEAM_HORDE:
        if (!dbData->ZoneID || zoneId == dbData->ZoneID)
            scenarioID = dbData->Scenario_H;
        break;
    default:
        break;
    }

    // class row without a scenario (LegionCore uses 0 to give none to that class)
    if (!scenarioID)
        return nullptr;

    auto itr = _scenarioData.find(scenarioID);
    if (itr == _scenarioData.end())
    {
        TC_LOG_ERROR("scenario", "Table `scenarios` contained data linking scenario (Id: %u) to map (Id: %u), difficulty (Id: %u) but no scenario data was found related to that scenario Id.", scenarioID, map->GetId(), map->GetDifficultyID());
        return nullptr;
    }

    return new InstanceScenario(map, &itr->second);
}

// A keystone run has its own scenario, bosses and enemy forces (LegionCore Scenario::CreateChallenge)
InstanceScenario* ScenarioMgr::CreateChallengeScenario(Map const* map, uint32 challengeModeId, bool teeming) const
{
    uint32 scenarioID = 0;
    switch (challengeModeId)
    {
        case 197: scenarioID = 1169; break; // Eye of Azshara
        case 198: scenarioID = 1172; break; // Darkheart Thicket
        case 199: scenarioID = 1166; break; // Black Rook Hold
        case 200: scenarioID = 1046; break; // Halls of Valor
        case 206: scenarioID = 1174; break; // Neltharion's Lair
        case 207: scenarioID = 1173; break; // Vault of the Wardens
        case 208: scenarioID = 1175; break; // Maw of Souls
        case 209: scenarioID = 1177; break; // The Arcway
        case 210: scenarioID = 1178; break; // Court of Stars
        case 227: scenarioID = 1309; break; // Return to Karazhan: Lower
        case 233: scenarioID = 1335; break; // Cathedral of Eternal Night
        case 234: scenarioID = 1308; break; // Return to Karazhan: Upper
        case 239: scenarioID = 1428; break; // Seat of the Triumvirate
        default:
            return nullptr;
    }

    if (teeming)
    {
        auto itr = _teemingScenarioData.find(scenarioID);
        if (itr != _teemingScenarioData.end())
            return new InstanceScenario(map, &itr->second);
    }

    auto itr = _scenarioData.find(scenarioID);
    if (itr == _scenarioData.end())
        return nullptr;

    return new InstanceScenario(map, &itr->second);
}

InstanceScenario * ScenarioMgr::CreateInstanceScenarioByID(Map const * map, uint32 zoneId)
{
    ScenarioDBData const* dbData = SelectDBData(map->GetId(), map->GetDifficultyID(), 0);
    // No scenario registered for this map and difficulty in the database
    if (!dbData)
        return nullptr;

    uint32 scenarioID = 0;
    if (!dbData->ZoneID || zoneId == dbData->ZoneID)
        scenarioID = dbData->Scenario_A;

    auto itr = _scenarioData.find(scenarioID);
    if (itr == _scenarioData.end())
    {
        TC_LOG_ERROR("scenario", "Table `scenarios` contained data linking scenario (Id: %u) to map (Id: %u), difficulty (Id: %u) but no scenario data was found related to that scenario Id.", scenarioID, map->GetId(), map->GetDifficultyID());
        return nullptr;
    }

    return new InstanceScenario(map, &itr->second);
}

void ScenarioMgr::LoadDBData()
{
    _scenarioDBData.clear();

    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT map, difficulty, scenario_A, scenario_H, zoneid, class FROM scenarios");

    if (!result)
    {
        TC_LOG_INFO("server.loading", ">> Loaded 0 scenarios. DB table `scenarios` is empty!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        uint32 mapId = fields[0].GetUInt32();
        uint8 difficulty = fields[1].GetUInt8();
        uint32 zoneid = fields[4].GetUInt32();

        uint32 scenarioAllianceId = fields[2].GetUInt32();
        if (scenarioAllianceId > 0 && _scenarioData.find(scenarioAllianceId) == _scenarioData.end())
        {
            TC_LOG_ERROR("sql.sql", "ScenarioMgr::LoadDBData: DB Table `scenarios`, column scenario_A contained an invalid scenario (Id: %u)!", scenarioAllianceId);
            continue;
        }

        uint32 scenarioHordeId = fields[3].GetUInt32();
        if (scenarioHordeId > 0 && _scenarioData.find(scenarioHordeId) == _scenarioData.end())
        {
            TC_LOG_ERROR("sql.sql", "ScenarioMgr::LoadDBData: DB Table `scenarios`, column scenario_H contained an invalid scenario (Id: %u)!", scenarioHordeId);
            continue;
        }

        if (scenarioHordeId == 0)
            scenarioHordeId = scenarioAllianceId;

        ScenarioDBData data;
        data.MapID = mapId;
        data.DifficultyID = difficulty;
        data.ZoneID = zoneid;
        data.Scenario_A = scenarioAllianceId;
        data.Scenario_H = scenarioHordeId;
        data.ClassID = fields[5].GetUInt8();
        _scenarioDBData[std::make_pair(mapId, difficulty)].push_back(data);
        ++count;
    }
    while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u instance scenario entries in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

// Keystone scenarios carry a "(More Trash)" step for the Teeming affix, run instead of their first step
static bool IsTeemingCriteriaTree(uint32 criteriaTreeId)
{
    switch (criteriaTreeId)
    {
        case 47415: // Halls of Valor
        case 50599: // Black Rook Hold
        case 51246: // Eye of Azshara
        case 51710: // Darkheart Thicket
        case 51880: // Vault of the Wardens
        case 52278: // Neltharion's Lair
        case 52327: // Maw of Souls
        case 52427: // The Arcway
        case 52471: // Court of Stars
        case 57810: // Return to Karazhan: Upper
        case 57866: // Return to Karazhan: Lower
        case 58715: // Cathedral of Eternal Night
        case 60933: // Seat of the Triumvirate
            return true;
        default:
            return false;
    }
}

void ScenarioMgr::LoadDB2Data()
{
    _scenarioData.clear();
    _teemingScenarioData.clear();

    std::unordered_map<uint32, std::map<uint8, ScenarioStepEntry const*>> scenarioSteps;
    std::unordered_map<uint32, ScenarioStepEntry const*> teemingSteps;
    uint32 deepestCriteriaTreeSize = 0;

    for (ScenarioStepEntry const* step : sScenarioStepStore)
    {
        // shares its OrderIndex with the normal step, which it used to overwrite
        if (IsTeemingCriteriaTree(step->Criteriatreeid))
            teemingSteps[step->ScenarioID] = step;
        else
            scenarioSteps[step->ScenarioID][step->OrderIndex] = step;

        if (CriteriaTree const* tree = sCriteriaMgr->GetCriteriaTree(step->Criteriatreeid))
        {
            uint32 criteriaTreeSize = 0;
            CriteriaMgr::WalkCriteriaTree(tree, [&criteriaTreeSize](CriteriaTree const* /*tree*/)
            {
                ++criteriaTreeSize;
            });
            deepestCriteriaTreeSize = std::max(deepestCriteriaTreeSize, criteriaTreeSize);
        }
    }

    ASSERT(deepestCriteriaTreeSize < MAX_ALLOWED_SCENARIO_POI_QUERY_SIZE, "MAX_ALLOWED_SCENARIO_POI_QUERY_SIZE must be at least %u", deepestCriteriaTreeSize + 1);

    for (ScenarioEntry const* scenario : sScenarioStore)
    {
        ScenarioData& data = _scenarioData[scenario->ID];
        data.Entry = scenario;
        data.Steps = std::move(scenarioSteps[scenario->ID]);
    }

    for (auto const& teemingStep : teemingSteps)
    {
        auto itr = _scenarioData.find(teemingStep.first);
        if (itr == _scenarioData.end() || itr->second.Steps.empty())
            continue;

        ScenarioData& data = _teemingScenarioData[teemingStep.first];
        data = itr->second;
        data.Steps.begin()->second = teemingStep.second;
    }
}

void ScenarioMgr::LoadScenarioPOI()
{
    uint32 oldMSTime = getMSTime();

    _scenarioPOIStore.clear(); // need for reload case

    uint32 count = 0;

    //                                                      0            1        2     6          7           8       9       10         11               12
    QueryResult result = WorldDatabase.Query("SELECT CriteriaTreeID, BlobIndex, Idx1, MapID, WorldMapAreaId, Floor, Priority, Flags, WorldEffectID, PlayerConditionID FROM scenario_poi ORDER BY CriteriaTreeID, Idx1");
    if (!result)
    {
        TC_LOG_ERROR("server.loading", ">> Loaded 0 scenario POI definitions. DB table `scenario_poi` is empty.");
        return;
    }

    //                                                       0        1    2  3
    QueryResult points = WorldDatabase.Query("SELECT CriteriaTreeID, Idx1, X, Y FROM scenario_poi_points ORDER BY CriteriaTreeID DESC, Idx1, Idx2");

    std::vector<std::vector<std::vector<ScenarioPOIPoint>>> POIs;

    if (points)
    {
        // The first result should have the highest criteriaTreeId
        Field* fields = points->Fetch();
        uint32 criteriaTreeIdMax = fields[0].GetInt32();
        POIs.resize(criteriaTreeIdMax + 1);

        do
        {
            fields = points->Fetch();

            int32 CriteriaTreeID = fields[0].GetInt32();
            int32 Idx1 = fields[1].GetInt32();
            int32 X = fields[2].GetInt32();
            int32 Y = fields[3].GetInt32();

            if (int32(POIs[CriteriaTreeID].size()) <= Idx1 + 1)
                POIs[CriteriaTreeID].resize(Idx1 + 10);

            ScenarioPOIPoint point(X, Y);
            POIs[CriteriaTreeID][Idx1].push_back(point);
        } while (points->NextRow());
    }

    do
    {
        Field* fields = result->Fetch();

        int32 CriteriaTreeID = fields[0].GetInt32();
        int32 BlobIndex = fields[1].GetInt32();
        int32 Idx1 = fields[2].GetInt32();
        int32 MapID = fields[3].GetInt32();
        int32 WorldMapAreaId = fields[4].GetInt32();
        int32 Floor = fields[5].GetInt32();
        int32 Priority = fields[6].GetInt32();
        int32 Flags = fields[7].GetInt32();
        int32 WorldEffectID = fields[8].GetInt32();
        int32 PlayerConditionID = fields[9].GetInt32();

        if (!sCriteriaMgr->GetCriteriaTree(CriteriaTreeID))
            TC_LOG_ERROR("sql.sql", "`scenario_poi` CriteriaTreeID (%u) Idx1 (%u) does not correspond to a valid criteria tree", CriteriaTreeID, Idx1);

        if (CriteriaTreeID < int32(POIs.size()) && Idx1 < int32(POIs[CriteriaTreeID].size()))
            _scenarioPOIStore[CriteriaTreeID].emplace_back(BlobIndex, MapID, WorldMapAreaId, Floor, Priority, Flags, WorldEffectID, PlayerConditionID, POIs[CriteriaTreeID][Idx1]);
        else
            TC_LOG_ERROR("server.loading", "Table scenario_poi references unknown scenario poi points for criteria tree id %i POI id %i", CriteriaTreeID, BlobIndex);

        ++count;
    } while (result->NextRow());

    TC_LOG_INFO("server.loading", ">> Loaded %u scenario POI definitions in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
}

ScenarioPOIVector const* ScenarioMgr::GetScenarioPOIs(int32 criteriaTreeID) const
{
    auto itr = _scenarioPOIStore.find(criteriaTreeID);
    if (itr != _scenarioPOIStore.end())
        return &itr->second;

    return nullptr;
}
