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

#include "VignetteMgr.h"
#include "AreaTrigger.h"
#include "ConditionMgr.h"
#include "Conversation.h"
#include "Corpse.h"
#include "Creature.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "VignettePackets.h"
#include "WorldSession.h"

namespace Vignette
{

Manager::Manager(Player const* player) : _owner(player)
{
}

Manager::~Manager()
{
    _owner = nullptr;

    for (auto itr : _vignettes)
        delete itr.second;
}

Entity* Manager::CreateAndAddVignette(VignetteEntry const* vignetteEntry, uint32 const mapID, Type const vignetteType, Position const position, uint32 zoneID, ObjectGuid const sourceGuid /*= ObjectGuid::Empty*/)
{
    for (auto v : _vignettes)
        if (v.second->GetVignetteEntry()->ID == vignetteEntry->ID && v.second->GetSourceGuid() == sourceGuid)
            return nullptr;

    Map* map = _owner->GetMap();
    if (!map)
        return nullptr;

    Entity* vignette = new Entity(vignetteEntry, mapID);
    vignette->Create(vignetteType, position, zoneID, sourceGuid, map->GenerateLowGuid<HighGuid::Vignette>());

    _vignettes.insert(std::make_pair(vignette->GetGuid(), vignette));
    _addedVignette.insert(vignette->GetGuid());

    return vignette;
}

void Manager::DestroyAndRemoveVignetteByEntry(VignetteEntry const* vignetteEntry)
{
    if (!vignetteEntry)
        return;

    for (auto itr = _vignettes.begin(); itr != _vignettes.end();)
    {
        if (itr->second->GetVignetteEntry()->ID == vignetteEntry->ID)
        {
            delete itr->second;
            _removedVignette.insert(itr->first);
            itr = _vignettes.erase(itr);
            continue;
        }

        ++itr;
    }
}

void Manager::DestroyAndRemoveVignettes(std::function<bool(Entity*)> const& lambda)
{
    for (auto itr = _vignettes.begin(); itr != _vignettes.end();)
    {
        if (lambda(itr->second))
        {
            delete itr->second;
            _removedVignette.insert(itr->first);
            itr = _vignettes.erase(itr);
            continue;
        }

        ++itr;
    }
}

void Manager::SendVignetteUpdateToClient()
{
    WorldPackets::Vignette::VignetteUpdate updatePacket;
    updatePacket.ForceUpdate = false;

    for (ObjectGuid const& guid : _removedVignette)
        updatePacket.Removed.IDs.emplace_back(guid);

    for (ObjectGuid const& guid : _updatedVignette)
    {
        auto itr = _vignettes.find(guid);
        if (itr == _vignettes.end())
            continue;

        Entity const* vignette = itr->second;
        updatePacket.Updated.Data.emplace_back(vignette->GetSourceGuid(), vignette->GetPosition(), vignette->GetVignetteEntry()->ID, vignette->GetZoneID());
        updatePacket.Updated.IdList.IDs.emplace_back(guid);
    }

    for (ObjectGuid const& guid : _addedVignette)
    {
        auto itr = _vignettes.find(guid);
        if (itr == _vignettes.end())
            continue;

        Entity const* vignette = itr->second;
        updatePacket.Added.Data.emplace_back(vignette->GetSourceGuid(), vignette->GetPosition(), vignette->GetVignetteEntry()->ID, vignette->GetZoneID());
        updatePacket.Added.IdList.IDs.emplace_back(guid);
    }

    _owner->GetSession()->SendPacket(updatePacket.Write());

    _updatedVignette.clear();
    _addedVignette.clear();
    _removedVignette.clear();
}

void Manager::Update()
{
    for (auto itr : _vignettes)
    {
        Entity* vignette = itr.second;

        // Une creature qui patrouille deplace son marqueur.
        if (vignette->GetSourceGuid().IsUnit())
            if (Creature* sourceCreature = ObjectAccessor::GetCreature(*_owner, vignette->GetSourceGuid()))
                vignette->UpdatePosition(sourceCreature->GetPosition());

        if (vignette->NeedClientUpdate())
        {
            _updatedVignette.insert(vignette->GetGuid());
            vignette->ResetNeedClientUpdate();
        }
    }

    if (!_addedVignette.empty() || !_updatedVignette.empty() || !_removedVignette.empty())
        SendVignetteUpdateToClient();
}

static VignetteEntry const* GetVignetteEntryFromWorldObject(WorldObject const* target)
{
    uint32 vignetteId = 0;

    if (Creature const* creature = target->ToCreature())
        vignetteId = creature->GetCreatureTemplate()->VignetteID;

    if (!vignetteId)
        return nullptr;

    return sVignetteStore.LookupEntry(vignetteId);
}

static Type GetDefaultVignetteTypeFromWorldObject(WorldObject const* target)
{
    switch (target->GetTypeId())
    {
        case TYPEID_UNIT:
            return Type::SourceRare;
        case TYPEID_GAMEOBJECT:
            return Type::SourceTreasure;
        default:
            return Type::SourceScript;
    }
}

template <class T>
void Manager::OnWorldObjectAppear(T const* target)
{
    VignetteEntry const* vignetteEntry = GetVignetteEntryFromWorldObject(target);
    if (!vignetteEntry)
        return;

    if (CanSeeVignette(target, vignetteEntry->ID))
        CreateAndAddVignette(vignetteEntry, target->GetMapId(), GetDefaultVignetteTypeFromWorldObject(target),
            target->GetPosition(), target->GetCurrentZoneID(), target->GetGUID());
}

template <class T>
void Manager::OnWorldObjectDisappear(T const* target)
{
    if (!GetVignetteEntryFromWorldObject(target))
        return;

    ObjectGuid const guid = target->GetGUID();
    DestroyAndRemoveVignettes([guid](Entity const* vignette) -> bool
    {
        return vignette->GetSourceGuid() == guid && vignette->GetVignetteType() != Type::SourceScript;
    });
}

bool Manager::CanSeeVignette(WorldObject const* obj, uint32 vignetteID) const
{
    if (!vignetteID)
        return false;

    VignetteEntry const* vignette = sVignetteStore.LookupEntry(vignetteID);
    if (!vignette)
        return false;

    // Une depouille ne merite plus de marqueur.
    if (Unit const* unitSource = obj->ToUnit())
        if (!unitSource->IsAlive())
            return false;

    if (vignette->PlayerConditionID)
        if (PlayerConditionEntry const* condition = sPlayerConditionStore.LookupEntry(vignette->PlayerConditionID))
            if (!ConditionMgr::IsPlayerMeetingCondition(_owner, condition))
                return false;

    return true;
}

template void Manager::OnWorldObjectDisappear(Corpse const*);
template void Manager::OnWorldObjectDisappear(Creature const*);
template void Manager::OnWorldObjectDisappear(GameObject const*);
template void Manager::OnWorldObjectDisappear(DynamicObject const*);
template void Manager::OnWorldObjectDisappear(AreaTrigger const*);
template void Manager::OnWorldObjectDisappear(Conversation const*);
template void Manager::OnWorldObjectDisappear(WorldObject const*);
template void Manager::OnWorldObjectDisappear(Player const*);

template void Manager::OnWorldObjectAppear(Corpse const*);
template void Manager::OnWorldObjectAppear(Creature const*);
template void Manager::OnWorldObjectAppear(GameObject const*);
template void Manager::OnWorldObjectAppear(DynamicObject const*);
template void Manager::OnWorldObjectAppear(AreaTrigger const*);
template void Manager::OnWorldObjectAppear(Conversation const*);
template void Manager::OnWorldObjectAppear(WorldObject const*);
template void Manager::OnWorldObjectAppear(Player const*);

}
