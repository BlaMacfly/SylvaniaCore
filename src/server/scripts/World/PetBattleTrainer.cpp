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

#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "PetBattle.h"
#include "BattlePetDataStore.h"
#include "Player.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"
#include "ObjectMgr.h"
#include "ObjectAccessor.h"
#include "WorldSession.h"
#include "PetBattleSystem.h"

enum
{
    PetBattleTrainerFightActionID = GOSSIP_ACTION_INFO_DEF + 0xABCD
};

class npc_TrainerBattlePet : public CreatureScript
{
public:
    npc_TrainerBattlePet() : CreatureScript("npc_TrainerBattlePet") { }

    uint32 ObjectId = 0;
    bool isTrainer = false;
    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (sBattlePetDataStore->GetPetBattleTrainerTeam(creature->GetEntry()).empty())
            return false;

        ObjectId = creature->GetEntry();

        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->QuestObjectiveActiveInPlayerByObject(ObjectId))
        {
            isTrainer = true;

        }

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Let`s Go", GOSSIP_SENDER_MAIN, 0);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        player->PlayerTalkClass->ClearMenus();

        if (isTrainer)
        {
            if (uiAction == 0)
            {
                CloseGossipMenuFor(player);

                static float distance = 10.0f;

                float l_X = creature->m_positionX + (std::cos(creature->m_orientation) * distance);
                float l_Y = creature->m_positionY + (std::sin(creature->m_orientation) * distance);
                float l_Z = player->GetMap()->GetHeight(l_X, l_Y, MAX_HEIGHT);

                Position playerPosition = Position(l_X, l_Y, l_Z);
                playerPosition.m_orientation = atan2(creature->m_positionY - l_Y, creature->m_positionX - l_X);
                playerPosition.m_orientation = (playerPosition.m_orientation >= 0.0f) ? playerPosition.m_orientation : 2 * M_PI + playerPosition.m_orientation;

                Position trainerPosition = Position(creature->m_positionX, creature->m_positionY, creature->m_positionZ, creature->m_orientation);

                Position battleCenterPosition = Position((playerPosition.m_positionX + trainerPosition.m_positionX) / 2, (playerPosition.m_positionY + trainerPosition.m_positionY) / 2, 0.0f, trainerPosition.m_orientation + M_PI);
                battleCenterPosition.m_positionZ = player->GetMap()->GetHeight(battleCenterPosition.m_positionX, battleCenterPosition.m_positionY, MAX_HEIGHT);

                PetBattleRequest* battleRequest = sPetBattleSystem->CreateRequest(player->GetGUID());
                battleRequest->OpponentGuid = creature->GetGUID();
                battleRequest->PetBattleCenterPosition = battleCenterPosition;
                battleRequest->TeamPosition[PETBATTLE_TEAM_1] = playerPosition;
                battleRequest->TeamPosition[PETBATTLE_TEAM_2] = trainerPosition;
                battleRequest->RequestType = PETBATTLE_TYPE_PVE;

                eBattlePetRequests canEnterResult = sPetBattleSystem->CanPlayerEnterInPetBattle(player, battleRequest);
                if (canEnterResult != PETBATTLE_REQUEST_OK)
                {
                    player->GetSession()->SendPetBattleRequestFailed(canEnterResult);
                    sPetBattleSystem->RemoveRequest(battleRequest->RequesterGuid);
                    return true;
                }

                std::shared_ptr<BattlePetInstance> playerPets[MAX_PETBATTLE_SLOTS];
                std::shared_ptr<BattlePetInstance> wildBattlePets[MAX_PETBATTLE_SLOTS];

                for (size_t i = 0; i < MAX_PETBATTLE_SLOTS; ++i)
                {
                    playerPets[i] = nullptr;
                    wildBattlePets[i] = nullptr;
                }

                uint32 wildsPetCount = 0;
                for (BattlePetNpcTeamMember& v : sBattlePetDataStore->GetPetBattleTrainerTeam(creature->GetEntry()))
                {
                    if (wildsPetCount >= MAX_PETBATTLE_SLOTS)
                        break;

                    auto battlePetInstance = std::make_shared<BattlePetInstance>();

                    uint32 l_DisplayID = 0;

                    if (sBattlePetSpeciesStore.LookupEntry(v.Specie) && sObjectMgr->GetCreatureTemplate(sBattlePetSpeciesStore.LookupEntry(v.Specie)->CreatureID))
                    {
                        l_DisplayID = sObjectMgr->GetCreatureTemplate(sBattlePetSpeciesStore.LookupEntry(v.Specie)->CreatureID)->Modelid1;

                        if (!l_DisplayID)
                        {
                            l_DisplayID = sObjectMgr->GetCreatureTemplate(sBattlePetSpeciesStore.LookupEntry(v.Specie)->CreatureID)->Modelid2;

                            if (!l_DisplayID)
                            {
                                l_DisplayID = sObjectMgr->GetCreatureTemplate(sBattlePetSpeciesStore.LookupEntry(v.Specie)->CreatureID)->Modelid3;
                                if (!l_DisplayID)
                                    l_DisplayID = sObjectMgr->GetCreatureTemplate(sBattlePetSpeciesStore.LookupEntry(v.Specie)->CreatureID)->Modelid4;
                            }
                        }
                    }

                    battlePetInstance->JournalID.Clear();
                    battlePetInstance->Slot = 0;
                    battlePetInstance->NameTimeStamp = 0;
                    battlePetInstance->Species = v.Specie;
                    battlePetInstance->DisplayModelID = l_DisplayID;
                    battlePetInstance->XP = 0;
                    battlePetInstance->Flags = 0;
                    battlePetInstance->Health = 20000;

                    uint8 randQuality = sBattlePetDataStore->GetRandomQuailty();
                    battlePetInstance->Quality = v.minquality > randQuality ? v.minquality : randQuality;
                    battlePetInstance->Breed = sBattlePetDataStore->GetRandomBreedID(v.BreedIDs);
                    battlePetInstance->Level = std::max(urand(v.minlevel, v.maxlevel), static_cast<uint32>(1));

                    for (size_t i = 0; i < MAX_PETBATTLE_ABILITIES; ++i)
                        battlePetInstance->Abilities[i] = v.Ability[i];

                    wildBattlePets[wildsPetCount] = battlePetInstance;
                    wildBattlePets[wildsPetCount]->OriginalCreature.Clear();
                    wildsPetCount++;
                }

                size_t playerPetCount = 0;
                std::shared_ptr<BattlePet>* petSlots = player->GetBattlePetCombatTeam();
                for (size_t i = 0; i < MAX_PETBATTLE_SLOTS; ++i)
                {
                    if (!petSlots[i])
                        continue;

                    if (playerPetCount >= MAX_PETBATTLE_SLOTS || playerPetCount >= player->GetUnlockedPetBattleSlot())
                        break;

                    playerPets[playerPetCount] = std::make_shared<BattlePetInstance>();
                    playerPets[playerPetCount]->CloneFrom(petSlots[i]);
                    playerPets[playerPetCount]->Slot = playerPetCount;
                    playerPets[playerPetCount]->OriginalBattlePet = petSlots[i];

                    ++playerPetCount;
                }

                player->GetSession()->SendPetBattleFinalizeLocation(battleRequest);

                PetBattle* petBattle = sPetBattleSystem->CreateBattle();

                petBattle->Teams[PETBATTLE_TEAM_1]->OwnerGuid = player->GetGUID();
                petBattle->Teams[PETBATTLE_TEAM_1]->PlayerGuid = player->GetGUID();
                petBattle->Teams[PETBATTLE_TEAM_2]->OwnerGuid = creature->GetGUID();

                for (size_t i = 0; i < MAX_PETBATTLE_SLOTS; ++i)
                {
                    if (playerPets[i])
                        petBattle->AddPet(PETBATTLE_TEAM_1, playerPets[i]);

                    if (wildBattlePets[i])
                        petBattle->AddPet(PETBATTLE_TEAM_2, wildBattlePets[i]);
                }

                petBattle->BattleType = battleRequest->RequestType;
                petBattle->PveBattleType = PVE_PETBATTLE_TRAINER;

                player->_petBattleId = petBattle->ID;

                sPetBattleSystem->RemoveRequest(battleRequest->RequesterGuid);

                for (size_t i = 0; i < MAX_PETBATTLE_SLOTS; ++i)
                {
                    if (playerPets[i])
                        playerPets[i] = nullptr;

                    if (wildBattlePets[i])
                        wildBattlePets[i] = nullptr;
                }

                player->GetMotionMaster()->MovePointWithRot(PETBATTLE_ENTER_MOVE_SPLINE_ID, playerPosition.m_positionX, playerPosition.m_positionY, playerPosition.m_positionZ, playerPosition.m_orientation);
                creature->ForcedDespawn(1);
                creature->SetRespawnTime(3000000000000000);
            }
            else
                CloseGossipMenuFor(player);

            return true;
        }
    }
};

class PlayerScriptPetBattle : public PlayerScript
{
public:
    PlayerScriptPetBattle() : PlayerScript("PlayerScriptPetBattle") { }

    void OnMovementInform(Player* player, uint32 mveType, uint32 id) override
    {
        if (player && mveType == POINT_MOTION_TYPE && id == PETBATTLE_ENTER_MOVE_SPLINE_ID)
        {
            m_Mutex.lock();
            m_DelayedPetBattleStart[player->GetGUID()] = getMSTime() + 1000;
            m_Mutex.unlock();
        }
    }

    void OnUpdate(Player* player, uint32 /*diff*/) override
    {
        m_Mutex.lock();

        if (m_DelayedPetBattleStart.find(player->GetGUID()) != m_DelayedPetBattleStart.end())
        {
            if (m_DelayedPetBattleStart[player->GetGUID()] > getMSTime())
            {
                m_DelayedPetBattleStart.erase(m_DelayedPetBattleStart.find(player->GetGUID()));

                if (PetBattle* battle = sPetBattleSystem->GetBattle(player->_petBattleId))
                {
                    player->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED | UNIT_FLAG_IMMUNE_TO_NPC); // Immuned only to NPC
                    player->SetControlled(true, UNIT_STATE_ROOT);
                    battle->Begin();
                }
            }
        }

        m_Mutex.unlock();
    }

    std::map<ObjectGuid, uint32> m_DelayedPetBattleStart;
    std::mutex m_Mutex;
};

void AddSC_npc_PetBattleTrainer()
{
    new npc_TrainerBattlePet();
    new PlayerScriptPetBattle;
}
