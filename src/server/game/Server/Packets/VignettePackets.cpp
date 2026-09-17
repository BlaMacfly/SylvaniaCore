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

#include "VignettePackets.h"

WorldPacket const* WorldPackets::Vignette::VignetteUpdate::Write()
{
    _worldPacket.WriteBit(ForceUpdate);
    _worldPacket.FlushBits();

    _worldPacket << static_cast<uint32>(Removed.IDs.size());
    for (ObjectGuid const& ID : Removed.IDs)
        _worldPacket << ID;

    _worldPacket << static_cast<uint32>(Added.IdList.IDs.size());
    for (ObjectGuid const& ID : Added.IdList.IDs)
        _worldPacket << ID;

    _worldPacket << static_cast<uint32>(Added.Data.size());
    for (VignetteClientData const& data : Added.Data)
    {
        _worldPacket << data.Pos;
        _worldPacket << data.ObjGUID;
        _worldPacket << data.VignetteID;
        _worldPacket << data.ZoneID;
    }

    _worldPacket << static_cast<uint32>(Updated.IdList.IDs.size());
    for (ObjectGuid const& ID : Updated.IdList.IDs)
        _worldPacket << ID;

    _worldPacket << static_cast<uint32>(Updated.Data.size());
    for (VignetteClientData const& data : Updated.Data)
    {
        _worldPacket << data.Pos;
        _worldPacket << data.ObjGUID;
        _worldPacket << data.VignetteID;
        _worldPacket << data.ZoneID;
    }

    return &_worldPacket;
}
