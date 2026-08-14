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
#include "DatabaseEnv.h"
#include "Player.h"
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
