/*
 * Solo LFG pour ArgusCore — Légion 7.3.5 (La Légion de Sylvania)
 *
 * Équivalent du mod-solo-lfg d'AzerothCore, adapté à ce core : ArgusCore
 * possède nativement un mode « testing » du Dungeon Finder (LFGMgr::m_isTesting)
 * qui lève les verrous nécessaires :
 *   - LFGQueue.cpp : un joueur seul (ou un groupe DÉJÀ FORMÉ de 2-4) déclenche
 *     immédiatement une proposition au lieu d'attendre un groupe complet ;
 *   - LFGScripts.cpp : le groupe LFG d'un seul joueur n'est pas dissous en
 *     quittant la carte du donjon.
 *
 * Ce module synchronise ce flag avec la clé SoloLFG.Enable, de façon IDEMPOTENTE
 * (ToggleTesting est une bascule, pas un setter) : l'état est réappliqué à chaque
 * (re)chargement de la config — « reload config » active/désactive à chaud.
 *
 * Il corrige aussi l'effet de bord « groupe fantôme » : hors testing le core
 * dissout le groupe LFG d'1 joueur dès qu'il quitte la carte du donjon ; en
 * testing ce nettoyage est désactivé, et une ré-inscription serait traitée comme
 * « continuer le même donjon ». On dissout donc nous-mêmes le groupe une fois le
 * donjon TERMINÉ, et on explique la situation au joueur s'il abandonne en cours.
 *
 * Limites assumées (mode testing global) :
 *   - les joueurs inscrits SÉPARÉMENT ne sont jamais regroupés (chaque
 *     inscription part instantanément) : pour jouer à plusieurs, former le
 *     groupe AVANT de s'inscrire ;
 *   - une instance commencée ne peut pas être rejointe (aucun backfill) ;
 *   - récompense journalière du donjon aléatoire à pleine valeur même en solo ;
 *   - pas de débuff Déserteur en solo/duo/trio (le core l'exige à 3+ restants).
 *
 * NB : la commande GM « .lfg debug » (admins, RBAC_PERM_COMMAND_LFG_DEBUG)
 * bascule le même flag ; l'état configuré est réimposé au prochain
 * « reload config ».
 */

#include "Chat.h"
#include "Config.h"
#include "Group.h"
#include "LFGMgr.h"
#include "Map.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "ScriptMgr.h"

#include <unordered_map>

namespace SoloLFG
{
    bool Enable   = false;
    bool Announce = true;

    // Anti-spam : groupe abandonné pour lequel le joueur a déjà été averti
    std::unordered_map<ObjectGuid, ObjectGuid> WarnedFor;

    void Reconcile()
    {
        if (Enable != sLFGMgr->IsTesting())
            sLFGMgr->ToggleTesting();
    }
}

class SoloLFG_WorldScript : public WorldScript
{
public:
    SoloLFG_WorldScript() : WorldScript("SoloLFG_WorldScript") { }

    void OnConfigLoad(bool /*reload*/) override
    {
        SoloLFG::Enable   = sConfigMgr->GetBoolDefault("SoloLFG.Enable", false);
        SoloLFG::Announce = sConfigMgr->GetBoolDefault("SoloLFG.Announce", true);
        SoloLFG::Reconcile();
    }
};

class SoloLFG_PlayerScript : public PlayerScript
{
public:
    SoloLFG_PlayerScript() : PlayerScript("SoloLFG_PlayerScript") { }

    void OnLogin(Player* player, bool /*firstLogin*/) override
    {
        // État réel du flag (un GM a pu le basculer via .lfg debug)
        if (SoloLFG::Announce && sLFGMgr->IsTesting())
            ChatHandler(player->GetSession()).SendSysMessage("|cffFF8000[Solo LFG]|r La Recherche de donjons se lance sans groupe complet : partez seul, ou formez votre groupe avant de vous inscrire.");
    }

    void OnLogout(Player* player) override
    {
        SoloLFG::WarnedFor.erase(player->GetGUID());
    }

    void OnMapChanged(Player* player) override
    {
        if (!SoloLFG::Enable || !sLFGMgr->IsTesting())
            return;

        Map* map = player->GetMap();
        if (!map || sLFGMgr->inLfgDungeonMap(player->GetGUID(), map->GetId(), map->GetDifficultyID()))
            return; // toujours dans son donjon LFG : rien à faire

        Group* group = player->GetGroup();
        if (!group || !group->isLFGGroup() || group->GetMembersCount() != 1)
            return;

        ObjectGuid gguid = group->GetGUID();

        if (sLFGMgr->GetState(gguid) == lfg::LFG_STATE_FINISHED_DUNGEON)
        {
            // Donjon terminé : dissoudre le groupe d'1 joueur (comportement core
            // hors testing), sinon la prochaine inscription serait traitée comme
            // « continuer » le donjon achevé.
            sLFGMgr->LeaveLfg(gguid);
            group->Disband();
            SoloLFG::WarnedFor.erase(player->GetGUID());
            return;
        }

        // Donjon quitté en cours : on conserve le groupe (retour possible via
        // l'œil LFG), mais on explique la situation — une seule fois.
        ObjectGuid& warned = SoloLFG::WarnedFor[player->GetGUID()];
        if (warned != gguid)
        {
            warned = gguid;
            ChatHandler(player->GetSession()).SendSysMessage("|cffFF8000[Solo LFG]|r Vous restez lié à votre donjon en cours : utilisez l'œil LFG pour y retourner, ou quittez le groupe d'instance pour pouvoir vous inscrire à un autre donjon.");
        }
    }
};

void AddSC_sololfg()
{
    new SoloLFG_WorldScript();
    new SoloLFG_PlayerScript();
}
