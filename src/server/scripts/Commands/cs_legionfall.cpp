// SylvaniaCore - batiments de Legionfall (Rivage brise)
//
// Commandes GM :
//   .legionfall info                         etape, progression, constructions et prochain changement des trois batiments
//   .legionfall state <batiment> <etape>     batiment : mage, command, nether ; etape : building, active, attack, destroyed
//   .legionfall progress <batiment> <pct>    progression d'un batiment en construction, 0 a 100 ; 100 le construit

#include "Chat.h"
#include "ContributionMgr.h"
#include "RBAC.h"
#include "ScriptMgr.h"

#include <cstring>
#include <ctime>

namespace
{
    char const* StateName(ContributionState state)
    {
        switch (state)
        {
            case CONTRIBUTION_STATE_BUILDING:     return "en construction";
            case CONTRIBUTION_STATE_ACTIVE:       return "actif";
            case CONTRIBUTION_STATE_UNDER_ATTACK: return "attaque";
            case CONTRIBUTION_STATE_DESTROYED:    return "detruit";
            default:                              return "inconnu";
        }
    }

    uint32 BuildingFromName(char const* name)
    {
        if (!name)
            return 0;
        if (!strcmp(name, "mage"))
            return CONTRIBUTION_MAGE_TOWER;
        if (!strcmp(name, "command"))
            return CONTRIBUTION_COMMAND_CENTER;
        if (!strcmp(name, "nether"))
            return CONTRIBUTION_NETHER_DISRUPTOR;
        return uint32(atoi(name));
    }

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

static bool HandleLegionfallInfo(ChatHandler* handler, char const* /*args*/)
{
    for (auto const& itr : sContributionMgr->GetContributions())
    {
        uint32 const id = itr.first;
        handler->PSendSysMessage("Batiment %u : %s, %u%%, construit %u fois, prochain changement %s.", id,
            StateName(sContributionMgr->GetState(id)), sContributionMgr->GetProgressPct(id), sContributionMgr->GetOccurrences(id),
            FormatTimestamp(sContributionMgr->GetNextChange(id)).c_str());
    }
    return true;
}

static bool HandleLegionfallState(ChatHandler* handler, char const* args)
{
    char* name = strtok((char*)args, " ");
    char* stateName = strtok(nullptr, " ");
    uint32 const building = BuildingFromName(name);

    ContributionState state = CONTRIBUTION_STATE_NONE;
    if (stateName)
    {
        if (!strcmp(stateName, "building"))
            state = CONTRIBUTION_STATE_BUILDING;
        else if (!strcmp(stateName, "active"))
            state = CONTRIBUTION_STATE_ACTIVE;
        else if (!strcmp(stateName, "attack"))
            state = CONTRIBUTION_STATE_UNDER_ATTACK;
        else if (!strcmp(stateName, "destroyed"))
            state = CONTRIBUTION_STATE_DESTROYED;
    }

    if (!sContributionMgr->SetState(building, state))
    {
        handler->SendSysMessage("Syntaxe : .legionfall state <mage|command|nether> <building|active|attack|destroyed>");
        handler->SetSentErrorMessage(true);
        return false;
    }

    handler->PSendSysMessage("Batiment %u : %s.", building, StateName(state));
    return true;
}

static bool HandleLegionfallProgress(ChatHandler* handler, char const* args)
{
    char* name = strtok((char*)args, " ");
    char* pct = strtok(nullptr, " ");
    uint32 const building = BuildingFromName(name);
    uint32 const percent = pct ? uint32(atoi(pct)) : 101;

    if (!sContributionMgr->SetProgress(building, percent))
    {
        handler->SendSysMessage("Seul un batiment en construction prend une progression, de 0 a 100 : .legionfall progress <mage|command|nether> <pct>");
        handler->SetSentErrorMessage(true);
        return false;
    }

    handler->PSendSysMessage("Batiment %u construit a %u%%.", building, percent);
    return true;
}

class legionfall_commandscript : public CommandScript
{
public:
    legionfall_commandscript() : CommandScript("legionfall_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> legionfallCommandTable =
        {
            { "info",     rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleLegionfallInfo,     "" },
            { "state",    rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleLegionfallState,    "" },
            { "progress", rbac::RBAC_PERM_COMMAND_EVENT, true, &HandleLegionfallProgress, "" },
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "legionfall", rbac::RBAC_PERM_COMMAND_EVENT, true, nullptr, "", legionfallCommandTable },
        };
        return commandTable;
    }
};

void AddSC_legionfall_commandscript()
{
    new legionfall_commandscript();
}
