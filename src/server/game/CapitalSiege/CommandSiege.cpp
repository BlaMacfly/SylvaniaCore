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

#include "CommandSiege.h"
#include "BotAI.h"
#include "BotBGAIMovement.h"
#include "CapitalSiegeMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"

CommandSiege::CommandSiege(uint32 mapId, TeamId attackerTeam) :
    m_mapId(mapId), m_attackerTeam(attackerTeam), m_bossGuid(ObjectGuid::Empty),
    m_lostCount(0), m_updateTimer(0)
{
}

CommandSiege::~CommandSiege()
{
    DismissAll();
}

/*******************************************************************************
 * Route
 ******************************************************************************/

bool CommandSiege::LoadRoute(uint32 firstEntry, uint32 lastEntry)
{
    m_route.clear();

    if (firstEntry > lastEntry)
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: plage de waypoints invalide (%u-%u).", firstEntry, lastEntry);
        return false;
    }

    uint32 skipped = 0;
    for (uint32 entry = firstEntry; entry <= lastEntry; ++entry)
    {
        AIWaypoint* waypoint = sAIWPMgr->FindAIWaypoint(entry);
        if (!waypoint)
            continue;   // les plages sont dimensionnees large, les trous sont normaux

        if (waypoint->mapID != m_mapId)
        {
            ++skipped;
            continue;
        }
        m_route.push_back(waypoint);
    }

    if (skipped)
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: %u waypoints de la plage %u-%u ignores, carte differente de %u.",
            skipped, firstEntry, lastEntry, m_mapId);

    if (!IsRouteReady())
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: route inexploitable, %u point(s) trouve(s) dans la plage %u-%u sur la carte %u. "
            "Verifiez que le script sql/sylvania des waypoints a bien ete applique.",
            uint32(m_route.size()), firstEntry, lastEntry, m_mapId);
        return false;
    }

    // AIWaypoint::pointDesc n est jamais renseigne par le constructeur du core
    // (le parametre desc est ignore), on trace donc les entrees.
    TC_LOG_INFO("server.worldserver", "Siege des Capitales: route chargee, %u points, de l entree %u a l entree %u.",
        uint32(m_route.size()), m_route.front()->entry, m_route.back()->entry);
    return true;
}

Position CommandSiege::GetStagingPosition() const
{
    if (m_route.empty())
        return Position();
    return m_route.front()->GetPosition();
}

Position CommandSiege::GetObjectivePosition() const
{
    if (m_route.empty())
        return Position();
    return m_route.back()->GetPosition();
}

/*******************************************************************************
 * Effectif
 ******************************************************************************/

bool CommandSiege::AddBot(Player* player)
{
    if (!player || !player->IsInWorld())
        return false;
    if (m_bots.find(player->GetGUID()) != m_bots.end())
        return false;

    BotBGAI* botAI = dynamic_cast<BotBGAI*>(player->GetAI());
    if (!botAI)
    {
        TC_LOG_ERROR("server.worldserver", "Siege des Capitales: %s n a pas d IA de combat scriptee, enrolement refuse.", player->GetName().c_str());
        return false;
    }

    botAI->ResetBotAI();
    botAI->SetSiegeMode(true);

    m_bots[player->GetGUID()] = SiegeBot();
    return true;
}

void CommandSiege::RemoveBot(ObjectGuid guid)
{
    std::map<ObjectGuid, SiegeBot>::iterator it = m_bots.find(guid);
    if (it == m_bots.end())
        return;

    if (BotBGAI* botAI = GetBotAI(guid))
    {
        botAI->SetSiegeMode(false);
        botAI->GetAIMovement()->ClearMovement();
    }
    m_bots.erase(it);
}

void CommandSiege::DismissAll()
{
    for (std::map<ObjectGuid, SiegeBot>::iterator it = m_bots.begin(); it != m_bots.end(); ++it)
    {
        if (BotBGAI* botAI = GetBotAI(it->first))
        {
            botAI->SetSiegeMode(false);
            botAI->GetAIMovement()->ClearMovement();
        }
    }
    m_bots.clear();
}

uint32 CommandSiege::GetAliveCount() const
{
    uint32 count = 0;
    for (std::map<ObjectGuid, SiegeBot>::const_iterator it = m_bots.begin(); it != m_bots.end(); ++it)
    {
        if (!it->second.dead)
            ++count;
    }
    return count;
}

std::vector<ObjectGuid> CommandSiege::GetBotGuids() const
{
    std::vector<ObjectGuid> guids;
    guids.reserve(m_bots.size());
    for (std::map<ObjectGuid, SiegeBot>::const_iterator it = m_bots.begin(); it != m_bots.end(); ++it)
        guids.push_back(it->first);
    return guids;
}

uint32 CommandSiege::GetVanguardProgress() const
{
    uint32 best = 0;
    for (std::map<ObjectGuid, SiegeBot>::const_iterator it = m_bots.begin(); it != m_bots.end(); ++it)
    {
        if (it->second.dead)
            continue;
        if (it->second.waypointIndex > best)
            best = it->second.waypointIndex;
    }
    return best;
}

/*******************************************************************************
 * Deroulement
 ******************************************************************************/

void CommandSiege::Update(uint32 diff)
{
    m_updateTimer += diff;
    if (m_updateTimer < COMMANDSIEGE_UPDATE_TICK)
        return;
    m_updateTimer = 0;

    if (m_route.empty())
        return;

    for (std::map<ObjectGuid, SiegeBot>::iterator it = m_bots.begin(); it != m_bots.end(); )
    {
        Player* player = GetBot(it->first);

        // Bot deconnecte : il quitte l effectif sans etre compte comme perte
        // au combat.
        if (!player)
        {
            it = m_bots.erase(it);
            continue;
        }

        // Hors du monde mais toujours connecte : changement de carte en cours.
        // On le laisse dans l effectif, sinon un simple teleport le ferait
        // sortir de la horde.
        if (!player->IsInWorld())
        {
            ++it;
            continue;
        }

        if (!player->IsAlive())
        {
            // Pas de resurrection en boucle : un bot tue est perdu pour
            // l evenement. BotBGAI en mode siege n appelle pas la remise en
            // jeu du champ de bataille.
            if (!it->second.dead)
            {
                it->second.dead = true;
                ++m_lostCount;
            }
            ++it;
            continue;
        }

        CommandBot(it->first, it->second, player);
        ++it;
    }
}

void CommandSiege::CommandBot(ObjectGuid guid, SiegeBot& state, Player* player)
{
    if (state.waypointIndex >= m_route.size())
        state.waypointIndex = uint32(m_route.size()) - 1;

    AIWaypoint* target = m_route[state.waypointIndex];
    float const distance = player->GetDistance(target->posX, target->posY, target->posZ);

    // L ordre de deplacement est reemis meme en plein combat : il ne fait que
    // memoriser la destination. BotBGAI arbitre seul, il ne marche que lorsqu il
    // n a plus d ennemi selectionne.
    if (distance < COMMANDSIEGE_WAYPOINT_REACH && state.waypointIndex + 1 < m_route.size())
    {
        ++state.waypointIndex;
        state.stallSeconds = 0;
        target = m_route[state.waypointIndex];
    }
    else
        ++state.stallSeconds;

    BotBGAI* botAI = GetBotAI(guid);
    if (!botAI)
        return;

    // Enlisement. Lacher la cible ne suffit pas : l IA en reselectionne une au
    // tick suivant, puisqu une ville presente toujours un adversaire a portee.
    // On ouvre donc une fenetre de marche forcee pendant laquelle le bot ignore
    // les cibles et progresse, quitte a encaisser des coups.
    uint32 const stallTimeout = sCapitalSiegeMgr->GetStallTimeout();
    if (stallTimeout && state.stallSeconds >= stallTimeout)
    {
        state.stallSeconds = 0;
        botAI->PushSiegeAdvance(sCapitalSiegeMgr->GetAdvanceWindow() * IN_MILLISECONDS);
    }

    // Arrive au dernier point de la route, le bot bascule sur le dirigeant.
    // L ordre est marque prioritaire pour qu un ordre de deplacement residuel
    // ne le detourne pas de sa cible.
    if (state.waypointIndex + 1 == m_route.size() && !m_bossGuid.IsEmpty())
    {
        botAI->GetAIMovement()->AcceptCommand(m_bossGuid, true);
        return;
    }

    botAI->GetAIMovement()->AcceptCommand(target);
}

/*******************************************************************************
 * Utilitaires
 ******************************************************************************/

Player* CommandSiege::GetBot(ObjectGuid guid) const
{
    return ObjectAccessor::FindPlayer(guid);
}

BotBGAI* CommandSiege::GetBotAI(ObjectGuid guid) const
{
    Player* player = GetBot(guid);
    if (!player)
        return nullptr;
    return dynamic_cast<BotBGAI*>(player->GetAI());
}
