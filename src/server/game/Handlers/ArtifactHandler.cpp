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

#include "WorldSession.h"
#include "ArtifactPackets.h"
#include "ConditionMgr.h"
#include "DB2Stores.h"
#include "GameTables.h"
#include "Item.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellPackets.h"

void WorldSession::HandleArtifactAddPower(WorldPackets::Artifact::ArtifactAddPower& artifactAddPower)
{
    if (!_player->GetGameObjectIfCanInteractWith(artifactAddPower.ForgeGUID, GAMEOBJECT_TYPE_ARTIFACT_FORGE))
        return;

    Item* artifact = _player->GetItemByGuid(artifactAddPower.ArtifactGUID);
    if (!artifact)
        return;

    uint8 categoryID = ARTIFACT_CATEGORY_PRIMARY;
    uint32 artifactID = artifact->GetTemplate()->GetArtifactID();
    if (ArtifactEntry const* entry = sArtifactStore.LookupEntry(artifactID))
        categoryID = static_cast<ArtifactCategory>(entry->ArtifactCategoryID);

    uint32 currentArtifactTier = artifact->GetModifier(ITEM_MODIFIER_ARTIFACT_TIER);

    uint64 xpCost = 0;
    if (GtArtifactLevelXPEntry const* cost = sArtifactLevelXPGameTable.GetRow(artifact->GetTotalPurchasedArtifactPowers() + 1))
        xpCost = uint64(currentArtifactTier == MAX_ARTIFACT_TIER ? cost->XP2 : cost->XP);

    if (xpCost > artifact->GetUInt64Value(ITEM_FIELD_ARTIFACT_XP))
        return;

    if (artifactAddPower.PowerChoices.empty())
        return;

    ItemDynamicFieldArtifactPowers const* artifactPower = artifact->GetArtifactPower(artifactAddPower.PowerChoices[0].ArtifactPowerID);
    if (!artifactPower)
        return;

    ArtifactPowerEntry const* artifactPowerEntry = sArtifactPowerStore.LookupEntry(artifactPower->ArtifactPowerId);
    if (!artifactPowerEntry)
        return;

    if (artifactPowerEntry->Tier > currentArtifactTier)
        return;

    if (categoryID == ARTIFACT_CATEGORY_FISHING)
        artifact->ActivateFishArtifact(artifactID);

    uint32 maxRank = artifactPowerEntry->MaxPurchasableRank;
    if (artifactPowerEntry->Tier < currentArtifactTier)
    {
        if (artifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_FINAL)
            maxRank = 1;
        else if (artifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_MAX_RANK_WITH_TIER)
            maxRank += currentArtifactTier - artifactPowerEntry->Tier;
    }

    if (artifactAddPower.PowerChoices[0].Rank != artifactPower->PurchasedRank + 1 ||
        artifactAddPower.PowerChoices[0].Rank > maxRank)
        return;

    if (!(artifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_NO_LINK_REQUIRED))
    {
        if (std::unordered_set<uint32> const* artifactPowerLinks = sDB2Manager.GetArtifactPowerLinks(artifactPower->ArtifactPowerId))
        {
            bool hasAnyLink = false;
            for (uint32 artifactPowerLinkId : *artifactPowerLinks)
            {
                ArtifactPowerEntry const* artifactPowerLink = sArtifactPowerStore.LookupEntry(artifactPowerLinkId);
                if (!artifactPowerLink)
                    continue;

                ItemDynamicFieldArtifactPowers const* artifactPowerLinkLearned = artifact->GetArtifactPower(artifactPowerLinkId);
                if (!artifactPowerLinkLearned)
                    continue;

                if (artifactPowerLinkLearned->PurchasedRank >= artifactPowerLink->MaxPurchasableRank)
                {
                    hasAnyLink = true;
                    break;
                }
            }

            if (!hasAnyLink)
                return;
        }
    }

    ArtifactPowerRankEntry const* artifactPowerRank = sDB2Manager.GetArtifactPowerRank(artifactPower->ArtifactPowerId, artifactPower->CurrentRankWithBonus + 1 - 1); // need data for next rank, but -1 because of how db2 data is structured
    if (!artifactPowerRank)
        return;

    ItemDynamicFieldArtifactPowers newPower = *artifactPower;
    ++newPower.PurchasedRank;
    ++newPower.CurrentRankWithBonus;
    artifact->SetArtifactPower(&newPower);

    if (artifact->IsEquipped())
    {
        _player->ApplyArtifactPowerRank(artifact, artifactPowerRank, true);

        for (ItemDynamicFieldArtifactPowers const& power : artifact->GetArtifactPowers())
        {
            ArtifactPowerEntry const* scaledArtifactPowerEntry = sArtifactPowerStore.AssertEntry(power.ArtifactPowerId);
            if (!(scaledArtifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_SCALES_WITH_NUM_POWERS))
                continue;

            ArtifactPowerRankEntry const* scaledArtifactPowerRank = sDB2Manager.GetArtifactPowerRank(scaledArtifactPowerEntry->ID, 0);
            if (!scaledArtifactPowerRank)
                continue;

            ItemDynamicFieldArtifactPowers newScaledPower = power;
            ++newScaledPower.CurrentRankWithBonus;
            artifact->SetArtifactPower(&newScaledPower);

            _player->ApplyArtifactPowerRank(artifact, scaledArtifactPowerRank, false);
            _player->ApplyArtifactPowerRank(artifact, scaledArtifactPowerRank, true);
        }
    }

    artifact->SetUInt64Value(ITEM_FIELD_ARTIFACT_XP, artifact->GetUInt64Value(ITEM_FIELD_ARTIFACT_XP) - xpCost);
    artifact->SetState(ITEM_CHANGED, _player);

    uint32 totalPurchasedArtifactPower = artifact->GetTotalPurchasedArtifactPowers();
    uint32 artifactTier = 0;

    for (ArtifactTierEntry const* tier : sArtifactTierStore)
    {
        if (artifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_FINAL && artifactPowerEntry->Tier < MAX_ARTIFACT_TIER)
        {
            artifactTier = artifactPowerEntry->Tier + 1;
            break;
        }

        if (totalPurchasedArtifactPower < tier->MaxNumTraits)
        {
            artifactTier = tier->ArtifactTier;
            break;
        }
    }

    artifactTier = std::max(artifactTier, currentArtifactTier);

    for (uint32 i = currentArtifactTier; i <= artifactTier; ++i)
        artifact->InitArtifactPowers(artifact->GetTemplate()->GetArtifactID(), uint8(i));

    artifact->SetModifier(ITEM_MODIFIER_ARTIFACT_TIER, artifactTier);
}

void WorldSession::HandleArtifactSetAppearance(WorldPackets::Artifact::ArtifactSetAppearance& artifactSetAppearance)
{
    if (!_player->GetGameObjectIfCanInteractWith(artifactSetAppearance.ForgeGUID, GAMEOBJECT_TYPE_ARTIFACT_FORGE))
        return;

    ArtifactAppearanceEntry const* artifactAppearance = sArtifactAppearanceStore.LookupEntry(artifactSetAppearance.ArtifactAppearanceID);
    if (!artifactAppearance)
        return;

    Item* artifact = _player->GetItemByGuid(artifactSetAppearance.ArtifactGUID);
    if (!artifact)
        return;

    ArtifactAppearanceSetEntry const* artifactAppearanceSet = sArtifactAppearanceSetStore.LookupEntry(artifactAppearance->ArtifactAppearanceSetID);
    if (!artifactAppearanceSet || artifactAppearanceSet->ArtifactID != artifact->GetTemplate()->GetArtifactID())
        return;

    if (PlayerConditionEntry const* playerCondition = sPlayerConditionStore.LookupEntry(artifactAppearance->UnlockPlayerConditionID))
        if (!sConditionMgr->IsPlayerMeetingCondition(_player, playerCondition))
            return;

    artifact->SetAppearanceModId(artifactAppearance->ItemAppearanceModifierID);
    artifact->SetModifier(ITEM_MODIFIER_ARTIFACT_APPEARANCE_ID, artifactAppearance->ID);
    artifact->SetState(ITEM_CHANGED, _player);
    Item* childItem = _player->GetChildItemByGuid(artifact->GetChildItem());
    if (childItem)
    {
        childItem->SetAppearanceModId(artifactAppearance->ItemAppearanceModifierID);
        childItem->SetState(ITEM_CHANGED, _player);
    }

    if (artifact->IsEquipped())
    {
        // change weapon appearance
        _player->SetVisibleItemSlot(artifact->GetSlot(), artifact);
        if (childItem)
            _player->SetVisibleItemSlot(childItem->GetSlot(), childItem);

        // change druid form appearance
        if (artifactAppearance->OverrideShapeshiftDisplayID && artifactAppearance->OverrideShapeshiftFormID && _player->GetShapeshiftForm() == ShapeshiftForm(artifactAppearance->OverrideShapeshiftFormID))
            _player->RestoreDisplayId(_player->IsMounted());
    }
}

void WorldSession::HandleConfirmArtifactRespec(WorldPackets::Artifact::ConfirmArtifactRespec& confirmArtifactRespec)
{
    if (!_player->GetNPCIfCanInteractWith(confirmArtifactRespec.NpcGUID, UNIT_NPC_FLAG_ARTIFACT_POWER_RESPEC))
        return;

    Item* artifact = _player->GetItemByGuid(confirmArtifactRespec.ArtifactGUID);
    if (!artifact)
        return;

    uint64 xpCost = 0;
    if (GtArtifactLevelXPEntry const* cost = sArtifactLevelXPGameTable.GetRow(artifact->GetTotalPurchasedArtifactPowers() + 1))
        xpCost = uint64(artifact->GetModifier(ITEM_MODIFIER_ARTIFACT_TIER) == 1 ? cost->XP2 : cost->XP);

    if (xpCost > artifact->GetUInt64Value(ITEM_FIELD_ARTIFACT_XP))
        return;

    uint64 newAmount = artifact->GetUInt64Value(ITEM_FIELD_ARTIFACT_XP) - xpCost;
    for (uint32 i = 0; i <= artifact->GetTotalPurchasedArtifactPowers(); ++i)
        if (GtArtifactLevelXPEntry const* cost = sArtifactLevelXPGameTable.GetRow(i))
            newAmount += uint64(artifact->GetModifier(ITEM_MODIFIER_ARTIFACT_TIER) == 1 ? cost->XP2 : cost->XP);

    for (ItemDynamicFieldArtifactPowers const& artifactPower : artifact->GetArtifactPowers())
    {
        uint8 oldPurchasedRank = artifactPower.PurchasedRank;
        if (!oldPurchasedRank)
            continue;

        ItemDynamicFieldArtifactPowers newPower = artifactPower;
        newPower.PurchasedRank -= oldPurchasedRank;
        newPower.CurrentRankWithBonus -= oldPurchasedRank;
        artifact->SetArtifactPower(&newPower);

        if (artifact->IsEquipped())
            if (ArtifactPowerRankEntry const* artifactPowerRank = sDB2Manager.GetArtifactPowerRank(artifactPower.ArtifactPowerId, 0))
                _player->ApplyArtifactPowerRank(artifact, artifactPowerRank, false);
    }

    for (ItemDynamicFieldArtifactPowers const& power : artifact->GetArtifactPowers())
    {
        ArtifactPowerEntry const* scaledArtifactPowerEntry = sArtifactPowerStore.AssertEntry(power.ArtifactPowerId);
        if (!(scaledArtifactPowerEntry->Flags & ARTIFACT_POWER_FLAG_SCALES_WITH_NUM_POWERS))
            continue;

        ArtifactPowerRankEntry const* scaledArtifactPowerRank = sDB2Manager.GetArtifactPowerRank(scaledArtifactPowerEntry->ID, 0);
        if (!scaledArtifactPowerRank)
            continue;

        ItemDynamicFieldArtifactPowers newScaledPower = power;
        newScaledPower.CurrentRankWithBonus = 0;
        artifact->SetArtifactPower(&newScaledPower);

        _player->ApplyArtifactPowerRank(artifact, scaledArtifactPowerRank, false);
    }

    artifact->SetUInt64Value(ITEM_FIELD_ARTIFACT_XP, newAmount);
    artifact->SetState(ITEM_CHANGED, _player);
}

void WorldSession::HandleArtifactAddRelicTalent(WorldPackets::Artifact::ArtifactAddRelicTalent& packet)
{
    if (!_player->GetGameObjectIfCanInteractWith(packet.ForgeGUID, GAMEOBJECT_TYPE_ARTIFACT_FORGE))
        return;

    Item* artifact = _player->GetItemByGuid(packet.ArtifactGUID);
    if (!artifact)
        return;

    if (packet.SlotIndex < 2)
        return;

    auto relics = artifact->GetArtifactSockets();
    auto relicItr = relics.find(packet.SlotIndex);
    if (relicItr == relics.end())
        return;

    ItemSocketInfo const& relic = relicItr->second;

    ItemDynamicFieldGems const* gem = artifact->GetGem(packet.SlotIndex - 2);
    if (!gem || !gem->ItemId)
        return;

    if (packet.TalentIndex >= 32)
        return;

    if ((uint32(1) << packet.TalentIndex) & relic.firstTier)
        return;

    uint32 reqLevel = 0;
    if (packet.TalentIndex > 0)
        reqLevel = 60 + (packet.SlotIndex - 2) * 3;
    if (packet.TalentIndex > 2)
        reqLevel += 9;

    if (reqLevel > artifact->GetTotalPurchasedArtifactPowers())
    {
        _player->SendEquipError(EQUIP_ERR_SCALING_STAT_ITEM_LEVEL_TOO_LOW);
        return;
    }

    artifact->SetState(ITEM_CHANGED, _player);

    uint32 offset = uint32(packet.SlotIndex - 2) * 6;
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, relic.unk1);
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, packet.SlotIndex);
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, relic.firstTier | (uint32(1) << packet.TalentIndex));
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, relic.secondTier);
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, relic.thirdTier);
    artifact->SetDynamicValue(ITEM_DYNAMIC_FIELD_RELIC_TALENT_DATA, offset++, relic.additionalThirdTier);

    // _player->UpdateAchievementCriteria(CRITERIA_TYPE_RELIC_TALENT_UNLOCKED, 1739, 1);
    _player->UpdateCriteria(CRITERIA_TYPE_RELIC_TALENT_UNLOCKED, 1739, 1);

    artifact->AddOrRemoveSocketTalent(packet.TalentIndex, true, packet.SlotIndex);
}

void WorldSession::HandleArtifactAttuneSocketedRelic(WorldPackets::Artifact::ArtifactAttuneSocketedRelic& packet)
{
    WorldPackets::Artifact::ArtifactAttuneSocketedRelicData art;
    art.ArtifactGUID = packet.ArtifactGUID;
    art.Result = packet.RelicSlotIndex;//or result
    SendPacket(art.Write());
}
