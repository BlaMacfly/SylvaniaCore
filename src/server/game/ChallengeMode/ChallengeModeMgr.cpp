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

#include "ChallengeModeMgr.h"
#include "Containers.h"
#include "DB2Stores.h"
#include "GameEventMgr.h"
#include "GameTables.h"
#include "Item.h"
#include "LootPackets.h"
#include "InstanceScript.h"

ChallengeModeMgr* ChallengeModeMgr::instance()
{
    static ChallengeModeMgr instance;
    return &instance;
}

MapChallengeModeEntry const* ChallengeModeMgr::GetMapChallengeModeEntry(uint32 mapId)
{
    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* challengeModeEntry = sMapChallengeModeStore.LookupEntry(i))
            if (challengeModeEntry->MapID == mapId)
                return challengeModeEntry;

    return nullptr;
}

MapChallengeModeEntry const* ChallengeModeMgr::GetMapChallengeModeEntryByModeId(uint32 modeId)
{
    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* challengeModeEntry = sMapChallengeModeStore.LookupEntry(i))
            if (challengeModeEntry->ID == modeId)
                return challengeModeEntry;

    return nullptr;
}

uint32 ChallengeModeMgr::GetDamageMultiplier(uint8 challengeLevel)
{
    if (GtChallengeModeDamage const* challengeDamage = sChallengeModeDamage.GetRow(challengeLevel))
        return uint32(100.f * (challengeDamage->Scalar - 1.f));

    return 1;
}

uint32 ChallengeModeMgr::GetHealthMultiplier(uint8 challengeLevel)
{
    if (GtChallengeModeHealth const* challengeHealth = sChallengeModeHealth.GetRow(challengeLevel))
        return uint32(100.f * (challengeHealth->Scalar - 1.f));

    return 1;
}

uint32 ChallengeModeMgr::GetRandomChallengeId(uint32 flags/* = 4*/)
{
    std::vector<uint32> challenges;

    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* challengeModeEntry = sMapChallengeModeStore.LookupEntry(i))
            if (challengeModeEntry->Flags & flags &&
                (challengeModeEntry->ID == 197 || challengeModeEntry->ID == 198 || challengeModeEntry->ID == 199 || challengeModeEntry->ID == 200 || challengeModeEntry->ID == 206 || challengeModeEntry->ID == 207 || challengeModeEntry->ID == 208 || challengeModeEntry->ID == 209 || challengeModeEntry->ID == 210 || challengeModeEntry->ID == 227 || challengeModeEntry->ID == 233 || challengeModeEntry->ID == 234 || challengeModeEntry->ID == 239)) // Temp fix, only doable dungeons here
                challenges.push_back(challengeModeEntry->ID);

    if (challenges.empty())
        return 0;

    return Trinity::Containers::SelectRandomContainerElement(challenges);
}

uint32 ChallengeModeMgr::GetRandomChallengeAffixId(uint32 affix,uint32 level/* = 2*/)
{
    std::vector<uint32> affixs;
    switch (affix)
    {
    case 1:
        if (level >= 4)
        {
            affixs.push_back(5);//??
            affixs.push_back(6);//??
            affixs.push_back(7);//??
            affixs.push_back(8);//??
            affixs.push_back(11);//??
        }
        break;
    case 2:
        if (level >= 7)
        {
            affixs.push_back(13);//??
            affixs.push_back(14);//??
            affixs.push_back(12);//??
            affixs.push_back(2);//??
            affixs.push_back(4);//??
            affixs.push_back(3);//??
        }
        break;
    case 3:
        if (level >= 10)
        {
            affixs.push_back(9);//??
            affixs.push_back(10);//??
            affixs.push_back(15);//??
        }
        break;
    default:
        break;
    }

    if (affixs.empty())
        return 0;

    return Trinity::Containers::SelectRandomContainerElement(affixs);
}

std::vector<int32> ChallengeModeMgr::GetBonusListIdsForRewards(uint32 baseItemIlevel, uint8 challengeLevel)
{
    if (challengeLevel < 2)
        return {};

    std::vector<std::pair<int32, uint32>> bonusDescriptionByChallengeLevel =
    {
        { 3410, 5  },   // Mythic 2
        { 3411, 5  },   // Mythic 3
        { 3412, 10 },   // Mythic 4
        { 3413, 15 },   // Mythic 5
        { 3414, 20 },   // Mythic 6
        { 3415, 20 },   // Mythic 7
        { 3416, 25 },   // Mythic 8
        { 3417, 25 },   // Mythic 9
        { 3418, 30 },   // Mythic 10
        { 3509, 35 },   // Mythic 11
        { 3510, 40 },   // Mythic 12
        { 3534, 45 },   // Mythic 13
        { 3535, 50 },   // Mythic 14
        { 3535, 55 },   // Mythic 15
    };

    const uint32 baseMythicIlevel = 885;
    std::pair<int32, uint32> bonusAndDeltaPair = bonusDescriptionByChallengeLevel[challengeLevel < 15 ? (challengeLevel - 2): 13];
    return { bonusAndDeltaPair.first, (int32)sDB2Manager.GetItemBonusListForItemLevelDelta(baseMythicIlevel - baseItemIlevel + bonusAndDeltaPair.second) };
}

void ChallengeModeMgr::Reward(Player* player, uint8 challengeLevel)
{
    if (!GetMapChallengeModeEntry(player->GetMapId()))
        return;

    uint32 addCA = 0;

    addCA = GetCAForLoot(challengeLevel, player->GetMapId(), false);

    if (addCA)
        player->AddItem(addCA, 1);

    uint32 addBigCA = 0;
    uint32 countBigCA = 0;
    if (challengeLevel > 10)
        addBigCA = GetBigCAForLoot(challengeLevel, player->GetMapId(), false, 0, countBigCA);

    if (addBigCA && countBigCA)
        player->AddItem(addBigCA, countBigCA);

    JournalInstanceEntry const* journalInstance  = sDB2Manager.GetJournalInstanceByMapId(player->GetMapId());
    if (!journalInstance)
        return;

    auto encounters = sDB2Manager.GetJournalEncounterByJournalInstanceId(journalInstance->ID);
    if (!encounters)
        return;

    std::vector<JournalEncounterItemEntry const*> items;
    for (auto encounter : *encounters)
        if (std::vector<JournalEncounterItemEntry const*> const* journalItems = sDB2Manager.GetJournalItemsByEncounter(encounter->ID))
            items.insert(items.end(), journalItems->begin(), journalItems->end());

    if (items.empty())
        return;

    std::vector<ItemTemplate const*> stuffLoots;
    for (JournalEncounterItemEntry const* journalEncounterItem : items)
    {
        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(journalEncounterItem->ItemID);
        if (!itemTemplate)
            continue;

        if (!itemTemplate->IsUsableByLootSpecialization(player, false))
            continue;

        if (itemTemplate->GetInventoryType() != INVTYPE_NON_EQUIP)
            stuffLoots.push_back(itemTemplate);
    }

    ItemTemplate const* randomStuffItem = Trinity::Containers::SelectRandomContainerElement(stuffLoots);
    if (!randomStuffItem)
        return;

    uint32 itemId = randomStuffItem->GetId();
    ItemPosCountVec dest;
    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, 1);
    if (msg != EQUIP_ERR_OK)
    {
        player->SendEquipError(msg, nullptr, nullptr, itemId);
        return;
    }

    std::vector<int32> bonusListIds = GetBonusListIdsForRewards(randomStuffItem->GetBaseItemLevel(), challengeLevel);
    Item* pItem = player->StoreNewItem(dest, itemId, true, GenerateItemRandomPropertyId(itemId), GuidSet(), 0, bonusListIds);
    player->SendNewItem(pItem, 1, true, false, true);

    WorldPackets::Loot::DisplayToast displayToast;
    displayToast.EntityId = itemId;
    displayToast.ToastType = TOAST_ITEM;
    displayToast.Quantity = 1;
    displayToast.RandomPropertiesID = pItem->GetItemRandomPropertyId();
    displayToast.ToastMethod = TOAST_METHOD_POPUP;
    displayToast.bonusListIDs = pItem->GetDynamicValues(ITEM_DYNAMIC_FIELD_BONUSLIST_IDS);
    player->SendDirectMessage(displayToast.Write());
}

void ChallengeModeMgr::LoadFromDB()
{
    if (QueryResult result = CharacterDatabase.Query("SELECT `ID`, `GuildID`, `MapID`, `RecordTime`, `Date`, `ChallengeLevel`, `TimerLevel`, `Affixes`, `ChestID`, `ChallengeID` FROM `challenge`"))
    {
        do
        {
            Field* fields = result->Fetch();

            auto challengeData = new ChallengeData;
            challengeData->ID = fields[0].GetUInt64();
            challengeData->GuildID = fields[1].GetUInt64();
            challengeData->MapID = fields[2].GetUInt16();
            challengeData->RecordTime = fields[3].GetUInt32();
            if (challengeData->RecordTime < 10000)
                challengeData->RecordTime *= IN_MILLISECONDS;
            challengeData->Date = fields[4].GetUInt32();
            challengeData->ChallengeLevel = fields[5].GetUInt8();
            challengeData->TimerLevel = fields[6].GetUInt8();
            challengeData->ChestID = fields[8].GetUInt32();
            challengeData->ChallengeID = fields[9].GetUInt16();
            if (!challengeData->ChallengeID)
                if (MapChallengeModeEntry const* challengeEntry = GetMapChallengeModeEntry(challengeData->MapID))
                    challengeData->ChallengeID = challengeEntry->ID;

            challengeData->Affixes.fill(0);

            uint8 i = 0;
            Tokenizer affixes(fields[7].GetString(), ' ');
            for (auto& affix : affixes)
                challengeData->Affixes[i] = atoul(affix);

            _challengeMap[challengeData->ID] = challengeData;
            CheckBestMapId(challengeData);
            CheckBestGuildMapId(challengeData);

        } while (result->NextRow());
    }

    if (QueryResult result = CharacterDatabase.Query("SELECT `id`, `member`, `specID`, `ChallengeLevel`, `Date`, `ChestID` FROM `challenge_member`"))
    {
        do
        {
            Field* fields = result->Fetch();
            ChallengeMember member;
            member.guid = ObjectGuid::Create<HighGuid::Player>(fields[1].GetUInt64());
            member.specId = fields[2].GetUInt16();
            member.ChallengeLevel = fields[3].GetUInt32();
            member.Date = fields[4].GetUInt32();
            member.ChestID = fields[5].GetUInt32();

            auto itr = _challengeMap.find(fields[0].GetUInt64());
            if (itr == _challengeMap.end())
                continue;

            itr->second->member.insert(member);
            CheckBestMemberMapId(member.guid, itr->second);
        } while (result->NextRow());
    }

    if (QueryResult result = CharacterDatabase.Query("SELECT `guid`, `chestListID`, `date`, `ChallengeLevel` FROM `challenge_oplote_loot`"))
    {
        do
        {
            Field* fields = result->Fetch();
            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].GetUInt64());
            OploteLoot& lootOplote = _oploteWeekLoot[guid];
            lootOplote.Date = fields[2].GetUInt32();
            lootOplote.ChallengeLevel = fields[3].GetUInt32();
            lootOplote.needSave = false;
            lootOplote.guid = guid;

            Tokenizer chestLists(fields[1].GetString(), ' ');
            for (auto& chestList : chestLists)
                lootOplote.chestListID.insert(atoul(chestList));

        } while (result->NextRow());
    }

    if (sWorld->getWorldState(WS_CHALLENGE_AFFIXE1_RESET_TIME) == 0 || sWorld->getWorldState(WS_CHALLENGE_AFFIXE1_RESET_TIME) == 0 || sWorld->getWorldState(WS_CHALLENGE_AFFIXE1_RESET_TIME) == 0)
        GenerateCurrentWeekAffixes();
}

void ChallengeModeMgr::SaveChallengeToDB(ChallengeData const* challengeData)
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHALLENGE);
    stmt->setUInt32(0, challengeData->ID);
    stmt->setUInt64(1, challengeData->GuildID);
    stmt->setUInt16(2, challengeData->MapID);
    stmt->setUInt16(3, challengeData->ChallengeID);
    stmt->setUInt32(4, challengeData->RecordTime);
    stmt->setUInt32(5, challengeData->Date);
    stmt->setUInt8(6, challengeData->ChallengeLevel);
    stmt->setUInt8(7, challengeData->TimerLevel);
    std::ostringstream affixesListIDs;
    for (uint16 affixe : challengeData->Affixes)
        if (affixe)
            affixesListIDs << affixe << ' ';
    stmt->setString(8, affixesListIDs.str());
    stmt->setUInt32(9, challengeData->ChestID);
    trans->Append(stmt);

    for (auto const& v : challengeData->member)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHALLENGE_MEMBER);
        stmt->setUInt32(0, challengeData->ID);
        stmt->setUInt64(1, v.guid.GetCounter());
        stmt->setUInt16(2, v.specId);
        stmt->setUInt32(3, v.ChallengeLevel);
        stmt->setUInt32(4, v.Date);
        stmt->setUInt32(5, v.ChestID);
        trans->Append(stmt);
    }

    CharacterDatabase.CommitTransaction(trans);
}

void ChallengeModeMgr::CheckBestMapId(ChallengeData* challengeData)
{
    if (!challengeData)
        return;

    if (!_bestForMap[challengeData->ChallengeID] || _bestForMap[challengeData->ChallengeID]->RecordTime > challengeData->RecordTime)
        _bestForMap[challengeData->ChallengeID] = challengeData;
}

void ChallengeModeMgr::CheckBestGuildMapId(ChallengeData* challengeData)
{
    if (!challengeData || !challengeData->GuildID)
        return;

    if (!m_GuildBest[challengeData->GuildID][challengeData->ChallengeID] || m_GuildBest[challengeData->GuildID][challengeData->ChallengeID]->RecordTime > challengeData->RecordTime)
        m_GuildBest[challengeData->GuildID][challengeData->ChallengeID] = challengeData;
}

bool ChallengeModeMgr::CheckBestMemberMapId(ObjectGuid const& guid, ChallengeData* challengeData)
{
    bool isBest = false;
    if (!_challengesOfMember[guid][challengeData->ChallengeID] || _challengesOfMember[guid][challengeData->ChallengeID]->RecordTime > challengeData->RecordTime)
    {
        _challengesOfMember[guid][challengeData->ChallengeID] = challengeData;
        isBest = true;
    }

    if (!_lastForMember[guid][challengeData->ChallengeID] || _lastForMember[guid][challengeData->ChallengeID]->Date < challengeData->Date)
        _lastForMember[guid][challengeData->ChallengeID] = challengeData;

    _challengeWeekList[guid].insert(challengeData);

    return isBest;
}

ChallengeData* ChallengeModeMgr::BestServerChallenge(uint16 ChallengeID)
{
    return Trinity::Containers::MapGetValuePtr(_bestForMap, ChallengeID);
}

ChallengeData* ChallengeModeMgr::BestGuildChallenge(ObjectGuid::LowType const& guildId, uint16 ChallengeID)
{
    if (!guildId)
        return nullptr;

    auto itr = m_GuildBest.find(guildId);
    if (itr == m_GuildBest.end())
        return nullptr;

    auto itr2 = itr->second.find(ChallengeID);
    if (itr2 == itr->second.end())
        return nullptr;

    return itr2->second;
}

void ChallengeModeMgr::SetChallengeMapData(ObjectGuid::LowType const& ID, ChallengeData* data)
{
    _challengeMap[ID] = data;
}

ChallengeByMap* ChallengeModeMgr::BestForMember(ObjectGuid const& guid)
{
    return Trinity::Containers::MapGetValuePtr(_challengesOfMember, guid);
}

ChallengeByMap* ChallengeModeMgr::LastForMember(ObjectGuid const& guid)
{
    return Trinity::Containers::MapGetValuePtr(_lastForMember, guid);
}

ChallengeData* ChallengeModeMgr::LastForMemberMap(ObjectGuid const& guid, uint32 ChallengeID)
{
    if (ChallengeByMap* _lastResalt = LastForMember(guid))
    {
        auto itr = _lastResalt->find(ChallengeID);
        if (itr != _lastResalt->end())
            return itr->second;
    }

    return nullptr;
}

ChallengeData* ChallengeModeMgr::BestForMemberMap(ObjectGuid const& guid, uint32 ChallengeID)
{
    if (ChallengeByMap* _lastResalt = BestForMember(guid))
    {
        auto itr = _lastResalt->find(ChallengeID);
        if (itr != _lastResalt->end())
            return itr->second;
    }

    return nullptr;
}

bool ChallengeModeMgr::HasOploteLoot(ObjectGuid const& guid)
{
    return Trinity::Containers::MapGetValuePtr(_oploteWeekLoot, guid);
}

OploteLoot* ChallengeModeMgr::GetOploteLoot(ObjectGuid const& guid)
{
    return Trinity::Containers::MapGetValuePtr(_oploteWeekLoot, guid);
}

void ChallengeModeMgr::SaveOploteLootToDB()
{
    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    for (auto const& v : _oploteWeekLoot)
    {
        if (v.second.needSave)
        {
            auto stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHALLENGE_OPLOTE_LOOT);
            stmt->setUInt32(0, v.second.guid.GetCounter());
            std::ostringstream chestLists;
            for (uint32 chestList : v.second.chestListID)
                if (chestList)
                    chestLists << chestList << ' ';
            stmt->setString(1, chestLists.str());
            stmt->setUInt32(2, v.second.Date);
            stmt->setUInt32(3, v.second.ChallengeLevel);
            trans->Append(stmt);
        }
    }
    CharacterDatabase.CommitTransaction(trans);
}

void ChallengeModeMgr::DeleteOploteLoot(ObjectGuid const& guid)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHALLENGE_OPLOTE_LOOT_BY_GUID);
    stmt->setUInt32(0, guid.GetCounter());
    CharacterDatabase.Execute(stmt);

    _oploteWeekLoot.erase(guid);
}

void ChallengeModeMgr::GenerateOploteLoot(bool manual)
{
    TC_LOG_DEBUG("misc", "GenerateOploteLoot manual %u _challengeWeekList %u", manual, _challengeWeekList.size());

    CharacterDatabase.Query("DELETE FROM challenge_oplote_loot WHERE date <= UNIX_TIMESTAMP()");
    _oploteWeekLoot.clear();

    for (auto const& c : _challengeWeekList)
    {
        for (auto const& v : c.second)
        {
            if (manual && (v->Date > sWorld->getWorldState(WS_CHALLENGE_LAST_RESET_TIME) || v->Date < (sWorld->getWorldState(WS_CHALLENGE_LAST_RESET_TIME) - (7 * DAY))))
                continue;

            if (!manual && (v->Date > sWorld->getWorldState(WS_CHALLENGE_KEY_RESET_TIME) || v->Date < sWorld->getWorldState(WS_CHALLENGE_LAST_RESET_TIME)))
                continue;

            if (!v->ChestID)
                continue;

            auto itr = _oploteWeekLoot.find(c.first);
            if (itr != _oploteWeekLoot.end())
            {
                if (itr->second.ChallengeLevel < v->ChallengeLevel)
                    itr->second.ChallengeLevel = v->ChallengeLevel;

                itr->second.chestListID.insert(v->ChestID);
            }
            else
            {
                OploteLoot& lootOplote = _oploteWeekLoot[c.first];
                lootOplote.Date = sWorld->getNextChallengeKeyReset();
                lootOplote.ChallengeLevel = v->ChallengeLevel;
                lootOplote.needSave = true;
                lootOplote.guid = c.first;
                lootOplote.chestListID.insert(v->ChestID);
            }
        }
    }
    _challengeWeekList.clear();
    SaveOploteLootToDB();
}

void ChallengeModeMgr::GenerateCurrentWeekAffixes()
{
    uint32 affixes[12][3] =
    {
        { Raging, Volcanic, Tyrannical},
        { Teeming, FelExplosives, Fortified},
        { Bolstering, Grievous, Tyrannical},
        { Sanguine, Volcanic, Fortified},
        { Bursting, Skittish, Tyrannical},
        { Teeming, Quaking, Fortified},
        { Raging, Necrotic, Tyrannical},
        { Bolstering, Skittish, Fortified},
        { Teeming, Necrotic, Tyrannical},
        { Sanguine, Grievous, Fortified},
        { Bolstering, FelExplosives, Tyrannical},
        { Bursting, Quaking, Fortified},
    };

    auto weekContainer = affixes[GetActiveAffixe()];

    sWorld->setWorldState(WS_CHALLENGE_AFFIXE1_RESET_TIME, weekContainer[0]);
    sWorld->setWorldState(WS_CHALLENGE_AFFIXE2_RESET_TIME, weekContainer[1]);
    sWorld->setWorldState(WS_CHALLENGE_AFFIXE3_RESET_TIME, weekContainer[2]);
}

uint8 ChallengeModeMgr::GetActiveAffixe()
{
    if (sGameEventMgr->IsActiveEvent(126))
        return 0;
    if (sGameEventMgr->IsActiveEvent(127))
        return 1;
    if (sGameEventMgr->IsActiveEvent(128))
        return 2;
    if (sGameEventMgr->IsActiveEvent(129))
        return 3;
    if (sGameEventMgr->IsActiveEvent(130))
        return 4;
    if (sGameEventMgr->IsActiveEvent(131))
        return 5;
    if (sGameEventMgr->IsActiveEvent(132))
        return 6;
    if (sGameEventMgr->IsActiveEvent(133))
        return 7;
    if (sGameEventMgr->IsActiveEvent(134))
        return 8;
    if (sGameEventMgr->IsActiveEvent(135))
        return 9;
    if (sGameEventMgr->IsActiveEvent(136))
        return 10;
    if (sGameEventMgr->IsActiveEvent(137))
        return 11;

    return urand(0, 11);
}

uint32 ChallengeModeMgr::GetLootTreeMod(int32& levelBonus, uint32& challengeLevel, bool isOplote)
{
    if (isOplote)
        challengeLevel = std::min(challengeLevel, 15u);

    uint32 bonusTreeMod = 16; // +2
    levelBonus = 0;
    switch (challengeLevel)
    {
        // Is bug???
    case 0:
    case 1:
        bonusTreeMod = 0;
        levelBonus = 0;
        break;
    case 2:
    case 3:
        if (isOplote)
            levelBonus = 15;
        else
            levelBonus = 0;
        break;
    case 4:
    case 5:
        if (isOplote)
            levelBonus = 20;
        else
            levelBonus = 5;
        break;
    case 6:
    case 7:
        if (isOplote)
            levelBonus = 25;
        else
            levelBonus = 10;
        break;
    case 8:
    case 9:
        if (isOplote)
            levelBonus = 30;
        else
            levelBonus = 15;
        break;
    case 10:
        if (isOplote)
            levelBonus = 35;
        else
            levelBonus = 20;
        break;
    case 11:
        if (isOplote)
            levelBonus = 40;
        else
            levelBonus = 20;
        break;
    case 12:
        if (isOplote)
            levelBonus = 45;
        else
            levelBonus = 25;
        break;
    case 13:
        if (isOplote)
            levelBonus = 50;
        else
            levelBonus = 30;
        break;
    case 14:
        if (isOplote)
            levelBonus = 55;
        else
            levelBonus = 35;
        break;
    case 15:
    default:
        if (isOplote)
            levelBonus = 60;
        else
            levelBonus = 40;
        break;
    }

    return bonusTreeMod;
}

uint32 ChallengeModeMgr::GetCAForLoot(uint32 challengeLevel, uint32 mapID, bool isOplote)
{
    if (!isOplote)
        return 0;

    switch (mapID)
    {
    case 1492: // Maw of Souls
    {
        // Lesser Dungeons
        switch (challengeLevel)
        {
        case 0:
        case 1:
            return 0;
        case 2:
        case 3:
            return 147398;
        case 4:
        case 5:
        case 6:
            return 147399;
        case 7:
        case 8:
        case 9:
            return 147400;
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
            return 147401;
        case 15:
        default:
            return 147719;
        }
    }
    case 1493: // Vault of the Wardens
    case 1466: // Darkheart Thicket
    case 1501: // Black Rook Hold
    case 1544: // Assault on Violet Hold
    case 1456: // Eye of Azshara
    case 1571: // Court of Stars
    case 1458: // Neltharion's Lair
    case 1651: // Karazhan
    case 1677: // Cathedral of Eternal Night
    case 1753: // Seat of the Triumvirate
    {
        // Regular Dungeons
        switch (challengeLevel)
        {
        case 0:
        case 1:
            return 0;
        case 2:
        case 3:
            return 147402;
        case 4:
        case 5:
        case 6:
            return 147403;
        case 7:
        case 8:
        case 9:
            return 147404;
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
            return 147405;
        case 15:
        default:
            return 147718;
        }
    }
    case 1516: // The Arcway
    case 1477: // Halls of Valor
    {
        // Greater Dungeons
        switch (challengeLevel)
        {
        case 0:
        case 1:
            return 0;
        case 2:
        case 3:
            return 147406;
        case 4:
        case 5:
        case 6:
            return 147407;
        case 7:
        case 8:
        case 9:
            return 147408;
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
            return 147409;
        case 15:
        default:
            return 147720;
        }
    }
    default:
        break;
    }

    return 0;
}

uint32 ChallengeModeMgr::GetBigCAForLoot(uint32 challengeLevel, uint32 mapID, bool isOplote, uint32 goEntry, uint32& count)
{
    if (!isOplote || challengeLevel <= 10)
        return 0;

    if (challengeLevel >= 15)
        count = challengeLevel - 15;
    else
        count = challengeLevel - 10;

    switch (mapID)
    {
    case 1492: // Maw of Souls
    {
        // Lesser Dungeons
        return 147808; // Lesser Adept's Spoils
    }
    case 1493: // Vault of the Wardens
    case 1466: // Darkheart Thicket
    case 1501: // Black Rook Hold
    case 1544: // Assault on Violet Hold
    case 1456: // Eye of Azshara
    case 1571: // Court of Stars
    case 1458: // Neltharion's Lair
    case 1651: // Karazhan
    case 1677: // Cathedral of Eternal Night
    case 1753: // Seat of the Triumvirate
    {
        // Regular Dungeons
        return 147809; // Adept's Spoils
    }
    case 1516: // The Arcway
    case 1477: // Halls of Valor
    {
        // Greater Dungeons
        return 147810; // Greater Adept's Spoils
    }
    default:
        break;
    }

    return 0;
}

uint32 ChallengeModeMgr::GetCAForOplote(uint32 challengeLevel)
{
    switch (challengeLevel)
    {
        // Is bug???
    case 0:
    case 1:
        return 0;
    case 2:
    case 3:
        return 147551;
    case 4:
    case 5:
    case 6:
        return 147550;
    case 7:
    case 8:
    case 9:
        return 147549;
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
        return 147548;
    default: // 15+
        return 147721;
    }
}

uint32 ChallengeModeMgr::GetBigCAForOplote(uint32 challengeLevel, uint32& count)
{
    if (challengeLevel <= 10)
        return 0;

    if (challengeLevel >= 15)
        count = challengeLevel - 15;
    else
        count = challengeLevel - 10;

    return 147819;
}

float ChallengeModeMgr::GetChanceItem(uint8 mode, uint32 challengeLevel)
{
    float base_chance = 200.0f;
    float add_chance = 0.0f;

    if (challengeLevel > 15)
        add_chance += (challengeLevel - 15) * 40.0f; // For 7.3.5 is 10

    switch (mode)
    {
    case CHALLENGE_TIMER_LEVEL_3: /// 3 chests + 3 levels
        base_chance += 200.0f; // 400% is 4 items
        break;
    case CHALLENGE_TIMER_LEVEL_2: /// 2 chests + 2 levels
        base_chance += 100.0f; // 300% is 3 items
        break;
    case CHALLENGE_TIMER_LEVEL_1: /// 1 chest + 1 level
    case CHALLENGE_NOT_IN_TIMER:  /// 0 chest
        base_chance += 0.0f; // 200% is 2 items
        break;
    default:
        break;
    }

    base_chance += add_chance;

    return base_chance;
}

bool ChallengeModeMgr::IsChest(uint32 goEntry)
{
    switch (goEntry)
    {
    case 252674: // Vault of the Wardens 100-110
    case 252677: // Black Rook Hold Dungeon 100-110
    case 252686: // Court of Stars 110
    case 252668: // Dark Heart Thicket 100-110
    case 252665: // Eye of Azshara 100-110
    case 252056: // Halls of Valor 100-110
    case 252680: // Maw of Souls 100-110
    case 252671: // Neltharions Lair 100-110
    case 252683: // The Arcway 100-110
    case 269852: // Lower Return to Karazhan 110
    case 269871: // Upper Return to Karazhan 110
    case 269843: // Cathedral of Eternal Night
    case 272689: // Seat of the Triumvirate
        return true;
    default:
        break;
    }

    return false;
}

bool ChallengeModeMgr::IsPower(uint32 itemId)
{
    switch (itemId)
    {
    case 138786:
    case 140176:
    case 141854:
    case 143868:
    case 143869:
    case 143870:
    case 143871:
    case 147402:
    case 147403:
    case 147404:
    case 147405:
    case 147579:
    case 147718:
    case 147809:
    case 147551:
    case 147550:
    case 147549:
    case 147548:
    case 147721:
    case 147819:
        return true;
        break;
    default:
        break;
    }
    return false;
}

uint32 ChallengeModeMgr::GetChest(uint32 challangeId)
{
    switch (challangeId)
    {
    case 197:
        return 252665; // Eye of Azshara 100-110
        break;
    case 198:
        return 252668; // Dark Heart Thicket 100-110
        break;
    case 199:
        return 252677; // Black Rook Hold Dungeon 100-110
        break;
    case 200:
        return 252056; // Halls of Valor 100-110
        break;
    case 206:
        return 252671; // Neltharions Lair 100-110
        break;
    case 207:
        return 252674; // Vault of the Wardens 100-110
        break;
    case 208:
        return 252680; // Maw of Souls 100-110
        break;
    case 209:
        return 252683; // The Arcway 100-110
        break;
    case 210:
        return 252686; // Court of Stars 110
        break;
    case 227:
        return 269852; // Lower Return to Karazhan 110
        break;
    case 233:
        return 269843; // Cathedral of Eternal Night
        break;
    case 234:
        return 269871; // Upper Return to Karazhan 110
        break;
    case 239:
        return 269843; // Cathedral of Eternal Night
        break;
    default:
        return 252668;
        break;
    }
    return 0;
}

bool ChallengeModeMgr::IsDoor(uint32 goEntry)
{
    switch (goEntry)
    {
    case 211989:
    case 211991:
    case 212972:
    case 211992:
    case 211988:
    case 212282:
    case 212387:
    case 239323:
    case 239408:
        return true;
    default:
        break;
    }

    return false;
}

bool ChallengeMember::operator<(const ChallengeMember& i) const
{
    return guid.GetCounter() > i.guid.GetCounter();
}

bool ChallengeMember::operator==(const ChallengeMember& i) const
{
    return guid.GetCounter() == i.guid.GetCounter();
}
