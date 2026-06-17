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
#include "InstanceScript.h"
#include "Item.h"
#include "Log.h"
#include "Player.h"
#include "WorldSession.h"
#include "ChallengeModeMgr.h"
#include "Warden.h"

void WorldSession::HandleRequestLeaders(WorldPackets::ChallengeMode::RequestLeaders& packet)
{
    WorldPackets::ChallengeMode::RequestLeadersResult result;
    result.MapID = packet.MapId;
    result.ChallengeID = packet.ChallengeID;

    result.LastGuildUpdate = time(nullptr);
    result.LastRealmUpdate = time(nullptr);

    if (auto bestGuild = sChallengeModeMgr->BestGuildChallenge(_player->GetGuildId(), packet.ChallengeID))
    {
        for (auto itr = bestGuild->member.begin(); itr != bestGuild->member.end(); ++itr)
        {
            WorldPackets::ChallengeMode::ModeAttempt guildLeaders;
            guildLeaders.InstanceRealmAddress = GetVirtualRealmAddress();
            guildLeaders.AttemptID = bestGuild->ID;
            guildLeaders.CompletionTime = bestGuild->RecordTime;
            guildLeaders.CompletionDate = bestGuild->Date;
            guildLeaders.MedalEarned = bestGuild->ChallengeLevel;

            for (auto const& v : bestGuild->member)
            {
                WorldPackets::ChallengeMode::ModeAttempt::Member memberData;
                memberData.VirtualRealmAddress = GetVirtualRealmAddress();
                memberData.NativeRealmAddress = GetVirtualRealmAddress();
                memberData.Guid = v.guid;
                memberData.SpecializationID = v.specId;
                guildLeaders.Members.emplace_back(memberData);
            }

            result.GuildLeaders.emplace_back(guildLeaders);
        }
    }

    if (ChallengeData* bestServer = sChallengeModeMgr->BestServerChallenge(packet.ChallengeID))
    {
        WorldPackets::ChallengeMode::ModeAttempt realmLeaders;
        realmLeaders.InstanceRealmAddress = GetVirtualRealmAddress();
        realmLeaders.AttemptID = bestServer->ID;
        realmLeaders.CompletionTime = bestServer->RecordTime;
        realmLeaders.CompletionDate = bestServer->Date;
        realmLeaders.MedalEarned = bestServer->ChallengeLevel;

        for (auto const& v : bestServer->member)
        {
            WorldPackets::ChallengeMode::ModeAttempt::Member memberData;
            memberData.VirtualRealmAddress = GetVirtualRealmAddress();
            memberData.NativeRealmAddress = GetVirtualRealmAddress();
            memberData.Guid = v.guid;
            memberData.SpecializationID = v.specId;
            realmLeaders.Members.emplace_back(memberData);
        }
        result.RealmLeaders.push_back(realmLeaders);
    }

    SendPacket(result.Write());
}

void WorldSession::HandleChallengeModeStart(WorldPackets::ChallengeMode::StartRequest& start)
{
    GameObject* object = _player->GetGameObjectIfCanInteractWith(start.GobGUID, GAMEOBJECT_TYPE_KEYSTONE_RECEPTACLE);
    if (!object)
    {
        TC_LOG_DEBUG("network", "WORLD: HandleChallengeModeStart - %s not found or you can not interact with it.", start.GobGUID.ToString().c_str());
        return;
    }

    Item* key = _player->GetItemByPos(start.Bag, start.Slot);
    if (!key)
    {
        TC_LOG_DEBUG("network", "WORLD: HandleChallengeModeStart - item in Bag %u and Slot %u not found.", start.Bag, start.Slot);
        return;
    }

    if (key->GetTemplate()->GetClass() != ITEM_CLASS_REAGENT || key->GetTemplate()->GetSubClass() != ITEM_SUBCLASS_KEYSTONE)
    {
        TC_LOG_DEBUG("network", "WORLD: HandleChallengeModeStart - Tried to start a challenge with item %s which have class %u and subclass %u.",
            key->GetGUID().ToString().c_str(),
            key->GetTemplate()->GetClass(),
            key->GetTemplate()->GetSubClass());
        return;
    }

    uint32 challengeModeId      = key->GetModifier(ITEM_MODIFIER_CHALLENGE_MAP_CHALLENGE_MODE_ID);
    uint32 challengeModeLevel   = key->GetModifier(ITEM_MODIFIER_CHALLENGE_KEYSTONE_LEVEL);
    uint32 challengeModeAffix1 = key->GetModifier(ITEM_MODIFIER_CHALLENGE_KEYSTONE_AFFIX_ID_1);
    uint32 challengeModeAffix2 = key->GetModifier(ITEM_MODIFIER_CHALLENGE_KEYSTONE_AFFIX_ID_2);
    uint32 challengeModeAffix3 = key->GetModifier(ITEM_MODIFIER_CHALLENGE_KEYSTONE_AFFIX_ID_3);

    MapChallengeModeEntry const* entry = sMapChallengeModeStore.LookupEntry(challengeModeId);
    if (!entry || !challengeModeLevel || entry->MapID != _player->GetMapId())
    {
        TC_LOG_DEBUG("network", "WORLD: HandleChallengeModeStart - Tried to start a challenge with wrong challengeModeId %u and level %u.", challengeModeId, challengeModeLevel);
        return;
    }

    if (InstanceScript* instanceScript = _player->GetInstanceScript())
        instanceScript->StartChallengeMode(challengeModeId, challengeModeLevel, challengeModeAffix1, challengeModeAffix2, challengeModeAffix3);

    // Blizzard do not delete the key at challenge start, will require mort research
    _player->DestroyItem(start.Bag, start.Slot, true);
}

void WorldSession::HandleChallengeModeRequestMapStatsOpcode(WorldPackets::ChallengeMode::RequestMapStats& request)
{
    WorldPackets::ChallengeMode::AllMapStats stats;
    if (ChallengeByMap* last = sChallengeModeMgr->LastForMember(_player->GetGUID()))
    {
        //printf("HandleChallengeModeRequestMapStatsOpcode size %zu\n", last->size());
        for (auto const& v : *last)
        {
            WorldPackets::ChallengeMode::ChallengeModeMap modeMap;
            modeMap.ChallengeID = v.second->ChallengeID;
            modeMap.BestMedalDate = v.second->Date;
            modeMap.MapId = v.second->MapID;
            modeMap.CompletedChallengeLevel = v.second->ChallengeLevel;

            modeMap.LastCompletionMilliseconds = v.second->RecordTime;
            if (ChallengeData* _lastData = sChallengeModeMgr->BestForMemberMap(_player->GetGUID(), v.second->ChallengeID))
                modeMap.BestCompletionMilliseconds = _lastData->RecordTime;
            else
                modeMap.BestCompletionMilliseconds = v.second->RecordTime;

            modeMap.Affixes = v.second->Affixes;

            for (auto const& z : v.second->member)
                modeMap.BestSpecID.push_back(z.specId);

            stats.ChallengeModeMaps.push_back(modeMap);
        }
    }

    SendPacket(stats.Write());
}

void WorldSession::HandleChallengeModeRewards(WorldPackets::ChallengeMode::GetChallengeModeRewards& getRewards)
{
    WorldPackets::ChallengeMode::ChallengeModeRewards result;
    result.LastWeekMapChallengeKeyEntry = 0;
    result.LastWeekHighestKeyCompleted = 0;
    result.CurrentWeekHighestKeyCompleted = 0;
    result.IsWeeklyRewardAvailable = sChallengeModeMgr->HasOploteLoot(_player->GetGUID());
    uint32 keyID = 0;
    uint32 capTime = 0;
    uint32 capLevel = -1;

    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* challengeModeEntry = sMapChallengeModeStore.LookupEntry(i))
            if (ChallengeData* challengeData = sChallengeModeMgr->LastForMemberMap(_player->GetGUID(), challengeModeEntry->ID))
                if (challengeData->ChallengeLevel >= result.LastWeekHighestKeyCompleted && (challengeData->Date + 86400 * 7) < time(nullptr))
                {
                    result.LastWeekHighestKeyCompleted = challengeData->ChallengeLevel;
                    result.LastWeekMapChallengeKeyEntry = challengeModeEntry->ID;
                }

    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* challengeModeEntry = sMapChallengeModeStore.LookupEntry(i))
            if (ChallengeData* challengeData = sChallengeModeMgr->BestForMemberMap(_player->GetGUID(), challengeModeEntry->ID))
                if (challengeData->ChallengeLevel >= result.CurrentWeekHighestKeyCompleted && (challengeData->Date + 86400 * 7) > time(nullptr))
                {
                    result.CurrentWeekHighestKeyCompleted = challengeData->ChallengeLevel;
                    //printf("keyID %d CurrentWeekHighestKeyCompleted=%d\n", challengeModeEntry->ID, result.CurrentWeekHighestKeyCompleted);
                }
                else  if (challengeData->ChallengeLevel >= result.LastWeekHighestKeyCompleted && (challengeData->Date + 86400 * 7) < time(nullptr))
                {
                    result.LastWeekHighestKeyCompleted = challengeData->ChallengeLevel;
                    result.LastWeekMapChallengeKeyEntry = challengeModeEntry->ID;
                    //printf("keyID else %d LastWeekHighestKeyCompleted=%d\n", challengeModeEntry->ID, result.LastWeekHighestKeyCompleted);
                }

    //printf("result.LastWeekMapChallengeKeyEntry =%d CurrentWeekHighestKeyCompleted = %d LastWeekHighestKeyCompleted=%d\n", result.LastWeekMapChallengeKeyEntry, result.CurrentWeekHighestKeyCompleted, result.LastWeekHighestKeyCompleted);
    if (result.CurrentWeekHighestKeyCompleted > 0)
        result.IsWeeklyRewardAvailable = true;
    SendPacket(result.Write());
}

void WorldSession::HandleResetChallengeMode(WorldPackets::ChallengeMode::ResetChallengeMode& /*packet*/)
{
    if (auto const& instanceScript = _player->GetInstanceScript())
        if (instanceScript->instance->isChallenge())
            instanceScript->ResetChallengeMode();
}

void WorldSession::HandleResetChallengeModeCheat(WorldPackets::ChallengeMode::ResetChallengeModeCheat& packet)
{
    if (!_warden)
    {
        TC_LOG_DEBUG("challenge", "%s tried ResetChallengeModeCheat but no Warden session exists.", GetPlayerName().c_str());
        return;
    }

    std::string action = _warden->Penalty(nullptr);

    TC_LOG_DEBUG("challenge", "%s triggered ResetChallengeModeCheat. Action: %s", GetPlayerName().c_str(), action.c_str());
}
