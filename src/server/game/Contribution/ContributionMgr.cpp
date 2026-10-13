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

#include "ContributionMgr.h"
#include "Chat.h"
#include "ConditionMgr.h"
#include "DB2Stores.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "SpellMgr.h"
#include "World.h"
#include "WorldSession.h"
#include "WorldStatePackets.h"

namespace
{
    // characters.worldstates rows keeping the time of the last stage change, one per building
    uint32 const LastChangeWorldStateBase = 20120;

    // 1 while Legionfall is open: the client shows the "Legionfall" point and the buildings on the Broken Isles map only
    // then (AreaPOI 5245 and three other client conditions wait for it). Nothing set it.
    uint32 const LegionfallOpenWorldState = 13317;

    // The Broken Shore rares of the map (AreaPOI 5284 to 5308): the client shows one while its world state is 1 and its daily
    // tracking quest is not done. Nothing set these states: no icon showed. All 22 are spawned (2026_10_13_13), with a short
    // respawn: their icons stay on.
    uint32 const BrokenShoreRareWorldStates[] =
    {
        12867, 12868, 12869, 12870, 12871, 12872, 12873, 12875, 12877, 12878, 12879,
        12880, 12882, 12883, 12884, 12885, 12886, 12887, 12888, 12889, 12890, 12891
    };

    uint32 GetPersonalTracker(uint32 contributionID)
    {
        switch (contributionID)
        {
            case CONTRIBUTION_MAGE_TOWER:       return CURRENCY_TYPE_LEGIONFALL_PERSONAL_TRACKER_MAGE_TOWER;
            case CONTRIBUTION_COMMAND_CENTER:   return CURRENCY_TYPE_LEGIONFALL_PERSONAL_TRACKER_COMMAND_TOWER;
            case CONTRIBUTION_NETHER_DISRUPTOR: return CURRENCY_TYPE_LEGIONFALL_PERSONAL_TRACKER_NETHER_TOWER;
            default:                            return 0;
        }
    }
}

ContributionMgr* ContributionMgr::instance()
{
    static ContributionMgr instance;
    return &instance;
}

bool ContributionMgr::IsAlwaysBuilt(ContributionData const& data) const
{
    return data.Contribution->ID == CONTRIBUTION_MAGE_TOWER && sWorld->getBoolConfig(CONFIG_LEGIONFALL_MAGE_TOWER_ALWAYS_BUILT);
}

uint32 ContributionMgr::GetValue(int32 worldStateID)
{
    return sWorld->getWorldState(uint32(worldStateID));
}

// Saved in characters.worldstates and sent at once to every player in the world: the map and the construction table read it
void ContributionMgr::SetValue(int32 worldStateID, uint32 value)
{
    if (sWorld->getWorldState(uint32(worldStateID)) == value)
        return;

    sWorld->setWorldState(uint32(worldStateID), value);
    for (auto const& itr : sWorld->GetAllSessions())
        if (Player* player = itr.second->GetPlayer())
            if (player->IsInWorld())
                player->SendUpdateWorldState(uint32(worldStateID), value);
}

void ContributionMgr::Initialize()
{
    _contributions.clear();

    for (ContributionEntry const* contribution : sContributionStore)
    {
        ManagedWorldStateInputEntry const* input = sManagedWorldStateInputStore.LookupEntry(contribution->ManagedWorldStateInputID);
        ManagedWorldStateEntry const* worldState = input ? sManagedWorldStateStore.LookupEntry(input->ManagedWorldStateID) : nullptr;
        if (!worldState)
            continue;

        ContributionData& data = _contributions[contribution->ID];
        data.Contribution = contribution;
        data.Input = input;
        data.WorldState = worldState;
        data.LastChange = sWorld->getWorldState(LastChangeWorldStateBase + contribution->ID);
    }

    // the benefits of a building: one buff per construction, in turn (OccurrenceValue 1 to 50)
    _buffs.clear();
    for (ManagedWorldStateBuffEntry const* buff : sManagedWorldStateBuffStore)
        if (buff->OccurrenceValue && sSpellMgr->GetSpellInfo(buff->BuffSpellID))
            _buffs[buff->ManagedWorldStateID].push_back(buff);

    sWorld->setWorldState(LegionfallOpenWorldState, 1);

    uint32 const now = uint32(time(nullptr));
    for (auto& itr : _contributions)
    {
        ContributionData& data = itr.second;
        ManagedWorldStateEntry const* worldState = data.WorldState;

        uint32 const stage = GetValue(worldState->CurrentStageWorldStateID);
        if (stage < CONTRIBUTION_STATE_BUILDING || stage > CONTRIBUTION_STATE_DESTROYED || !data.LastChange)
            ChangeState(data, CONTRIBUTION_STATE_BUILDING, now);
        if (IsAlwaysBuilt(data) && GetValue(worldState->CurrentStageWorldStateID) != CONTRIBUTION_STATE_ACTIVE)
            ChangeState(data, CONTRIBUTION_STATE_ACTIVE, now);

        TC_LOG_INFO("server.loading", ">> Legionfall building %u: stage %u, progress %u%%, built %u times", itr.first,
            GetState(itr.first), GetProgressPct(itr.first), GetValue(worldState->OccurrencesWorldStateID));
    }
}

void ContributionMgr::ChangeState(ContributionData& data, ContributionState state, uint32 now)
{
    ManagedWorldStateEntry const* worldState = data.WorldState;
    switch (state)
    {
        case CONTRIBUTION_STATE_ACTIVE:
            SetValue(worldState->ProgressWorldStateID, uint32(worldState->AccumulationStateTargetValue));
            if (GetValue(worldState->CurrentStageWorldStateID) != CONTRIBUTION_STATE_ACTIVE)
                SetValue(worldState->OccurrencesWorldStateID, GetValue(worldState->OccurrencesWorldStateID) + 1);
            break;
        case CONTRIBUTION_STATE_UNDER_ATTACK:
            SetValue(worldState->ProgressWorldStateID, uint32(worldState->DepletionStateTargetValue));
            break;
        default:
            SetValue(worldState->ProgressWorldStateID, 0);
            break;
    }
    SetValue(worldState->CurrentStageWorldStateID, state);

    data.LastChange = now;
    sWorld->setWorldState(LastChangeWorldStateBase + data.Contribution->ID, now);

    TC_LOG_INFO("misc", "[legionfall] building %u enters stage %u", data.Contribution->ID, uint32(state));
}

void ContributionMgr::Update(uint32 diff)
{
    _updateTimer += diff;
    if (_updateTimer < 10 * IN_MILLISECONDS)
        return;
    _updateTimer = 0;

    uint32 const now = uint32(time(nullptr));
    for (auto& itr : _contributions)
    {
        ContributionData& data = itr.second;
        ManagedWorldStateEntry const* worldState = data.WorldState;
        switch (GetValue(worldState->CurrentStageWorldStateID))
        {
            case CONTRIBUTION_STATE_ACTIVE:
                if (!IsAlwaysBuilt(data) && now >= data.LastChange + uint32(worldState->UpTimeSecs))
                    ChangeState(data, CONTRIBUTION_STATE_UNDER_ATTACK, now);
                break;
            case CONTRIBUTION_STATE_UNDER_ATTACK:
            {
                if (IsAlwaysBuilt(data))
                {
                    ChangeState(data, CONTRIBUTION_STATE_ACTIVE, now);
                    break;
                }

                uint32 const elapsed = now > data.LastChange ? now - data.LastChange : 0;
                uint32 const lost = elapsed / MINUTE * uint32(worldState->DepletionAmountPerMinute);
                uint32 const left = lost < uint32(worldState->DepletionStateTargetValue) ? uint32(worldState->DepletionStateTargetValue) - lost : 0;
                if (left)
                    SetValue(worldState->ProgressWorldStateID, left);
                else
                    ChangeState(data, CONTRIBUTION_STATE_DESTROYED, now);
                break;
            }
            case CONTRIBUTION_STATE_DESTROYED:
                if (now >= data.LastChange + uint32(worldState->DownTimeSecs))
                    ChangeState(data, CONTRIBUTION_STATE_BUILDING, now);
                break;
            default:    // building: contributions move it
                break;
        }
    }

    UpdateBuffs();
}

// Buff of the current construction while the building stands (active or under attack), 0 otherwise
uint32 ContributionMgr::GetCurrentBuff(ContributionData const& data, int32& conditionID) const
{
    conditionID = 0;
    uint32 const state = GetValue(data.WorldState->CurrentStageWorldStateID);
    if (state != CONTRIBUTION_STATE_ACTIVE && state != CONTRIBUTION_STATE_UNDER_ATTACK)
        return 0;

    auto itr = _buffs.find(int32(data.WorldState->ID));
    uint32 const occurrences = GetValue(data.WorldState->OccurrencesWorldStateID);
    if (itr == _buffs.end() || !occurrences)
        return 0;

    uint32 maxOccurrence = 0;
    for (ManagedWorldStateBuffEntry const* buff : itr->second)
        maxOccurrence = std::max(maxOccurrence, buff->OccurrenceValue);

    uint32 const occurrence = (occurrences - 1) % maxOccurrence + 1;      // the list starts again past its end
    for (ManagedWorldStateBuffEntry const* buff : itr->second)
        if (buff->OccurrenceValue == occurrence)
        {
            conditionID = buff->PlayerConditionID;
            return uint32(buff->BuffSpellID);
        }
    return 0;
}

// Every player meeting the client condition carries the benefit of each standing building, and loses it once destroyed
void ContributionMgr::UpdateBuffs()
{
    for (auto const& itr : _contributions)
    {
        auto buffs = _buffs.find(int32(itr.second.WorldState->ID));
        if (buffs == _buffs.end())
            continue;

        int32 conditionID = 0;
        uint32 const current = GetCurrentBuff(itr.second, conditionID);
        PlayerConditionEntry const* condition = conditionID ? sPlayerConditionStore.LookupEntry(conditionID) : nullptr;

        for (auto const& session : sWorld->GetAllSessions())
        {
            Player* player = session.second->GetPlayer();
            if (!player || !player->IsInWorld())
                continue;

            bool const wanted = current && (!condition || ConditionMgr::IsPlayerMeetingCondition(player, condition));
            for (ManagedWorldStateBuffEntry const* buff : buffs->second)
            {
                uint32 const spellId = uint32(buff->BuffSpellID);
                if (spellId == current && wanted)
                {
                    if (!player->HasAura(spellId))
                        player->AddAura(spellId, player);
                }
                else if (spellId != current && player->HasAura(spellId))
                    player->RemoveAurasDueToSpell(spellId);
            }
            if (current && !wanted && player->HasAura(current))
                player->RemoveAurasDueToSpell(current);
        }
    }
}

void ContributionMgr::FillInitWorldStates(WorldPackets::WorldState::InitWorldStates& packet) const
{
    packet.Worldstates.emplace_back(LegionfallOpenWorldState, 1);
    for (uint32 rareWorldState : BrokenShoreRareWorldStates)
        packet.Worldstates.emplace_back(rareWorldState, 1);
    for (auto const& itr : _contributions)
    {
        ManagedWorldStateEntry const* worldState = itr.second.WorldState;
        for (int32 id : { worldState->CurrentStageWorldStateID, worldState->ProgressWorldStateID, worldState->OccurrencesWorldStateID })
            packet.Worldstates.emplace_back(uint32(id), int32(GetValue(id)));
    }
}

void ContributionMgr::Contribute(Player* player, uint32 orderIndex)
{
    // the packet names the order index of the building on the table; the contribution ID is accepted when no order matches
    ContributionData* data = nullptr;
    for (auto& itr : _contributions)
        if (uint32(itr.second.Contribution->OrderIndex) == orderIndex)
            data = &itr.second;
    if (!data)
    {
        auto itr = _contributions.find(orderIndex);
        data = itr != _contributions.end() ? &itr->second : nullptr;
    }

    ChatHandler chat(player->GetSession());
    if (!data)
    {
        TC_LOG_ERROR("misc", "[legionfall] %s : contribution inconnue (index %u)", player->GetName().c_str(), orderIndex);
        return;
    }

    uint32 const contributionID = data->Contribution->ID;
    TC_LOG_INFO("misc", "[legionfall] %s contribue : index envoye %u, batiment %u", player->GetName().c_str(), orderIndex, contributionID);

    ManagedWorldStateEntry const* worldState = data->WorldState;
    if (GetValue(worldState->CurrentStageWorldStateID) != CONTRIBUTION_STATE_BUILDING)
    {
        chat.SendSysMessage("Ce bâtiment n'est pas en construction : on ne peut y contribuer qu'entre sa destruction et sa reconstruction.");
        return;
    }

    if (data->Input->ValidInputConditionID)
        if (PlayerConditionEntry const* condition = sPlayerConditionStore.LookupEntry(data->Input->ValidInputConditionID))
            if (!ConditionMgr::IsPlayerMeetingCondition(player, condition))
            {
                chat.SendSysMessage("Vous ne remplissez pas encore les conditions pour contribuer à ce bâtiment.");
                return;
            }

    uint32 const questID = uint32(data->Input->QuestID);
    Quest const* quest = sObjectMgr->GetQuestTemplate(questID);
    if (!quest)
    {
        TC_LOG_ERROR("misc", "[legionfall] quete de contribution %u absente (batiment %u)", questID, contributionID);
        return;
    }

    // the quest asks for the War Supplies and takes them when rewarded, with the reputation and its item
    for (QuestObjective const& objective : quest->GetObjectives())
        if (objective.Type == QUEST_OBJECTIVE_CURRENCY && !player->HasCurrency(objective.ObjectID, objective.Amount))
        {
            chat.PSendSysMessage("Il vous faut %u Fournitures de guerre pour contribuer.", uint32(objective.Amount));
            return;
        }

    QuestStatus const status = player->GetQuestStatus(questID);
    if (status == QUEST_STATUS_NONE || status == QUEST_STATUS_REWARDED)
    {
        if (!player->CanTakeQuest(quest, true) || !player->CanAddQuest(quest, true))
            return;
        player->AddQuest(quest, nullptr);
    }

    if (player->CanCompleteQuest(questID))
        player->CompleteQuest(questID);

    if (player->GetQuestStatus(questID) != QUEST_STATUS_COMPLETE || !player->CanRewardQuest(quest, true))
    {
        uint16 const slot = player->FindQuestSlot(questID);
        if (slot < MAX_QUEST_LOG_SIZE)
            player->SetQuestSlot(slot, 0);
        player->RemoveActiveQuest(quest);
        TC_LOG_ERROR("misc", "[legionfall] %s : quete %u impossible a rendre (statut %u)", player->GetName().c_str(), questID, uint32(player->GetQuestStatus(questID)));
        return;
    }

    player->RewardQuest(quest, 0, player, true);
    if (uint32 tracker = GetPersonalTracker(contributionID))
        player->ModifyCurrency(tracker, 1, false, true);

    uint32 const target = uint32(worldState->AccumulationStateTargetValue);
    uint32 const needed = std::max<uint32>(1, sWorld->getIntConfig(CONFIG_LEGIONFALL_CONTRIBUTIONS_REQUIRED));
    uint32 const progress = uint32(std::min<uint64>(target, uint64(GetValue(worldState->ProgressWorldStateID)) + (target + needed - 1) / needed));
    if (progress >= target)
        ChangeState(*data, CONTRIBUTION_STATE_ACTIVE, uint32(time(nullptr)));
    else
        SetValue(worldState->ProgressWorldStateID, progress);
}

void ContributionMgr::OnStateRequest(Player* player, uint32 contributionID) const
{
    // the reply (SMSG_CONTRIBUTION_LAST_UPDATE_RESPONSE, 0x285C) has no known layout in 7.3.5: none is sent, the table reads
    // the world states. Logged to confirm in game that opening the table sends these requests.
    TC_LOG_DEBUG("misc", "[legionfall] %s demande l'etat du batiment %u", player->GetName().c_str(), contributionID);
}

ContributionState ContributionMgr::GetState(uint32 contributionID) const
{
    auto itr = _contributions.find(contributionID);
    return itr != _contributions.end() ? ContributionState(GetValue(itr->second.WorldState->CurrentStageWorldStateID)) : CONTRIBUTION_STATE_NONE;
}

uint32 ContributionMgr::GetProgressPct(uint32 contributionID) const
{
    auto itr = _contributions.find(contributionID);
    if (itr == _contributions.end())
        return 0;

    ManagedWorldStateEntry const* worldState = itr->second.WorldState;
    uint32 const target = GetState(contributionID) == CONTRIBUTION_STATE_UNDER_ATTACK ? uint32(worldState->DepletionStateTargetValue) : uint32(worldState->AccumulationStateTargetValue);
    return target ? uint32(uint64(GetValue(worldState->ProgressWorldStateID)) * 100 / target) : 0;
}

uint32 ContributionMgr::GetOccurrences(uint32 contributionID) const
{
    auto itr = _contributions.find(contributionID);
    return itr != _contributions.end() ? GetValue(itr->second.WorldState->OccurrencesWorldStateID) : 0;
}

uint32 ContributionMgr::GetNextChange(uint32 contributionID) const
{
    auto itr = _contributions.find(contributionID);
    if (itr == _contributions.end())
        return 0;

    ContributionData const& data = itr->second;
    ManagedWorldStateEntry const* worldState = data.WorldState;
    switch (GetValue(worldState->CurrentStageWorldStateID))
    {
        case CONTRIBUTION_STATE_ACTIVE:
            return IsAlwaysBuilt(data) ? 0 : data.LastChange + uint32(worldState->UpTimeSecs);
        case CONTRIBUTION_STATE_UNDER_ATTACK:
            return worldState->DepletionAmountPerMinute ? data.LastChange + uint32(worldState->DepletionStateTargetValue / worldState->DepletionAmountPerMinute) * MINUTE : 0;
        case CONTRIBUTION_STATE_DESTROYED:
            return data.LastChange + uint32(worldState->DownTimeSecs);
        default:
            return 0;
    }
}

bool ContributionMgr::SetState(uint32 contributionID, ContributionState state)
{
    auto itr = _contributions.find(contributionID);
    if (itr == _contributions.end() || state < CONTRIBUTION_STATE_BUILDING || state > CONTRIBUTION_STATE_DESTROYED)
        return false;

    ChangeState(itr->second, state, uint32(time(nullptr)));
    return true;
}

bool ContributionMgr::SetProgress(uint32 contributionID, uint32 percent)
{
    auto itr = _contributions.find(contributionID);
    if (itr == _contributions.end() || percent > 100 || GetState(contributionID) != CONTRIBUTION_STATE_BUILDING)
        return false;

    ManagedWorldStateEntry const* worldState = itr->second.WorldState;
    if (percent == 100)
        ChangeState(itr->second, CONTRIBUTION_STATE_ACTIVE, uint32(time(nullptr)));
    else
        SetValue(worldState->ProgressWorldStateID, uint32(uint64(worldState->AccumulationStateTargetValue) * percent / 100));
    return true;
}
