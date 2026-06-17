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

#ifndef SCHOLOMANCE_H
#define SCHOLOMANCE_H

#define MAX_ENCOUNTER 5

enum Data
{
    DATA_INSTRUCTOR_CHILLHEART,
    DATA_JANDICE_BAROV,
    DATA_RATTLEGORE,
    DATA_LILLIAN_VOSS,
    DATA_GANDLING,

    DATA_PHYLACTERY,
    DATA_LILLIAN_VOSS_SOUL,

    DATA_COFFER_OF_FORGOTTEN_SOULS,
    DATA_COFFER_OF_FORGOTTEN_SOULS_HEROIC,

    DATA_RATTLEGORE_EVENT,
    DATA_LILIAN_ENTRANCE,

    DATA_GANDLING_EVENT,
};

enum Creatures
{
    NPC_INSTRUCTOR_CHILLHEART = 58633,
    NPC_JANDICE_BAROV = 59184,
    NPC_RATTLEGORE = 59153,
    NPC_LILLIAN_VOSS = 58722,
    NPC_DARKMASTER_GANDLING = 59080,

    NPC_PHYLACTERY = 58664,

    NPC_LILLIAN_VOSS_SOUL = 58791,

    NPC_DARKMASTER_GANDLING_1 = 58875, // event npc

    NPC_TALKING_SKULL = 64562, // 126155 aura visual
    NPC_TALKING_SKULL_END = 64563, // 126155 aura visual

    NPC_DOCTOR_THEOLEN_KRASTINOV = 59369, // spawns on heroic after rattlegore's death, 5-10% chance
};

enum GameObjects
{
    GO_COFFER_OF_FORGOTTEN_SOULS = 211277,
    GO_COFFER_OF_FORGOTTEN_SOULS_H = 211278,

    ChallengeDoor = 211989
};

enum eScenarioDatas
{
    ScenarioID = 51,
    /// Bosses datas
    Chillheart = 19259,
    Barov = 19260,
    RattleGore = 19261,
    LilianVoss = 19262,
    Gandling = 19263,
    Ennemies = 20030,
    KillCount = 35
};

#define DOCTOR_THEOLEN_KRASTINOV_CHANCE 8

const Position krastinovPos = { 205.28f, 151.01f, 113.32f, 0.03f };

#endif
