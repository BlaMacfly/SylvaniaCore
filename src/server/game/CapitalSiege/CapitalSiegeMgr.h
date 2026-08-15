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
// Une fois par jour serveur, a une heure tiree au hasard dans une plage
// configurable, une horde de playerbots de haut niveau assaille la capitale de
// la faction adverse et tente d abattre son dirigeant. La faction attaquante
// alterne strictement d un jour a l autre.
//
// Ce gestionnaire porte l ordonnancement, la persistance et la machine a etats.
// L IA d assaut vit dans CommandSiege, le pilotage GM dans
// scripts/CapitalSiege/cs_capital_siege.cpp.

#ifndef __CAPITALSIEGEMGR_H__
#define __CAPITALSIEGEMGR_H__

#include "Common.h"
#include "ObjectGuid.h"
#include "Position.h"
#include "SharedDefines.h"
#include <list>
#include <set>
#include <string>

class CommandSiege;
class Creature;
class Player;

enum CapitalSiegeStatus
{
    SIEGE_STATUS_IDLE       = 0,    // aucun evenement en cours
    SIEGE_STATUS_SPAWNING   = 1,    // vague en cours de connexion / equipement
    SIEGE_STATUS_ASSAULT    = 2,    // progression vers le trone
    SIEGE_STATUS_ENDING     = 3     // nettoyage en cours
};

// Valeurs ecrites telles quelles dans capital_siege_history.outcome
enum CapitalSiegeOutcome
{
    SIEGE_OUTCOME_RUNNING     = 0,  // ligne ouverte, evenement en cours
    SIEGE_OUTCOME_VICTORY     = 1,  // dirigeant abattu
    SIEGE_OUTCOME_TIMEOUT     = 2,  // duree maximale atteinte
    SIEGE_OUTCOME_CANCELLED   = 3,  // annulation GM
    SIEGE_OUTCOME_OVERLOAD    = 4,  // arret d urgence, serveur sous charge
    SIEGE_OUTCOME_INTERRUPTED = 5   // arret/crash du worldserver pendant l evenement
};

// Cible d une invasion : la capitale de la faction qui subit l assaut.
struct CapitalSiegeTarget
{
    uint32 mapId;               // carte de la capitale
    uint32 bossEntry;           // creature_template du dirigeant
    Position bossPos;           // position du trone
    Position stagingPos;        // point de rassemblement de la horde d invasion
    uint32 routeFirst;          // premiere entree aiwaypoints de la route d assaut
    uint32 routeLast;           // derniere entree aiwaypoints de la route d assaut
    uint32 bossSpawnId;         // creature.guid du dirigeant, pour le retrouver sur la carte
    uint32 bossLevel;           // niveau impose pendant l evenement, 0 = ne pas toucher
    uint64 bossHealth;          // PV imposes pendant l evenement, 0 = ne pas toucher
    uint32 bossFaction;         // faction imposee pendant l evenement, 0 = ne pas toucher
    char const* cityName;
};

class TC_GAME_API CapitalSiegeMgr
{
private:
    CapitalSiegeMgr();
    ~CapitalSiegeMgr();

public:
    CapitalSiegeMgr(CapitalSiegeMgr const&) = delete;
    CapitalSiegeMgr(CapitalSiegeMgr&&) = delete;
    CapitalSiegeMgr& operator=(CapitalSiegeMgr const&) = delete;
    CapitalSiegeMgr& operator=(CapitalSiegeMgr&&) = delete;

    static CapitalSiegeMgr* instance();

    // Cycle de vie -----------------------------------------------------------
    void LoadConfig();                          // (re)lecture de worldserver.conf
    void LoadState();                           // au demarrage du monde
    void Update(uint32 diff);                   // tick monde

    // Pilotage ---------------------------------------------------------------
    bool StartSiege(TeamId attacker, std::string const& trigger);
    void StopSiege(CapitalSiegeOutcome outcome);

    // Consultation -----------------------------------------------------------
    bool IsEnabled() const { return m_enabled; }
    CapitalSiegeStatus GetStatus() const { return m_status; }
    bool IsRunning() const { return m_status != SIEGE_STATUS_IDLE; }
    TeamId GetAttackerTeam() const { return m_attackerTeam; }
    TeamId GetScheduledTeam() const { return m_scheduledTeam; }
    CapitalSiegeTarget const* GetTarget() const { return m_target; }
    // Commandant de la horde d invasion, nul hors evenement.
    CommandSiege* GetCommander() const { return m_commander; }
    uint32 GetElapsedSeconds() const { return m_elapsed / IN_MILLISECONDS; }
    uint32 GetRemainingSeconds() const;
    std::string GetStatusText() const;
    std::string GetScheduleText() const;

    // Parametres exposes aux etapes suivantes (spawner, IA d assaut, boss)
    uint32 GetBotCount() const { return m_botCount; }
    uint32 GetBotLevel() const { return m_botLevel; }
    uint32 GetSpawnRate() const { return m_spawnRate; }
    uint32 GetPvpMode() const { return m_pvpMode; }
    float GetEngageRange() const { return m_engageRange; }
    uint32 GetStallTimeout() const { return m_stallTimeout; }
    uint32 GetAdvanceWindow() const { return m_advanceWindow; }

    static char const* GetTeamName(TeamId team);
    static char const* GetOutcomeName(CapitalSiegeOutcome outcome);

private:
    // Ordonnancement ---------------------------------------------------------
    void UpdateSchedule(time_t now);
    void DrawScheduleForDay(time_t now);
    bool IsInsideWindow(time_t now) const;

    // Deroulement ------------------------------------------------------------
    void UpdateRunningSiege(uint32 diff);
    bool IsServerOverloaded(uint32 diff);

    // Dirigeant --------------------------------------------------------------
    Creature* FindBoss() const;
    void AwakenBoss();
    void RestoreBoss();
    bool IsBossDead() const;

    // Recrutement ------------------------------------------------------------
    void UpdateRecruitment();
    void ProcessPendingRecruits();
    bool RecruitOneBot();
    void ReleaseAllBots();
    // BotClassAI ne couvre que neuf classes : pas de chevalier de la mort, de
    // moine ni de chasseur de demons dans la horde d invasion.
    static bool IsSiegeCapableClass(uint8 playerClass);

    // Persistance ------------------------------------------------------------
    void SaveState();
    void OpenHistoryRow(std::string const& trigger);
    void CloseHistoryRow(CapitalSiegeOutcome outcome);
    void CloseOrphanHistoryRows();

    // Utilitaires ------------------------------------------------------------
    static time_t GetDayStart(time_t t);
    static uint32 GetServerDay(time_t t);
    void Announce(char const* format, ...) const ATTR_PRINTF(2, 3);

private:
    // Configuration
    bool   m_enabled;
    uint32 m_hourMin;
    uint32 m_hourMax;
    uint32 m_botCount;
    uint32 m_botLevel;
    uint32 m_duration;          // secondes
    uint32 m_spawnRate;         // bots par seconde
    uint32 m_pvpMode;           // 0 = PNJ seuls, 1 = joueurs flagges PvP, 2 = tous
    float  m_engageRange;       // yards, portee d engagement en mode siege
    uint32 m_stallTimeout;      // secondes sans progresser avant de lacher la cible
    uint32 m_advanceWindow;     // secondes de marche forcee apres un enlisement
    uint32 m_maxDiff;           // ms, seuil d arret d urgence (0 = desactive)
    bool   m_announce;
    CapitalSiegeTarget m_targets[2];    // indexe par TeamId de l attaquant

    // Etat persiste
    uint32 m_lastEventDay;      // dernier jour ou un evenement a ete consomme
    TeamId m_lastAttackerTeam;  // derniere faction attaquante (alternance)
    uint32 m_scheduledDay;      // jour du tirage courant
    time_t m_scheduledTime;     // horodatage du declenchement tire
    TeamId m_scheduledTeam;

    // Etat volatil
    // Bot en cours d enrolement : connexion, remise a niveau, puis trajet vers
    // le point de rassemblement. Suivi par compte, car le personnage tire par
    // la connexion n est pas connu a l avance.
    struct SiegeRecruit
    {
        uint32 accountId;
        uint32 stage;           // 0 = connexion et reglage, 1 = trajet
        uint32 waitSeconds;

        explicit SiegeRecruit(uint32 account) : accountId(account), stage(0), waitSeconds(0) { }
    };

    CapitalSiegeStatus m_status;
    TeamId m_attackerTeam;
    CapitalSiegeTarget const* m_target;
    CommandSiege* m_commander;
    // Dirigeant : etat d origine, restaure en fin d evenement. Rien n est
    // ecrit en base, un arret du worldserver laisse donc la creature intacte.
    ObjectGuid m_bossGuid;
    uint32 m_bossClearedFlags;
    uint32 m_bossOriginalLevel;
    uint32 m_bossOriginalFaction;
    uint64 m_bossOriginalMaxHealth;
    bool   m_bossAwakened;
    bool   m_bossLookupFailed;
    uint32 m_bossRetryTimer;

    std::list<SiegeRecruit> m_recruits;
    std::set<uint32> m_engagedAccounts;
    // Total engage depuis le debut de l evenement. Plafonne le recrutement :
    // un bot tue n est jamais remplace, il n y a pas de vague infinie.
    uint32 m_totalRecruited;
    uint32 m_elapsed;           // ms depuis le debut de l evenement
    uint32 m_updateTimer;       // ms, cadence le tick a la seconde
    uint32 m_overloadTimer;     // ms passees au-dessus du seuil de charge
    uint32 m_botsSpawned;
    uint32 m_botsLost;
    time_t m_startTime;
};

#define sCapitalSiegeMgr CapitalSiegeMgr::instance()

#endif // __CAPITALSIEGEMGR_H__
