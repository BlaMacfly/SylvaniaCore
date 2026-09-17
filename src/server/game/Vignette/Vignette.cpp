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

#include "Vignette.h"
#include "ObjectMgr.h"

namespace Vignette
{

Entity::Entity(VignetteEntry const* vignetteEntry, uint32 mapID) :
    _vignetteEntry(vignetteEntry), _map(mapID), _zoneID(0), _type(Type::SourceScript), _needClientUpdate(false)
{
}

Entity::~Entity()
{
}

void Entity::Create(Type type, Position const& position, uint32 zoneID, ObjectGuid sourceGuid, ObjectGuid::LowType lowGuid)
{
    _guid = ObjectGuid::Create<HighGuid::Vignette>(_map, _vignetteEntry->ID, lowGuid);
    _type = type;
    _position = position;
    _zoneID = zoneID;
    _sourceGuid = sourceGuid;
}

// On ne previent le client que lorsque le marqueur a bouge d'au moins un metre :
// une creature qui patrouille enverrait sinon un paquet a chaque pas.
void Entity::UpdatePosition(Position newPosition)
{
    if (static_cast<int32>(_position.GetPositionX()) == static_cast<int32>(newPosition.GetPositionX())
        && static_cast<int32>(_position.GetPositionY()) == static_cast<int32>(newPosition.GetPositionY()))
        return;

    _position = newPosition;
    _needClientUpdate = true;
}

void Entity::ResetNeedClientUpdate()
{
    _needClientUpdate = false;
}

ObjectGuid Entity::GetGuid() const
{
    return _guid;
}

ObjectGuid Entity::GetSourceGuid() const
{
    return _sourceGuid;
}

Type Entity::GetVignetteType() const
{
    return _type;
}

bool Entity::NeedClientUpdate() const
{
    return _needClientUpdate;
}

Position const& Entity::GetPosition() const
{
    return _position;
}

uint32 Entity::GetZoneID() const
{
    return _zoneID;
}

VignetteEntry const* Entity::GetVignetteEntry() const
{
    return _vignetteEntry;
}

}
