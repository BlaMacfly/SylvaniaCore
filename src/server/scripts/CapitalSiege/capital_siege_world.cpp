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
// Branchement du gestionnaire sur la boucle du monde. Le module ne modifie pas
// World.cpp : tout passe par les hooks WorldScript, dans le sens autorise
// scripts -> game.

#include "CapitalSiegeMgr.h"
#include "ScriptMgr.h"

class capital_siege_world : public WorldScript
{
public:
    capital_siege_world() : WorldScript("capital_siege_world") { }

    // Lecture des cles de configuration, au demarrage comme sur .reload config.
    void OnConfigLoad(bool /*reload*/) override
    {
        sCapitalSiegeMgr->LoadConfig();
    }

    // Rechargement de l ordonnancement persiste et fermeture d un evenement
    // reste ouvert si le worldserver s est arrete en plein siege.
    void OnStartup() override
    {
        sCapitalSiegeMgr->LoadState();
    }

    void OnUpdate(uint32 diff) override
    {
        sCapitalSiegeMgr->Update(diff);
    }

    // Arret propre : la ligne d historique est refermee tout de suite plutot
    // que d attendre le prochain demarrage du core.
    void OnShutdown() override
    {
        if (sCapitalSiegeMgr->IsRunning())
            sCapitalSiegeMgr->StopSiege(SIEGE_OUTCOME_INTERRUPTED);
    }
};

void AddSC_capital_siege_world()
{
    new capital_siege_world();
}
