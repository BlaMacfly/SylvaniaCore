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

enum DataTypes
{
    DATA_JINROKH,
    DATA_HORRIDON,
    DATA_COUNCIL_OF_ELDERS,
    DATA_TORTOS,
    DATA_MEGAERA,
    DATA_JI_KUN,
    DATA_DURUMU_THE_FORGOTTEN,
    DATA_PRIMORDIUS,
    DATA_DARK_ANIMUS,
    DATA_IRON_QON,
    DATA_TWIN_CONSORTS,
    DATA_LEI_SHEN,
    DATA_RA_DEN,
    MAX_DATA
};

enum CreaturesIds
{
    BOSS_COUNCIL_SUL_THE_SANDCRAWLER = 69078,
    BOSS_COUNCIL_FROST_KING_MALAKK = 69131,
    BOSS_COUNCIL_HIGH_PRIESTESS_MARLI = 69132,
    BOSS_COUNCIL_KAZRAJIN = 69134,
    BOSS_DARK_ANIMUS = 69427,
    MOB_GARA_JAL = 69135,
    MOB_GARA_JALS_SOUL = 69182,

    NPC_TWISTED_FATE_HELPER = 662204,
    NPC_AREATRIGGER_ANIMA = 999288,
};

class notPlayerPredicate
{
public:
    bool operator()(WorldObject* target) const
    {
        return target && (target->GetTypeId() != TYPEID_PLAYER || target->ToPlayer() && target->ToPlayer()->IsGameMaster());
    }
};
