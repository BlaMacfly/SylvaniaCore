/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2008-2017 TrinityCore <http://www.trinitycore.org/>
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
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "GameObject.h"
#include "ScriptedGossip.h"
#include "Log.h"

enum
{
    ///Hunter Quest
    NPC_SNOWFEATHER_100786 = 100786,
    QUEST_NEEDS_OF_THE_HUNTERS = 40384,
    QUEST_The_Hunters_Call = 41415,
};

enum ClassHallhunter
{
    SPELL_PLAYERCHOICE                      = 198430,
    PLAYER_CHOICE_HUNTER_ARTIFACT_SELECTION = 240,
    PLAYER_CHOICE_Hunter_Shooting           = 451,
    PLAYER_CHOICE_Hunter_Survival           = 450,
    PLAYER_CHOICE_Hunter_Beast_Mastery      = 452,
    SPELL_Hunter_SPEC_Beast_Mastery              = 198433,
    SPELL_Hunter_SPEC_Survival                   = 198435,
    SPELL_Hunter_SPEC_Shooting                   = 198436,
    KILL_CREDIT_HUNTER_ARTIFACT_CHOSEN          = 104634,
};

struct npc_snowfeather_100786 : public ScriptedAI
{
    npc_snowfeather_100786(Creature* creature) : ScriptedAI(creature) { SayHi = false; }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!who || !who->IsInWorld())
            return;
        if (!me->IsWithinDist(who, 25.0f, false))
            return;

        Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself();

        if (!player)
            return;
        me->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, me->GetFollowAngle());
        if (!SayHi)
        {
            SayHi = true;
            Talk(0, player);
        }
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_NEEDS_OF_THE_HUNTERS)
        {
            Talk(1, player);
            me->DespawnOrUnsummon(5000);
        }
    }
private:
    bool SayHi;
};

struct npc_grif_wildheart_100810 : public ScriptedAI
{
    npc_grif_wildheart_100810(Creature* creature) : ScriptedAI(creature) {  }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
    {
        TC_LOG_ERROR("server.worldserver", "sGossipSelect %u, %u", menuId, gossipListId);
        if (player->HasQuest(QUEST_The_Hunters_Call))
        {
            if (gossipListId == 0)
            {
                player->KilledMonsterCredit(104297);
                CloseGossipMenuFor(player);
            }
        }
    }
};

struct npc_apata_highmountain_99986 : public ScriptedAI
{
    npc_apata_highmountain_99986(Creature* creature) : ScriptedAI(creature) {  }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
    {
        TC_LOG_ERROR("server.worldserver", "sGossipSelect %u, %u", menuId, gossipListId);
        if (player->HasQuest(QUEST_The_Hunters_Call))
        {
            if (gossipListId == 0)
            {
                player->KilledMonsterCredit(104298);
                CloseGossipMenuFor(player);
            }
        }
    }
};

struct npc_courier_larkspur_100171 : public ScriptedAI
{
    npc_courier_larkspur_100171(Creature* creature) : ScriptedAI(creature) {  }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
    {
        TC_LOG_ERROR("server.worldserver", "sGossipSelect %u, %u", menuId, gossipListId);
        if (player->HasQuest(QUEST_The_Hunters_Call))
        {
            if (gossipListId == 0)
            {
                player->KilledMonsterCredit(104299);
                CloseGossipMenuFor(player);
            }
        }
    }
};

class PlayerScript_hunter_artifact_choice : public PlayerScript
{
public:
    PlayerScript_hunter_artifact_choice() : PlayerScript("PlayerScript_hunter_artifact_choice") {}

    // Hook renomme : OnCompleteQuestChoice est declare dans ScriptMgr mais
    // appele DE NULLE PART. Le seul hook que le core invoque a la reception
    // dun choix est OnPlayerChoiceResponse (QuestHandler.cpp). Cette methode
    // etait donc du code mort.
    void OnPlayerChoiceResponse(Player* player, uint32 choiceID, uint32 responseID) override
    {
        if (choiceID != PLAYER_CHOICE_HUNTER_ARTIFACT_SELECTION)
            return;

        // RemoveRewardedQuest(40618) retire : il rendait « Armes de legende » de nouveau
        // disponible a chaque choix, y compris pour la deuxieme et la troisieme arme.
        // Le credit des quetes 44043/44366 est donne par artifact_choice_universal,
        // qui seul sait si l arme choisie est nouvelle.
        // Le choix de l arme ne change PLUS la specialisation : le script d origine
        // forcait ActivateTalentGroup(), ce qui basculait le joueur sur un jeu de
        // talents vide et retirait son equipement. Les autres classes ne le font pas.
        switch (responseID)
        {
            case PLAYER_CHOICE_Hunter_Shooting:
            {
                if (player->GetQuestStatus(40618) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(KILL_CREDIT_HUNTER_ARTIFACT_CHOSEN);

                break;
            }   
            case PLAYER_CHOICE_Hunter_Beast_Mastery:
            {
                if (player->GetQuestStatus(40618) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(KILL_CREDIT_HUNTER_ARTIFACT_CHOSEN);

                break;
            }   
            case PLAYER_CHOICE_Hunter_Survival:
            {
                if (player->GetQuestStatus(40618) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(KILL_CREDIT_HUNTER_ARTIFACT_CHOSEN);

                break;
            } 
            default:
                break;
        }
    }
};

class npc_40618_artifact : public CreatureScript
{
public:
    npc_40618_artifact() : CreatureScript("npc_40618_artifact") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == 40618)
        {
            player->CastSpell(player, SPELL_PLAYERCHOICE, true); // Display player spec choice
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->HasQuest(40618) &&
            player->GetQuestStatus(40618) != QUEST_STATUS_REWARDED) {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "J'aimerais revoir les armes que nous pourrions rechercher.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF + 1:
            // ORDRE CRITIQUE : fermer AVANT de lancer le sort. SendCloseGossip()
            // appelle _interactionData.Reset(), ce qui efface le PlayerChoiceId
            // que SendPlayerChoice vient d'inscrire, et le serveur rejette
            // ensuite le clic du joueur.
            CloseGossipMenuFor(player);
            player->CastSpell(player, SPELL_PLAYERCHOICE, true); // Display player spec choice
            break;
        }
        return true;
    }
};

// Emmarel Shadewarden au Pavillon (107317, 107973) : « Perpetuer la legende » (44043) et
// « Une derniere aventure » (44366) demandent de choisir une nouvelle arme, mais aucun
// PNJ ne proposait le choix (ni chez nous ni chez LegionCore) : on rouvre la fenetre 240.
class npc_emmarel_artifact_next : public CreatureScript
{
public:
    npc_emmarel_artifact_next() : CreatureScript("npc_emmarel_artifact_next") { }

    static bool HasPendingChoice(Player* player)
    {
        return player->GetQuestStatus(44043) == QUEST_STATUS_INCOMPLETE
            || player->GetQuestStatus(44366) == QUEST_STATUS_INCOMPLETE;
    }

    bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest) override
    {
        if (quest->GetQuestId() == 44043 || quest->GetQuestId() == 44366)
            player->CastSpell(player, SPELL_PLAYERCHOICE, true);
        return false;
    }

    // reprise du SmartAI LegionCore de 107973 (un PNJ n a qu une IA) :
    // a la remise de 42659 « In Defense of Dalaran », le joueur lance 216477
    bool OnQuestReward(Player* player, Creature* /*creature*/, Quest const* quest, uint32 /*opt*/) override
    {
        if (quest->GetQuestId() == 42659)
            player->CastSpell(player, 216477, true);
        return false;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (HasPendingChoice(player))
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Je voudrais choisir une autre arme prodigieuse.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player); // AVANT le sort : la fermeture efface le choix autorise
            player->CastSpell(player, SPELL_PLAYERCHOICE, true);
        }
        return true;
    }
};

void AddSC_class_hall_hunter()
{
    new npc_emmarel_artifact_next();
    RegisterCreatureAI(npc_snowfeather_100786);
    RegisterCreatureAI(npc_grif_wildheart_100810);
    RegisterCreatureAI(npc_apata_highmountain_99986);
    RegisterCreatureAI(npc_courier_larkspur_100171);
    new PlayerScript_hunter_artifact_choice();
    new npc_40618_artifact();
}
