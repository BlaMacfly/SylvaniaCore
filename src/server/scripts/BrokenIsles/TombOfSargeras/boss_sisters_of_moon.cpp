/*
* Copyright (C) 2017-2019 AshamaneProject <https://github.com/AshamaneProject>
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

#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "InstanceScript.h"
#include "ObjectAccessor.h"
#include "SpellScript.h"
#include "tomb_of_sargeras.h"


//constant positions about teleports and Kasparian Jumps
Position const LunaspyreTeleports[5] =
{
    {},
    {},
    {},
    {},
    {},
};

Position const CenterCombat[1] =
{
    {},
};

Position const YathaeTeleports[5] =
{
    {},
    {},
    {},
    {},
    {},
};

Position const KasparianJumps[5] =
{
    {},
    {},
    {},
    {},
    {},
};

enum Says
{
    // Sisters
    SAY_SISTERS_AGGRO                               = 1,
    SAY_SISTERS_DEATH                               = 2,
    SAY_SISTERS_EVADE                               = 3,
    SAY_SISTER_KILLS                                = 4,

    // Kasparian
    SAY_KASPARIAN_AGGRO                             = 1,
    SAY_SPELL_GLAIVE                                = 2,
    SAY_KASPARIAN_KILLS                             = 3,
    SAY_KASPARIAN_EVADE                             = 4,
    SAY_KASPARIAN_DIED                              = 5,

    // Yathae
    SAY_YATHAE_AGGRO                                = 6,
    SAY_PHASE_COMBAT                                = 7,
    SAY_SPELLS_ARROW                                = 8,
    SAY_SPELL_AOE                                   = 9,
    SAY_YATHAE_KILLS                                = 10,
    SAY_YATHAE_EVADE                                = 11,
    SAY_YATHAE_DIED                                 = 12,

    // Lunaspyre
    SAY_LUNASPYRE_AGGRO                             = 13,
    SAY_SPELL                                       = 14,
    SAY_FOUNTAIN_OF_ELUNE                           = 15,
    SAY_LUNASPYRE_KILLS                             = 16,
    SAY_LUNASPYRE_EVADE                             = 17,
    SAY_LUNASPYRE_DIED                              = 18
};

enum SistersSpells
{
    // Generic
    SPELL_QUIET_SUICIDE                             = 3617, // Serverside spell
    SPELL_INCORPOREAL_TELEPORT                      = 236115, // Cast
    SPELL_INCORPOREAL_TELEPORT_2                    = 236224, // Not sure if this is the teleport or need script. Instant cast. These two teleport spells are the same for Lunaspyre
    SPELL_COOLDOWN_CREATURE_SPECIAL                 = 61207, // To block other spells from interfering with their special
    SPELL_GHOST_AURA                                = 235268, // Cosmetic for Sisters
    SPELL_ELUNE_FOUNTAIN                            = 236357, // Create AT 11284
    SPELL_LUNAR_SUFFUSION                           = 234995, // Add the aura every 3 seconds on the bright side
    SPELL_UMBRA_SUFFUSION                           = 234996, // Add the aura every 3 seconds on the dark side
    SPELL_ASTRAL_PURGE                              = 234998, // Will trigger on change side in Fountain of Elune, and reset Suffusion marks.

    // Generic Talk
    // Kasparian
    SPELL_KASPARIAN_KILL_CONVERSATION_A             = 243051, // When unactive sister kills a player
    SPELL_KASPARIAN_KILL_CONVERSATION_B             = 243052, // When unactive sister kills a player
    SPELL_KASPARIAN_KILL_CONVERSATION_C             = 243053, // When unactive sister kills a player

    // Yathae
    SPELL_YATHAE_BECOMES_ACTIVE_CONVERSATION        = 243044, // Probably at Start Combat in Active Phase

    // Lunaspyre
    SPELL_LUNASPYRE_BECOMES_ACTIVE_CONVERSATION     = 243047, // Probably at Start Combat in Active Phase
    SPELL_LUNASPYRE_KILL_CONVERSATION_A             = 243059, // When unactive sister kills a player
    SPELL_LUNASPYPE_KILL_CONVERSATION_B             = 243060, // When unactive sister kills a player
    SPELL_LUNASPYRE_KILL_CONVERSATION_C             = 243061, // When unactive sister kills a player

    // Kasparian
    SPELL_TWILIGHT_GLAIVE_AT                        = 236529, // AT 9785 and add aura to bunny + make bunny got target,then return
    SPELL_TWILIGHT_GLAIVE_DAMAGE                    = 236541,
    SPELL_TWILIGHT_GLAIVE_DUMMY                     = 237561,
    SPELL_MOON_GLAIVE                               = 236547,
    SPELL_DISCORPORATE                              = 236550, // Astral Purge will remove it
    SPELL_GLAIVE_STORM                              = 239379, // Only used in Elune's Fountain Phase 3 (normal), phase 2 and 3 heroic and mythic

    // Yathae
    SPELL_SHADOW_SHOT                               = 237630,
    SPELL_INCORPOREAL_SHOT_CAST                     = 236305, // Only used in Elune's Fountain Phase 2 (normal), phase 1 and 3 heroic and mythic
    SPELL_INCORPOREAL_SHOT_DAMAGE                   = 236306,
    SPELL_CALL_MOONTALON                            = 236694,
    SPELL_TWILIGHT_VOLLEY_AT                        = 236442, // AT 9777
    SPELL_TWILIGHT_VOLLEY_DAMAGE                    = 236516, // Apply this aura OnUnitEnter();
    SPELL_RAPID_SHOT                                = 236598,
    SPELL_RAPID_SHOT_AURA                           = 236596,

    // Lunaspyre
    SPELL_EMBRACE_OF_THE_ECLIPSE_HEAL               = 233263, // Shields Heal
    SPELL_EMBRACE_OF_THE_ECLIPSE_BOSS               = 233264, // Shield Boss
    SPELL_LUNAR_BEACON                              = 236712, // OnRemove(); actives Lunar barrage.
    SPELL_LUNAR_FIRE                                = 239264, // Only on current target,active.
    SPELL_LUNAR_STRIKE                              = 237632,
    SPELL_MOON_BURN                                 = 236518, // Astral Purge will remove this.
    SPELL_LUNAR_BARRAGE_AT                          = 236726, // AT 9807
    SPELL_LUNAR_BARRAGE_DAMAGE                      = 237351
};

enum SistersEvents
{
    // General
    EVENT_INCORPOREAL_TELEPORT                      = 1,
    EVENT_TELEPORT_CENTER_COMBAT,
    EVENT_BACK_TO_GHOST,
    EVENT_BERSERKER,

    // Kasparian
    EVENT_TWILIGHT_GLAIVE,
    EVENT_MOON_GLAIVE,
    EVENT_GLAIVE_STORM,
    EVENT_JUMP_TIGER,
    EVENT_KASPARIAN_JUST_DIED,
    EVENT_KASPARIAN_AGGRO,

    // Yathae
    EVENT_SHADOW_SHOT,
    EVENT_INCORPOREAL_SHOT,
    EVENT_CALL_MOONTALON,
    EVENT_TWILIGHT_VOLLEY,
    EVENT_RAPID_SHOT,
    EVENT_YATHAE_JUST_DIED,
    EVENT_YATHAE_AGGRO,

    // Lunaspyre
    EVENT_EMBRACE_OF_THE_ECLIPSE,
    EVENT_LUNAR_BEACON,
    EVENT_LUNAR_FIRE,
    EVENT_LUNAR_STRIKE,
    EVENT_MOON_BURN,
    EVENT_LUNASPYRE_JUST_DIED,
    EVENT_LUNASPYRE_AGGRO
};

enum Actions
{
    ACTION_RETURN_PHASE1                            = 1,
    ACTION_RETURN                                   = 2,
    ACTION_SAY_SISTERS_AGGRO                        = 3,
    ACTION_EVADE                                    = 4,
    ACTION_PHASE_2                                  = 5,
    ACTION_PHASE_3                                  = 6,
    ACTION_SISTERS_DEAD                             = 7
};

enum Phases
{
    THE_HUNTRESS                                    = 1,
    THE_CAPTAIN                                     = 2,
    THE_PRIESTESS                                   = 3,
    SISTER_GHOST                                    = 4
};

enum Objects
{
    DATA_HUNTRESS_KASPARIAN,
    DATA_CAPTAIN_YATHAE_MOONSTRIKE,
    DATA_PRIESTESS_LUNASPYRE,
};

class boss_sisters_of_the_moon : public CreatureScript
{
    public:
        boss_sisters_of_the_moon() : CreatureScript("boss_sisters_of_the_moon") { }

        struct boss_sisters_of_the_moon_AI : public BossAI
        {
            boss_sisters_of_the_moon_AI(Creature* creature) : BossAI(creature, DATA_SISTERS_OF_THE_MOON)
            {
                creature->GetInstanceScript();

                Creature* kasparian = instance->GetCreature(NPC_HUNTRESS_KASPARIAN);
                Creature* yathae = instance->GetCreature(NPC_CAPTAIN_YATHAE_MOONSTRIKE);
                Creature* lunaspyre = instance->GetCreature(NPC_PRIESTESS_LUNASPYRE);

                if (instance)
                {
                    EncounterState bossState = instance->GetBossState(DATA_SISTERS_OF_THE_MOON);
                    if (bossState != DONE && bossState != NOT_STARTED)
                        instance->SetBossState(DATA_SISTERS_OF_THE_MOON, NOT_STARTED);
                }
            }

            void Reset() override
            {
                me->RemoveAllAreaTriggers();

                events.Reset();

                if (instance)
                    instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

                switch (me->GetEntry())
                {
                    case NPC_HUNTRESS_KASPARIAN:
                        DoAction(ACTION_RETURN_PHASE1);
                        break;
                    case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                    case NPC_PRIESTESS_LUNASPYRE:
                        DoAction(ACTION_RETURN);
                        break;
                    default:
                        break;
                }
            }

            void EnterCombat(Unit* /*attacker*/) override
            {
                if (instance)
                {
                   instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
                   instance->SetBossState(DATA_SISTERS_OF_THE_MOON, IN_PROGRESS);
                }

                events.AddPhase(THE_HUNTRESS);
                DoAction(ACTION_SAY_SISTERS_AGGRO);
                DoZoneInCombat();

                switch (me->GetEntry())
                {
                    case NPC_HUNTRESS_KASPARIAN:
                        events.ScheduleEvent(EVENT_MOON_GLAIVE, 17s, THE_HUNTRESS);
                        events.ScheduleEvent(EVENT_TWILIGHT_GLAIVE, 22s);
                    break;
                    case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                        events.ScheduleEvent(EVENT_TWILIGHT_VOLLEY, 15s);
                        events.ScheduleEvent(EVENT_CALL_MOONTALON, 40s, 0, THE_CAPTAIN);
                        events.ScheduleEvent(EVENT_INCORPOREAL_TELEPORT, 30s, 38s, 0, ((THE_HUNTRESS), (THE_PRIESTESS)));
                        events.ScheduleEvent(EVENT_RAPID_SHOT, 25s, 0, THE_CAPTAIN);
                        events.ScheduleEvent(EVENT_SHADOW_SHOT, 10s, 0, THE_CAPTAIN);
                    break;
                    case NPC_PRIESTESS_LUNASPYRE:
                        events.ScheduleEvent(EVENT_LUNAR_FIRE, 12s);
                        events.ScheduleEvent(EVENT_LUNAR_BEACON, 17s, 0 , THE_PRIESTESS);
                        events.ScheduleEvent(EVENT_MOON_BURN, 10s, 0 , THE_PRIESTESS);
                        events.ScheduleEvent(EVENT_INCORPOREAL_TELEPORT, 30s, 38s, ((THE_HUNTRESS), (THE_CAPTAIN)));
                    break;
                }
            }

            void EnterEvadeMode(EvadeReason /*why*/) override
            {
                _DespawnAtEvade();

                me->RemoveAllAreaTriggers();

                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MOON_BURN);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_RAPID_SHOT);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MOON_GLAIVE);
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_LUNAR_BARRAGE_DAMAGE);

                switch (me->GetEntry())
                {
                    case NPC_HUNTRESS_KASPARIAN:
                    {
                        if (events.IsInPhase(THE_HUNTRESS))
                            Talk(SAY_KASPARIAN_EVADE);
                        break;
                    }

                    case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                    {
                        if (events.IsInPhase(THE_CAPTAIN))
                            Talk(SAY_YATHAE_EVADE);
                        break;
                    }

                    case NPC_PRIESTESS_LUNASPYRE:
                    {
                        if (events.IsInPhase(THE_PRIESTESS))
                            Talk(SAY_LUNASPYRE_EVADE);
                        break;
                    }

                    default:
                        break;
                }
            }

            void DoAction(const int32 action) override
            {
                switch (action)
                {
                    case ACTION_EVADE:
                    {
                        switch (me->GetEntry())
                        {
                            case NPC_HUNTRESS_KASPARIAN:
                            {
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                                me->RemoveAurasDueToSpell(SPELL_GHOST_AURA);
                                break;
                            }
                            case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                            case NPC_PRIESTESS_LUNASPYRE:
                            {
                                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                                me->AddAura(SPELL_GHOST_AURA, me);
                                break;
                            }
                            default:
                                break;
                        }
                        break;
                    }

                    case ACTION_PHASE_2:
                    {
                        events.SetPhase(THE_CAPTAIN);
                        switch (me->GetEntry())
                        {
                            case NPC_HUNTRESS_KASPARIAN:
                            {
                                me->AddAura(SPELL_GHOST_AURA, me);
                                // Disable Movement
                                break;
                            }

                            case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                            {
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                                events.ScheduleEvent(EVENT_TELEPORT_CENTER_COMBAT, 0s);
                                //Enable Movement
                                break;
                            }

                            case NPC_PRIESTESS_LUNASPYRE:
                                break;
                            default:
                                break;
                        }
                        break;
                    }

                    case ACTION_PHASE_3:
                    {
                        events.SetPhase(THE_PRIESTESS);

                        switch (me->GetEntry())
                        {
                            case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                            {
                                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                                me->AddAura(SPELL_GHOST_AURA, me);
                                events.ScheduleEvent(EVENT_BACK_TO_GHOST, 0s);
                                // Disable Movement
                                break;
                            }

                            case NPC_PRIESTESS_LUNASPYRE:
                            {
                                me->RemoveAurasDueToSpell(SPELL_GHOST_AURA);
                                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                                events.ScheduleEvent(EVENT_TELEPORT_CENTER_COMBAT, 0s);
                                // Enable Movement
                                break;
                            }
                            default:
                                break;
                        }
                        break;
                    }

                    case ACTION_SISTERS_DEAD:
                    {
                        events.ScheduleEvent(EVENT_LUNASPYRE_JUST_DIED, 0s);
                        events.ScheduleEvent(EVENT_YATHAE_JUST_DIED, 8s);
                        events.ScheduleEvent(EVENT_KASPARIAN_JUST_DIED, 16s);
                        break;
                    }

                    case ACTION_SAY_SISTERS_AGGRO:
                    {
                        events.ScheduleEvent(EVENT_KASPARIAN_AGGRO, 0s);
                        events.ScheduleEvent(EVENT_LUNASPYRE_AGGRO, 4s);
                        events.ScheduleEvent(EVENT_YATHAE_AGGRO, 9s);
                        break;
                    }
                    default:
                        break;
                }
            }

            void DamageTaken(Unit* attacker, uint32 &damage) override
            {
                if (me->GetEntry() == NPC_HUNTRESS_KASPARIAN)
                {
                    if (me->HealthBelowPctDamaged(70, damage))
                    {
                        DoAction(ACTION_PHASE_2);
                    }
                }

                if (me->GetEntry() == NPC_CAPTAIN_YATHAE_MOONSTRIKE)
                {
                    if (me->HealthBelowPctDamaged(40, damage))
                    {
                        DoAction(ACTION_PHASE_3);
                    }
                }
            }

            void JustDied(Unit* /*killer*/) override
            {
                DoAction(ACTION_SISTERS_DEAD);
            }

            void KilledUnit(Unit* killer) override
            {
                if (killer->GetTypeId() == TYPEID_PLAYER && !me->IsInEvadeMode())
                {
                    /*switch (killer)
                    {
                        case NPC_HUNTRESS_KASPARIAN:
                        {
                            if (events.IsInPhase(THE_HUNTRESS))
                                killer->Talk(SAY_KASPARIAN_KILLS);
                            else if (events.IsInPhase(THE_CAPTAIN))
                                yathae->AI()->Talk(SAY_SISTER_KILLS);
                            else if (events.IsInPhase(THE_PRIESTESS))
                                lunaspyre->AI()->Talk(SAY_SISTER_KILLS);
                            break;
                        }

                        case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                        {
                            if (events.IsInPhase(THE_HUNTRESS))
                                kasparian->AI()->Talk(SAY_SISTER_KILLS);
                            else if (events.IsInPhase(THE_CAPTAIN))
                                killer->Talk(SAY_YATHAE_KILLS);
                            else if (events.IsInPhase(THE_PRIESTESS))
                                lunaspyre->AI()->Talk(SAY_SISTER_KILLS);
                            break;
                        }

                        case NPC_PRIESTESS_LUNASPYRE:
                        {
                            if (events.IsInPhase(THE_HUNTRESS))
                                kasparian->AI()->Talk(SAY_SISTER_KILLS);
                            else if (events.IsInPhase(THE_CAPTAIN))
                                yathae->AI()->Talk(SAY_YATHAE_KILLS);
                            else if (events.IsInPhase(THE_PRIESTESS))
                                killer->Talk(SAY_LUNASPYRE_KILLS);
                            break;
                        }
                        default:
                            break;
                    }*/
                }
            }

            void UpdateAI(const uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        // Kasparian
                        case EVENT_KASPARIAN_AGGRO:
                            Talk(SAY_KASPARIAN_AGGRO);
                            break;

                        case EVENT_MOON_GLAIVE:
                        {
                          DoCastVictim(SPELL_MOON_GLAIVE);
                          events.Repeat(17s);
                        }
                        break;

                        case EVENT_TWILIGHT_GLAIVE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_TWILIGHT_GLAIVE_AT);
                            events.Repeat(22s);
                        break;

                        case EVENT_GLAIVE_STORM:
                            // TODO
                        break;

                        case EVENT_KASPARIAN_JUST_DIED:
                              Talk(SAY_KASPARIAN_DIED);
                             break;

                        // Yathae
                        case EVENT_YATHAE_AGGRO:
                            Talk(SAY_YATHAE_AGGRO);
                            break;

                        case EVENT_CALL_MOONTALON:
                            DoCast(me, SPELL_CALL_MOONTALON);
                            events.Repeat(40s);
                            break;

                        case EVENT_TWILIGHT_VOLLEY:
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                               DoCast(target, SPELL_TWILIGHT_VOLLEY_AT);

                            events.Repeat(15s);
                        }
                        break;

                        case EVENT_RAPID_SHOT:
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            {
                                DoCast(target, SPELL_RAPID_SHOT);
                                DoCast(me, SPELL_COOLDOWN_CREATURE_SPECIAL, true);
                            }
                            events.Repeat(17s);
                        }
                        break;

                        case EVENT_SHADOW_SHOT:
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            {
                                DoCast(target, SPELL_SHADOW_SHOT);
                            }
                            events.Repeat(20s);
                        }
                        break;

                        case EVENT_YATHAE_JUST_DIED:
                            Talk(SAY_YATHAE_DIED);
                            break;

                        // Lunaspyre
                        case EVENT_LUNASPYRE_AGGRO:
                            Talk(SAY_LUNASPYRE_AGGRO);
                            break;

                        case EVENT_LUNAR_BEACON:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_LUNAR_BEACON);

                            events.Repeat(12s);
                            break;

                        case EVENT_LUNAR_FIRE:
                            DoCastVictim(SPELL_LUNAR_FIRE);
                            events.Repeat(25s);
                            break;

                        case EVENT_MOON_BURN:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_MOON_BURN);

                            events.Repeat(14s);
                            break;

                        case EVENT_LUNAR_STRIKE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_LUNAR_STRIKE);

                            events.Repeat(16s);
                            break;

                        case EVENT_EMBRACE_OF_THE_ECLIPSE:
                            // TODO
                            break;

                        case EVENT_LUNASPYRE_JUST_DIED:
                            Talk(SAY_LUNASPYRE_DIED);
                            break;
                        default:
                            break;
                    }
                }

                switch (me->GetEntry())
                {
                    case NPC_HUNTRESS_KASPARIAN:
                    {
                        if (events.IsInPhase(THE_HUNTRESS))
                            DoMeleeAttackIfReady();
                        else
                            DoSpellAttackIfReady(SPELL_MOON_GLAIVE);
                        break;
                    }

                    case NPC_CAPTAIN_YATHAE_MOONSTRIKE:
                    {
                        if (events.IsInPhase(THE_CAPTAIN))
                            DoMeleeAttackIfReady();
                        else
                            DoSpellAttackIfReady(SPELL_SHADOW_SHOT);
                        break;
                    }

                    case NPC_PRIESTESS_LUNASPYRE:
                    {
                        if (events.IsInPhase(THE_PRIESTESS))
                            DoMeleeAttackIfReady();
                        else
                            DoSpellAttackIfReady(SPELL_LUNAR_STRIKE);
                        break;
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new boss_sisters_of_the_moon_AI(creature);
        }
};

// Kasparian Spells & ATs
struct at_twilight_glaive : AreaTriggerAI
{
    at_twilight_glaive(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnInitialize() override
    {
        if (Unit* caster = at->GetCaster())
            if (Creature* creCaster = caster->ToCreature())
                if (creCaster->IsAIEnabled)
                    if (Unit* target = ObjectAccessor::GetUnit(*creCaster, creCaster->AI()->GetGUID()))
                    {
                        Position targetPos = target->GetPosition();
                        float targetDist = caster->GetDistance(target);
                        float targetAngle = caster->GetAngle(target);
                        at->MovePosition(targetPos, targetDist, targetAngle);
                    }
    }

    void OnUnitEnter(Unit* /*unit*/) override
    {
        if (Unit* caster = at->GetCaster())
            if (Unit* target = at->GetTarget())
                if (caster->IsValidAttackTarget(target))
                    caster->CastSpell(target, SPELL_TWILIGHT_GLAIVE_DAMAGE, true);
    }

    void OnDestinationReached() override
    {
        if (Unit* caster = at->GetCaster())
        {
            Position casterPos = caster->GetPosition();
            float casterDist = at->GetDistance(caster);
            float casterAngle = at->GetAngle(caster);
            at->MovePosition(casterPos, casterDist, casterAngle);
        }

        at->Remove();
    }
};

// Yathae Spells & AT
struct at_twilight_volley : AreaTriggerAI
{
    at_twilight_volley(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnInitialize() override
    {
        /*if (Unit* caster = at->GetCaster())
            if (Creature* creCaster = caster->ToCreature())
                if (creCaster->IsAIEnabled)
                    if (Unit* target = ObjectAccessor::GetUnit(*creCaster, creCaster->AI()->GetGUID()))
                        at->SetPosition(*target);*/
    }

    void OnUnitEnter(Unit* /*unit*/) override
    {
        if (Unit* caster = at->GetCaster())
            if (Unit* target = at->GetTarget())
                if (caster->IsValidAttackTarget(target))
                    caster->CastSpell(target, SPELL_TWILIGHT_VOLLEY_DAMAGE, true);
    }

    void OnUnitExit(Unit* /*unit*/) override
    {
        if (Unit* caster = at->GetCaster())
            if (Unit* target = at->GetTarget())
                if (caster->IsValidAttackTarget(target))
                    target->RemoveAurasDueToSpell(SPELL_TWILIGHT_VOLLEY_DAMAGE);
    }
};

// Lunasypre Spells & AT
/*class spell_embrace_of_the_eclipse : public SpellScriptLoader
{
    public:
        spell_embrace_of_the_eclipse() : SpellScriptLoader("spell_embrace_of_the_eclipse") { }

        class spell_embrace_of_the_eclipse_SpellScript : public SpellScript
        {
           PrepareSpellScript(spell_embrace_of_the_eclipse_SpellScript);

            bool Validate(SpellInfo const* /*spellInfo*//*) override
            {
                return ValidateSpellInfo({ SPELL_EMBRACE_OF_THE_ECLIPSE_HEAL, SPELL_EMBRACE_OF_THE_ECLIPSE_BOSS });
            }

            void HandleAfterCast()
            {
                Unit* caster = GetCaster();
                Creature* kasparian = instance->GetCreature(NPC_HUNTRESS_KASPARIAN);
                Creature* yathae = instance->GetCreature(NPC_CAPTAIN_YATHAE_MOONSTRIKE);

                if (!caster)
                    return;

                std::list<Player*> playerList;
                GetPlayerListInGrid(playerList, me, 200.0f);

                for (auto itr : playerList)
                    itr->RemoveAura(SPELL_EMBRACE_OF_THE_ECLIPSE_HEAL);
           }

           void Register() override
           {
               AfterCast += SpellCastFn(spell_embrace_of_the_eclipse_SpellScript::HandleAfterCast);
           }
       };

        class spell_embrace_of_the_eclipse_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_embrace_of_the_eclipse_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*//*) override
            {
                return ValidateSpellInfo({ SPELL_EMBRACE_OF_THE_ECLIPSE_BOSS, SPELL_EMBRACE_OF_THE_ECLIPSE_HEAL });
            }

            void HandleRemove(AuraEffect const* aurEff, uint32 &shieldType, AuraEffectHandleModes /*mode*//*)
            {
                AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();

                if (removeMode == AURA_REMOVE_BY_EXPIRE)
                {
                    switch (shieldType)
                    {
                        case SPELL_EMBRACE_OF_THE_ECLIPSE_BOSS:
                            break;
                        case SPELL_EMBRACE_OF_THE_ECLIPSE_HEAL:
                            break;
                        default:
                            break;
                    }
                }
            }

            void Register() override
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_embrace_of_the_eclipse_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_ABSORB, AURA_EFFECT_HANDLE_REAL);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_embrace_of_the_eclipse_SpellScript();
        }

        AuraScript* GetAuraScript() const override
        {
            return new spell_embrace_of_the_eclipse_AuraScript();
        }
};*/

class spell_lunar_beacon : public SpellScriptLoader
{
public:
    spell_lunar_beacon() : SpellScriptLoader("spell_lunar_beacon") { }

    class spell_lunar_beacon_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_lunar_beacon_AuraScript);

        bool Validate(SpellInfo const* /*spellInfo*/) override
        {
            return ValidateSpellInfo({ SPELL_LUNAR_BARRAGE_AT });
        }

        void HandleRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
        {
            if (GetCaster())
            {
                AuraRemoveMode removeMode = GetTargetApplication()->GetRemoveMode();

                if (removeMode == AURA_REMOVE_BY_EXPIRE)
                    GetCaster()->CastSpell(GetTarget(), SPELL_LUNAR_BARRAGE_AT, true);
            }
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_lunar_beacon_AuraScript::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    }; 

    AuraScript* GetAuraScript() const
    {
        return new spell_lunar_beacon_AuraScript();
    }
};

struct at_lunar_barrage : AreaTriggerAI
{
    at_lunar_barrage(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnInitialize() override
    {
        if (Unit* caster = at->GetCaster())
            if (Creature* creCaster = caster->ToCreature())
                if (creCaster->IsAIEnabled)
                    if (Unit* target = ObjectAccessor::GetUnit(*creCaster, creCaster->AI()->GetGUID()))
                        at->SetDestination(*target, 1000);
    }

    void OnUnitEnter(Unit* /*unit*/) override
    {
        if (Unit* caster = at->GetCaster())
            if (Unit* target = at->GetTarget())
                if (caster->IsValidAttackTarget(target))
                    caster->CastSpell(target, SPELL_LUNAR_BARRAGE_DAMAGE, true);
    }

    void OnUnitExit(Unit* /*unit*/) override
    {
        if (Unit* caster = at->GetCaster())
            if (Unit* target = at->GetTarget())
                if (caster->IsValidAttackTarget(target))
                    target->RemoveAurasDueToSpell(SPELL_LUNAR_BARRAGE_DAMAGE);
    }
};

void AddSC_boss_sisters_of_the_moon_debug()
{
   // Boss
   new boss_sisters_of_the_moon();
   // Kasparian ATs & Spells
   RegisterAreaTriggerAI(at_twilight_glaive);
   // Yathae ATs & Spells
   RegisterAreaTriggerAI(at_twilight_volley);
   // Lunaspyre ATs & Spells
   new spell_lunar_beacon();
   //new spell_embrace_of_the_eclipse();
   RegisterAreaTriggerAI(at_lunar_barrage);
}
