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

#include "Creature.h"
#include "DatabaseEnv.h"
#include "GameObject.h"
#include "GarrisonMgr.h"
#include "Log.h"
#include "MapManager.h"
#include "PhasingHandler.h"
#include "ObjectMgr.h"
#include "VehicleDefines.h"
#include "WodGarrison.h"
#include "MotionMaster.h"
#include "Random.h"
#include <cmath>

enum : uint32 { GARRISON_BUILDING_BARRACKS_1 = 26 }; // GarrBuilding.db2 : Caserne niveau 1

WodGarrison::WodGarrison(Player* owner) : Garrison(owner)
{
    _garrisonType = GARRISON_TYPE_GARRISON;
}

bool WodGarrison::LoadFromDB()
{
    if (!Garrison::LoadFromDB())
        return false;

    ObjectGuid::LowType lowGuid = _owner->GetGUID().GetCounter();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_GARRISON_BLUEPRINTS);
    stmt->setUInt64(0, lowGuid);
    stmt->setUInt8(1, _garrisonType);
    PreparedQueryResult blueprints = CharacterDatabase.Query(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_GARRISON_BUILDINGS);
    stmt->setUInt64(0, lowGuid);
    stmt->setUInt8(1, _garrisonType);
    PreparedQueryResult buildings = CharacterDatabase.Query(stmt);

    InitializePlots();

    if (blueprints)
    {
        do
        {
            Field* fields = blueprints->Fetch();
            if (GarrBuildingEntry const* building = sGarrBuildingStore.LookupEntry(fields[0].GetUInt32()))
                _knownBuildings.insert(building->ID);

        } while (blueprints->NextRow());
    }

    if (buildings)
    {
        do
        {
            Field* fields = buildings->Fetch();
            uint32 plotInstanceId = fields[0].GetUInt32();
            uint32 buildingId = fields[1].GetUInt32();
            time_t timeBuilt = time_t(fields[2].GetUInt64());
            bool active = fields[3].GetBool();


            Plot* plot = GetPlot(plotInstanceId);
            if (!plot)
                continue;

            if (!sGarrBuildingStore.LookupEntry(buildingId))
                continue;

            plot->BuildingInfo.PacketInfo.emplace();
            plot->BuildingInfo.PacketInfo->GarrPlotInstanceID = plotInstanceId;
            plot->BuildingInfo.PacketInfo->GarrBuildingID = buildingId;
            plot->BuildingInfo.PacketInfo->TimeBuilt = timeBuilt;
            plot->BuildingInfo.PacketInfo->Active = active;

        } while (buildings->NextRow());
    }

    return true;
}

void WodGarrison::SaveToDB(CharacterDatabaseTransaction& trans)
{
    Garrison::SaveToDB(trans);

    for (uint32 building : _knownBuildings)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_GARRISON_BLUEPRINTS);
        stmt->setUInt64(0, _owner->GetGUID().GetCounter());
        stmt->setUInt8(1, _garrisonType);
        stmt->setUInt32(2, building);
        trans->Append(stmt);
    }

    for (auto const& p : _plots)
    {
        Plot const& plot = p.second;
        if (plot.BuildingInfo.PacketInfo)
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHARACTER_GARRISON_BUILDINGS);
            stmt->setUInt64(0, _owner->GetGUID().GetCounter());
            stmt->setUInt8(1, _garrisonType);
            stmt->setUInt32(2, plot.BuildingInfo.PacketInfo->GarrPlotInstanceID);
            stmt->setUInt32(3, plot.BuildingInfo.PacketInfo->GarrBuildingID);
            stmt->setUInt64(4, plot.BuildingInfo.PacketInfo->TimeBuilt);
            stmt->setBool(5, plot.BuildingInfo.PacketInfo->Active);
            trans->Append(stmt);
        }
    }
}

bool WodGarrison::Create(uint32 garrSiteId)
{
    if (!Garrison::Create(garrSiteId))
        return false;

    InitializePlots();
    _owner->SendGarrisonRemoteInfo();
    return true;
}

bool WodGarrison::CanUpgrade(bool checkCost /*= true*/)
{
    if (_siteLevel->GarrLevel >= WOD_GARRISON_LEVEL_MAX)
        return false;

    if (checkCost)
    {
        if (_owner->GetCurrency(GARRISON_WOD_CURRENCY) < _siteLevel->UpgradeCost)
            return false;

        if (_owner->GetMoney() < _siteLevel->UpgradeGoldCost)
            return false;
    }

    if (!AI()->OnCheckUpgradeable())
        return false;

    return true;
}

bool WodGarrison::Upgrade()
{
    if (!CanUpgrade())
        return false;

    GarrSiteLevelEntry const* siteLevel = sGarrisonMgr.GetGarrSiteLevelEntry(_siteLevel->GarrSiteID, _siteLevel->GarrLevel + 1);
    if (!siteLevel)
        return false;

    _owner->ModifyCurrency(GARRISON_WOD_CURRENCY, -_siteLevel->UpgradeCost);
    _owner->ModifyMoney(-_siteLevel->UpgradeGoldCost);

    SetSiteLevel(siteLevel);
    InitializePlots();
    _owner->SendGarrisonRemoteInfo();
    PhasingHandler::OnConditionChange(_owner);

    TeleportOwnerToGarrison();

    return true;
}

void WodGarrison::TeleportOwnerToGarrison() const
{
    Position WodGarrisonEntrancePositions[2][3] =
    {
        // Horde
        {
            { 5698.020020f, 4512.1635574f,  127.401695f,    2.8622720f  },
            { 5754.82f,     4495.425f,      132.50f,        2.90f       },
            { 5622.5063f,   4465.5161f,     130.1637f,      0.0f        }
        },
        // Alliance
        {
            { 1766.761475f, 191.2846830f, 72.115326f, 0.4649370f },
            { 1759.94f,     184.86f,      71.50f,     0.57f      },
            { 1759.94f,     184.86f,      71.50f,     0.57f      }
        }
    };

    /// Le film d'etablissement du fief (189 Horde / 192 Alliance, et 190/191/193/194
    /// aux niveaux suivants) fige le client : le joueur doit se reconnecter. Comme il
    /// n'envoie alors jamais CMSG_COMPLETE_MOVIE, l'action differee ne partait pas et
    /// il n'etait jamais teleporte dans son fief. On teleporte donc directement.
    /// Remettre AddMovieDelayedAction + SendMovieStart(_siteLevel->UpgradeMovieID) le
    /// jour ou la cause du gel cote client sera connue.
    _owner->TeleportTo(_siteLevel->MapID, WodGarrisonEntrancePositions[GetFaction()][_siteLevel->GarrLevel - 1]);
}

void WodGarrison::Delete()
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    DeleteFromDB(trans);
    CharacterDatabase.CommitTransaction(trans);

    Garrison::Delete();
}

void WodGarrison::InitializePlots()
{
    if (std::vector<GarrSiteLevelPlotInstEntry const*> const* plots = sGarrisonMgr.GetGarrPlotInstForSiteLevel(_siteLevel->ID))
    {
        for (std::size_t i = 0; i < plots->size(); ++i)
        {
            uint32 garrPlotInstanceId = plots->at(i)->GarrPlotInstanceID;
            GarrPlotInstanceEntry const* plotInstance = sGarrPlotInstanceStore.LookupEntry(garrPlotInstanceId);
            GameObjectsEntry const* gameObject = sGarrisonMgr.GetPlotGameObject(_siteLevel->MapID, garrPlotInstanceId);
            if (!plotInstance || !gameObject)
                continue;

            GarrPlotEntry const* plot = sGarrPlotStore.LookupEntry(plotInstance->GarrPlotID);
            if (!plot)
                continue;

            Plot& plotInfo = _plots[garrPlotInstanceId];
            plotInfo.PacketInfo.GarrPlotInstanceID = garrPlotInstanceId;
            plotInfo.PacketInfo.PlotPos = Position(gameObject->Pos.X, gameObject->Pos.Y, gameObject->Pos.Z, 2 * std::acos(gameObject->Rot[3]));
            plotInfo.PacketInfo.PlotType = plot->PlotType;
            plotInfo.Rotation = QuaternionData(gameObject->Rot[0], gameObject->Rot[1], gameObject->Rot[2], gameObject->Rot[3]);
            plotInfo.EmptyGameObjectId = gameObject->ID;
            plotInfo.GarrSiteLevelPlotInstId = plots->at(i)->ID;
        }
    }
}

void WodGarrison::Enter()
{
    Garrison::Enter();

    if (MapEntry const* map = sMapStore.LookupEntry(_siteLevel->MapID))
        if (int32(_owner->GetMapId()) == map->ParentMapID)
        {
            if (_owner->GetMotionMaster()->GetCurrentMovementGeneratorType() == FLIGHT_MOTION_TYPE)
            {
                _owner->GetScheduler().Schedule(Milliseconds(10000), [this](TaskContext context)
                    {
                        _owner->SeamlessTeleportToMap(_siteLevel->MapID);
                    });
            }
            else
                _owner->SeamlessTeleportToMap(_siteLevel->MapID);
        }
}

void WodGarrison::Leave()
{
    if (MapEntry const* map = sMapStore.LookupEntry(_siteLevel->MapID))
    {
        if (_owner->GetMapId() == _siteLevel->MapID)
        {
            uint32 futureAreaId = sMapMgr->GetAreaId(_owner->GetPhaseShift(), map->ParentMapID, _owner->GetPositionX(), _owner->GetPositionY(), _owner->GetPositionZ());

            // This check prevent infinite teleport if new map don't exactly overlap current map area
            if (AreaTableEntry const* futureArea = sAreaTableStore.LookupEntry(futureAreaId))
                if (IsAllowedArea(futureArea))
                    return;

            Garrison::Leave();
            if (_owner->GetMotionMaster()->GetCurrentMovementGeneratorType() != FLIGHT_MOTION_TYPE)
                _owner->SeamlessTeleportToMap(map->ParentMapID);
        }
        else // We already have been teleported
            Garrison::Leave();
    }
}

bool WodGarrison::IsAllowedArea(AreaTableEntry const* area) const
{
    if (!area)
        return false;

    switch (area->ID)
    {
        case 7004: // Horde Garrison
        //case 7765: // Horde Shipyard
        case 7078: // Alliance Garrison
        //case 7760: // Alliance Shipyard
            return true;
        default:
            break;
    }

    return area->Flags[1] & AREA_FLAG_GARRISON && area->ContinentID == MAP_DRAENOR;
}

std::vector<WodGarrison::Plot*> WodGarrison::GetPlots()
{
    std::vector<Plot*> plots;
    plots.reserve(_plots.size());
    for (auto& p : _plots)
        plots.push_back(&p.second);

    return plots;
}

WodGarrison::Plot* WodGarrison::GetPlot(uint32 garrPlotInstanceId)
{
    auto itr = _plots.find(garrPlotInstanceId);
    if (itr != _plots.end())
        return &itr->second;

    return nullptr;
}

WodGarrison::Plot const* WodGarrison::GetPlot(uint32 garrPlotInstanceId) const
{
    auto itr = _plots.find(garrPlotInstanceId);
    if (itr != _plots.end())
        return &itr->second;

    return nullptr;
}

void WodGarrison::LearnBlueprint(uint32 garrBuildingId)
{
    WorldPackets::Garrison::GarrisonLearnBlueprintResult learnBlueprintResult;
    learnBlueprintResult.GarrTypeID = GARRISON_TYPE_GARRISON;
    learnBlueprintResult.BuildingID = garrBuildingId;
    learnBlueprintResult.Result = GARRISON_SUCCESS;

    if (!sGarrBuildingStore.LookupEntry(garrBuildingId))
        learnBlueprintResult.Result = GARRISON_ERROR_INVALID_BUILDINGID;
    else if (HasBlueprint(garrBuildingId))
        learnBlueprintResult.Result = GARRISON_ERROR_BLUEPRINT_EXISTS;
    else
        _knownBuildings.insert(garrBuildingId);

    _owner->SendDirectMessage(learnBlueprintResult.Write());
}

void WodGarrison::UnlearnBlueprint(uint32 garrBuildingId)
{
    WorldPackets::Garrison::GarrisonUnlearnBlueprintResult unlearnBlueprintResult;
    unlearnBlueprintResult.GarrTypeID = GARRISON_TYPE_GARRISON;
    unlearnBlueprintResult.BuildingID = garrBuildingId;
    unlearnBlueprintResult.Result = GARRISON_SUCCESS;

    if (!sGarrBuildingStore.LookupEntry(garrBuildingId))
        unlearnBlueprintResult.Result = GARRISON_ERROR_INVALID_BUILDINGID;
    else if (!HasBlueprint(garrBuildingId))
        unlearnBlueprintResult.Result = GARRISON_ERROR_REQUIRES_BLUEPRINT;
    else
        _knownBuildings.erase(garrBuildingId);

    _owner->SendDirectMessage(unlearnBlueprintResult.Write());
}

void WodGarrison::PlaceBuilding(uint32 garrPlotInstanceId, uint32 garrBuildingId)
{
    WorldPackets::Garrison::GarrisonPlaceBuildingResult placeBuildingResult;
    placeBuildingResult.GarrTypeID = GARRISON_TYPE_GARRISON;
    placeBuildingResult.Result = CheckBuildingPlacement(garrPlotInstanceId, garrBuildingId);
    if (placeBuildingResult.Result == GARRISON_SUCCESS)
    {
        placeBuildingResult.BuildingInfo.GarrPlotInstanceID = garrPlotInstanceId;
        placeBuildingResult.BuildingInfo.GarrBuildingID = garrBuildingId;
        placeBuildingResult.BuildingInfo.TimeBuilt = time(nullptr);

        // LegionCore instance_garr.cpp (OnPlaceBuilding) : caserne de niveau 1 posee pendant "Construire votre caserne"
        // (Horde 34461 / Alliance 34587). Construite en 60 s au lieu de 3600 (Gazlowe, texte 82336 : "seein' as how this
        // is your first building...") ; cote Horde, credit de l'objectif "Suivez Gazlowe" (78466).
        if (garrBuildingId == GARRISON_BUILDING_BARRACKS_1)
        {
            bool horde = GetFaction() == GARRISON_FACTION_INDEX_HORDE;
            if (_owner->GetQuestStatus(horde ? 34461 : 34587) == QUEST_STATUS_INCOMPLETE)
            {
                if (Creature* guide = _owner->FindNearestCreature(horde ? 78466 : 77209, 100.0f))
                {
                    placeBuildingResult.BuildingInfo.TimeBuilt -= 3540;
                    if (horde)
                        _owner->KilledMonsterCredit(guide->GetEntry());
                }
            }
        }

        Plot* plot = GetPlot(garrPlotInstanceId);
        uint32 oldBuildingId = 0;
        Map* map = FindMap();
        GarrBuildingEntry const* building = sGarrBuildingStore.AssertEntry(garrBuildingId);
        if (map)
            plot->DeleteGameObject(map);

        if (plot->BuildingInfo.PacketInfo)
        {
            oldBuildingId = plot->BuildingInfo.PacketInfo->GarrBuildingID;
            if (sGarrBuildingStore.AssertEntry(oldBuildingId)->BuildingType != building->BuildingType)
                plot->ClearBuildingInfo(_owner);
        }

        plot->SetBuildingInfo(placeBuildingResult.BuildingInfo, _owner);
        if (map)
            if (GameObject* go = plot->CreateGameObject(map, GetFaction()))
                map->AddToMap(go);

        _owner->ModifyCurrency(building->CurrencyTypeID, -building->CurrencyQty, false, true);
        _owner->ModifyMoney(-building->GoldCost * GOLD, false);

        if (oldBuildingId)
        {
            WorldPackets::Garrison::GarrisonBuildingRemoved buildingRemoved;
            buildingRemoved.GarrTypeID = GARRISON_TYPE_GARRISON;
            buildingRemoved.Result = GARRISON_SUCCESS;
            buildingRemoved.GarrPlotInstanceID = garrPlotInstanceId;
            buildingRemoved.GarrBuildingID = oldBuildingId;
            _owner->SendDirectMessage(buildingRemoved.Write());
        }

        _owner->UpdateCriteria(CRITERIA_TYPE_PLACE_GARRISON_BUILDING, garrBuildingId);
    }

    _owner->SendDirectMessage(placeBuildingResult.Write());
}

void WodGarrison::CancelBuildingConstruction(uint32 garrPlotInstanceId)
{
    WorldPackets::Garrison::GarrisonBuildingRemoved buildingRemoved;
    buildingRemoved.GarrTypeID = GARRISON_TYPE_GARRISON;
    buildingRemoved.Result = CheckBuildingRemoval(garrPlotInstanceId);
    if (buildingRemoved.Result == GARRISON_SUCCESS)
    {
        Plot* plot = GetPlot(garrPlotInstanceId);

        buildingRemoved.GarrPlotInstanceID = garrPlotInstanceId;
        buildingRemoved.GarrBuildingID = plot->BuildingInfo.PacketInfo->GarrBuildingID;

        Map* map = FindMap();
        if (map)
            plot->DeleteGameObject(map);

        plot->ClearBuildingInfo(_owner);
        _owner->SendDirectMessage(buildingRemoved.Write());

        GarrBuildingEntry const* constructing = sGarrBuildingStore.AssertEntry(buildingRemoved.GarrBuildingID);
        // Refund construction/upgrade cost
        _owner->ModifyCurrency(constructing->CurrencyTypeID, constructing->CurrencyQty, false, true);
        _owner->ModifyMoney(constructing->GoldCost * GOLD, false);

        if (constructing->UpgradeLevel > 1)
        {
            // Restore previous level building
            uint32 restored = sGarrisonMgr.GetPreviousLevelBuildingId(constructing->BuildingType, constructing->UpgradeLevel);
            ASSERT(restored);

            WorldPackets::Garrison::GarrisonPlaceBuildingResult placeBuildingResult;
            placeBuildingResult.GarrTypeID = GARRISON_TYPE_GARRISON;
            placeBuildingResult.Result = GARRISON_SUCCESS;
            placeBuildingResult.BuildingInfo.GarrPlotInstanceID = garrPlotInstanceId;
            placeBuildingResult.BuildingInfo.GarrBuildingID = restored;
            placeBuildingResult.BuildingInfo.TimeBuilt = time(nullptr);
            placeBuildingResult.BuildingInfo.Active = true;

            plot->SetBuildingInfo(placeBuildingResult.BuildingInfo, _owner);
            _owner->SendDirectMessage(placeBuildingResult.Write());
        }

        if (map)
            if (GameObject* go = plot->CreateGameObject(map, GetFaction()))
                map->AddToMap(go);
    }
    else
        _owner->SendDirectMessage(buildingRemoved.Write());
}

void WodGarrison::ActivateBuilding(uint32 garrPlotInstanceId)
{
    if (Plot* plot = GetPlot(garrPlotInstanceId))
    {
        if (plot->BuildingInfo.CanActivate() && plot->BuildingInfo.PacketInfo && !plot->BuildingInfo.PacketInfo->Active)
        {
            plot->BuildingInfo.PacketInfo->Active = true;
            if (Map* map = FindMap())
            {
                plot->DeleteGameObject(map);
                if (GameObject* go = plot->CreateGameObject(map, GetFaction()))
                    map->AddToMap(go);
            }

            WorldPackets::Garrison::GarrisonBuildingActivated buildingActivated;
            buildingActivated.GarrPlotInstanceID = garrPlotInstanceId;
            _owner->SendDirectMessage(buildingActivated.Write());

            // LC Garrison.cpp:1393 / TC master Garrison::ActivateBuilding : jamais appele ici, d'ou "Finaliser votre parcelle"
            // (critere 25030 = type 169 sur le batiment 26) impossible
            _owner->UpdateCriteria(CRITERIA_TYPE_CONSTRUCT_GARRISON_BUILDING, plot->BuildingInfo.PacketInfo->GarrBuildingID);
        }
    }
}

/// Batiment offert par une quete : ni plan, ni cout, construit d emblee (LegionCore Garrison::PlaceBuilding(plot, build, true))
void WodGarrison::PlaceQuestRewardBuilding(uint32 garrPlotInstanceId, uint32 garrBuildingId)
{
    Plot* plot = GetPlot(garrPlotInstanceId);
    GarrPlotInstanceEntry const* plotInstance = sGarrPlotInstanceStore.LookupEntry(garrPlotInstanceId);
    GarrBuildingEntry const* building = sGarrBuildingStore.LookupEntry(garrBuildingId);
    if (!plot || !plotInstance || !building || plot->BuildingInfo.PacketInfo)
        return;

    if (!sGarrisonMgr.IsPlotMatchingBuilding(plotInstance->GarrPlotID, garrBuildingId))
        return;

    WorldPackets::Garrison::GarrisonPlaceBuildingResult placeBuildingResult;
    placeBuildingResult.GarrTypeID = GARRISON_TYPE_GARRISON;
    placeBuildingResult.Result = GARRISON_SUCCESS;
    placeBuildingResult.BuildingInfo.GarrPlotInstanceID = garrPlotInstanceId;
    placeBuildingResult.BuildingInfo.GarrBuildingID = garrBuildingId;
    placeBuildingResult.BuildingInfo.TimeBuilt = time(nullptr) - building->BuildSeconds;

    Map* map = FindMap();
    if (map)
        plot->DeleteGameObject(map);

    plot->SetBuildingInfo(placeBuildingResult.BuildingInfo, _owner);
    if (map)
        if (GameObject* go = plot->CreateGameObject(map, GetFaction()))
            map->AddToMap(go);

    _owner->SendDirectMessage(placeBuildingResult.Write());
    _owner->UpdateCriteria(CRITERIA_TYPE_PLACE_GARRISON_BUILDING, garrBuildingId);

    ActivateBuilding(garrPlotInstanceId);
}

/// Batiments ouverts par une quete, leur sort de recompense n etant qu un effet factice (LegionCore Garrison::OnQuestReward)
void WodGarrison::OnQuestReward(uint32 questId)
{
    switch (questId)
    {
        case 36404: // Clearing the Garden (jardin, parcelle 63)
        case 34193:
            PlaceQuestRewardBuilding(63, 29);
            break;
        case 35154: // Things Are Not Goren Our Way (mine, parcelle 59)
        case 34192:
            PlaceQuestRewardBuilding(59, 61);
            break;
        case 36870: // Luring Nat (cabane de peche, parcelle 67)
        case 36612:
            PlaceQuestRewardBuilding(67, 64);
            break;
        case 36483: // menagerie, parcelle 81
        case 36662:
            PlaceQuestRewardBuilding(81, 42);
            break;
        default:
            break;
    }
}

std::unordered_set<uint32> const& WodGarrison::GetKnownBuildings() const
{
    return _knownBuildings;
}

void WodGarrison::SendBuildingLandmarks(Player* receiver) const
{
    WorldPackets::Garrison::GarrisonBuildingLandmarks buildingLandmarks;
    buildingLandmarks.Landmarks.reserve(_plots.size());

    for (auto const& p : _plots)
    {
        Plot const& plot = p.second;
        if (plot.BuildingInfo.PacketInfo)
            if (uint32 garrBuildingPlotInstId = sGarrisonMgr.GetGarrBuildingPlotInst(plot.BuildingInfo.PacketInfo->GarrBuildingID, plot.GarrSiteLevelPlotInstId))
                buildingLandmarks.Landmarks.emplace_back(garrBuildingPlotInstId, plot.PacketInfo.PlotPos);
    }

    receiver->SendDirectMessage(buildingLandmarks.Write());
}

GarrisonError WodGarrison::CheckBuildingPlacement(uint32 garrPlotInstanceId, uint32 garrBuildingId) const
{
    GarrPlotInstanceEntry const* plotInstance = sGarrPlotInstanceStore.LookupEntry(garrPlotInstanceId);
    Plot const* plot = GetPlot(garrPlotInstanceId);
    if (!plotInstance || !plot)
        return GARRISON_ERROR_INVALID_PLOT_INSTANCEID;

    GarrBuildingEntry const* building = sGarrBuildingStore.LookupEntry(garrBuildingId);
    if (!building)
        return GARRISON_ERROR_INVALID_BUILDINGID;

    if (!sGarrisonMgr.IsPlotMatchingBuilding(plotInstance->GarrPlotID, garrBuildingId))
        return GARRISON_ERROR_INVALID_PLOT_BUILDING;

    // Cannot place buldings of higher level than garrison level
    if (building->UpgradeLevel > _siteLevel->MaxBuildingLevel)
        return GARRISON_ERROR_INVALID_BUILDINGID;

    if (building->Flags & GARRISON_BUILDING_FLAG_NEEDS_PLAN)
    {
        if (!HasBlueprint(garrBuildingId))
            return GARRISON_ERROR_REQUIRES_BLUEPRINT;
    }
    else // Building is built as a quest reward
        return GARRISON_ERROR_INVALID_BUILDINGID;

    for (auto const& p : _plots)
    {
        if (p.second.BuildingInfo.PacketInfo)
        {
            GarrBuildingEntry const* existingBuilding = sGarrBuildingStore.AssertEntry(p.second.BuildingInfo.PacketInfo->GarrBuildingID);
            if (existingBuilding->BuildingType == building->BuildingType)
                if (p.first != garrPlotInstanceId || existingBuilding->UpgradeLevel + 1 != building->UpgradeLevel)    // check if its an upgrade in same plot
                    return GARRISON_ERROR_BUILDING_EXISTS;
        }
    }

    if (!_owner->HasCurrency(building->CurrencyTypeID, building->CurrencyQty))
        return GARRISON_ERROR_NOT_ENOUGH_CURRENCY;

    if (!_owner->HasEnoughMoney(uint64(building->GoldCost) * GOLD))
        return GARRISON_ERROR_NOT_ENOUGH_GOLD;

    // New building cannot replace another building currently under construction
    if (plot->BuildingInfo.PacketInfo)
        if (!plot->BuildingInfo.PacketInfo->Active)
            return GARRISON_ERROR_NO_BUILDING;

    return GARRISON_SUCCESS;
}

GarrisonError WodGarrison::CheckBuildingRemoval(uint32 garrPlotInstanceId) const
{
    Plot const* plot = GetPlot(garrPlotInstanceId);
    if (!plot)
        return GARRISON_ERROR_INVALID_PLOT_INSTANCEID;

    if (!plot->BuildingInfo.PacketInfo)
        return GARRISON_ERROR_NO_BUILDING;

    if (plot->BuildingInfo.CanActivate())
        return GARRISON_ERROR_BUILDING_EXISTS;

    return GARRISON_SUCCESS;
}

template<class T, void(T::*SecondaryRelocate)(float, float, float, float)>
T* BuildingSpawnHelper(GameObject* building, ObjectGuid::LowType spawnId, Map* map)
{
    T* spawn = new T();
    if (!spawn->LoadFromDB(spawnId, map))
    {
        delete spawn;
        return nullptr;
    }

    float x = spawn->GetPositionX();
    float y = spawn->GetPositionY();
    float z = spawn->GetPositionZ();
    float o = spawn->GetOrientation();
    TransportBase::CalculatePassengerPosition(x, y, z, &o, building->GetPositionX(), building->GetPositionY(), building->GetPositionZ(), building->GetOrientation());

    spawn->Relocate(x, y, z, o);
    (spawn->*SecondaryRelocate)(x, y, z, o);

    if (!spawn->IsPositionValid())
    {
        delete spawn;
        return nullptr;
    }

    if (!map->AddToMap(spawn))
    {
        delete spawn;
        return nullptr;
    }

    return spawn;
}

namespace
{
    // Cartes de fief WoD par faction (niveaux 1, 2, 3) : cf. GarrSiteLevel.db2 (258/445/259 Horde, 5/444/6 Alliance)
    bool IsWodGarrisonMapOfFaction(uint32 mapId, GarrisonFactionIndex faction)
    {
        switch (mapId)
        {
            case 1152: case 1330: case 1153: return faction == GARRISON_FACTION_INDEX_HORDE;
            case 1158: case 1331: case 1159: return faction == GARRISON_FACTION_INDEX_ALLIANCE;
            default: return false;
        }
    }

    float PlotYaw(float qz, float qw) { return 2.0f * std::atan2(qz, qw); }

    /// Garde les lignes relevees sur la carte courante, sinon celles d'une seule autre carte de la faction
    /// (LC les prenait toutes : 9 couples batiment/parcelle releves sur deux niveaux apparaissaient en double).
    std::vector<GarrisonBuildingSpawn const*> SelectBuildingSpawns(std::vector<GarrisonBuildingSpawn> const* rows, uint32 currentMapId, GarrisonFactionIndex faction, bool active, bool hasBuilding)
    {
        std::vector<GarrisonBuildingSpawn const*> selected;
        if (!rows)
            return selected;

        uint32 sourceMapId = 0;
        for (GarrisonBuildingSpawn const& row : *rows)
            if (row.MapId == currentMapId)
                sourceMapId = currentMapId;

        for (GarrisonBuildingSpawn const& row : *rows)
        {
            if (!IsWodGarrisonMapOfFaction(row.MapId, faction))
                continue;

            if (!sourceMapId)
                sourceMapId = row.MapId;
            if (row.MapId != sourceMapId)
                continue;

            // regle de LC (GarrisonPlot.cpp) : ouvriers seulement pendant le chantier, contenu seulement batiment actif
            if (row.DuringConstruction && !hasBuilding)
                continue;
            if (hasBuilding && active == row.DuringConstruction)
                continue;

            selected.push_back(&row);
        }
        return selected;
    }
}

/// Recale une position relevee sur la parcelle `plotInstanceId` de la carte `sourceMapId` sur la parcelle courante.
/// Identite quand la parcelle a la meme pose (ex. parcelle 18 Horde : 1152 = 1330, mais pas 1153).
Position WodGarrison::Plot::RelocateBuildingSpawn(GarrisonBuildingSpawn const& row) const
{
    GameObjectsEntry const* source = sGarrisonMgr.GetPlotGameObject(row.MapId, PacketInfo.GarrPlotInstanceID);
    if (!source)
        return row.Pos;

    Position const& target = PacketInfo.PlotPos.Pos;
    float delta = PlotYaw(Rotation.z, Rotation.w) - PlotYaw(source->Rot[2], source->Rot[3]);
    float dx = row.Pos.GetPositionX() - source->Pos.X;
    float dy = row.Pos.GetPositionY() - source->Pos.Y;
    float c = std::cos(delta), s = std::sin(delta);
    return Position(target.GetPositionX() + dx * c - dy * s,
                    target.GetPositionY() + dx * s + dy * c,
                    target.GetPositionZ() + row.Pos.GetPositionZ() - source->Pos.Z,
                    Position::NormalizeOrientation(row.Pos.GetOrientation() + delta));
}

void WodGarrison::Plot::SpawnBuildingContent(Map* map, GarrisonFactionIndex faction)
{
    bool hasBuilding = BuildingInfo.PacketInfo.has_value();
    bool active = hasBuilding && BuildingInfo.PacketInfo->Active;
    uint32 buildingId = active ? BuildingInfo.PacketInfo->GarrBuildingID : 0;

    for (GarrisonBuildingSpawn const* row : SelectBuildingSpawns(sGarrisonMgr.GetBuildingGameObjects(buildingId, PacketInfo.GarrPlotInstanceID), map->GetId(), faction, active, hasBuilding))
    {
        Position pos = RelocateBuildingSpawn(*row);
        QuaternionData rotation = QuaternionData::fromEulerAnglesZYX(pos.GetOrientation(), 0.0f, 0.0f);
        GameObject* go = GameObject::CreateGameObject(row->Entry, map, pos, rotation, 255, GO_STATE_READY);
        if (!go)
            continue;

        go->SetParentRotation(Rotation); // les releves LC portent la rotation de la parcelle, pas celle de l'objet
        if (!go->IsPositionValid() || !map->AddToMap(go))
        {
            delete go;
            continue;
        }
        BuildingInfo.Spawns.insert(go->GetGUID());
    }

    for (GarrisonBuildingSpawn const* row : SelectBuildingSpawns(sGarrisonMgr.GetBuildingCreatures(buildingId, PacketInfo.GarrPlotInstanceID), map->GetId(), faction, active, hasBuilding))
    {
        Creature* creature = Creature::CreateCreature(row->Entry, map, RelocateBuildingSpawn(*row));
        if (!creature)
            continue;

        if (!creature->IsPositionValid() || !map->AddToMap(creature))
        {
            delete creature;
            continue;
        }

        if (row->DuringConstruction) // LC : les ouvriers martelent (emotes 173 / 69)
            creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, urand(0, 1) ? 173 : 69);

        BuildingInfo.Spawns.insert(creature->GetGUID());
    }
}

GameObject* WodGarrison::Plot::CreateGameObject(Map* map, GarrisonFactionIndex faction)
{
    uint32 entry = EmptyGameObjectId;
    if (BuildingInfo.PacketInfo)
    {
        GarrPlotInstanceEntry const* plotInstance = sGarrPlotInstanceStore.AssertEntry(PacketInfo.GarrPlotInstanceID);
        GarrPlotEntry const* plot = sGarrPlotStore.AssertEntry(plotInstance->GarrPlotID);
        GarrBuildingEntry const* building = sGarrBuildingStore.AssertEntry(BuildingInfo.PacketInfo->GarrBuildingID);
        entry = faction == GARRISON_FACTION_INDEX_HORDE ? plot->HordeConstructObjID : plot->AllianceConstructObjID;
        if (BuildingInfo.PacketInfo->Active || !entry)
            entry = faction == GARRISON_FACTION_INDEX_HORDE ? building->HordeGameObjectID : building->AllianceGameObjectID;
    }

    if (!sObjectMgr->GetGameObjectTemplate(entry))
    {
        TC_LOG_ERROR("garrison", "Garrison attempted to spawn gameobject whose template doesn't exist (%u)", entry);
        return nullptr;
    }

    GameObject* building = GameObject::CreateGameObject(entry, map, PacketInfo.PlotPos.Pos, Rotation, 255, GO_STATE_READY);
    if (!building)
        return nullptr;

    if (BuildingInfo.CanActivate() && BuildingInfo.PacketInfo && !BuildingInfo.PacketInfo->Active)
    {
        if (FinalizeGarrisonPlotGOInfo const* finalizeInfo = sGarrisonMgr.GetPlotFinalizeGOInfo(PacketInfo.GarrPlotInstanceID))
        {
            Position const& pos2 = finalizeInfo->FactionInfo[faction].Pos;
            if (GameObject* finalizer = GameObject::CreateGameObject(finalizeInfo->FactionInfo[faction].GameObjectId, map, pos2, Rotation, 255, GO_STATE_READY))
            {
                // set some spell id to make the object delete itself after use
                finalizer->SetSpellId(finalizer->GetGOInfo()->goober.spell);
                finalizer->SetRespawnTime(0);

                if (uint16 animKit = finalizeInfo->FactionInfo[faction].AnimKitId)
                    finalizer->SetAnimKitId(animKit, false);

                map->AddToMap(finalizer);
            }
        }
    }

    if (building->GetGoType() == GAMEOBJECT_TYPE_GARRISON_BUILDING && building->GetGOInfo()->garrisonBuilding.SpawnMap)
    {
        for (CellObjectGuidsMap::value_type const& cellGuids : sObjectMgr->GetMapObjectGuids(building->GetGOInfo()->garrisonBuilding.SpawnMap, map->GetDifficultyID()))
        {
            for (ObjectGuid::LowType spawnId : cellGuids.second.creatures)
                if (Creature* spawn = BuildingSpawnHelper<Creature, &Creature::SetHomePosition>(building, spawnId, map))
                    BuildingInfo.Spawns.insert(spawn->GetGUID());

            for (ObjectGuid::LowType spawnId : cellGuids.second.gameobjects)
                if (GameObject* spawn = BuildingSpawnHelper<GameObject, &GameObject::RelocateStationaryPosition>(building, spawnId, map))
                    BuildingInfo.Spawns.insert(spawn->GetGUID());
        }
    }

    SpawnBuildingContent(map, faction);

    BuildingInfo.Guid = building->GetGUID();
    return building;
}

void WodGarrison::Plot::DeleteGameObject(Map* map)
{
    if (BuildingInfo.Guid.IsEmpty())
        return;

    for (ObjectGuid const& guid : BuildingInfo.Spawns)
    {
        WorldObject* object = nullptr;
        switch (guid.GetHigh())
        {
        case HighGuid::Creature:
            object = map->GetCreature(guid);
            break;
        case HighGuid::GameObject:
            object = map->GetGameObject(guid);
            break;
        default:
            continue;
        }

        if (object)
            object->AddObjectToRemoveList();
    }

    BuildingInfo.Spawns.clear();

    if (GameObject* oldBuilding = map->GetGameObject(BuildingInfo.Guid))
        oldBuilding->Delete();

    BuildingInfo.Guid.Clear();
}

void WodGarrison::Plot::ClearBuildingInfo(Player* owner)
{
    WorldPackets::Garrison::GarrisonPlotPlaced plotPlaced;
    plotPlaced.GarrTypeID = GARRISON_TYPE_GARRISON;
    plotPlaced.PlotInfo = &PacketInfo;
    owner->SendDirectMessage(plotPlaced.Write());

    BuildingInfo.PacketInfo = std::nullopt;
}

void WodGarrison::Plot::SetBuildingInfo(WorldPackets::Garrison::GarrisonBuildingInfo const& buildingInfo, Player* owner)
{
    if (!BuildingInfo.PacketInfo)
    {
        WorldPackets::Garrison::GarrisonPlotRemoved plotRemoved;
        plotRemoved.GarrPlotInstanceID = PacketInfo.GarrPlotInstanceID;
        owner->SendDirectMessage(plotRemoved.Write());
    }

    BuildingInfo.PacketInfo = buildingInfo;
}

bool WodGarrison::Building::CanActivate() const
{
    if (PacketInfo)
    {
        GarrBuildingEntry const* building = sGarrBuildingStore.AssertEntry(PacketInfo->GarrBuildingID);
        if (PacketInfo->TimeBuilt + building->BuildSeconds <= time(nullptr))
            return true;
    }

    return false;
}
