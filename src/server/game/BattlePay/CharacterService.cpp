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

#include "CharacterService.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSession.h"

CharacterService* CharacterService::instance()
{
    static CharacterService instance;
    return &instance;
}

void CharacterService::BoostCharacter(WorldSession* /*session*/, ObjectGuid targetCharGuid, uint8 targetLevel,
    uint16 overrideMapId, uint16 overrideZoneId,
    float overrideX, float overrideY, float overrideZ, float overrideO,
    bool isClassTrial, uint16 specId)
{
    CharacterInfo const* charInfo = sWorld->GetCharacterInfo(targetCharGuid);
    if (!charInfo)
        return;

    uint64 charLowGuid = targetCharGuid.GetCounter();
    uint8 charRace = charInfo->Race;
    bool isAlliance = ((1 << (charRace - 1)) & RACEMASK_ALLIANCE) != 0;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_LEVEL);
    stmt->setUInt8(0, targetLevel);
    stmt->setUInt64(1, charLowGuid);
    trans->Append(stmt);

    float x = 0.0f, y = 0.0f, z = 0.0f, o = 0.0f;
    uint16 mapId = 0, zoneId = 0;

    if (overrideMapId != 0)
    {
        mapId = overrideMapId;
        zoneId = overrideZoneId;
        x = overrideX;
        y = overrideY;
        z = overrideZ;
        o = overrideO;
    }
    else if (targetLevel <= 90)
    {
        mapId = 0;
        zoneId = 4709;
        x = -11840.0f;
        y = -3207.0f;
        z = -29.0f;
    }
    else if (targetLevel == 100)
    {
        if (isAlliance)
        {
            mapId = 0;
            zoneId = 1519;
            x = -8833.0f;
            y = 628.0f;
            z = 94.0f;
        }
        else
        {
            mapId = 1;
            zoneId = 1637;
            x = 1569.0f;
            y = -4397.0f;
            z = 16.0f;
        }
    }
    else
    {
        mapId = 1220;
        zoneId = 7502;
        x = -831.0f;
        y = 4374.0f;
        z = 738.0f;
    }

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHARACTER_POSITION);
    stmt->setFloat(0, x);
    stmt->setFloat(1, y);
    stmt->setFloat(2, z);
    stmt->setFloat(3, o);
    stmt->setUInt16(4, mapId);
    stmt->setUInt16(5, zoneId);
    stmt->setUInt64(6, charLowGuid);
    trans->Append(stmt);

    uint32 const flyingSpells[] = { 34091, 54197, 90267, 115913 };
    for (uint32 spellId : flyingSpells)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SPELL);
        stmt->setUInt64(0, charLowGuid);
        stmt->setUInt32(1, spellId);
        stmt->setUInt8(2, 1);
        stmt->setUInt8(3, 0);
        trans->Append(stmt);
    }

    if (targetLevel >= 110)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CHAR_SPELL);
        stmt->setUInt64(0, charLowGuid);
        stmt->setUInt32(1, 191645);
        stmt->setUInt8(2, 1);
        stmt->setUInt8(3, 0);
        trans->Append(stmt);
    }

    if (isClassTrial)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmt->setUInt16(0, uint16(AT_LOGIN_CLASS_TRIAL));
        stmt->setUInt64(1, charLowGuid);
        trans->Append(stmt);

        if (specId)
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_SPECIALIZATION);
            stmt->setUInt16(0, specId);
            stmt->setUInt64(1, charLowGuid);
            trans->Append(stmt);
        }

        trans->PAppend("UPDATE characters SET cinematic = 1 WHERE guid = " UI64FMTD, charLowGuid);
    }
    else
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REM_AT_LOGIN_FLAG);
        stmt->setUInt16(0, uint16(AT_LOGIN_CLASS_TRIAL | AT_LOGIN_CLASS_TRIAL_LOCKED));
        stmt->setUInt64(1, charLowGuid);
        trans->Append(stmt);
    }

    CharacterDatabase.CommitTransaction(trans);
    sWorld->UpdateCharacterInfoLevel(targetCharGuid, targetLevel);

    TC_LOG_INFO("server.battlepay", "BoostCharacter: character %s (%u) boosted to level %u%s",
        charInfo->Name.c_str(), uint32(charLowGuid), targetLevel, isClassTrial ? " as class trial" : "");
}
