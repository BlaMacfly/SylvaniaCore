/*
 * SylvaniaCore : Monastere ecarlate refait (Mists of Pandaria, carte 1004).
 * Porte de LegionCore (boss_thalnos_the_soulrender.cpp, boss_brother_korloff.cpp,
 * boss_high_inquisitor_whitemane.cpp). Adaptations :
 *  - Durand, les Judicateurs de la salle de Blanchetete et les mannequins de Korloff sont des
 *    apparitions fixes chez nous : les boss ne les invoquent pas a chaque Reset ;
 *  - groupes de textes alignes sur creature_text (BroadcastText officiels).
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "MotionMaster.h"
#include "Player.h"
#include "scarlet_monastery.h"

enum MopActions
{
    ACTION_DURAND_FALLEN        = 1, // Durand feint la mort : Blanchetete entre en combat
    ACTION_JUDICATOR_DIED       = 2,
    ACTION_ZOMBIE_SUMMONED      = 3,
    ACTION_ZOMBIE_DIED          = 4,
    ACTION_DUMMY_BURNED         = 5,
    ACTION_DURAND_INTRO         = 6
};

/*######
## Thalnos l'Ecorcheur d'ames (59789)
######*/

enum ThalnosTexts
{
    SAY_THALNOS_CRUSADER        = 0, // emote : detruire les tas de cadavres
    SAY_THALNOS_AGGRO           = 1,
    SAY_THALNOS_SPIRITS         = 2,
    SAY_THALNOS_DEATH           = 3
};

enum ThalnosSpells
{
    SPELL_SPIRIT_GALE               = 115289,
    SPELL_RAISE_FALLEN_CRUSADER     = 115139,
    SPELL_EVICT_SOUL                = 115297,
    SPELL_SUMMON_EMPOWERING_SPIRITS = 115147,

    SPELL_EVICT_SOUL_VISUAL         = 115304,
    SPELL_EVICT_SOUL_FOCUS_TARGET   = 115309,
    SPELL_SOUL_REND                 = 115306,

    SPELL_EMPOWERING_SPIRIT         = 115157,
    SPELL_EMPOWER_ZOMBIE_RIDE       = 115239,
    SPELL_ZOMBIE_TRANSFORM          = 115258,

    SPELL_MIND_ROT                  = 115143,
    SPELL_PERMANENT_FEIGN_DEATH     = 115163
};

enum ThalnosEvents
{
    EVENT_SPIRIT_GALE       = 1,
    EVENT_FALLEN_CRUSADER,
    EVENT_EVICT_SOUL,
    EVENT_SUMMON_SPIRITS
};

class boss_thalnos_the_soulrender : public CreatureScript
{
public:
    boss_thalnos_the_soulrender() : CreatureScript("boss_thalnos_the_soulrender") { }

    struct boss_thalnos_the_soulrenderAI : public BossAI
    {
        boss_thalnos_the_soulrenderAI(Creature* creature) : BossAI(creature, DATA_THALNOS_SOULRENDER) { }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_THALNOS_AGGRO);
            _EnterCombat();
            events.ScheduleEvent(EVENT_SPIRIT_GALE, 1000);
            events.ScheduleEvent(EVENT_FALLEN_CRUSADER, 8000);
            events.ScheduleEvent(EVENT_EVICT_SOUL, 25000);
            events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 46000);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            DoZoneInCombat(summon, 60.0f);

            if (summon->GetEntry() == NPC_EVICTED_SOUL)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                {
                    summon->CastSpell(summon, SPELL_SOUL_REND, true);
                    summon->AddThreat(target, 150.0f);
                    summon->AI()->AttackStart(target);
                    target->CastSpell(summon, SPELL_EVICT_SOUL_VISUAL, true);
                    summon->CastSpell(target, SPELL_EVICT_SOUL_FOCUS_TARGET, true);
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_THALNOS_DEATH);
            _JustDied();

            if (Creature* zombie = instance->instance->GetCreature(instance->GetGuidData(DATA_EMPOWERED_ZOMBIE)))
                zombie->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SPIRIT_GALE:
                        DoCastVictim(SPELL_SPIRIT_GALE);
                        events.ScheduleEvent(EVENT_SPIRIT_GALE, 8000);
                        break;
                    case EVENT_FALLEN_CRUSADER:
                        Talk(SAY_THALNOS_CRUSADER);
                        DoCast(SPELL_RAISE_FALLEN_CRUSADER);
                        events.ScheduleEvent(EVENT_FALLEN_CRUSADER, 60000);
                        break;
                    case EVENT_EVICT_SOUL:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            DoCast(target, SPELL_EVICT_SOUL);
                        events.ScheduleEvent(EVENT_EVICT_SOUL, 41000);
                        break;
                    case EVENT_SUMMON_SPIRITS:
                        Talk(SAY_THALNOS_SPIRITS);
                        DoCast(SPELL_SUMMON_EMPOWERING_SPIRITS);
                        events.ScheduleEvent(EVENT_SUMMON_SPIRITS, 60000);
                        break;
                    default:
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_thalnos_the_soulrenderAI>(creature);
    }
};

// 59893 : rejoint un Croise dechu marque et le transforme en Zombie surpuissant
class npc_empowering_spirit : public CreatureScript
{
public:
    npc_empowering_spirit() : CreatureScript("npc_empowering_spirit") { }

    struct npc_empowering_spiritAI : public ScriptedAI
    {
        npc_empowering_spiritAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
            me->SetSpeedRate(MOVE_RUN, 0.6f);
            me->SetSpeedRate(MOVE_WALK, 0.6f);
        }

        bool rideVehicle = false;
        uint32 moveTimer = 0;

        void Reset() override { }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            DoCast(SPELL_EMPOWERING_SPIRIT);
            moveTimer = 500;
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_EMPOWERING_SPIRIT)
            {
                me->AddThreat(target, 15000.0f);
                AttackStart(target);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || rideVehicle || !moveTimer)
                return;

            if (moveTimer > diff)
            {
                moveTimer -= diff;
                return;
            }

            moveTimer = 500;
            Unit* target = me->GetVictim();
            if (!target || !target->IsCreature() || !target->HasAura(SPELL_EMPOWERING_SPIRIT))
                return;

            if (me->GetDistance(target) <= 5.0f)
            {
                moveTimer = 0;
                rideVehicle = true;
                me->AttackStop();
                DoCast(target, SPELL_EMPOWER_ZOMBIE_RIDE, true);
                target->CastSpell(target, SPELL_ZOMBIE_TRANSFORM, true);
                me->DespawnOrUnsummon(500);
            }
            else
                me->GetMotionMaster()->MoveChase(target);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_empowering_spiritAI>(creature);
    }
};

// 59884
class npc_fallen_crusader : public CreatureScript
{
public:
    npc_fallen_crusader() : CreatureScript("npc_fallen_crusader") { }

    struct npc_fallen_crusaderAI : public ScriptedAI
    {
        npc_fallen_crusaderAI(Creature* creature) : ScriptedAI(creature) { }

        bool feignDeath = false;

        void Reset() override
        {
            DoCast(SPELL_MIND_ROT);
        }

        void PassengerBoarded(Unit* /*who*/, int8 /*seatId*/, bool apply) override
        {
            if (apply)
            {
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                me->DespawnOrUnsummon(1000);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            if (damage < me->GetHealth())
                return;

            damage = 0;
            if (!feignDeath)
            {
                feignDeath = true;
                me->AttackStop();
                DoCast(me, SPELL_PERMANENT_FEIGN_DEATH, true);
            }
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim() || feignDeath)
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_fallen_crusaderAI>(creature);
    }
};

// 59930
class npc_empowered_zombie : public CreatureScript
{
public:
    npc_empowered_zombie() : CreatureScript("npc_empowered_zombie") { }

    struct npc_empowered_zombieAI : public ScriptedAI
    {
        npc_empowered_zombieAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript()) { }

        InstanceScript* instance;
        uint32 checkTimer = 1000;

        void Reset() override { }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            DoZoneInCombat(me, 100.0f);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32 diff) override
        {
            if (checkTimer <= diff)
            {
                if (instance->GetBossState(DATA_THALNOS_SOULRENDER) != IN_PROGRESS)
                {
                    me->DespawnOrUnsummon();
                    return;
                }
                checkTimer = 1000;
            }
            else
                checkTimer -= diff;

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_empowered_zombieAI>(creature);
    }
};

/*######
## Frere Korloff (59223)
######*/

enum KorloffTexts
{
    SAY_KORLOFF_AGGRO           = 0,
    SAY_KORLOFF_DEATH           = 1
};

enum KorloffSpells
{
    SPELL_RISING_FLAME          = 114410,
    SPELL_FLYING_KICK           = 114487,
    SPELL_BLAZING_FISTS         = 114807,
    SPELL_SCORCHED_EARTH        = 114460,
    SPELL_SCORCHED_EARTH_SUM    = 114463,

    SPELL_BURNING_MAN_1         = 125852,
    SPELL_BURNING_MAN_2         = 125844
};

enum KorloffEvents
{
    EVENT_FLYING_KICK           = 1,
    EVENT_BLAZING_FISTS
};

class boss_brother_korloff : public CreatureScript
{
public:
    boss_brother_korloff() : CreatureScript("boss_brother_korloff") { }

    struct boss_brother_korloffAI : public BossAI
    {
        boss_brother_korloffAI(Creature* creature) : BossAI(creature, DATA_BROTHER_KORLOFF) { }

        bool lowHp = false;
        uint32 healthPct = 90;

        void Reset() override
        {
            _Reset();
            lowHp = false;
            healthPct = 90;
            me->RemoveAllAuras();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_KORLOFF_AGGRO);
            events.ScheduleEvent(EVENT_FLYING_KICK, 10000);
            events.ScheduleEvent(EVENT_BLAZING_FISTS, 20000);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            BossAI::EnterEvadeMode(why);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BURNING_MAN_2);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_KORLOFF_DEATH);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BURNING_MAN_2);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            // Flammes ascendantes a chaque tranche de 10 % (LC ne declenchait que la premiere)
            if (healthPct && me->HealthBelowPctDamaged(healthPct, damage))
            {
                healthPct -= 10;
                DoCast(me, SPELL_RISING_FLAME, true);
            }

            if (damage >= me->GetHealth() && !lowHp)
            {
                lowHp = true;
                DoCast(SPELL_SCORCHED_EARTH);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FLYING_KICK:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            DoCast(target, SPELL_FLYING_KICK);
                        events.ScheduleEvent(EVENT_FLYING_KICK, 26000);
                        break;
                    case EVENT_BLAZING_FISTS:
                        DoCastVictim(SPELL_BLAZING_FISTS);
                        events.ScheduleEvent(EVENT_BLAZING_FISTS, 30000);
                        break;
                    default:
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_brother_korloffAI>(creature);
    }
};

// 64446 : mannequins de la salle de Korloff, enflammes par Terre brulee
class npc_korloff_training_dummy : public CreatureScript
{
public:
    npc_korloff_training_dummy() : CreatureScript("npc_korloff_training_dummy") { }

    struct npc_korloff_training_dummyAI : public ScriptedAI
    {
        npc_korloff_training_dummyAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
            me->SetReactState(REACT_PASSIVE);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            damage = 0;
        }

        void UpdateAI(uint32 /*diff*/) override { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_korloff_training_dummyAI>(creature);
    }
};

// 114460
class spell_korloff_scorched_earth : public AuraScript
{
    PrepareAuraScript(spell_korloff_scorched_earth);

    void OnTick(AuraEffect const* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            if (caster->isMoving())
                caster->CastSpell(caster, SPELL_SCORCHED_EARTH_SUM, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_korloff_scorched_earth::OnTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

/*######
## Grande inquisitrice Blanchetete (3977) et commandant Durand (60040)
######*/

enum WhitemaneTexts
{
    SAY_WH_AGGRO                = 0,
    SAY_WH_RESURRECT            = 1,
    SAY_WH_DEATH                = 2,

    SAY_D_INTRO                 = 0,
    SAY_D_AGGRO                 = 1,
    SAY_D_DEATH                 = 2
};

enum WhitemaneSpells
{
    SPELL_HOLY_SMITE            = 114848,
    SPELL_POWER_WORD_SHIELD     = 127399,
    SPELL_DEEP_SLEEP            = 9256,
    SPELL_SCARLET_RESURRECTION  = 9232,
    SPELL_MASS_RESURRECTION     = 113134,
    SPELL_DOMINATE_MIND         = 130857,

    SPELL_FLASH_OF_STEEL        = 115629,
    SPELL_FEIGN_DEATH           = 29266,
    SPELL_FURIOUS_RESOLVE       = 115876,
    SPELL_SUICIDE_NO_BLOOD      = 42278,

    SPELL_PASS_JUDGMENT         = 111107
};

enum WhitemaneEvents
{
    EVENT_HOLY_SMITE            = 1,
    EVENT_POWER_WORD_SHIELD,
    EVENT_MASS_RESURRECTION,
    EVENT_DOMINATE_MIND,
    EVENT_FLASH_OF_STEEL
};

uint32 const POINT_DURAND = 1;
Position const JudicatorRoomCenter = { 761.4f, 547.0f, 12.8f, 0.0f };

class boss_high_inquisitor_whitemane_mop : public CreatureScript
{
public:
    boss_high_inquisitor_whitemane_mop() : CreatureScript("boss_high_inquisitor_whitemane") { }

    struct boss_high_inquisitor_whitemane_mopAI : public BossAI
    {
        boss_high_inquisitor_whitemane_mopAI(Creature* creature) : BossAI(creature, DATA_WHITEMANE) { }

        bool resurrect = false;
        bool resurrecting = false;
        bool massRes = false;

        void Reset() override
        {
            _Reset();
            resurrect = false;
            resurrecting = false;
            massRes = false;
            me->SetReactState(REACT_DEFENSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_WH_AGGRO);
            _EnterCombat();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            events.ScheduleEvent(EVENT_HOLY_SMITE, 5000);
            events.ScheduleEvent(EVENT_POWER_WORD_SHIELD, 26000);
            events.ScheduleEvent(EVENT_MASS_RESURRECTION, 12000);
            if (IsChallengeMode())
                events.ScheduleEvent(EVENT_DOMINATE_MIND, 14000);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            BossAI::EnterEvadeMode(why);
            me->NearTeleportTo(me->GetHomePosition());

            // Durand (apparition fixe) revient pour la tentative suivante
            if (Creature* durand = instance->instance->GetCreature(instance->GetGuidData(DATA_DURAND)))
                durand->DespawnOrUnsummon(0, Seconds(5));
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            if ((damage >= me->GetHealth() && !resurrect) || resurrecting)
            {
                damage = 0;
                if (!resurrect)
                    me->SetHealth(me->CountPctFromMaxHealth(50));
            }

            if (!resurrect && me->HealthBelowPctDamaged(51, damage))
            {
                resurrect = true;
                resurrecting = true;
                me->AttackStop();
                me->SetReactState(REACT_PASSIVE);
                DoCast(me, SPELL_DEEP_SLEEP, true);
                if (Creature* durand = instance->instance->GetCreature(instance->GetGuidData(DATA_DURAND)))
                {
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(POINT_DURAND, durand->GetPositionX(), durand->GetPositionY(), durand->GetPositionZ());
                }
                else
                {
                    resurrecting = false;
                    me->SetReactState(REACT_AGGRESSIVE);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_DURAND)
                return;

            DoCast(SPELL_SCARLET_RESURRECTION);
            Talk(SAY_WH_RESURRECT);
            resurrecting = false;
            me->SetWalk(false);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_WH_DEATH);

            if (!IsChallengeMode())
                if (Creature* durand = instance->instance->GetCreature(instance->GetGuidData(DATA_DURAND)))
                    if (durand->IsAlive())
                        durand->CastSpell(durand, SPELL_SUICIDE_NO_BLOOD, true);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DURAND_FALLEN && !me->IsInCombat())
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                DoZoneInCombat();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || resurrecting)
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_HOLY_SMITE:
                        DoCastVictim(SPELL_HOLY_SMITE);
                        events.ScheduleEvent(EVENT_HOLY_SMITE, 1000);
                        break;
                    case EVENT_POWER_WORD_SHIELD:
                        DoCast(me, SPELL_POWER_WORD_SHIELD, true);
                        events.ScheduleEvent(EVENT_POWER_WORD_SHIELD, 15000);
                        break;
                    case EVENT_MASS_RESURRECTION:
                        // une seule Resurrection de masse (LC : hook SpellFinishCast, jamais appele chez nous)
                        if (!massRes)
                        {
                            massRes = true;
                            DoCast(SPELL_MASS_RESURRECTION);
                        }
                        break;
                    case EVENT_DOMINATE_MIND:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            DoCast(target, SPELL_DOMINATE_MIND);
                        events.ScheduleEvent(EVENT_DOMINATE_MIND, 18000);
                        break;
                    default:
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_high_inquisitor_whitemane_mopAI>(creature);
    }
};

class npc_commander_durand : public CreatureScript
{
public:
    npc_commander_durand() : CreatureScript("npc_commander_durand") { }

    struct npc_commander_durandAI : public ScriptedAI
    {
        npc_commander_durandAI(Creature* creature) : ScriptedAI(creature), instance(creature->GetInstanceScript()) { }

        InstanceScript* instance;
        EventMap events;
        bool intro = true;
        bool fakeDeath = false;
        bool sayDeath = false;

        void Reset() override
        {
            events.Reset();
            fakeDeath = false;
            sayDeath = false;
            me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_D_AGGRO);
            events.ScheduleEvent(EVENT_FLASH_OF_STEEL, 10000);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            if (damage < me->GetHealth())
                return;

            // Durand ne meurt pas : il feint la mort jusqu a ce que Blanchetete le releve
            damage = 0;
            if (fakeDeath)
                return;

            fakeDeath = true;
            me->AttackStop();
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            DoCast(me, SPELL_FEIGN_DEATH, true);
            me->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);

            if (!sayDeath)
            {
                sayDeath = true;
                Talk(SAY_D_DEATH);

                if (Creature* whitemane = instance->instance->GetCreature(instance->GetGuidData(DATA_WHITEMANE)))
                    whitemane->AI()->DoAction(ACTION_DURAND_FALLEN);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DURAND_INTRO && intro)
            {
                intro = false;
                Talk(SAY_D_INTRO);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_SCARLET_RESURRECTION)
                return;

            me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetFullHealth();
            caster->CastSpell(caster, SPELL_FURIOUS_RESOLVE, true);
            me->SetReactState(REACT_AGGRESSIVE);
            fakeDeath = false;
            DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            if (fakeDeath || !UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (events.ExecuteEvent() == EVENT_FLASH_OF_STEEL)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                    DoCast(target, SPELL_FLASH_OF_STEEL);
                events.ScheduleEvent(EVENT_FLASH_OF_STEEL, 26000);
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_commander_durandAI>(creature);
    }
};

// 58605 : seuls les Judicateurs couches dans la salle de Blanchetete feignent la mort
// jusqu a la Resurrection de masse ; les autres sont des gardes ordinaires (SmartAI).
class npc_scarlet_judicator : public CreatureScript
{
public:
    npc_scarlet_judicator() : CreatureScript("npc_scarlet_judicator") { }

    struct npc_scarlet_judicatorAI : public ScriptedAI
    {
        npc_scarlet_judicatorAI(Creature* creature) : ScriptedAI(creature) { }

        bool raised = false;
        uint32 judgmentTimer = 0;

        bool InWhitemaneRoom() const
        {
            return me->GetHomePosition().GetExactDist2d(&JudicatorRoomCenter) < 20.0f;
        }

        void Reset() override
        {
            judgmentTimer = urand(5000, 8000);
            if (!InWhitemaneRoom() || raised)
                return;

            DoCast(me, SPELL_FEIGN_DEATH, true);
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id != SPELL_MASS_RESURRECTION || raised)
                return;

            raised = true;
            me->RemoveAurasDueToSpell(SPELL_FEIGN_DEATH);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);
            DoZoneInCombat(me, 120.0f);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            raised = false;
            ScriptedAI::EnterEvadeMode(why);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            // Jugement (ancienne SmartAI de 58605 : 5-8 s puis toutes les 12-15 s)
            if (judgmentTimer <= diff)
            {
                DoCastVictim(SPELL_PASS_JUDGMENT);
                judgmentTimer = urand(12000, 15000);
            }
            else
                judgmentTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_scarlet_judicatorAI>(creature);
    }
};

// 7496 : entree dans la salle de Durand
class at_enter_durand_room : public AreaTriggerScript
{
public:
    at_enter_durand_room() : AreaTriggerScript("at_enter_durand_room") { }

    bool OnTrigger(Player* player, AreaTriggerEntry const* /*trigger*/, bool /*entered*/) override
    {
        if (player->IsGameMaster())
            return false;

        if (InstanceScript* instance = player->GetInstanceScript())
            if (Creature* durand = instance->instance->GetCreature(instance->GetGuidData(DATA_DURAND)))
                durand->AI()->DoAction(ACTION_DURAND_INTRO);
        return true;
    }
};

void AddSC_scarlet_monastery_mop()
{
    new boss_thalnos_the_soulrender();
    new npc_empowering_spirit();
    new npc_fallen_crusader();
    new npc_empowered_zombie();
    new boss_brother_korloff();
    new npc_korloff_training_dummy();
    RegisterAuraScript(spell_korloff_scorched_earth);
    new boss_high_inquisitor_whitemane_mop();
    new npc_commander_durand();
    new npc_scarlet_judicator();
    new at_enter_durand_room();
}
