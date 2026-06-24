/*
 * Sylvania custom : commande de sonde runtime de quete (Couche 3 du harnais de debug).
 * .qtest <nomJoueur> <questId> [complete]
 *   - dump objectif-par-objectif l'etat live de la quete pour un joueur EN LIGNE
 *   - allowConsole=true => utilisable via SOAP/console sans selectionner le joueur
 *   - option "complete" : AddQuest si besoin puis ForceCompleteQuest (test du flux/rendu)
 */
#include "ScriptMgr.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "QuestDef.h"
#include "RBAC.h"
#include <sstream>

class qtest_commandscript : public CommandScript
{
public:
    qtest_commandscript() : CommandScript("qtest_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> qtestCommandTable =
        {
            { "qtest", rbac::RBAC_PERM_COMMAND_QUEST, true, &HandleQTest, "" },
        };
        return qtestCommandTable;
    }

    static bool HandleQTest(ChatHandler* handler, char const* args)
    {
        if (!args || !*args)
        {
            handler->SendSysMessage("Usage: .qtest <nomJoueur> <questId> [complete]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::istringstream ss(args);
        std::string name;
        uint32 questId = 0;
        std::string act;
        ss >> name >> questId >> act;

        if (name.empty() || questId == 0)
        {
            handler->SendSysMessage("Usage: .qtest <nomJoueur> <questId> [complete]");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = ObjectAccessor::FindConnectedPlayerByName(name);
        if (!player)
        {
            handler->PSendSysMessage("qtest: joueur '%s' introuvable (doit etre en ligne).", name.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
        {
            handler->PSendSysMessage("qtest: quete %u introuvable.", questId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        QuestStatus st = player->GetQuestStatus(questId);
        char const* stName;
        switch (st)
        {
            case QUEST_STATUS_NONE:       stName = "NONE";       break;
            case QUEST_STATUS_COMPLETE:   stName = "COMPLETE";   break;
            case QUEST_STATUS_INCOMPLETE: stName = "INCOMPLETE"; break;
            case QUEST_STATUS_REWARDED:   stName = "REWARDED";   break;
            case QUEST_STATUS_FAILED:     stName = "FAILED";     break;
            default:                      stName = "?";          break;
        }

        handler->PSendSysMessage("=== qtest joueur=%s quete=%u statut=%s ===", name.c_str(), questId, stName);

        QuestObjectives const& objs = quest->GetObjectives();
        handler->PSendSysMessage("Objectifs: %u", uint32(objs.size()));
        for (QuestObjective const& obj : objs)
        {
            int32 cur = player->GetQuestObjectiveData(quest, obj.StorageIndex);
            bool done = player->IsQuestObjectiveComplete(obj);
            handler->PSendSysMessage("  [idx %d] Type=%u ObjectID=%d  %d/%d  %s",
                int32(obj.StorageIndex), uint32(obj.Type), obj.ObjectID, cur, obj.Amount, done ? "OK" : "--");
        }

        if (act == "complete")
        {
            if (st == QUEST_STATUS_NONE && player->CanAddQuest(quest, false))
                player->AddQuestAndCheckCompletion(quest, nullptr);
            player->ForceCompleteQuest(questId);
            handler->PSendSysMessage("qtest: ForceCompleteQuest applique -> statut=%d", int32(player->GetQuestStatus(questId)));
        }

        return true;
    }
};

void AddSC_custom_qtest()
{
    new qtest_commandscript();
}
