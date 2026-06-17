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

void AddSC_frostfire_ridge();
void AddSC_shadowmoon_draenor();
void AddSC_tanaan_jungle();

void AddSC_tanaan_intro_global();
void AddSC_tanaan_intro_portal();
void AddSC_tanaan_intro_bleeding_hollow();
void AddSC_tanaan_intro_shattered_hand();
void AddSC_tanaan_intro_shadowmoon();
void AddSC_tanaan_intro_blackrock();
void AddSC_tanaan_intro_finale();

void AddSC_garrison_level_1();
void AddSC_garrison_level_2();
void AddSC_garrison_level_3();
void AddSC_spells_garrison();
void AddSC_class_hall_legion();

// Auchindoun
void AddSC_auchindoun();
void AddSC_boss_azzakel();
void AddSC_boss_kaathar();
void AddSC_boss_nyami();
void AddSC_boss_teronogor();
void AddSC_instance_auchindoun();

// Blackrock Foundry
void AddSC_blackrock_foundry();
void AddSC_boss_beastlord_darmac();
void AddSC_boss_blackhand();
void AddSC_boss_blast_furnace();
void AddSC_boss_flamebender_kagraz();
void AddSC_boss_gruul_foundry();
void AddSC_boss_hansgar_and_franzok();
void AddSC_boss_iron_maidens();
void AddSC_boss_kromog();
void AddSC_boss_operator_thogar();
void AddSC_boss_oregorger();
void AddSC_instance_blackrock_foundry();

// Bloodmaul Slag Mines
void AddSC_areatrigger_Bloodmaul();
void AddSC_boss_forgemaster_gogduh();
void AddSC_boss_gugrokk();
void AddSC_boss_roltall();
void AddSC_boss_SlaveWatcherCrushto();
void AddSC_mob_Bloodmaul();
void AddSC_spell_Bloodmaul();
void AddSC_instance_Bloodmaul();

// Everbloom
void AddSC_boss_ancient_protectors();
void AddSC_boss_sol();
void AddSC_boss_witherbark();
void AddSC_boss_xeritac();
void AddSC_boss_yalnu();
void AddSC_the_everbloom();
void AddSC_instance_everbloom();

// Shadowmoon Burial Grounds
void AddSC_bonemaw();
void AddSC_nerzul();
void AddSC_nhalish();
void AddSC_sadana();
void AddSC_shadowmoon_burial_grounds();
void AddSC_instance_shadowmoon_burial_grounds();

// Highmaul
void AddSC_boss_twin_ogron();
void AddSC_boss_the_butcher();
void AddSC_boss_koragh();
void AddSC_boss_kargath_bladefist();
void AddSC_boss_imperator_margok();
void AddSC_boss_brackenspore();
void AddSC_boss_tectus();
void AddSC_highmaul();
void AddSC_instance_highmaul();

// The name of this function should match:
// void Add${NameOfDirectory}Scripts()
void AddDraenorScripts()
{
    AddSC_frostfire_ridge();
    AddSC_shadowmoon_draenor();
    AddSC_tanaan_jungle();

    AddSC_tanaan_intro_global();
    AddSC_tanaan_intro_portal();
    AddSC_tanaan_intro_bleeding_hollow();
    AddSC_tanaan_intro_shattered_hand();
    AddSC_tanaan_intro_shadowmoon();
    AddSC_tanaan_intro_blackrock();
    AddSC_tanaan_intro_finale();

    AddSC_garrison_level_1();
    AddSC_garrison_level_2();
    AddSC_garrison_level_3();
    AddSC_spells_garrison();
    AddSC_class_hall_legion();

    // Auchindoun
    AddSC_auchindoun();
    AddSC_boss_azzakel();
    AddSC_boss_kaathar();
    AddSC_boss_nyami();
    AddSC_boss_teronogor();
    AddSC_instance_auchindoun();

    // Blackrock Foundry
    AddSC_blackrock_foundry();
    AddSC_boss_beastlord_darmac();
    AddSC_boss_blackhand();
    AddSC_boss_blast_furnace();
    AddSC_boss_flamebender_kagraz();
    AddSC_boss_gruul_foundry();
    AddSC_boss_hansgar_and_franzok();
    AddSC_boss_iron_maidens();
    AddSC_boss_kromog();
    AddSC_boss_operator_thogar();
    AddSC_boss_oregorger();
    AddSC_instance_blackrock_foundry();

    // Bloodmaul Slag Mines
    AddSC_areatrigger_Bloodmaul();
    AddSC_boss_forgemaster_gogduh();
    AddSC_boss_gugrokk();
    AddSC_boss_roltall();
    AddSC_boss_SlaveWatcherCrushto();
    AddSC_mob_Bloodmaul();
    AddSC_spell_Bloodmaul();
    AddSC_instance_Bloodmaul();

    // Everbloom
    AddSC_boss_ancient_protectors();
    AddSC_boss_sol();
    AddSC_boss_witherbark();
    AddSC_boss_xeritac();
    AddSC_boss_yalnu();
    AddSC_the_everbloom();
    AddSC_instance_everbloom();

    // Shadowmoon Burial Grounds
    AddSC_bonemaw();
    AddSC_nerzul();
    AddSC_nhalish();
    AddSC_sadana();
    AddSC_shadowmoon_burial_grounds();
    AddSC_instance_shadowmoon_burial_grounds();

    // Highmaul
    AddSC_boss_twin_ogron();
    AddSC_boss_the_butcher();
    AddSC_boss_koragh();
    AddSC_boss_kargath_bladefist();
    AddSC_boss_imperator_margok();
    AddSC_boss_brackenspore();
    AddSC_boss_tectus();
    AddSC_highmaul();
    AddSC_instance_highmaul();
}
