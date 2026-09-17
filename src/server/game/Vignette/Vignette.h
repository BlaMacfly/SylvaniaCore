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

// Les vignettes sont les marqueurs que le serveur pose sur la minicarte du joueur
// pour lui signaler un rare ou un tresor. Sans elles, les modules du genre
// RareScanner n'ont rien a ecouter. Porte de notre amont DestinyCore, ou le systeme
// existe deja pour cette version du client.

#ifndef VIGNETTE_H
#define VIGNETTE_H

#include "Common.h"
#include "DB2Stores.h"
#include "Object.h"

namespace Vignette
{
enum class Type : uint8
{
    SourceCreature,     // vignette liee a une creature visible
    SourceGameObject,   // vignette liee a un objet du monde
    SourceRare,         // creature rare
    SourceTreasure,     // tresor
    SourceScript        // posee par un script : jamais retiree automatiquement
};

class Entity
{
    friend class Manager;

public:
    void UpdatePosition(Position newPosition);
    void ResetNeedClientUpdate();
    ObjectGuid GetGuid() const;
    ObjectGuid GetSourceGuid() const;
    Type GetVignetteType() const;
    bool NeedClientUpdate() const;
    Position const& GetPosition() const;
    uint32 GetZoneID() const;
    VignetteEntry const* GetVignetteEntry() const;

private:
    Entity(VignetteEntry const* vignetteEntry, uint32 mapID);
    ~Entity();

    void Create(Type type, Position const& position, uint32 zoneID, ObjectGuid sourceGuid, ObjectGuid::LowType lowGuid);

    VignetteEntry const* _vignetteEntry;
    ObjectGuid _guid;
    ObjectGuid _sourceGuid;
    Position _position;
    uint32 _map;
    uint32 _zoneID;
    Type _type;

protected:
    bool _needClientUpdate;
};

}
#endif
