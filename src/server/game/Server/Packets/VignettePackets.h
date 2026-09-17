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

#ifndef VignettePackets_h__
#define VignettePackets_h__

#include "Packet.h"
#include "ObjectGuid.h"
#include "Position.h"

namespace WorldPackets
{
    namespace Vignette
    {
        struct VignetteInstanceIDList
        {
            GuidVector IDs;
        };

        struct VignetteClientData
        {
            VignetteClientData(ObjectGuid guid, Position pos, int32 vignetteID, int32 zoneID) :
                ObjGUID(guid), Pos(pos), VignetteID(vignetteID), ZoneID(zoneID) { }

            ObjectGuid ObjGUID;
            TaggedPosition<Position::XYZ> Pos;
            int32 VignetteID = 0;
            int32 ZoneID = 0;
        };

        struct VignetteClientDataSet
        {
            VignetteInstanceIDList IdList;
            std::vector<VignetteClientData> Data;
        };

        class VignetteUpdate final : public ServerPacket
        {
        public:
            VignetteUpdate() : ServerPacket(SMSG_VIGNETTE_UPDATE, 20 + 1) { }
            VignetteUpdate(bool update) : ServerPacket(SMSG_VIGNETTE_UPDATE, 20 + 1), ForceUpdate(update) { }

            WorldPacket const* Write() override;

            VignetteClientDataSet Updated;
            VignetteClientDataSet Added;
            VignetteInstanceIDList Removed;
            bool ForceUpdate = false;
        };
    }
}

#endif // VignettePackets_h__
