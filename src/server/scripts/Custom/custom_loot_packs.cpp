/*
 * SylvaniaCore : packs d'equipement « loot-driven » (reconstruit 23/07/2026).
 * Des items conteneurs (Baleful/Dauntless etc.) n'ouvraient aucun loot au clic :
 * a l'utilisation, on deverse leur loot template d'item puis on consomme l'objet.
 * Bindings DB : item_script_names (8 ScriptName loot_item_*).
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Item.h"
#include "LootMgr.h"

class loot_item_pack_base : public ItemScript
{
public:
    loot_item_pack_base(char const* name) : ItemScript(name) { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/, ObjectGuid /*castId*/) override
    {
        uint32 entry = item->GetEntry();
        player->AutoStoreLoot(entry, LootTemplates_Item, true);
        player->DestroyItemCount(entry, 1, true);
        return true;
    }
};

#define REGISTER_LOOT_PACK(name) new loot_item_pack_base(#name)

void AddSC_custom_loot_packs()
{
    REGISTER_LOOT_PACK(loot_item_generic_pack);
    REGISTER_LOOT_PACK(loot_item_leggings_of_the_foregone);
    REGISTER_LOOT_PACK(loot_item_gloves_of_the_foregone);
    REGISTER_LOOT_PACK(loot_item_shoulders_of_the_foreseen);
    REGISTER_LOOT_PACK(loot_item_cloak_of_the_foreseen);
    REGISTER_LOOT_PACK(loot_item_chest_of_the_foregone);
    REGISTER_LOOT_PACK(loot_item_unsullied_plate_helmet);
    REGISTER_LOOT_PACK(loot_item_champion_equipment_147432);
}
