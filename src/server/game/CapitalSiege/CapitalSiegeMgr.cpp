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

#include "CapitalSiegeMgr.h"
#include "CommandSiege.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerBotMgr.h"
#include "PlayerBotSession.h"
#include "PlayerBotSetting.h"
#include "Random.h"
#include "World.h"
#include "WorldSession.h"

#include <algorithm>
#include <cstdarg>
#include <cstdio>
#include <ctime>

namespace
{
    // Duree minimale passee au-dessus du seuil de charge avant l arret d urgence.
    constexpr uint32 SIEGE_OVERLOAD_GRACE_MS = 10 * IN_MILLISECONDS;

    // Au-dela, une recrue qui n a pas rejoint la horde est abandonnee : compte
    // bloque en chargement, personnage d une classe non geree, teleport perdu.
    constexpr uint32 SIEGE_RECRUIT_TIMEOUT_SECONDS = 90;
}

CapitalSiegeMgr::CapitalSiegeMgr() :
    m_enabled(false), m_hourMin(18), m_hourMax(24), m_botCount(50), m_botLevel(110),
    m_duration(HOUR), m_spawnRate(5), m_pvpMode(1), m_engageRange(18.0f), m_stallTimeout(20), m_advanceWindow(12),
    m_bossLevel(112), m_bossHealthMult(50),
    m_maxDiff(400), m_announce(true),
    m_lastEventDay(0), m_lastAttackerTeam(TEAM_NEUTRAL), m_scheduledDay(0),
    m_scheduledTime(0), m_scheduledTeam(TEAM_NEUTRAL),
    m_status(SIEGE_STATUS_IDLE), m_attackerTeam(TEAM_NEUTRAL), m_target(nullptr),
    m_commander(nullptr), m_totalRecruited(0),
    m_elapsed(0), m_updateTimer(0), m_overloadTimer(0),
    m_botsSpawned(0), m_botsLost(0), m_startTime(0)
{
    // Les valeurs sont ecrasees par LoadConfig(). Elles ne servent que si le
    // fichier de configuration est muet sur une cle.
    m_targets[TEAM_ALLIANCE] = { 1, 42283, Position(), Position(), 2000, 2099, "Orgrimmar" };
    m_targets[TEAM_HORDE]    = { 0, 107574, Position(), Position(), 1000, 1099, "Hurlevent" };
}

CapitalSiegeMgr::~CapitalSiegeMgr() { }

CapitalSiegeMgr* CapitalSiegeMgr::instance()
{
    static CapitalSiegeMgr instance;
    return &instance;
}

char const* CapitalSiegeMgr::GetTeamName(TeamId team)
{
    switch (team)
    {
        case TEAM_ALLIANCE: return "Alliance";
        case TEAM_HORDE:    return "Horde";
        default:            return "aucune";
    }
}

char const* CapitalSiegeMgr::GetOutcomeName(CapitalSiegeOutcome outcome)
{
    switch (outcome)
    {
        case SIEGE_OUTCOME_RUNNING:     return "en cours";
        case SIEGE_OUTCOME_VICTORY:     return "victoire";
        case SIEGE_OUTCOME_TIMEOUT:     return "echec (temps ecoule)";
        case SIEGE_OUTCOME_CANCELLED:   return "annule";
        case SIEGE_OUTCOME_OVERLOAD:    return "arret d urgence (charge)";
        case SIEGE_OUTCOME_INTERRUPTED: return "interrompu (arret du serveur)";
        default:                        return "inconnu";
    }
}

/*******************************************************************************
 * Configuration
 ******************************************************************************/

void CapitalSiegeMgr::LoadConfig()
{
    m_enabled         = sConfigMgr->GetBoolDefault("siege_enable", false);
    m_hourMin         = sConfigMgr->GetIntDefault("siege_hour_min", 18);
    m_hourMax         = sConfigMgr->GetIntDefault("siege_hour_max", 24);
    m_botCount        = sConfigMgr->GetIntDefault("siege_botcount", 50);
    m_botLevel        = sConfigMgr->GetIntDefault("siege_botlevel", 110);
    m_duration        = sConfigMgr->GetIntDefault("siege_duration", HOUR);
    m_spawnRate       = sConfigMgr->GetIntDefault("siege_spawn_rate", 5);
    m_pvpMode         = sConfigMgr->GetIntDefault("siege_pvp", 1);
    m_engageRange     = sConfigMgr->GetFloatDefault("siege_engage_range", 18.0f);
    m_stallTimeout    = sConfigMgr->GetIntDefault("siege_stall_timeout", 20);
    m_advanceWindow   = sConfigMgr->GetIntDefault("siege_advance_window", 12);
    m_bossLevel       = sConfigMgr->GetIntDefault("siege_boss_level", 112);
    m_bossHealthMult  = sConfigMgr->GetIntDefault("siege_boss_hp_mult", 50);
    m_maxDiff         = sConfigMgr->GetIntDefault("siege_maxdiff", 400);
    m_announce        = sConfigMgr->GetBoolDefault("siege_announce", true);

    // Garde-fous : une plage horaire vide ou inversee rendrait le tirage
    // impossible, un nombre de bots absurde noierait le serveur.
    if (m_hourMin > 23)
        m_hourMin = 23;
    if (m_hourMax > 24)
        m_hourMax = 24;
    if (m_hourMax <= m_hourMin)
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: plage horaire invalide (%u-%u), retour a 18-24.", m_hourMin, m_hourMax);
        m_hourMin = 18;
        m_hourMax = 24;
    }
    if (m_botCount > 100)
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: siege_botcount=%u plafonne a 100.", m_botCount);
        m_botCount = 100;
    }
    if (m_spawnRate == 0)
        m_spawnRate = 1;
    if (m_duration < MINUTE)
        m_duration = MINUTE;
    if (m_pvpMode > 2)
        m_pvpMode = 1;
    // Une portee trop courte rendrait les bots inoffensifs, une portee au-dela
    // de BOTAI_SEARCH_RANGE (32 yards, BotAITool.h) les ferait courir apres
    // toute la ville au lieu de suivre leur route.
    if (m_engageRange < 5.0f || m_engageRange > 32.0f)
        m_engageRange = 18.0f;
    // Une fenetre de marche nulle rendrait le garde-fou anti-enlisement inutile.
    if (!m_advanceWindow)
        m_advanceWindow = 12;

    // Cible assaillie par l Alliance : la capitale de la Horde.
    m_targets[TEAM_ALLIANCE].mapId     = sConfigMgr->GetIntDefault("siege_horde_map", 1);
    m_targets[TEAM_ALLIANCE].bossEntry = sConfigMgr->GetIntDefault("siege_horde_boss_entry", 42283);
    m_targets[TEAM_ALLIANCE].bossPos.Relocate(
        sConfigMgr->GetFloatDefault("siege_horde_boss_x", 1924.4f),
        sConfigMgr->GetFloatDefault("siege_horde_boss_y", -4144.1f),
        sConfigMgr->GetFloatDefault("siege_horde_boss_z", 40.6f));
    m_targets[TEAM_ALLIANCE].stagingPos.Relocate(
        sConfigMgr->GetFloatDefault("siege_horde_staging_x", 1570.0f),
        sConfigMgr->GetFloatDefault("siege_horde_staging_y", -4397.4f),
        sConfigMgr->GetFloatDefault("siege_horde_staging_z", 16.0f));
    m_targets[TEAM_ALLIANCE].routeFirst = sConfigMgr->GetIntDefault("siege_horde_route_first", 2000);
    m_targets[TEAM_ALLIANCE].routeLast  = sConfigMgr->GetIntDefault("siege_horde_route_last", 2099);
    m_targets[TEAM_ALLIANCE].cityName = "Orgrimmar";

    // Cible assaillie par la Horde : la capitale de l Alliance.
    m_targets[TEAM_HORDE].mapId     = sConfigMgr->GetIntDefault("siege_alliance_map", 0);
    m_targets[TEAM_HORDE].bossEntry = sConfigMgr->GetIntDefault("siege_alliance_boss_entry", 107574);
    m_targets[TEAM_HORDE].bossPos.Relocate(
        sConfigMgr->GetFloatDefault("siege_alliance_boss_x", -8363.3f),
        sConfigMgr->GetFloatDefault("siege_alliance_boss_y", 232.5f),
        sConfigMgr->GetFloatDefault("siege_alliance_boss_z", 157.1f));
    m_targets[TEAM_HORDE].stagingPos.Relocate(
        sConfigMgr->GetFloatDefault("siege_alliance_staging_x", -8904.1f),
        sConfigMgr->GetFloatDefault("siege_alliance_staging_y", 692.4f),
        sConfigMgr->GetFloatDefault("siege_alliance_staging_z", 99.5f));
    m_targets[TEAM_HORDE].routeFirst = sConfigMgr->GetIntDefault("siege_alliance_route_first", 1000);
    m_targets[TEAM_HORDE].routeLast  = sConfigMgr->GetIntDefault("siege_alliance_route_last", 1099);
    m_targets[TEAM_HORDE].cityName = "Hurlevent";

    TC_LOG_INFO("server.loading", "Siege des Capitales: %s (plage %02uh-%02uh, %u bots niveau %u, duree max %u min).",
        m_enabled ? "actif" : "inactif", m_hourMin, m_hourMax, m_botCount, m_botLevel, m_duration / MINUTE);
}

/*******************************************************************************
 * Cycle de vie
 ******************************************************************************/

void CapitalSiegeMgr::LoadState()
{
    // Un evenement laisse ouvert signifie que le worldserver s est arrete en
    // plein siege : la ligne d historique est refermee et les bots eventuels
    // sont deja hors ligne (leurs sessions ne survivent pas a l arret).
    CloseOrphanHistoryRows();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CAPITAL_SIEGE_STATE);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
    {
        TC_LOG_INFO("server.loading", "Siege des Capitales: aucun etat persiste, premier tirage au prochain tick.");
        return;
    }

    Field* fields = result->Fetch();
    m_lastEventDay     = fields[0].GetUInt32();
    m_lastAttackerTeam = TeamId(fields[1].GetInt8() < 0 ? TEAM_NEUTRAL : fields[1].GetInt8());
    m_scheduledDay     = fields[2].GetUInt32();
    m_scheduledTime    = time_t(fields[3].GetUInt32());
    m_scheduledTeam    = TeamId(fields[4].GetInt8() < 0 ? TEAM_NEUTRAL : fields[4].GetInt8());

    TC_LOG_INFO("server.loading", "Siege des Capitales: etat recharge (derniere faction attaquante: %s, jour du dernier evenement: %u).",
        GetTeamName(m_lastAttackerTeam), m_lastEventDay);
}

void CapitalSiegeMgr::Update(uint32 diff)
{
    if (!m_enabled)
    {
        if (IsRunning())
        {
            TC_LOG_INFO("server.worldserver", "Siege des Capitales: module desactive en cours d evenement, arret.");
            StopSiege(SIEGE_OUTCOME_CANCELLED);
        }
        return;
    }

    // La charge est surveillee a chaque tick monde, pas seulement a la seconde.
    bool const overloaded = IsServerOverloaded(diff);

    m_updateTimer += diff;
    if (m_updateTimer < IN_MILLISECONDS)
        return;

    uint32 const elapsedMs = m_updateTimer;
    m_updateTimer = 0;

    if (IsRunning())
    {
        if (overloaded)
        {
            TC_LOG_ERROR("server.worldserver", "Siege des Capitales: arret d urgence, le monde tourne au-dessus de %u ms depuis %u s.",
                m_maxDiff, SIEGE_OVERLOAD_GRACE_MS / IN_MILLISECONDS);
            StopSiege(SIEGE_OUTCOME_OVERLOAD);
            return;
        }
        UpdateRunningSiege(elapsedMs);
    }
    else
        UpdateSchedule(sWorld->GetGameTime());
}

/*******************************************************************************
 * Ordonnancement
 ******************************************************************************/

void CapitalSiegeMgr::UpdateSchedule(time_t now)
{
    uint32 const today = GetServerDay(now);

    if (m_scheduledDay != today)
        DrawScheduleForDay(now);

    if (m_lastEventDay == today)    // deja joue aujourd hui
        return;
    if (now < m_scheduledTime)
        return;

    // Rattrapage. Si le worldserver etait arrete a l heure tiree, on ne
    // declenche que tant qu on est encore dans la plage horaire configuree :
    // sinon le siege se lancerait a 7h du matin apres une nuit d arret.
    if (!IsInsideWindow(now))
    {
        TC_LOG_INFO("server.worldserver", "Siege des Capitales: creneau du jour manque (serveur arrete), report a demain.");
        m_lastEventDay = today;
        SaveState();
        return;
    }

    StartSiege(m_scheduledTeam, "auto");
}

void CapitalSiegeMgr::DrawScheduleForDay(time_t now)
{
    m_scheduledDay = GetServerDay(now);

    // Alternance stricte : jamais deux fois la meme faction attaquante.
    m_scheduledTeam = (m_lastAttackerTeam == TEAM_ALLIANCE) ? TEAM_HORDE : TEAM_ALLIANCE;

    uint32 const windowLength = (m_hourMax - m_hourMin) * HOUR;
    m_scheduledTime = GetDayStart(now) + time_t(m_hourMin * HOUR) + time_t(urand(0, windowLength - 1));

    SaveState();

    tm scheduledTm;
    time_t const scheduled = m_scheduledTime;
    localtime_r(&scheduled, &scheduledTm);
    TC_LOG_INFO("server.worldserver", "Siege des Capitales: tirage du jour -> %s a %02u:%02u:%02u.",
        GetTeamName(m_scheduledTeam), uint32(scheduledTm.tm_hour), uint32(scheduledTm.tm_min), uint32(scheduledTm.tm_sec));
}

bool CapitalSiegeMgr::IsInsideWindow(time_t now) const
{
    tm localTm;
    localtime_r(&now, &localTm);
    uint32 const hour = uint32(localTm.tm_hour);
    return hour >= m_hourMin && hour < m_hourMax;
}

/*******************************************************************************
 * Pilotage
 ******************************************************************************/

bool CapitalSiegeMgr::StartSiege(TeamId attacker, std::string const& trigger)
{
    if (IsRunning())
        return false;
    if (attacker != TEAM_ALLIANCE && attacker != TEAM_HORDE)
        return false;

    CapitalSiegeTarget const* target = &m_targets[attacker];

    // La route est validee avant toute autre chose : si elle est absente ou
    // incomplete, le creneau du jour n est pas consomme et l evenement pourra
    // se declencher normalement une fois les waypoints en base.
    CommandSiege* commander = new CommandSiege(target->mapId, attacker);
    if (!commander->LoadRoute(target->routeFirst, target->routeLast))
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: assaut sur %s annule, route d invasion indisponible.", target->cityName);
        delete commander;
        return false;
    }

    m_recruits.clear();
    m_engagedAccounts.clear();
    m_totalRecruited = 0;

    m_attackerTeam  = attacker;
    m_target        = target;
    m_commander     = commander;
    m_status        = SIEGE_STATUS_SPAWNING;
    m_elapsed       = 0;
    m_overloadTimer = 0;
    m_botsSpawned   = 0;
    m_botsLost      = 0;
    m_startTime     = sWorld->GetGameTime();

    // Le jour est consomme des le declenchement, avant toute autre operation :
    // un redemarrage du worldserver en plein evenement ne peut pas le rejouer.
    m_lastEventDay     = GetServerDay(m_startTime);
    m_lastAttackerTeam = attacker;
    SaveState();
    OpenHistoryRow(trigger);

    TC_LOG_INFO("server.worldserver", "Siege des Capitales: debut de l assaut %s sur %s (declencheur: %s).",
        GetTeamName(attacker), m_target->cityName, trigger.c_str());

    if (m_announce)
        Announce("|cffff2020[Siege des Capitales]|r Une armee de la %s marche sur %s !", GetTeamName(attacker), m_target->cityName);

    // E7 : demarrage du spawn etale de la horde d invasion.
    // E8 : eveil du dirigeant de la capitale.
    return true;
}

void CapitalSiegeMgr::StopSiege(CapitalSiegeOutcome outcome)
{
    if (!IsRunning())
        return;

    m_status = SIEGE_STATUS_ENDING;

    // Les bots repassent en IA normale et perdent leurs ordres d assaut avant
    // toute autre operation : aucun ne doit continuer a marcher sur le trone
    // pendant le nettoyage.
    if (m_commander)
    {
        m_botsSpawned = m_commander->GetBotCount();
        m_botsLost    = m_commander->GetLostCount();
    }

    ReleaseAllBots();

    delete m_commander;
    m_commander = nullptr;

    // E8 : restauration des drapeaux du dirigeant et purge des aggro de ville.

    CloseHistoryRow(outcome);

    TC_LOG_INFO("server.worldserver", "Siege des Capitales: fin de l assaut %s sur %s apres %u s -> %s.",
        GetTeamName(m_attackerTeam), m_target ? m_target->cityName : "?", GetElapsedSeconds(), GetOutcomeName(outcome));

    if (m_announce)
    {
        if (outcome == SIEGE_OUTCOME_VICTORY)
            Announce("|cffff2020[Siege des Capitales]|r %s est tombee : le dirigeant a ete abattu par la %s !",
                m_target ? m_target->cityName : "La capitale", GetTeamName(m_attackerTeam));
        else if (outcome == SIEGE_OUTCOME_TIMEOUT)
            Announce("|cff20ff20[Siege des Capitales]|r L assaut sur %s a ete repousse.", m_target ? m_target->cityName : "la capitale");
    }

    m_status       = SIEGE_STATUS_IDLE;
    m_attackerTeam = TEAM_NEUTRAL;
    m_target       = nullptr;
    m_elapsed      = 0;
}

void CapitalSiegeMgr::UpdateRunningSiege(uint32 diff)
{
    m_elapsed += diff;

    if (m_elapsed >= m_duration * IN_MILLISECONDS)
    {
        StopSiege(SIEGE_OUTCOME_TIMEOUT);
        return;
    }

    if (!m_commander)
        return;

    UpdateRecruitment();

    m_commander->Update(diff);
    m_botsSpawned = m_commander->GetBotCount();
    m_botsLost    = m_commander->GetLostCount();

    // E8 : detection de la mort du dirigeant, condition de victoire immediate.
}

/*******************************************************************************
 * Recrutement de la horde d invasion
 ******************************************************************************/

bool CapitalSiegeMgr::IsSiegeCapableClass(uint8 playerClass)
{
    switch (playerClass)
    {
        case CLASS_WARRIOR:
        case CLASS_PALADIN:
        case CLASS_HUNTER:
        case CLASS_ROGUE:
        case CLASS_PRIEST:
        case CLASS_SHAMAN:
        case CLASS_MAGE:
        case CLASS_WARLOCK:
        case CLASS_DRUID:
            return true;
        default:
            // Chevalier de la mort, moine et chasseur de demons n ont pas d IA
            // de combat scriptee dans BotClassAI.
            return false;
    }
}

void CapitalSiegeMgr::UpdateRecruitment()
{
    ProcessPendingRecruits();

    // Plafond sur le total engage depuis le debut, et non sur l effectif
    // present : un bot tue n est pas remplace. Sans ce plafond, les pertes
    // relanceraient le recrutement et l evenement produirait une vague sans fin.
    uint32 const engaged = m_totalRecruited;
    if (engaged >= m_botCount)
    {
        if (m_status == SIEGE_STATUS_SPAWNING && m_commander->GetBotCount())
        {
            m_status = SIEGE_STATUS_ASSAULT;
            TC_LOG_INFO("server.worldserver", "Siege des Capitales: horde au complet, %u bots en marche sur %s.",
                m_commander->GetBotCount(), m_target ? m_target->cityName : "?");
        }
        return;
    }

    // Etalement du deploiement : au plus siege_spawn_rate engagements par
    // seconde. Connecter et re-equiper cinquante personnages sur un seul tick
    // monde ferait decrocher le serveur.
    uint32 remaining = std::min(m_spawnRate, m_botCount - engaged);
    while (remaining--)
    {
        if (!RecruitOneBot())
            break;  // plus aucun compte bot libre, on retentera au tick suivant
    }
}

void CapitalSiegeMgr::ProcessPendingRecruits()
{
    for (std::list<SiegeRecruit>::iterator it = m_recruits.begin(); it != m_recruits.end(); )
    {
        ++it->waitSeconds;
        if (it->waitSeconds > SIEGE_RECRUIT_TIMEOUT_SECONDS)
        {
            TC_LOG_ERROR("server.worldserver", "Siege des Capitales: recrue abandonnee, le compte bot %u n a pas rejoint la horde en %u s.",
                it->accountId, SIEGE_RECRUIT_TIMEOUT_SECONDS);
            m_engagedAccounts.erase(it->accountId);
            it = m_recruits.erase(it);
            continue;
        }

        WorldSession* session = sWorld->FindSession(it->accountId);
        if (!session || !session->IsBotSession())
        {
            m_engagedAccounts.erase(it->accountId);
            it = m_recruits.erase(it);
            continue;
        }

        Player* player = session->GetPlayer();
        if (!player || !player->IsInWorld() || session->PlayerLoading())
        {
            ++it;   // connexion ou changement de carte en cours
            continue;
        }

        if (it->stage == 0)
        {
            // La remise a niveau doit etre terminee avant le depart, sinon le
            // bot part au front avec son ancien equipement.
            if (session->HasSchedules() || !player->IsSettingFinish())
            {
                ++it;
                continue;
            }

            if (!IsSiegeCapableClass(player->getClass()))
            {
                m_engagedAccounts.erase(it->accountId);
                it = m_recruits.erase(it);
                continue;
            }

            PlayerBotMgr::SwitchPlayerBotAI(player, PlayerBotAIType::PBAIT_BG, true);

            Position const staging = m_commander->GetStagingPosition();
            player->TeleportTo(m_target->mapId, staging.GetPositionX(), staging.GetPositionY(), staging.GetPositionZ(), 0.0f);
            it->stage = 1;
            ++it;
            continue;
        }

        // Arrive sur la carte de la capitale : le bot rejoint la horde.
        if (player->GetMapId() != m_target->mapId)
        {
            ++it;
            continue;
        }

        if (!m_commander->AddBot(player))
        {
            m_engagedAccounts.erase(it->accountId);
            it = m_recruits.erase(it);
            continue;
        }

        it = m_recruits.erase(it);
    }
}

bool CapitalSiegeMgr::RecruitOneBot()
{
    SessionMap const& sessions = sWorld->GetAllSessions();

    // Premier choix : un bot deja connecte et inoccupe. Pas de connexion a
    // payer, et il est deja charge en memoire.
    for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
    {
        if (!it->second->IsBotSession())
            continue;
        PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(it->second);
        if (!session || session->PlayerLoading() || session->HasSchedules() || session->IsAccountBotSession())
            continue;
        if (m_engagedAccounts.find(session->GetAccountId()) != m_engagedAccounts.end())
            continue;

        Player* player = session->GetPlayer();
        if (!player || player->IsLoading() || !player->IsInWorld())
            continue;
        // On ne debauche pas un bot deja occupe ailleurs : un champ de bataille
        // en cours reste prioritaire sur l evenement.
        if (player->InBattleground() || player->InArena() || player->InBattlegroundQueue())
            continue;
        if (player->GetMap()->IsDungeon() || player->isUsingLfg())
            continue;
        if (!player->IsSettingFinish())
            continue;
        if (player->GetTeamId() != m_attackerTeam)
            continue;
        if (!IsSiegeCapableClass(player->getClass()))
            continue;

        uint32 const level = PlayerBotSetting::CheckMaxLevel(m_botLevel);
        BotGlobleSchedule setting(BotGlobleScheduleType::BGSType_Settting, 0);
        setting.parameter1 = level;
        setting.parameter2 = level;
        setting.parameter3 = 4;
        session->PushScheduleToQueue(setting);

        m_engagedAccounts.insert(session->GetAccountId());
        m_recruits.push_back(SiegeRecruit(session->GetAccountId()));
        ++m_totalRecruited;
        return true;
    }

    // Second choix : une session bot hors ligne, qu on connecte sur un
    // personnage de la faction attaquante.
    for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
    {
        if (!it->second->IsBotSession())
            continue;
        PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(it->second);
        if (!session || session->PlayerLoading() || session->HasSchedules() || session->IsAccountBotSession())
            continue;
        if (m_engagedAccounts.find(session->GetAccountId()) != m_engagedAccounts.end())
            continue;
        if (session->GetPlayer())
            continue;

        uint32 const level = PlayerBotSetting::CheckMaxLevel(m_botLevel);

        BotGlobleSchedule online(BotGlobleScheduleType::BGSType_Online, 0);
        online.parameter1 = (m_attackerTeam == TEAM_ALLIANCE) ? 1 : 2;
        session->PushScheduleToQueue(online);

        BotGlobleSchedule setting(BotGlobleScheduleType::BGSType_Settting, 0);
        setting.parameter1 = level;
        setting.parameter2 = level;
        setting.parameter3 = 4;
        session->PushScheduleToQueue(setting);

        m_engagedAccounts.insert(session->GetAccountId());
        m_recruits.push_back(SiegeRecruit(session->GetAccountId()));
        ++m_totalRecruited;
        return true;
    }

    return false;
}

void CapitalSiegeMgr::ReleaseAllBots()
{
    if (m_commander)
    {
        // Deconnexion de tout l effectif, morts compris : c est le despawn
        // exige en fin d evenement.
        std::vector<ObjectGuid> const guids = m_commander->GetBotGuids();
        m_commander->DismissAll();

        for (ObjectGuid const& guid : guids)
        {
            if (Player* player = ObjectAccessor::FindPlayer(guid))
            {
                if (WorldSession* session = player->GetSession())
                    sPlayerBotMgr->PlayerBotLogout(session->GetAccountId());
            }
        }
    }

    // Les recrues encore en chemin sont relachees sans avoir combattu.
    for (std::list<SiegeRecruit>::const_iterator it = m_recruits.begin(); it != m_recruits.end(); ++it)
        sPlayerBotMgr->PlayerBotLogout(it->accountId);

    m_recruits.clear();
    m_engagedAccounts.clear();
}

bool CapitalSiegeMgr::IsServerOverloaded(uint32 diff)
{
    if (!m_maxDiff)
        return false;

    if (diff > m_maxDiff)
        m_overloadTimer += diff;
    else
        m_overloadTimer = 0;

    return m_overloadTimer >= SIEGE_OVERLOAD_GRACE_MS;
}

/*******************************************************************************
 * Persistance
 ******************************************************************************/

void CapitalSiegeMgr::SaveState()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_REP_CAPITAL_SIEGE_STATE);
    stmt->setUInt32(0, m_lastEventDay);
    stmt->setInt8(1, int8(m_lastAttackerTeam == TEAM_NEUTRAL ? -1 : int8(m_lastAttackerTeam)));
    stmt->setUInt32(2, m_scheduledDay);
    stmt->setUInt32(3, uint32(m_scheduledTime));
    stmt->setInt8(4, int8(m_scheduledTeam == TEAM_NEUTRAL ? -1 : int8(m_scheduledTeam)));
    CharacterDatabase.Execute(stmt);
}

void CapitalSiegeMgr::OpenHistoryRow(std::string const& trigger)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CAPITAL_SIEGE_HISTORY);
    stmt->setUInt32(0, uint32(m_startTime));
    stmt->setInt8(1, int8(m_attackerTeam));
    stmt->setUInt16(2, uint16(m_target ? m_target->mapId : 0));
    stmt->setUInt32(3, m_target ? m_target->bossEntry : 0);
    stmt->setString(4, trigger);
    CharacterDatabase.Execute(stmt);
}

void CapitalSiegeMgr::CloseHistoryRow(CapitalSiegeOutcome outcome)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CAPITAL_SIEGE_HISTORY_CLOSE);
    stmt->setUInt32(0, uint32(sWorld->GetGameTime()));
    stmt->setUInt32(1, GetElapsedSeconds());
    stmt->setInt8(2, int8(outcome));
    stmt->setUInt16(3, uint16(m_botsSpawned));
    stmt->setUInt16(4, uint16(m_botsLost));
    CharacterDatabase.Execute(stmt);
}

void CapitalSiegeMgr::CloseOrphanHistoryRows()
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CAPITAL_SIEGE_HISTORY_ORPHAN);
    stmt->setUInt32(0, uint32(sWorld->GetGameTime()));
    stmt->setInt8(1, int8(SIEGE_OUTCOME_INTERRUPTED));
    CharacterDatabase.Execute(stmt);
}

/*******************************************************************************
 * Consultation
 ******************************************************************************/

uint32 CapitalSiegeMgr::GetRemainingSeconds() const
{
    if (!IsRunning())
        return 0;
    uint32 const elapsed = GetElapsedSeconds();
    return elapsed >= m_duration ? 0 : m_duration - elapsed;
}

std::string CapitalSiegeMgr::GetStatusText() const
{
    char buffer[256];

    if (!m_enabled)
        return "Siege des Capitales: module desactive (siege_enable = 0).";

    if (!IsRunning())
        return GetScheduleText();

    char const* statusName = "?";
    switch (m_status)
    {
        case SIEGE_STATUS_SPAWNING: statusName = "deploiement"; break;
        case SIEGE_STATUS_ASSAULT:  statusName = "assaut";      break;
        case SIEGE_STATUS_ENDING:   statusName = "nettoyage";   break;
        default: break;
    }

    snprintf(buffer, sizeof(buffer),
        "Siege en cours [%s]: %s attaque %s. Ecoule %u s, restant %u s, bots %u engages / %u vivants / %u perdus / %u en route (objectif %u). Progression %u/%u.",
        statusName, GetTeamName(m_attackerTeam), m_target ? m_target->cityName : "?",
        GetElapsedSeconds(), GetRemainingSeconds(), m_botsSpawned,
        m_commander ? m_commander->GetAliveCount() : 0, m_botsLost,
        uint32(m_recruits.size()), m_botCount,
        m_commander ? m_commander->GetVanguardProgress() + 1 : 0,
        m_commander ? m_commander->GetRouteSize() : 0);
    return buffer;
}

std::string CapitalSiegeMgr::GetScheduleText() const
{
    char buffer[256];
    time_t const now = sWorld->GetGameTime();

    if (m_lastEventDay == GetServerDay(now))
    {
        snprintf(buffer, sizeof(buffer),
            "Aucun siege en cours. Le creneau du jour est deja consomme (derniere faction attaquante: %s). Prochain tirage demain.",
            GetTeamName(m_lastAttackerTeam));
        return buffer;
    }

    if (!m_scheduledTime)
        return "Aucun siege en cours. Tirage du jour pas encore effectue.";

    tm scheduledTm;
    time_t const scheduled = m_scheduledTime;
    localtime_r(&scheduled, &scheduledTm);
    snprintf(buffer, sizeof(buffer),
        "Aucun siege en cours. Prochain assaut: %s a %02u:%02u:%02u (dans %d s).",
        GetTeamName(m_scheduledTeam), uint32(scheduledTm.tm_hour), uint32(scheduledTm.tm_min), uint32(scheduledTm.tm_sec),
        int32(m_scheduledTime - now));
    return buffer;
}

/*******************************************************************************
 * Utilitaires
 ******************************************************************************/

time_t CapitalSiegeMgr::GetDayStart(time_t t)
{
    tm localTm;
    localtime_r(&t, &localTm);
    localTm.tm_hour = 0;
    localTm.tm_min  = 0;
    localTm.tm_sec  = 0;
    localTm.tm_isdst = -1;
    return mktime(&localTm);
}

uint32 CapitalSiegeMgr::GetServerDay(time_t t)
{
    return uint32(GetDayStart(t) / DAY);
}

void CapitalSiegeMgr::Announce(char const* format, ...) const
{
    char buffer[512];
    va_list args;
    va_start(args, format);
    vsnprintf(buffer, sizeof(buffer), format, args);
    va_end(args);

    sWorld->SendGlobalText(buffer, nullptr);
}
