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

// SylvaniaCore - Module "Siege des Capitales"
//
// Commandes GM :
//   .siege status              etat courant ou prochain declenchement
//   .siege start [alliance|horde]  declenchement manuel (faction par defaut :
//                              celle que l alternance a tiree pour aujourd hui)
//   .siege stop                annulation de l evenement en cours
//   .siege history             les dix derniers evenements
//
// Le declenchement manuel consomme le creneau du jour, exactement comme un
// declenchement automatique : pas de double siege dans la meme journee.

#include "CapitalSiegeMgr.h"
#include "Chat.h"
#include "CommandSiege.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "PlayerBotMgr.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "WorldSession.h"

#include <cstring>
#include <ctime>

namespace
{
    std::string FormatTimestamp(uint32 unixTime)
    {
        if (!unixTime)
            return "-";

        time_t const t = time_t(unixTime);
        tm localTm;
        localtime_r(&t, &localTm);

        char buffer[32];
        strftime(buffer, sizeof(buffer), "%d/%m %H:%M", &localTm);
        return buffer;
    }
}

static bool HandleSiegeStatus(ChatHandler* handler, char const* /*args*/)
{
    handler->SendSysMessage(sCapitalSiegeMgr->GetStatusText().c_str());
    return true;
}

static bool HandleSiegeStart(ChatHandler* handler, char const* args)
{
    if (!sCapitalSiegeMgr->IsEnabled())
    {
        handler->SendSysMessage("Le module Siege des Capitales est desactive (siege_enable = 0).");
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (sCapitalSiegeMgr->IsRunning())
    {
        handler->SendSysMessage("Un siege est deja en cours. Utilisez .siege stop pour l interrompre.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    TeamId attacker = TEAM_NEUTRAL;
    if (args && *args)
    {
        if (!strncmp(args, "alliance", 8))
            attacker = TEAM_ALLIANCE;
        else if (!strncmp(args, "horde", 5))
            attacker = TEAM_HORDE;
        else
        {
            handler->SendSysMessage("Syntaxe : .siege start [alliance|horde]");
            handler->SetSentErrorMessage(true);
            return false;
        }
    }
    else
    {
        // Sans argument, on respecte l alternance : la faction qui devait
        // attaquer aujourd hui.
        attacker = sCapitalSiegeMgr->GetScheduledTeam();
        if (attacker == TEAM_NEUTRAL)
            attacker = TEAM_ALLIANCE;
    }

    std::string trigger = "GM";
    if (Player* gm = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr)
        trigger = gm->GetName();

    if (!sCapitalSiegeMgr->StartSiege(attacker, trigger))
    {
        handler->SendSysMessage("Impossible de declencher le siege.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    handler->PSendSysMessage("Siege declenche : assaut %s.", CapitalSiegeMgr::GetTeamName(attacker));
    return true;
}

static bool HandleSiegeStop(ChatHandler* handler, char const* /*args*/)
{
    if (!sCapitalSiegeMgr->IsRunning())
    {
        handler->SendSysMessage("Aucun siege en cours.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    sCapitalSiegeMgr->StopSiege(SIEGE_OUTCOME_CANCELLED);
    handler->SendSysMessage("Siege annule et nettoye.");
    return true;
}

// Harnais de test de l IA d assaut, en attendant le spawner automatique (E7) :
// enrole manuellement le playerbot selectionne dans la horde d invasion.
static bool HandleSiegeRecruit(ChatHandler* handler, char const* /*args*/)
{
    CommandSiege* commander = sCapitalSiegeMgr->GetCommander();
    if (!commander)
    {
        handler->SendSysMessage("Aucun siege en cours. Lancez d abord .siege start.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    Player* target = handler->getSelectedPlayer();
    if (!target)
    {
        handler->SendSysMessage("Selectionnez le playerbot a enroler.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (!target->IsPlayerBot())
    {
        handler->SendSysMessage("Seul un playerbot peut etre enrole dans la horde d invasion.");
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (target->GetTeamId() != commander->GetAttackerTeam())
    {
        handler->PSendSysMessage("%s n est pas de la faction attaquante (%s).",
            target->GetName().c_str(), CapitalSiegeMgr::GetTeamName(commander->GetAttackerTeam()));
        handler->SetSentErrorMessage(true);
        return false;
    }

    // L IA de combat scriptee doit etre en place avant l enrolement : c est
    // elle que CommandSiege bascule en mode siege.
    PlayerBotMgr::SwitchPlayerBotAI(target, PlayerBotAIType::PBAIT_BG, true);

    if (!commander->AddBot(target))
    {
        handler->PSendSysMessage("Enrolement de %s refuse (deja engage ?).", target->GetName().c_str());
        handler->SetSentErrorMessage(true);
        return false;
    }

    Position const staging = commander->GetStagingPosition();
    target->TeleportTo(commander->GetMapId(), staging.GetPositionX(), staging.GetPositionY(), staging.GetPositionZ(), 0.0f);

    handler->PSendSysMessage("%s enrole et deploye au point de rassemblement (%u bots engages).",
        target->GetName().c_str(), commander->GetBotCount());
    return true;
}

static bool HandleSiegeHistory(ChatHandler* handler, char const* /*args*/)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CAPITAL_SIEGE_HISTORY);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        handler->SendSysMessage("Aucun siege dans l historique.");
        return true;
    }

    handler->SendSysMessage("Derniers sieges (date, attaquant, issue, duree, bots) :");
    do
    {
        Field* fields = result->Fetch();
        uint32 const startTime    = fields[0].GetUInt32();
        int8 const  attackerTeam  = fields[1].GetInt8();
        int8 const  outcome       = fields[2].GetInt8();
        uint32 const duration     = fields[3].GetUInt32();
        uint16 const botsSpawned  = fields[4].GetUInt16();
        uint16 const botsLost     = fields[5].GetUInt16();
        std::string const trigger = fields[6].GetString();

        handler->PSendSysMessage("  %s | %s | %s | %u s | %u deployes, %u perdus | %s",
            FormatTimestamp(startTime).c_str(),
            CapitalSiegeMgr::GetTeamName(attackerTeam < 0 ? TEAM_NEUTRAL : TeamId(attackerTeam)),
            CapitalSiegeMgr::GetOutcomeName(CapitalSiegeOutcome(outcome)),
            duration, uint32(botsSpawned), uint32(botsLost), trigger.c_str());
    }
    while (result->NextRow());

    return true;
}

class capital_siege_commandscript : public CommandScript
{
public:
    capital_siege_commandscript() : CommandScript("capital_siege_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> siegeCommandTable =
        {
            { "status",  rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleSiegeStatus,  "" },
            { "start",   rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleSiegeStart,   "" },
            { "stop",    rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleSiegeStop,    "" },
            { "recruit", rbac::RBAC_PERM_COMMAND_EVENT, false, &HandleSiegeRecruit, "" },
            { "history", rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleSiegeHistory, "" },
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "siege", rbac::RBAC_PERM_COMMAND_EVENT, true, nullptr, "", siegeCommandTable },
        };

        return commandTable;
    }
};

void AddSC_capital_siege_commandscript()
{
    new capital_siege_commandscript();
}
