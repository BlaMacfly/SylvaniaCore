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

// This is where scripts' loading functions should be declared:

// AntorusTheBurningThrone
void AddSC_antorus_the_burning_throne();
void AddSC_boss_admiral_svirax();
void AddSC_boss_aggramar();
void AddSC_boss_argus_the_unmaker();
void AddSC_boss_essence_of_eonar();
void AddSC_boss_fharg();
void AddSC_boss_garothi_worldbreaker();
void AddSC_boss_imonar_the_soulhunter();
void AddSC_boss_kingaroth();
void AddSC_boss_noura_mother_of_flames();
void AddSC_boss_portal_keeper_hasabel();
void AddSC_boss_shiwar();
void AddSC_boss_varimathras();
void AddSC_instance_antorus_the_burning_throne();

// Zones
void AddSC_zone_argus_antoran_wastes();
void AddSC_zone_argus_krokuun();
void AddSC_zone_argus_macaree();


// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddArgusScripts()
{
    // AntorusTheBurningThrone
    AddSC_antorus_the_burning_throne();
    AddSC_boss_admiral_svirax();
    AddSC_boss_aggramar();
    AddSC_boss_argus_the_unmaker();
    AddSC_boss_essence_of_eonar();
    AddSC_boss_fharg();
    AddSC_boss_garothi_worldbreaker();
    AddSC_boss_imonar_the_soulhunter();
    AddSC_boss_kingaroth();
    AddSC_boss_noura_mother_of_flames();
    AddSC_boss_portal_keeper_hasabel();
    AddSC_boss_shiwar();
    AddSC_boss_varimathras();
    AddSC_instance_antorus_the_burning_throne();

    // Zones
    AddSC_zone_argus_antoran_wastes();
    AddSC_zone_argus_krokuun();
    AddSC_zone_argus_macaree();
}
