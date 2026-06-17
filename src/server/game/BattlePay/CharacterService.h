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

#ifndef DESTINYCORE_CHARSERVICE_H
#define DESTINYCORE_CHARSERVICE_H

#include "Define.h"
#include "ObjectGuid.h"

class WorldSession;

class CharacterService
{
public:
    static CharacterService* instance();

    void BoostCharacter(WorldSession* session, ObjectGuid targetCharGuid, uint8 targetLevel,
        uint16 overrideMapId = 0, uint16 overrideZoneId = 0,
        float overrideX = 0.0f, float overrideY = 0.0f, float overrideZ = 0.0f, float overrideO = 0.0f,
        bool isClassTrial = false, uint16 specId = 0);
};

#define sCharacterService CharacterService::instance()

#endif
