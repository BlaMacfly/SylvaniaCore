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

#ifndef VIGNETTE_MGR_H
#define VIGNETTE_MGR_H

#include "Vignette.h"
#include <functional>

class WorldObject;
class Player;

namespace Vignette
{
// Un gestionnaire par joueur : les marqueurs sont personnels, ils suivent ce que
// ce joueur voit. Les ajouts et retraits sont accumules puis envoyes en un paquet.
class Manager
{
public:
    explicit Manager(Player const* player);
    ~Manager();

    Entity* CreateAndAddVignette(VignetteEntry const* vignetteEntry, uint32 mapID, Type vignetteType, Position position, uint32 zoneID, ObjectGuid sourceGuid = ObjectGuid::Empty);
    void DestroyAndRemoveVignetteByEntry(VignetteEntry const* vignetteEntry);
    void DestroyAndRemoveVignettes(std::function<bool(Entity*)> const& lambda);

    void Update();

    template<class T>
    void OnWorldObjectAppear(T const* target);

    template<class T>
    void OnWorldObjectDisappear(T const* target);

    bool CanSeeVignette(WorldObject const* obj, uint32 vignetteID) const;

private:
    void ForgetVignette(ObjectGuid const& guid);
    void SendVignetteUpdateToClient();

    Player const* _owner;

    std::map<ObjectGuid, Entity*> _vignettes;
    std::set<ObjectGuid> _removedVignette;
    std::set<ObjectGuid> _addedVignette;
    std::set<ObjectGuid> _updatedVignette;
};

}

#endif
