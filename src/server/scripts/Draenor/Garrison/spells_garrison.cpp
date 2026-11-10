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

#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellScript.h"
#include "WodGarrison.h"

// 171253 - Garrison hearthstone
class spell_garrison_hearthstone : public SpellScript
{
    PrepareSpellScript(spell_garrison_hearthstone);

    SpellCastResult CheckCast()
    {
        if (Player* caster = GetCaster()->ToPlayer())
            if (Garrison* garr = caster->GetGarrison(GARRISON_TYPE_GARRISON))
                if (garr->GetSiteLevel())
                    return SPELL_CAST_OK;

        return SPELL_FAILED_GARRISON_NOT_OWNED;
    }

    void SetDest(SpellDestination& dest)
    {
        if (Player* caster = GetCaster()->ToPlayer())
        {
            if (Garrison* garr = caster->GetGarrison(GARRISON_TYPE_GARRISON))
            {
                if (GarrSiteLevelEntry const* siteLevel = garr->GetSiteLevel())
                {
                    // Adjust effect summon position
                    Position const garrPos = GarrisonHearthstoneCoordinates[caster->GetTeamId()][siteLevel->GarrLevel - 1];
                    dest.Relocate(WorldLocation(siteLevel->MapID, garrPos));
                }
            }
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_garrison_hearthstone::CheckCast);
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_garrison_hearthstone::SetDest, EFFECT_0, TARGET_DEST_DB);
    }
};

// 173847 - Loot (garrison cache), forced by 178479 (gameobjects 237191/236916/237720/237722/237723/237724)
class spell_garrison_cache_loot : public SpellScript
{
    PrepareSpellScript(spell_garrison_cache_loot);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Player* player = GetHitUnit() ? GetHitUnit()->ToPlayer() : nullptr;
        if (!player)
            return;

        Garrison* garrison = player->GetGarrison(GARRISON_TYPE_GARRISON);
        if (!garrison)
            return;

        uint32 amount = garrison->GetCacheResourceCount();
        if (!amount)
            return;

        player->ModifyCurrency(GARRISON_WOD_CURRENCY, int32(amount));
        player->SendDisplayToast(GARRISON_WOD_CURRENCY, 0, amount, DISPLAY_TOAST_METHOD_GARRISON_CACHE, TOAST_TYPE_CURRENCY, false, false);
        garrison->CollectCache();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_garrison_cache_loot::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 189189 - Improved Logistics, 189205 - Trade Agreement: Arakkoa Outcasts
class spell_garrison_cache_size : public SpellScript
{
    PrepareSpellScript(spell_garrison_cache_size);

    void HandleCacheSize(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetHitUnit() ? GetHitUnit()->ToPlayer() : nullptr)
            if (Garrison* garrison = player->GetGarrison(GARRISON_TYPE_GARRISON))
                garrison->SetCacheMaxSize(uint32(GetEffectValue()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_garrison_cache_size::HandleCacheSize, EFFECT_ALL, SPELL_EFFECT_SET_GARRISON_CACHE_SIZE);
    }
};

void AddSC_spells_garrison()
{
    RegisterSpellScript(spell_garrison_hearthstone);
    RegisterSpellScript(spell_garrison_cache_loot);
    RegisterSpellScript(spell_garrison_cache_size);
}
