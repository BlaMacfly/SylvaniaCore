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

#include "ClassHall.h"
#include "GarrisonAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Config.h"
#include "GameObject.h"

struct class_hall_legion : public GarrisonAI
{
    class_hall_legion(Garrison* gar) : GarrisonAI(gar) { }

    void OnPlayerEnter(Player* player) override
    {
        
        {
            player->CheckClassHallAllowArea();
            player->CastSpell(player, 213170, true);
            CheckGrandChallengersBounty(player);
        }          
    }

    void OnPlayerLeave(Player* player) override
    {
        player->RemoveAurasDueToSpell(213170);
    }

    void CheckGrandChallengersBounty(Player* player)
    {
        if (GameObject* bounty = player->FindNearestGameObjectOfType(GAMEOBJECT_TYPE_CHALLENGE_MODE_REWARD, 500.0f))
        {
           // bounty->SetGoState(GO_STATE_ACTIVE);//GO_STATE_ACTIVE  GO_STATE_ACTIVE_ALTERNATIVE GO_STATE_READY
           // printf("FindNearestGameObjectOfType\n");
        }
    }
};

void AddSC_class_hall_legion()
{
    RegisterGarrisonAI(class_hall_legion);
};
