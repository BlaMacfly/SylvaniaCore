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

// This is where scripts' loading functions should be declared:void AddSC_();

void AddSC_brawlers_guild();
void AddSC_brawlers_guild_bosses_rank_one();
void AddSC_brawlers_guild_bosses_rank_two();
void AddSC_brawlers_guild_bosses_rank_three();
void AddSC_brawlers_guild_bosses_rank_four();
void AddSC_brawlers_guild_bosses_rank_five();
void AddSC_brawlers_guild_bosses_rank_six();

// The name of this function should match: AddSC_();
// void Add${NameOfDirectory}Scripts() 
void AddBrawlersGuildScripts()
{    
     AddSC_brawlers_guild();
     AddSC_brawlers_guild_bosses_rank_one();
     AddSC_brawlers_guild_bosses_rank_two();
     AddSC_brawlers_guild_bosses_rank_three();
     AddSC_brawlers_guild_bosses_rank_four();
     AddSC_brawlers_guild_bosses_rank_five();
     AddSC_brawlers_guild_bosses_rank_six();
}
