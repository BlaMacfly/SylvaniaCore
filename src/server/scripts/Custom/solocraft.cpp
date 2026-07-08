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

#include <map>
#include "Config.h"
#include "Chat.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "Group.h"
#include "InstanceScript.h"

namespace {

    class solocraft_player_instance_handler : public PlayerScript {

    public:

        solocraft_player_instance_handler() : PlayerScript("solocraft_player_instance_handler")
        {
            TC_LOG_INFO("scripts.solocraft.player.instance", "[Solocraft] solocraft_player_instance_handler Loaded");
        }

        void OnMapChanged(Player* player) override
        {
            TC_LOG_INFO("server.worldserver", "[SoloDBG] OnMapChanged player=%s mapId=%u maxHP=%u", player->GetName().c_str(), player->GetMapId(), (uint32)player->GetMaxHealth());
            if (sConfigMgr->GetBoolDefault("Solocraft.Enable", false))
            {
                Map* map = player->GetMap();
                float difficulty = CalculateDifficulty(map, player);
                int numInGroup = GetNumInGroup(player);
                ApplyBuffs(player, map, difficulty, numInGroup);
            }
        }

        void OnLogout(Player* player) override
        {
            // Les modificateurs de stats (TOTAL_PCT) sont remis a 1.0 a chaque login,
            // mais _unitDifficulty (statique) survivait a la deconnexion. Un ClearBuffs
            // ulterieur retrouvait alors une entree fantome et DIVISAIT des stats jamais
            // buffees (perso niveau 1 rabaisse a 20% de ses stats -> 28 PV, cf. bug Selena).
            _unitDifficulty.erase(player->GetGUID());
        }

    private:
        std::map<uint64, float> _unitDifficulty;

        // Set the instance difficulty
        float CalculateDifficulty(Map* map, Player* player)
        {
            // Valeurs lues a CHAQUE changement de carte (evenement peu frequent) plutot qu'une seule fois
            // au boot -> 'reload config' (tmux: reload config) suffit desormais pour tuner, sans restart.
            const float D5  = sConfigMgr->GetFloatDefault("Solocraft.Dungeon", 5.0f);
            const float D5H = sConfigMgr->GetFloatDefault("Solocraft.Heroic", 10.0f);
            const float D10 = sConfigMgr->GetFloatDefault("Solocraft.Raid10", 10.0f);
            const float D25 = sConfigMgr->GetFloatDefault("Solocraft.Raid25", 25.0f);
            const float D30 = sConfigMgr->GetFloatDefault("Solocraft.Raid30", 30.0f);
            const float D40 = sConfigMgr->GetFloatDefault("Solocraft.Raid40", 40.0f);
            float difficulty = 1.0;
            if (map)
            {
                // Pas de Solocraft en Mythique / Mythique+ : Map::IsMythic() couvre le donjon Mythique (23),
                // la clef Mythique+ (DIFFICULTY_MYTHIC_KEYSTONE 8) et le raid Mythique. Contenu reserve au groupe.
                // On retourne 0 (aucun buff) ; ApplyBuffs/ClearBuffs retirera tout buff Solocraft anterieur.
                if (map->IsMythic())
                    return 0.0f;

                if (map->IsRaid())
                {
                    switch (map->GetMapDifficulty()->MaxPlayers)
                    {
                    case 10:
                        difficulty = D10; break;
                    case 25:
                        difficulty = D25; break;
                    case 30:
                        difficulty = D30; break;
                    case 40:
                        difficulty = D40; break;
                    default:
                        TC_LOG_WARN("scripts.solocraft.player.instance", "[SoloCraft] Unrecognized max players %d, defaulting to 10 man difficulty",
                            map->GetMapDifficulty()->MaxPlayers);
                        difficulty = D10;
                    }
                }
                else if (map->IsDungeon())
                {
                    if (map->IsHeroic())
                        difficulty = D5H;
                    else
                        difficulty = D5;
                }
            }
            return difficulty - 1.0; // HandleStatModifier treats 100 as +100%, so a difficulty of 1 ends up being applied as a 200% buff
        }

        // Get the groups size
        int GetNumInGroup(Player* player)
        {
            int numInGroup = 1;
            Group* group = player->GetGroup();
            if (group)
            {
                Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
                numInGroup = groupMembers.size();
            }
            return numInGroup;
        }

        // Apply the player buffs
        void ApplyBuffs(Player* player, Map* map, float difficulty, int numInGroup)
        {
            ClearBuffs(player, map);

            if (difficulty != 0)
            {
                // InstanceMap *instanceMap = map->ToInstanceMap();
                // InstanceScript *instanceScript = instanceMap->GetInstanceScript();

                // Announce to player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered %s - # of Players: %d - Difficulty Offset: %0.2f.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), numInGroup, difficulty + 1.0);

                // Adjust player stats
                _unitDifficulty[player->GetGUID()] = difficulty;
                TC_LOG_INFO("server.worldserver", "[SoloDBG] ApplyBuffs player=%s diff=%.2f stamPctBefore=%.3f maxHPbefore=%u", player->GetName().c_str(), difficulty, player->GetModifierValue(UNIT_MOD_STAT_STAMINA, TOTAL_PCT), (uint32)player->GetMaxHealth());
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                {
                    // Buff the player
                    player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, difficulty * 100.0, true);
                }
                TC_LOG_INFO("server.worldserver", "[SoloDBG] ApplyBuffs DONE player=%s stamPctAfter=%.3f maxHPafter=%u", player->GetName().c_str(), player->GetModifierValue(UNIT_MOD_STAT_STAMINA, TOTAL_PCT), (uint32)player->GetMaxHealth());

                // Set player health
                player->SetFullHealth();
                if (player->GetPowerType() == POWER_MANA)
                {
                    // Buff the player's health
                    player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
                }
            }
        }

        void ClearBuffs(Player* player, Map* map)
        {
            std::map<uint64, float>::iterator unitDifficultyIterator = _unitDifficulty.find(player->GetGUID());
            TC_LOG_INFO("server.worldserver", "[SoloDBG] ClearBuffs player=%s found=%d stamPct=%.3f maxHP=%u", player->GetName().c_str(), unitDifficultyIterator != _unitDifficulty.end() ? 1 : 0, player->GetModifierValue(UNIT_MOD_STAT_STAMINA, TOTAL_PCT), (uint32)player->GetMaxHealth());
            if (unitDifficultyIterator != _unitDifficulty.end())
            {
                float difficulty = unitDifficultyIterator->second;
                _unitDifficulty.erase(unitDifficultyIterator);

                // Inform the player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " exited to %s - Reverting Difficulty Offset: %0.2f.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty + 1.0);

                // Clear the buffs
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                {
                    player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, difficulty * 100.0, false);
                }
            }
        }
    };
}

void AddSC_solocraft()
{
    new solocraft_player_instance_handler();
}
