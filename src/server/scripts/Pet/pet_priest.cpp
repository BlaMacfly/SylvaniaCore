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

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_pri_".
 */

#include "ScriptMgr.h"
#include "PassiveAI.h"
#include "PetAI.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "SpellMgr.h"

enum PriestSpells
{
    SPELL_PRIEST_GLYPH_OF_SHADOWFIEND       = 58228,
    SPELL_PRIEST_SHADOWFIEND_DEATH          = 57989,
    SPELL_PRIEST_LIGHTWELL_CHARGES          = 59907
};

class npc_pet_pri_lightwell : public CreatureScript
{
    public:
        npc_pet_pri_lightwell() : CreatureScript("npc_pet_pri_lightwell") { }

        struct npc_pet_pri_lightwellAI : public PassiveAI
        {
            npc_pet_pri_lightwellAI(Creature* creature) : PassiveAI(creature)
            {
                DoCast(me, SPELL_PRIEST_LIGHTWELL_CHARGES, false);
            }

            void EnterEvadeMode(EvadeReason /*why*/) override
            {
                if (!me->IsAlive())
                    return;

                me->DeleteThreatList();
                me->CombatStop(true);
                me->ResetPlayerDamageReq();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_pet_pri_lightwellAI(creature);
        }
};

//npcs: Mindbender 62982    Shadowfiend 19668
//spells: 123040 Mindbender / 34433 Shadowfiend
struct npc_pet_pri_shadowfiend_mindbender : public ScriptedAI
{
    explicit npc_pet_pri_shadowfiend_mindbender(Creature* creature)
        : ScriptedAI(creature)
    {
        if (Unit* owner = me->GetOwner())
        {
            if (owner->HasAura(SpellIds::PriestAtonement))
                me->AddAura(SpellIds::PriestAtonementPet, me);
        }
    }

    struct SpellIds
    {
        static constexpr uint32 ManaLeech = 123051;
        static constexpr uint32 PriestGlyphShadowfiend = 58228;
        static constexpr uint32 PriestShadowfiendDeath = 57989;
        static constexpr uint32 PriestLightwellCharges = 59907;
        static constexpr uint32 MindbenderSpell = 123040;
        static constexpr uint32 PowerInfusionSpell = 200174;
        static constexpr uint32 PriestAtonement = 81749;
        static constexpr uint32 PriestAtonementPet = 195178;
    };

    void Reset() override
    {
        if (auto* tempSum = me->ToTempSummon())
        {
            if (auto* owner = tempSum->GetOwner())
            {
                if (auto* player = owner->ToPlayer())
                {
                    if (auto* victim = player->GetSelectedUnit())
                        AttackStart(victim);
                }
            }
        }
    }

    void IsSummonedBy(Unit* summoner) override
    {
        if (me->GetEntry() == 19668 && summoner->HasAura(SpellIds::PriestGlyphShadowfiend))
            DoCastAOE(SpellIds::PriestShadowfiendDeath);
    }

    void DamageDealt(Unit* /*victim*/, uint32& /*damage*/, DamageEffectType /*damageType*/) override
    {
        auto* tempSum = me->ToTempSummon();
        if (!tempSum)
            return;

        Unit* owner = tempSum->GetOwner();
        if (!owner)
            return;

        if (owner->HasSpell(SpellIds::MindbenderSpell))
        {
            tempSum->CastSpell(owner, SpellIds::ManaLeech, true);
            return;
        }

        if (owner->HasSpell(SpellIds::PowerInfusionSpell))
        {
            if (const SpellInfo* spellInfo = sSpellMgr->GetSpellInfo(SpellIds::PowerInfusionSpell))
            {
                int32 plusPower = spellInfo->GetEffect(EFFECT_2)->BasePoints * 100;
                tempSum->EnergizeBySpell(owner, SpellIds::PowerInfusionSpell, plusPower, Powers::POWER_INSANITY);
            }
        }
    }
};

enum PsyfiendSpells
{
    SPELL_PSYFIEND_BASE  = 211522,
    SPELL_PSYFLAY_DAMAGE = 199845
};

// 101398 - Psyfiend
// 7.3.5
class npc_pri_psyfiend : public CreatureScript
{
public:
    npc_pri_psyfiend() : CreatureScript("npc_pri_psyfiend") { }

    struct npc_pri_psyfiend_voidAI : public ScriptedAI
    {
        npc_pri_psyfiend_voidAI(Creature* creature) : ScriptedAI(creature) { }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            canCast = true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (canSetHealth)
            {
                me->SetMaxHealth(sSpellMgr->GetSpellInfo(SPELL_PSYFIEND_BASE)->GetEffect(EFFECT_0)->BasePoints);
                canSetHealth = false;
            }

            if (canCast)
                if (me->GetOwner() && me->GetOwner()->ToPlayer())
                {
                    if (Unit* unit = me->GetOwner()->ToPlayer()->GetSelectedUnit())
                        if (unit->IsPlayer())
                        {
                            me->CastCustomSpell(SPELL_PSYFLAY_DAMAGE, SPELLVALUE_BASE_POINT0, unit->CountPctFromMaxHealth(sSpellMgr->GetSpellInfo(SPELL_PSYFLAY_DAMAGE)->GetEffect(EFFECT_0)->BasePoints), me, TRIGGERED_FULL_MASK);
                            canCast = false;
                        }
                }
        }

    private:
        bool canSetHealth = true;
        bool canCast = true;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pri_psyfiend_voidAI(creature);
    }
};

void AddSC_priest_pet_scripts()
{
    new npc_pet_pri_lightwell();
    RegisterCreatureAI(npc_pet_pri_shadowfiend_mindbender);
    new npc_pri_psyfiend();
}
