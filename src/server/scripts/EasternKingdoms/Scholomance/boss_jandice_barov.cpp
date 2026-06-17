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

#include "ScriptPCH.h"
#include "scholomance.h"
#include "AreaTrigger.h"

enum ScriptedTexts
{
    SAY_AGGRO = 0,
    SAY_DEATH = 1,
    SAY_KILL = 2,
    SAY_WIPE = 3,
    SAY_SPELL_1 = 4,
    SAY_SPELL_2 = 5,
};

enum Spells
{
    SPELL_GRAVITY_FLUX = 114059,
    SPELL_GRAVITY_FLUX_AREA = 114035,
    SPELL_GRAVITY_FLUX_DMG = 114038,

    SPELL_DISSIPATE = 113819,

    SPELL_WHIRL_OF_ILLUSION = 113808, // first spell, hide
    SPELL_WHIRL_OF_ILLUSION_1 = 114048, // casted only by boss (visual/whirl)
    SPELL_WHIRL_OF_ILLUSION_DMG = 113775,
    SPELL_WHIRL_OF_ILLUSION_2 = 113730, // illusions without dmg
    SPELL_WHIRL_OF_ILLUSION_3 = 113774,
    SPELL_WHIRL_OF_ILLUSION_4 = 115130,
    SPELL_WHIRL_OF_ILLUSION_DUMMY = 113737,

    SPELL_WONDROUS_RAPIDITY = 114062,
    SPELL_WONDROUS_RAPIDITY_DMG = 114061,

    SPELL_FLASH_BANG = 113866,
};

enum Events
{
    EVENT_GRAVITY_FLUX = 1,
    EVENT_WONDROUS_RAPIDITY,
    EVENT_WHIRL_OF_ILLUSION,
    EVENT_WHIRL_OF_ILLUSION_1,
};

enum Adds
{
    NPC_JANDICE_BAROV_ILLUSION = 59220,
};

Position const IllusionPos[9] =
{
    { 300.248f, 46.374f, 113.409f, 0.0f },
    { 299.957f, 31.166f, 113.409f, 0.0f },
    { 299.764f, 21.024f, 113.409f, 0.0f },
    { 280.708f, 31.672f, 113.408f, 0.0f },
    { 281.195f, 21.988f, 113.408f, 0.0f },
    { 262.164f, 32.343f, 113.409f, 0.0f },
    { 261.658f, 21.720f, 113.409f, 0.0f },
    { 262.375f, 46.644f, 113.409f, 0.0f },
    { 282.495f, 45.559f, 113.408f, 0.0f },
};

Position const IllusionHeroPos[15] =
{
    { 300.248f, 46.374f, 113.409f, 0.f },
    { 299.957f, 31.166f, 113.409f, 0.f },
    { 299.764f, 21.024f, 113.409f, 0.f },
    { 280.708f, 31.672f, 113.408f, 0.f },
    { 281.195f, 21.988f, 113.408f, 0.f },
    { 262.164f, 32.343f, 113.409f, 0.f },
    { 261.658f, 21.720f, 113.409f, 0.f },
    { 262.375f, 46.644f, 113.409f, 0.f },
    { 282.495f, 45.559f, 113.408f, 0.f },
    { 271.660f, 21.244f, 113.408f, 0.f },
    { 271.631f, 31.055f, 113.408f, 0.f },
    { 272.426f, 46.041f, 113.408f, 0.f },
    { 291.272f, 46.044f, 113.408f, 0.f },
    { 290.763f, 31.190f, 113.408f, 0.f },
    { 290.394f, 21.659f, 113.408f, 0.f },
};

class boss_jandice_barov : public CreatureScript
{
public:
    boss_jandice_barov() : CreatureScript("boss_jandice_barov") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_jandice_barovAI(creature);
    }

    struct boss_jandice_barovAI : public BossAI
    {
        boss_jandice_barovAI(Creature* creature) : BossAI(creature, DATA_JANDICE_BAROV)
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CONFUSE, true);

            me->setActive(true);

            phase = 0;
        }

        void Reset()
        {
            _Reset();

            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag(UNIT_FIELD_FLAGS,
                UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);

            phase = 0;

            SetEquipmentSlots(false, 13000, 0, 0);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_GRAVITY_FLUX, urand(10000, 12000));
            events.ScheduleEvent(EVENT_WONDROUS_RAPIDITY, 6000);

            DoZoneInCombat();
            if (instance)
                instance->SetBossState(DATA_JANDICE_BAROV, IN_PROGRESS);
        }

        void JustSummoned(Creature* summon)
        {
            BossAI::JustSummoned(summon);

            if (summon->GetEntry() == NPC_JANDICE_BAROV_ILLUSION)
            {
                summon->SetMaxHealth(me->GetMaxHealth());
                summon->SetHealth(me->GetHealth());
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage)
        {
            // Phase change 1 (67)
            if (me->GetHealthPct() <= 67.0f && phase == 0)
            {
                damage = 0;
                phase = 1;

                Talk(SAY_SPELL_1);

                PreIllusion();

                events.CancelEvent(EVENT_GRAVITY_FLUX);
                events.CancelEvent(EVENT_WONDROUS_RAPIDITY);
                events.ScheduleEvent(EVENT_WHIRL_OF_ILLUSION, 1000);
                return;
            }

            // Phase change 2 (34)
            if (me->GetHealthPct() <= 34.0f && phase == 2)
            {
                damage = 0;
                phase = 3;

                Talk(SAY_SPELL_2);

                PreIllusion();

                events.CancelEvent(EVENT_GRAVITY_FLUX);
                events.CancelEvent(EVENT_WONDROUS_RAPIDITY);
                events.ScheduleEvent(EVENT_WHIRL_OF_ILLUSION, 1000);
                return;
            }

            // Take no real damage during illusion phase but return from illusion phase after being hit
            if (phase == 1 || phase == 3)
            {
                if (damage > 0)
                {
                    phase++;

                    summons.DespawnAll();
                    me->RemoveAura(SPELL_WHIRL_OF_ILLUSION_1);

                    me->SetReactState(REACT_AGGRESSIVE);
                    if (Unit* victim = me->GetVictim())
                        AttackStart(victim);

                    events.ScheduleEvent(EVENT_WONDROUS_RAPIDITY, 6000);
                    events.ScheduleEvent(EVENT_GRAVITY_FLUX, 12000);
                }
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            _JustDied();
        }

        void JustReachedHome()
        {
            Talk(SAY_WIPE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
        }

        void UpdateAI(uint32 const diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_GRAVITY_FLUX:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        DoCast(target, SPELL_GRAVITY_FLUX);
                    events.ScheduleEvent(EVENT_GRAVITY_FLUX, 12000);
                    break;
                case EVENT_WONDROUS_RAPIDITY:
                    DoCastVictim(SPELL_WONDROUS_RAPIDITY);
                    events.ScheduleEvent(EVENT_WONDROUS_RAPIDITY, 20000);
                    break;
                case EVENT_WHIRL_OF_ILLUSION:
                {
                    Position pos = SummonIllusions();
                    me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation());

                    events.ScheduleEvent(EVENT_WHIRL_OF_ILLUSION_1, 1000);
                    break;
                }
                case EVENT_WHIRL_OF_ILLUSION_1:
                    me->RemoveAura(SPELL_WHIRL_OF_ILLUSION);
                    me->RemoveFlag(UNIT_FIELD_FLAGS,
                        UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
                    DoCast(me, SPELL_WHIRL_OF_ILLUSION_1); // explicitly only to oneself
                    break;
                default:
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint8 phase;

        void PreIllusion()
        {
            me->RemoveAllAuras();
            me->InterruptNonMeleeSpells(false);
            me->AttackStop();
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS,
                UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
            DoCast(me, SPELL_WHIRL_OF_ILLUSION);
        }

        Position SummonIllusions()
        {
            uint8 randIndex = 0;

            if (IsHeroic())
            {
                randIndex = urand(0, 14);

                for (uint8 i = 0; i < 15; ++i)
                {
                    if (i == randIndex)
                        continue;

                    me->SummonCreature(NPC_JANDICE_BAROV_ILLUSION, IllusionHeroPos[i], TEMPSUMMON_DEAD_DESPAWN, 0);
                }

                return IllusionHeroPos[randIndex];
            }
            else
            {
                randIndex = urand(0, 8);

                for (uint8 i = 0; i < 9; ++i)
                {
                    if (i == randIndex)
                        continue;

                    me->SummonCreature(NPC_JANDICE_BAROV_ILLUSION, IllusionPos[i], TEMPSUMMON_DEAD_DESPAWN, 0);
                }

                return IllusionPos[randIndex];
            }
        }
    };
};

class npc_jandice_barov_illusion : public CreatureScript
{
public:
    npc_jandice_barov_illusion() : CreatureScript("npc_jandice_barov_illusion") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_jandice_barov_illusionAI(creature);
    }

    struct npc_jandice_barov_illusionAI : public Scripted_NoMovementAI
    {
        npc_jandice_barov_illusionAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK_DEST, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_GRIP, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_STUN, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FEAR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_ROOT, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_FREEZE, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_POLYMORPH, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_HORROR, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_SAPPED, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_CHARM, true);
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_DISORIENTED, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_CONFUSE, true);
        }

        void Reset()
        {
            me->SetReactState(REACT_PASSIVE);
            despawn = false;
        }

        void DamageTaken(Unit* /*who*/, uint32& /*damage*/)
        {
            if (!despawn)
            {
                despawn = true;

                if (IsHeroic())
                    DoCastAOE(SPELL_FLASH_BANG, true);

                me->DespawnOrUnsummon(500);
            }
        }

    private:
        bool despawn;
    };
};

// Spell 114048 - Whirl of Illusion
class spell_jandice_barov_whirl_of_illusion : public SpellScriptLoader
{
public:
    spell_jandice_barov_whirl_of_illusion() : SpellScriptLoader("spell_jandice_barov_whirl_of_illusion") {}

    class spell_jandice_barov_whirl_of_illusion_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_jandice_barov_whirl_of_illusion_SpellScript);

        void HandleOnHit()
        {
            Unit* target = GetHitUnit();
            if (!target)
                return;

            if (target->GetEntry() != NPC_JANDICE_BAROV && target->GetEntry() != NPC_JANDICE_BAROV_ILLUSION)
            {
                PreventHitDefaultEffect(EFFECT_0);
                PreventHitDefaultEffect(EFFECT_1);
                PreventHitDefaultEffect(EFFECT_2);

                target->RemoveAurasDueToSpell(GetSpellInfo()->Id);
            }
        }

        void Register() override
        {
            OnHit += SpellHitFn(spell_jandice_barov_whirl_of_illusion_SpellScript::HandleOnHit);
        }
    };

    class spell_jandice_barov_whirl_of_illusion_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_jandice_barov_whirl_of_illusion_AuraScript);

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            Unit* owner = GetUnitOwner();
            if (!owner)
                return;

            if (owner->GetEntry() != NPC_JANDICE_BAROV && owner->GetEntry() != NPC_JANDICE_BAROV_ILLUSION)
            {
                owner->RemoveAurasDueToSpell(GetId());
                return;
            }

            if (owner->GetEntry() == NPC_JANDICE_BAROV_ILLUSION)
            {
                PreventDefaultAction();
                owner->CastSpell(owner, SPELL_WHIRL_OF_ILLUSION_DUMMY, true);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(
                spell_jandice_barov_whirl_of_illusion_AuraScript::HandlePeriodic,
                EFFECT_0,
                SPELL_AURA_PERIODIC_TRIGGER_SPELL
            );
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_jandice_barov_whirl_of_illusion_SpellScript();
    }

    AuraScript* GetAuraScript() const override
    {
        return new spell_jandice_barov_whirl_of_illusion_AuraScript();
    }
};

class spell_area_jandice_barov_gravity_flux : public AreaTriggerScript
{
public:
    spell_area_jandice_barov_gravity_flux() : AreaTriggerScript("spell_area_jandice_barov_gravity_flux") {}

    bool OnTrigger(Player* p_Player, AreaTriggerEntry const* /*p_Trigger*/, bool /*entered*/) override
    {
        if (!p_Player->isTargetableForAttack())
            return false;

        p_Player->CastSpell(p_Player, SPELL_GRAVITY_FLUX_DMG, true);
        return true;
    }
};

void AddSC_boss_jandice_barov()
{
    new boss_jandice_barov();
    new npc_jandice_barov_illusion();

    new spell_jandice_barov_whirl_of_illusion();
    new spell_area_jandice_barov_gravity_flux();
}
