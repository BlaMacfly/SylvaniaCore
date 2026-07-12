/*
 * Choix d'artefact universel — 8 classes sans handler PlayerChoice
 * (guerrier, paladin, chasseur, pretre, DK, DH, chaman, demoniste).
 *
 * Les forges de chaque hall ouvrent deja l'interface de choix (SmartAI action 85) ;
 * ce script traite la REPONSE : il accorde, complete et recompense la quete
 * « <Spec> Chosen » d'origine, qui donne directement l'arme prodigieuse
 * (InitArtifactPowers est automatique a la reception de l'arme).
 *
 * Druide, mage, voleur et moine ont deja leurs handlers dedies : leurs
 * responseIds ne figurent pas dans la table ci-dessous.
 * Les responseIds sont uniques toutes classes confondues (verifie en DB).
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

namespace
{
    struct ArtifactChoiceReward
    {
        uint8 classId;
        uint32 questId;
    };

    // responseId -> (classe, quete « Chosen » qui recompense l'artefact)
    std::unordered_map<uint32, ArtifactChoiceReward> const ArtifactChoices =
    {
        // Chevalier de la mort (choix 253)
        { 400, { CLASS_DEATH_KNIGHT, 40722 } }, // Sang - Gueule des damnes
        { 401, { CLASS_DEATH_KNIGHT, 40723 } }, // Givre - Lames du Prince dechu
        { 402, { CLASS_DEATH_KNIGHT, 40724 } }, // Impie - Apocalypse
        // Demoniste (choix 245)
        { 420, { CLASS_WARLOCK, 40689 } },      // Affliction - Ulthalesh
        { 421, { CLASS_WARLOCK, 40691 } },      // Demonologie - Crane du man'ari
        { 422, { CLASS_WARLOCK, 40690 } },      // Destruction - Sceptre de Sargeras
        // Chasseur (choix 240)
        { 450, { CLASS_HUNTER, 40619 } },       // Survie - Serredague
        { 451, { CLASS_HUNTER, 40620 } },       // Precision - Thas'dorah
        { 452, { CLASS_HUNTER, 40621 } },       // Maitrise des betes - Frappe-titan
        // Paladin (choix 235)
        { 460, { CLASS_PALADIN, 40410 } },      // Sacre - Main d'argent
        { 461, { CLASS_PALADIN, 40409 } },      // Vindicte - Porte-cendres
        { 462, { CLASS_PALADIN, 40411 } },      // Protection - Garde-verite
        // Guerrier (choix 236)
        { 470, { CLASS_WARRIOR, 40580 } },      // Protection - Ecaille du Gardien de terre
        { 471, { CLASS_WARRIOR, 40582 } },      // Armes - Strom'kar
        { 472, { CLASS_WARRIOR, 40581 } },      // Fureur - Epees de guerre des Valarjar
        // Chasseur de demons (choix 231 et 255)
        { 478, { CLASS_DEMON_HUNTER, 40817 } }, // Devastation - Lames jumelles
        { 479, { CLASS_DEMON_HUNTER, 40818 } }, // Vengeance - Lames de guerre aldrachi
        { 640, { CLASS_DEMON_HUNTER, 40818 } }, // Vengeance (variante)
        { 641, { CLASS_DEMON_HUNTER, 40817 } }, // Devastation (variante)
        // Pretre (choix 248)
        { 480, { CLASS_PRIEST, 40708 } },       // Sacre - T'uure
        { 481, { CLASS_PRIEST, 40709 } },       // Discipline - Courroux de la Lumiere
        { 482, { CLASS_PRIEST, 40707 } },       // Ombre - Xal'atath
        // Chaman (choix 266)
        { 587, { CLASS_SHAMAN, 41328 } },       // Amelioration - Marteau-du-Destin
        { 588, { CLASS_SHAMAN, 41329 } },       // Elementaire - Poing de Ra-den
        { 589, { CLASS_SHAMAN, 41330 } },       // Restauration - Sharas'dal
    };
}

class artifact_choice_universal : public PlayerScript
{
public:
    artifact_choice_universal() : PlayerScript("artifact_choice_universal") { }

    void OnPlayerChoiceResponse(Player* player, uint32 /*choiceId*/, uint32 responseId) override
    {
        auto itr = ArtifactChoices.find(responseId);
        if (itr == ArtifactChoices.end())
            return;

        if (player->getClass() != itr->second.classId || player->getLevel() < 98)
            return;

        uint32 questId = itr->second.questId;
        if (player->GetQuestStatus(questId) != QUEST_STATUS_NONE)
            return;

        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
        {
            player->AddQuest(quest, nullptr);
            player->CompleteQuest(questId);
            player->RewardQuest(quest, 0, player, true);
        }
    }
};

// Ritssyn Flamescowl (104795, Dreadscar Rift) - la forge demoniste n'avait
// aucun declencheur : son gossip ouvre le choix d'artefact (PlayerChoice 245).
struct npc_ritssyn_flamescowl : public ScriptedAI
{
    npc_ritssyn_flamescowl(Creature* creature) : ScriptedAI(creature) { }

    void sGossipHello(Player* player) override
    {
        if (player->getClass() != CLASS_WARLOCK || player->getLevel() < 98)
            return;
        CloseGossipMenuFor(player);
        player->SendPlayerChoice(me->GetGUID(), 245);
    }
};

void AddSC_class_hall_artifact_choices()
{
    new artifact_choice_universal();
    RegisterCreatureAI(npc_ritssyn_flamescowl);
}
