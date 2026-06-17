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

#include "BattlePayPackets.h"
#include "BattlePayMgr.h"
#include "BattlePayData.h"
#include "Bag.h"
#include "CharacterPackets.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "DB2Stores.h"
#include "World.h"
#include "CharacterService.h"

auto GetBagsFreeSlots = [](Player* player) -> uint32
{
    uint32 freeBagSlots = 0;
    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (auto bag = player->GetBagByPos(i))
            freeBagSlots += bag->GetFreeSlots();

    uint8 inventoryEnd = INVENTORY_SLOT_ITEM_START + player->GetInventorySlotCount();
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < inventoryEnd; i++)
        if (!player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            ++freeBagSlots;

    return freeBagSlots;
};

auto SendStartPurchaseResponse = [](WorldSession* session, Battlepay::Purchase const& purchase, Battlepay::Error const& result) -> void
{
    WorldPackets::BattlePay::StartPurchaseResponse response;
    response.PurchaseID = purchase.PurchaseID;
    response.ClientToken = purchase.ClientToken;
    response.PurchaseResult = result;
    session->SendPacket(response.Write());
};

auto SendPurchaseUpdate = [](WorldSession* session, Battlepay::Purchase const& purchase, uint32 result) -> void
{
    WorldPackets::BattlePay::PurchaseUpdate packet;
    WorldPackets::BattlePay::BattlePayPurchase data;
    data.PurchaseID = purchase.PurchaseID;
    data.UnkLong = 0;
    data.UnkLong2 = 0;
    data.Status = purchase.Status;
    data.ResultCode = result;
    data.ProductID = purchase.ProductID;
    data.UnkInt = purchase.ServerToken;
    data.WalletName = session->GetBattlePayMgr()->GetDefaultWalletName();
    packet.Purchase.emplace_back(data);
    session->SendPacket(packet.Write());
};

void WorldSession::HandleGetPurchaseListQuery(WorldPackets::BattlePay::GetPurchaseListQuery& /*packet*/)
{
    WorldPackets::BattlePay::PurchaseListResponse packet;
    //uint32 Result = 0;
    //std::vector<WorldPackets::BattlePay::BattlePayPurchase> Purchase;
    SendPacket(packet.Write());
}

void WorldSession::HandleUpdateVasPurchaseStates(WorldPackets::BattlePay::UpdateVasPurchaseStates& /*packet*/)
{
}

void WorldSession::HandleBattlePayDistributionAssign(WorldPackets::BattlePay::DistributionAssignToTarget& packet)
{
    if (!GetBattlePayMgr()->IsAvailable())
        return;

    GetBattlePayMgr()->AssignDistributionToCharacter(packet.TargetCharacter, packet.DistributionID, packet.ProductID, packet.SpecializationID, packet.ChoiceID);
}

void WorldSession::HandleGetProductList(WorldPackets::BattlePay::GetProductList& /*packet*/)
{
    if (!GetBattlePayMgr()->IsAvailable())
        return;

    GetBattlePayMgr()->SendProductList();
    GetBattlePayMgr()->SendAccountCredits();
}

void WorldSession::SendMakePurchase(ObjectGuid targetCharacter, uint32 clientToken, uint32 productID, WorldSession* session)
{
    if (!session || !session->GetBattlePayMgr()->IsAvailable())
        return;

    auto mgr = session->GetBattlePayMgr();

    auto player = session->GetPlayer();

    auto accountID = session->GetAccountId();

    Battlepay::Purchase purchase;
    purchase.ProductID = productID;
    purchase.ClientToken = clientToken;
    purchase.TargetCharacter = targetCharacter;
    purchase.Status = Battlepay::UpdateStatus::Loading;
    purchase.DistributionId = mgr->GenerateNewDistributionId();

    if (!sBattlePayDataStore->ProductExist(productID))
    {
        SendStartPurchaseResponse(session, purchase, Battlepay::Error::PurchaseDenied);
        return;
    }

    auto const& product = sBattlePayDataStore->GetProduct(purchase.ProductID);
    auto displayInfo = sBattlePayDataStore->GetDisplayInfo(product.DisplayInfoID);
    purchase.CurrentPrice = product.CurrentPriceFixedPoint;

    mgr->RegisterStartPurchase(purchase);

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_BATTLE_PAY_ACCOUNT_CREDITS);
    stmt->setUInt32(0, session->GetBattlenetAccountId());
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    uint32 accountCredits = result ? result->Fetch()[0].GetUInt32() : 0;
    auto purchaseData = mgr->GetPurchase();
    if (!accountCredits)
    {
        SendStartPurchaseResponse(session, *purchaseData, Battlepay::Error::InsufficientBalance);
        return;
    }

    if (accountCredits < static_cast<int64>(purchaseData->CurrentPrice))
    {
        SendStartPurchaseResponse(session, *purchaseData, Battlepay::Error::InsufficientBalance);
        return;
    }

    if (player && !product.Items.empty())
    {
        if (product.Items.size() > GetBagsFreeSlots(player))
        {
            player->SendBattlePayMessage(11, displayInfo->Name1);
            SendStartPurchaseResponse(session, *purchaseData, Battlepay::Error::PurchaseDenied);
            return;
        }
    }

    if (player)
    {
        for (auto itr : product.Items)
        {
            if (mgr->AlreadyOwnProduct(itr.ItemID))
            {
                player->SendBattlePayMessage(12, displayInfo->Name1);
                SendStartPurchaseResponse(session, *purchaseData, Battlepay::Error::PurchaseDenied);
                return;
            }
        }
    }

    purchaseData->PurchaseID = mgr->GenerateNewPurchaseID();
    purchaseData->ServerToken = urand(0, 0xFFFFFFF);

    SendStartPurchaseResponse(session, *purchaseData, Battlepay::Error::Ok);
    SendPurchaseUpdate(session, *purchaseData, Battlepay::Error::Ok);

    WorldPackets::BattlePay::ConfirmPurchase confirmPurchase;
    confirmPurchase.PurchaseID = purchaseData->PurchaseID;
    confirmPurchase.ServerToken = purchaseData->ServerToken;
    session->SendPacket(confirmPurchase.Write());
};


void WorldSession::HandleBattlePayStartPurchase(WorldPackets::BattlePay::StartPurchase& packet)
{
    SendMakePurchase(packet.TargetCharacter, packet.ClientToken, packet.ProductID, this);
}

void WorldSession::HandleBattlePayPurchaseProduct(WorldPackets::BattlePay::PurchaseProduct& packet)
{
    SendMakePurchase(packet.TargetCharacter, packet.ClientToken, packet.ProductID, this);
}

void WorldSession::HandleBattlePayConfirmPurchase(WorldPackets::BattlePay::ConfirmPurchaseResponse& packet)
{
    if (!GetBattlePayMgr()->IsAvailable())
        return;

    packet.ClientCurrentPriceFixedPoint /= Battlepay::g_CurrencyPrecision;

    auto purchase = GetBattlePayMgr()->GetPurchase();
    auto const& product = sBattlePayDataStore->GetProduct(purchase->ProductID);
    if (!purchase)
        return;

    if (purchase->Lock)
    {
        SendPurchaseUpdate(this, *purchase, Battlepay::Error::PurchaseDenied);
        return;
    }

    if (purchase->ServerToken != packet.ServerToken || !packet.ConfirmPurchase || purchase->CurrentPrice != packet.ClientCurrentPriceFixedPoint)
    {
        SendPurchaseUpdate(this, *purchase, Battlepay::Error::PurchaseDenied);
        return;
    }

    auto player = GetPlayer();

    LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_BATTLE_PAY_ACCOUNT_CREDITS);
    stmt->setUInt32(0, GetBattlenetAccountId());
    PreparedQueryResult result = LoginDatabase.Query(stmt);

    uint32 accountBalance = result ? result->Fetch()[0].GetUInt32() : 0;
    if (accountBalance < static_cast<int64>(purchase->CurrentPrice))
    {
        SendPurchaseUpdate(this, *purchase, Battlepay::Error::PurchaseDenied);
        return;
    }

    if (player && product.WebsiteType == Battlepay::BattlePet && player->HasSpell(product.CustomValue))
    {
        SendPurchaseUpdate(this, *purchase, Battlepay::Error::TooManyTokens);
        return;
    }

    purchase->Lock = true;
    purchase->Status = Battlepay::UpdateStatus::Finish;

    auto displayInfo = sBattlePayDataStore->GetDisplayInfo(product.DisplayInfoID);

    if (player && !product.Items.empty())
    {
        if (product.Items.size() > GetBagsFreeSlots(player))
        {
            player->SendBattlePayMessage(11, displayInfo->Name1);
            SendStartPurchaseResponse(this, *purchase, Battlepay::Error::PurchaseDenied);
            return;
        }
    }

    if (player)
    {
        for (auto itr : product.Items)
        {
            if (GetBattlePayMgr()->AlreadyOwnProduct(itr.ItemID))
            {
                player->SendBattlePayMessage(12, displayInfo->Name1);
                SendStartPurchaseResponse(this, *purchase, Battlepay::Error::PurchaseDenied);
                return;
            }
        }
    }

    SendPurchaseUpdate(this, *purchase, Battlepay::Error::Other);

    GetBattlePayMgr()->SavePurchase(purchase);
    GetBattlePayMgr()->ProcessDelivery(purchase);

    if (!player)
    {
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ENUM);
        stmt->setUInt32(0, GetAccountId());

        _queryProcessor.AddCallback(CharacterDatabase.AsyncQuery(stmt).WithPreparedCallback(
            [this](PreparedQueryResult result)
            {
                HandleCharEnum(result);
            }));
    }

    uint64 newBalance = accountBalance - purchase->CurrentPrice;

    LoginDatabasePreparedStatement* updStmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_BATTLE_PAY_ACCOUNT_CREDITS);
    updStmt->setUInt64(0, newBalance);
    updStmt->setUInt32(1, GetBattlenetAccountId());
    LoginDatabase.Execute(updStmt);

    if (player)
        player->SendBattlePayMessage(1, displayInfo->Name1);

    GetBattlePayMgr()->SendAccountCredits();
    GetBattlePayMgr()->SendProductList();
}

void WorldSession::HandleBattlePayAckFailedResponse(WorldPackets::BattlePay::BattlePayAckFailedResponse& /*packet*/)
{
}

void WorldSession::HandleBattlePayQueryClassTrialResult(WorldPackets::BattlePay::BattlePayQueryClassTrialResult& /*packet*/)
{
    WorldPackets::BattlePay::CharacterClassTrialCreate response;
    response.Result = 0;
    SendPacket(response.Write());
}

void WorldSession::HandleBattlePayTrialBoostCharacter(WorldPackets::BattlePay::BattlePayTrialBoostCharacter& packet)
{
    if (!sWorld->getBoolConfig(CONFIG_CLASS_TRIAL_ENABLED))
        return;

    CharacterInfo const* charInfo = sWorld->GetCharacterInfo(packet.Character);
    if (!charInfo || charInfo->AccountId != GetAccountId())
        return;

    uint8 charRace = charInfo->Race;
    bool isAlliance = ((1 << (charRace - 1)) & RACEMASK_ALLIANCE) != 0;

    float x, y, z, o;
    uint16 mapId, zoneId;

    if (isAlliance)
    {
        mapId = 1554;
        zoneId = 8124;
        x = -2556.0f;
        y = 2939.6f;
        z = 134.6f;
        o = 1.98f;
    }
    else
    {
        mapId = 1557;
        zoneId = 8422;
        x = 0.721f;
        y = 1.685f;
        z = 34.501f;
        o = 6.2787f;
    }

    sCharacterService->BoostCharacter(this, packet.Character, 100, mapId, zoneId, x, y, z, o, true, uint16(packet.SpecializationID));

    WorldPackets::BattlePay::CharacterClassTrialCreate response;
    response.Result = 0;
    SendPacket(response.Write());

    WorldPackets::BattlePay::UpgradeStarted upgradeStarted;
    upgradeStarted.CharacterGUID = packet.Character;
    SendPacket(upgradeStarted.Write());

    WorldPackets::BattlePay::BattlePayCharacterUpgradeQueued upgradeQueued;
    upgradeQueued.Character = packet.Character;
    SendPacket(upgradeQueued.Write());
}

void WorldSession::HandleBattlePayPurchaseDetailsResponse(WorldPackets::BattlePay::BattlePayPurchaseDetailsResponse& packet)
{
    WorldPackets::BattlePay::BattlePayPurchaseUnk response;
    response.UnkInt = 0;
    response.Key = "";
    response.UnkByte = packet.UnkByte;
    SendPacket(response.Write());
}

void WorldSession::HandleBattlePayPurchaseUnkResponse(WorldPackets::BattlePay::BattlePayPurchaseUnkResponse& /*packet*/)
{
    auto purchaseData = GetBattlePayMgr()->GetPurchase();
    SendPurchaseUpdate(this, *purchaseData, Battlepay::Error::Ok);
}

void WorldSession::SendDisplayPromo(int32 promotionID /*= 0*/)
{
    SendPacket(WorldPackets::BattlePay::DisplayPromotion(promotionID).Write());

    if (!GetBattlePayMgr()->IsAvailable())
        return;

    auto player = GetPlayer();
    auto const& product = sBattlePayDataStore->GetProduct(109);
    WorldPackets::BattlePay::DistributionListResponse packet;
    packet.Result = Battlepay::Error::Ok;

    WorldPackets::BattlePay::BattlePayDistributionObject data;
    data.TargetPlayer;
    data.DistributionID = GetBattlePayMgr()->GenerateNewDistributionId();
    data.PurchaseID = GetBattlePayMgr()->GenerateNewPurchaseID();
    data.Status = Battlepay::DistributionStatus::BATTLE_PAY_DIST_STATUS_AVAILABLE;
    data.ProductID = 109;
    data.TargetVirtualRealm = 0;
    data.TargetNativeRealm = 0;
    data.Revoked = false;

    WorldPackets::BattlePay::BattlePayProduct pProduct;
    pProduct.ProductID = product.ProductID;
    pProduct.Flags = product.Flags;
    pProduct.Type = product.Type;

    auto dataP = GetBattlePayMgr()->WriteDisplayInfo(product.DisplayInfoID, GetSessionDbLocaleIndex());
    if (std::get<0>(dataP))
    {
        pProduct.DisplayInfo.emplace();
        pProduct.DisplayInfo = std::get<1>(dataP);
    }

    data.Product.emplace();
    data.Product = pProduct;

    packet.DistributionObject.emplace_back(data);

    SendPacket(packet.Write());
}
