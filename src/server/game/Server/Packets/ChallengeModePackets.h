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

#ifndef CHALLENGEMODEPACKETS_H
#define CHALLENGEMODEPACKETS_H

#include "Packet.h"
#include "WorldSession.h"

namespace WorldPackets
{
    namespace ChallengeMode
    {
        struct ModeAttempt
        {
            struct Member
            {
                ObjectGuid Guid;
                uint32 VirtualRealmAddress = 0;
                uint32 NativeRealmAddress = 0;
                uint32 SpecializationID = 0;
            };

            uint32 InstanceRealmAddress = 0;
            uint32 AttemptID = 0;
            uint32 CompletionTime = 0;
            time_t CompletionDate = time(nullptr);
            uint32 MedalEarned = 0;
            std::vector<Member> Members;
        };

        struct ItemReward
        {
            uint32 ItemID = 0;
            uint32 ItemDisplayID = 0;
            uint32 Quantity = 0;
        };

        struct CurrencyReward
        {
            CurrencyReward(uint32 ID, uint32 count) : CurrencyID(ID), Quantity(count) {}

            uint32 CurrencyID = 0;
            uint32 Quantity = 0;
        };

        struct MapChallengeModeReward
        {
            struct ChallengeModeReward
            {
                std::vector<ItemReward> ItemRewards;
                uint32 Money = 0;
                std::vector<CurrencyReward> CurrencyRewards;
            };

            uint32 MapId = 0;
            std::vector<ChallengeModeReward> Rewards;
        };

        struct ChallengeModeMap
        {
            uint32 MapId = 0;
            uint32 BestCompletionMilliseconds = 0;
            uint32 LastCompletionMilliseconds = 0;
            uint32 CompletedChallengeLevel = 0;
            uint32 ChallengeID = 0;
            time_t BestMedalDate = time(nullptr);
            std::vector<uint16> BestSpecID;
            std::array<uint32, 3> Affixes;
        };

        class StartRequest final : public ClientPacket
        {
        public:
            StartRequest(WorldPacket&& packet) : ClientPacket(CMSG_START_CHALLENGE_MODE, std::move(packet)) { }

            void Read() override;

            uint8 Bag;
            uint32 Slot;
            ObjectGuid GobGUID;
        };

        class ChangePlayerDifficultyResult final : public ServerPacket
        {
        public:
            ChangePlayerDifficultyResult(uint32 type = 0) : ServerPacket(SMSG_CHANGE_PLAYER_DIFFICULTY_RESULT, 4), Type(type) { }

            WorldPacket const* Write() override;

            uint8 Type;
            uint32 InstanceDifficultyID;
            uint32 DifficultyRecID;
        };

        class Start final : public ServerPacket
        {
        public:
            Start() : ServerPacket(SMSG_CHALLENGE_MODE_START, 33) { }

            WorldPacket const* Write() override;

            uint32 MapId;
            uint32 ChallengeId;
            uint32 ChallengeLevel;

            uint32 unk1 = 0;
            uint32 unk2 = 0;
            uint32 unk3 = 0;
            uint32 unk4 = 0;
            uint32 unk5 = 0;

            uint8 unk = 128;
        };

        class Reset final : public ServerPacket
        {
        public:
            Reset(uint32 mapId = 0) : ServerPacket(SMSG_CHALLENGE_MODE_RESET, 4), MapId(mapId) { }

            WorldPacket const* Write() override;

            uint32 MapId;
        };

        class UpdateDeathCount final : public ServerPacket
        {
        public:
            UpdateDeathCount(uint32 deathCount = 0) : ServerPacket(SMSG_CHALLENGE_MODE_UPDATE_DEATH_COUNT, 4), DeathCount(deathCount) { }

            WorldPacket const* Write() override;

            uint32 DeathCount;
        };

        class Complete final : public ServerPacket
        {
        public:
            Complete() : ServerPacket(SMSG_CHALLENGE_MODE_COMPLETE, 4) { }

            WorldPacket const* Write() override;

            uint32 Duration;
            uint32 MapId;
            uint32 ChallengeId;
            uint32 ChallengeLevel;
            uint8 unk = 128;
        };

        class ResetChallengeMode final : public ClientPacket
        {
        public:
            ResetChallengeMode(WorldPacket&& packet) : ClientPacket(CMSG_RESET_CHALLENGE_MODE, std::move(packet)) {}

            void Read() override {}
        };

        class ResetChallengeModeCheat final : public ClientPacket
        {
        public:
            ResetChallengeModeCheat(WorldPacket&& packet) : ClientPacket(CMSG_RESET_CHALLENGE_MODE_CHEAT, std::move(packet)) {}

            void Read() override {};
        };

        class NewPlayerRecord final : public ServerPacket
        {
        public:
            NewPlayerRecord() : ServerPacket(SMSG_CHALLENGE_MODE_NEW_PLAYER_RECORD, 4) { }

            WorldPacket const* Write() override;

            uint32 MapId;
            uint32 Duration;
            uint32 ChallengeLevel;
        };

        class RequestLeaders final : public ClientPacket
        {
        public:
            RequestLeaders(WorldPacket&& packet) : ClientPacket(CMSG_CHALLENGE_MODE_REQUEST_LEADERS, std::move(packet)) {}

            void Read() override;

            uint32 MapId = 0;
            uint32 ChallengeID = 0;
            time_t LastGuildUpdate = time(nullptr);
            time_t LastRealmUpdate = time(nullptr);
        };

        class RequestLeadersResult final : public ServerPacket
        {
        public:
            RequestLeadersResult() : ServerPacket(SMSG_CHALLENGE_MODE_REQUEST_LEADERS_RESULT, 20 + 8) {}

            WorldPacket const* Write() override;

            uint32 MapID = 0;
            uint32 ChallengeID = 0;
            time_t LastGuildUpdate = time(nullptr);
            time_t LastRealmUpdate = time(nullptr);
            std::vector<ModeAttempt> GuildLeaders;
            std::vector<ModeAttempt> RealmLeaders;
        };

        class AllMapStats final : public ServerPacket
        {
        public:
            AllMapStats() : ServerPacket(SMSG_CHALLENGE_MODE_ALL_MAP_STATS, 4) {}

            WorldPacket const* Write() override;

            std::vector<ChallengeModeMap> ChallengeModeMaps;
        };

        class RequestMapStats final : public ClientPacket
        {
        public:
            RequestMapStats(WorldPacket&& packet) : ClientPacket(CMSG_CHALLENGE_MODE_REQUEST_MAP_STATS, std::move(packet)) {}

            void Read() override;
        };

        class ChallengeModeRewards final : public ServerPacket
        {
        public:
            ChallengeModeRewards() : ServerPacket(SMSG_CHALLENGE_MODE_REWARDS, 4) {}

            WorldPacket const* Write() override;

            bool IsWeeklyRewardAvailable = true;
            uint32 LastWeekHighestKeyCompleted = -1;
            uint32 LastWeekMapChallengeKeyEntry = -1;
            uint32 CurrentWeekHighestKeyCompleted = -1;
        };

        class GetChallengeModeRewards final : public ClientPacket
        {
        public:
            GetChallengeModeRewards(WorldPacket&& packet) : ClientPacket(CMSG_GET_CHALLENGE_MODE_REWARDS, std::move(packet)) {}

            void Read() override;
        };
    }
}

#endif
