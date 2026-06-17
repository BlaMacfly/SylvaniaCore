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

#include "ChallengeModePackets.h"
#include "WowTime.hpp"

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::ChallengeMode::ModeAttempt const& modeAttempt)
{
    data << modeAttempt.InstanceRealmAddress;
    data << modeAttempt.AttemptID;
    data << modeAttempt.CompletionTime;
    data << MS::Utilities::WowTime::Encode(modeAttempt.CompletionDate);
    data << modeAttempt.MedalEarned;
    data << static_cast<uint32>(modeAttempt.Members.size());
    for (auto const& map : modeAttempt.Members)
    {
        data << map.VirtualRealmAddress;
        data << map.NativeRealmAddress;
        data << map.Guid;
        data << map.SpecializationID;
    }

    return data;
}

void WorldPackets::ChallengeMode::StartRequest::Read()
{
    _worldPacket >> Bag;
    _worldPacket >> Slot;
    _worldPacket >> GobGUID;
}

WorldPacket const* WorldPackets::ChallengeMode::ChangePlayerDifficultyResult::Write()
{
    _worldPacket.WriteBits(Type, 4);

    switch (Type)
    {
        case 5:
        {
            _worldPacket.WriteBit(false);
            _worldPacket << uint32(2766309915);
            break;
        }
        case 11:
        {
            _worldPacket << InstanceDifficultyID;
            _worldPacket << DifficultyRecID;
            break;
        }
    }

    return &_worldPacket;
}

void WorldPackets::ChallengeMode::RequestLeaders::Read()
{
    _worldPacket >> MapId;
    _worldPacket >> ChallengeID;
    LastGuildUpdate = _worldPacket.read<uint32>();
    LastRealmUpdate = _worldPacket.read<uint32>();
}

WorldPacket const* WorldPackets::ChallengeMode::RequestLeadersResult::Write()
{
    _worldPacket << MapID;
    _worldPacket << ChallengeID;
    _worldPacket << MS::Utilities::WowTime::Encode(LastGuildUpdate);
    _worldPacket << MS::Utilities::WowTime::Encode(LastRealmUpdate);

    _worldPacket << static_cast<uint32>(GuildLeaders.size());
    _worldPacket << static_cast<uint32>(RealmLeaders.size());

    for (auto const& guildLeaders : GuildLeaders)
        _worldPacket << guildLeaders;

    for (auto const& realmLeaders : RealmLeaders)
        _worldPacket << realmLeaders;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::ChallengeMode::Start::Write()
{
    _worldPacket << (uint32)MapId;
    _worldPacket << (uint32)ChallengeId;
    _worldPacket << (uint32)ChallengeLevel;

    _worldPacket << (uint32)unk1;
    _worldPacket << (uint32)unk2;
    _worldPacket << (uint32)unk3;
    _worldPacket << (uint32)unk4;
    _worldPacket << (uint32)unk5;

    _worldPacket << (int8)unk;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::ChallengeMode::Reset::Write()
{
    _worldPacket << (uint32)MapId;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::ChallengeMode::UpdateDeathCount::Write()
{
    _worldPacket << (uint32)DeathCount;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::ChallengeMode::Complete::Write()
{
    _worldPacket << (uint32)Duration;
    _worldPacket << (uint32)MapId;
    _worldPacket << (uint32)ChallengeId;
    _worldPacket << (uint32)ChallengeLevel;

    _worldPacket << (uint8)unk;

    return &_worldPacket;
}

ByteBuffer& operator<<(ByteBuffer& data, WorldPackets::ChallengeMode::ChallengeModeMap const& challengeModeMap)
{
    data << challengeModeMap.MapId;
    data << challengeModeMap.ChallengeID;
    data << challengeModeMap.BestCompletionMilliseconds;
    data << challengeModeMap.LastCompletionMilliseconds;
    data << challengeModeMap.CompletedChallengeLevel;
    data.AppendPackedTime(challengeModeMap.BestMedalDate);

    data << static_cast<uint32>(challengeModeMap.BestSpecID.size());

    for (auto const& v : challengeModeMap.Affixes)
        data << v;

    for (auto const& map : challengeModeMap.BestSpecID)
        data << map;

    return data;
}

WorldPacket const* WorldPackets::ChallengeMode::NewPlayerRecord::Write()
{
    _worldPacket << (uint32)MapId;
    _worldPacket << (uint32)Duration;
    _worldPacket << (uint32)ChallengeLevel;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::ChallengeMode::AllMapStats::Write()
{
    _worldPacket << static_cast<uint32>(ChallengeModeMaps.size());
    for (auto const& map : ChallengeModeMaps)
        _worldPacket << map;

    return &_worldPacket;
}

void WorldPackets::ChallengeMode::RequestMapStats::Read() {}

WorldPacket const* WorldPackets::ChallengeMode::ChallengeModeRewards::Write()
{
    _worldPacket.WriteBit(IsWeeklyRewardAvailable);
    _worldPacket << (uint32)LastWeekHighestKeyCompleted;
    _worldPacket << (uint32)LastWeekMapChallengeKeyEntry;
    _worldPacket << (uint32)CurrentWeekHighestKeyCompleted;

    return &_worldPacket;
}

void WorldPackets::ChallengeMode::GetChallengeModeRewards::Read() {}
