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
#include "ScriptedCreature.h"
#include "stormstout_brewery.h"
#include "Vehicle.h"
#include "SpellAuras.h"

enum Spells
{
    SPELL_BARREL_EXPLOSION_HOSTILE = 106769,
    SPELL_BARREL_EXPLOSION_PLAYER = 107016,

    SPELL_FORCECAST_BARREL_DROP = 122385,
    SPELL_CANCEL_BARREL_AURA = 94465,
    SPELL_ROLLING_BARREL_COSMETIC = 106647,
    SPELL_BARREL_TOSS = 106847,

    SPELL_BARREL_PERIODIC_PLAYER = 115868,
    SPELL_BARREL_PERIODIC_OOK = 106784,
    SPELL_BARREL_PERIODIC_HOSTILE = 106768,

    SPELL_BARREL_RIDE = 106614,

    SPELL_GOING_BANANAS = 106651,
    SPELL_GROUND_POUND = 106807,
};

static const Position ookJumpPos = { -755.68f, 1351.83f, 146.92f, 1.82f };
static const Position barrelPos[] =
{
    { -733.33f, 1372.51f, 146.73f, 4.66f },
    { -777.73f, 1357.66f, 147.79f, 1.64f }
};

bool CheckIfAgainstUnit(Unit* me, ObjectGuid casterGUID)
{
    Unit* owner = ObjectAccessor::GetUnit(*me, casterGUID);

    if (!owner)
        return false;

    if (Unit* bunny = owner->SelectNearbyTarget(nullptr, 3.f)) // General purpose bunny JMF
        if (bunny->ToCreature() && bunny->ToCreature()->GetEntry() == NPC_BARREL_TOSS_BUNNY)
            return true;

    if (Unit* bunny = GetClosestCreatureWithEntry(owner, NPC_BARREL_TOSS_BUNNY, 10.f))
        if (owner->GetDistance(bunny) < 3.3f)
            return true;

    if (Player* itr = owner->FindNearestPlayer(1.0f))
        if (owner->GetDistance(itr) < 3.0f)
            if (!itr->IsOnVehicle() || !owner->GetCharmer())
                return true;

    if (Unit* ookOok = GetClosestCreatureWithEntry(owner, NPC_OOK_OOK, 100.0f, true))
        if (owner->GetDistance(ookOok) < 3.0f)
            return true;

    return false;
}

class boss_ook_ook : public CreatureScript
{
public:
    boss_ook_ook() : CreatureScript("boss_ook_ook") {}

    enum Creatures
    {
        NPC_HOZEN_HOLLERER = 56783,
        NPC_ROLLING_BARREL = 56682
    };

    enum Events
    {
        EVENT_NONE,
        EVENT_INTROCHECK,
        EVENT_GOING_BANANAS,
        EVENT_GROUND_POUND,
        EVENT_BARREL_TOSS,
        EVENT_GROUND_POUND_CANCEL,
    };

    enum Talks
    {
        TALK_INTRO,
        TALK_AGGRO,
        TALK_SPELL,
        EMOTE_GOING_BANANAS,
        TALK_DEATH
    };

    struct boss_ook_ook_AI : public BossAI
    {
        boss_ook_ook_AI(Creature* creature) : BossAI(creature, DATA_OOK_OOK) {}

        bool introDone, initializedBarrels;
        ObjectGuid targetGuid;

        void InitializeAI() override
        {
            me->setActive(true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_PASSIVE);
            introDone = false;
            initializedBarrels = false;
            events.ScheduleEvent(EVENT_INTROCHECK, 3000);

            // SONDE TEMPORAIRE
            TC_LOG_ERROR("misc",
                "OOKDBG InitializeAI : etatBoss=%u nonAttaquable=%u reactState=%u",
                instance ? uint32(instance->GetBossState(DATA_OOK_OOK)) : 999,
                uint32(me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) ? 1 : 0),
                uint32(me->GetReactState()));

            if (instance && instance->GetBossState(DATA_OOK_OOK) == SPECIAL)
            {
                // SONDE TEMPORAIRE
                TC_LOG_ERROR("misc", "OOKDBG   etat SPECIAL persistant -> intro lancee des l initialisation");
                me->AI()->DoAction(0);
            }
        }

        void Reset() override
        {
            _Reset();
            events.Reset();

            if (instance)
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
        }

        void HandleRemoveHollers()
        {
            std::list<Creature*> hollers;
            GetCreatureListWithEntryInGrid(hollers, me, NPC_HOZEN_HOLLERER, 150.0f);

            if (!hollers.empty())
                for (auto&& itr : hollers)
                    itr->DespawnOrUnsummon();
        }

        void StartIntro()
        {
            // SONDE TEMPORAIRE
            TC_LOG_ERROR("misc", "OOKDBG StartIntro appelee (introDone valait %u)", uint32(introDone ? 1 : 0));

            introDone = true;
            events.CancelEvent(EVENT_INTROCHECK);

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetReactState(REACT_AGGRESSIVE);

            DoAction(1);

            Talk(TALK_INTRO);
            me->GetMotionMaster()->MoveJump(ookJumpPos.GetPositionX(), ookJumpPos.GetPositionY(), ookJumpPos.GetPositionZ(), 25.0f, 25.0f);
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetHomePosition(ookJumpPos);
        }

        void EnterCombat(Unit* who) override
        {
            // SONDE TEMPORAIRE - c'est la question centrale : qui l'engage,
            // et dans quel etat etait-il a ce moment-la ?
            TC_LOG_ERROR("misc",
                "OOKDBG EnterCombat par %s (type=%u entree=%u) | nonAttaquable=%u reactState=%u introDone=%u",
                who ? who->GetName().c_str() : "INCONNU",
                who ? uint32(who->GetTypeId()) : 999,
                (who && who->GetTypeId() == TYPEID_UNIT) ? who->GetEntry() : 0,
                uint32(me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE) ? 1 : 0),
                uint32(me->GetReactState()),
                uint32(introDone ? 1 : 0));

            _EnterCombat();

            Talk(TALK_AGGRO);

            events.ScheduleEvent(EVENT_GOING_BANANAS, 2000);
            events.ScheduleEvent(EVENT_GROUND_POUND, urand(8000, 14000));

            if (instance)
                instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me);
        }

        void DoAction(int32 actionId) override
        {
            // SONDE TEMPORAIRE
            TC_LOG_ERROR("misc", "OOKDBG DoAction(%d)", actionId);

            if (actionId == 0)
                StartIntro();
            else if (actionId == 1)
                events.ScheduleEvent(EVENT_BARREL_TOSS, 1000);
        }

        float GetNeededHealthPercent()
        {
            if (me->GetAura(SPELL_GOING_BANANAS))
                return (90 - ((me->GetAura(SPELL_GOING_BANANAS)->GetStackAmount()) * 30)); // 90, 60 and 30%

            return 90;
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            _EnterEvadeMode();

            events.Reset();

            me->RemoveAllAuras();

            if (me->HasUnitState(UNIT_STATE_CANNOT_TURN))
                me->ClearUnitState(UNIT_STATE_CANNOT_TURN);

            if (instance)
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

            me->GetMotionMaster()->MovePoint(4, ookJumpPos);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (pointId == 4)
                JustReachedHome();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();

            if (instance)
                instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

            HandleRemoveHollers();
        }

        void MoveInLineOfSight(Unit* who) override
        {
            ScriptedAI::MoveInLineOfSight(who);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_GOING_BANANAS:
                    if (me->GetHealthPct() < GetNeededHealthPercent())
                    {
                        DoCast(SPELL_GOING_BANANAS);
                        Talk(TALK_SPELL);
                        Talk(EMOTE_GOING_BANANAS);
                    }
                    events.ScheduleEvent(EVENT_GOING_BANANAS, 2000);
                    break;
                case EVENT_GROUND_POUND:
                    if (Unit* vict = me->GetVictim())
                    {
                        targetGuid = vict->GetGUID();
                        me->PrepareChanneledCast(me->GetAngle(vict), SPELL_GROUND_POUND);
                    }
                    Talk(TALK_SPELL);
                    events.ScheduleEvent(EVENT_GROUND_POUND_CANCEL, 5 * IN_MILLISECONDS);
                    events.ScheduleEvent(EVENT_GROUND_POUND, urand(10000, 14000));
                    break;
                case EVENT_GROUND_POUND_CANCEL:
                    me->RemoveChanneledCast(targetGuid);
                    break;
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new boss_ook_ook_AI(creature);
    }
};

class npc_barrel : public CreatureScript
{
public:
    npc_barrel() : CreatureScript("npc_barrel") {}

    enum Events
    {
        EVENT_NONE,
        EVENT_EXPLOSION,
        EVENT_MOVE,
        EVENT_EXPLOSION_BREAK,
    };

    struct npc_barrel_AI : public ScriptedAI
    {
        npc_barrel_AI(Creature* creature) : ScriptedAI(creature) {}

        ObjectGuid playerGuid;
        EventMap events;
        bool initiate;

        void IsSummonedBy(Unit* summoner) override
        {
            me->SetReactState(REACT_PASSIVE);
            me->AddAura(SPELL_ROLLING_BARREL_COSMETIC, me);

            // SylvaniaCore : le tonneau part desormais dans la direction du
            // lancer. Il est invoque par un sort a 5-10 m devant le Hurleur
            // (npc_hozen_hollerer::DoCastBarrel), mais son orientation
            // propre n'etait jamais fixee : rien ne garantissait qu'il
            // roule vers la salle plutot que dans n'importe quel sens.
            if (summoner)
            {
                float const cap = summoner->GetOrientation();
                me->SetOrientation(cap);
                me->SetFacingTo(cap, true);
            }
            me->SetSpeed(MOVE_WALK, 0.85f);
            me->SetSpeed(MOVE_RUN, 0.85f);
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
            Move();
            initiate = false;
            events.ScheduleEvent(EVENT_EXPLOSION_BREAK, 2000);
        }

        void OnSpellClick(Unit* clicker, bool& result) override
        {
            if (clicker)
                clicker->CastSpell(me, SPELL_BARREL_RIDE, false);

            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }

        // SylvaniaCore - deplacement des tonneaux.
        //
        // SIGNALE EN JEU : « les tonneaux sont completement bugges, ils se
        // deplacent bizarrement ».
        //
        // L'ancienne version relancait un MovePoint vers un point situe a
        // 5 m devant, TOUTES LES 300 ms. Or le tonneau avance a 0,85 de
        // vitesse, soit environ 5,95 m/s : parcourir ces 5 m lui demande
        // 840 ms. Le trajet etait donc reinitialise alors qu'il n'en avait
        // effectue qu'un tiers, et cela quatre fois de suite pour chaque
        // segment. Cote client, chaque reinitialisation est une rupture de
        // trajectoire : d'ou le roulement saccade.
        //
        // On ne relance donc plus au chronometre mais A L'ARRIVEE, via
        // MovementInform. Le segment est aussi allonge : moins de coutures,
        // donc un roulement continu.
        static uint32 const POINT_ROULEMENT = 100;

        void Move()
        {
            // 20 m par segment : assez long pour que le roulement paraisse
            // continu, assez court pour que le tonneau reste reactif.
            float const DISTANCE_ROULEMENT = 20.0f;

            float x = 0, y = 0;
            GetPositionWithDistInOrientation(me, DISTANCE_ROULEMENT, me->GetOrientation(), x, y);

            // On conserve volontairement la generation de chemin. Un tonneau
            // devrait rouler en ligne droite, et la couper ferait mieux sur
            // le papier -- mais elle est aussi ce qui garde le tonneau sur
            // le sol praticable. Sans elle il traverserait les murs et
            // sortirait de la salle, ce qui serait pire que le defaut
            // corrige. Sur un sol degage, le chemin calcule est de toute
            // facon quasi rectiligne.
            me->GetMotionMaster()->MovePoint(POINT_ROULEMENT, x, y, me->GetPositionZ());
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_ROULEMENT)
                Move();
        }

        void UpdateAI(uint32 diff) override
        {
            if (CheckIfAgainstUnit(me, me->GetGUID()) && initiate)
                DoExplode();

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_EXPLOSION_BREAK:
                    initiate = true;
                    break;
                }
            }
        }

        // Particular functions here.
    private:
        void DoExplode()
        {
            DoCast(SPELL_BARREL_EXPLOSION_HOSTILE);
            DoCast(SPELL_BARREL_EXPLOSION_PLAYER);

            me->Kill(me);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_barrel_AI(creature);
    }
};

class npc_hozen_hollerer : public CreatureScript
{
public:
    npc_hozen_hollerer() : CreatureScript("npc_hozen_hollerer") {}

    enum Events
    {
        EVENT_NONE,
        EVENT_BARREL_TOSS
    };

    enum Spells
    {
        SPELL_BARREL_TOSS = 106847
    };

    struct npc_hozen_hollererAI : public ScriptedAI
    {
        npc_hozen_hollererAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;
        InstanceScript* instance;

        void InitializeAI() override
        {
            instance = me->GetInstanceScript();
            events.ScheduleEvent(EVENT_BARREL_TOSS, 1000);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        void DoCastBarrel()
        {
            float x, y, z;

            GetPositionWithDistInOrientation(me, frand(5.0f, 10.0f), me->GetOrientation(), x, y);
            z = 146.79f;

            me->CastSpell(x, y, z, SPELL_BARREL_TOSS, false);
        }

        uint32 GetBarrelTimer() const
        {
            if (instance)
                if (Unit* ookOok = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_OOK_OOK)))
                    if (ookOok->GetAura(SPELL_GOING_BANANAS))
                    {
                        switch (ookOok->GetAura(SPELL_GOING_BANANAS)->GetStackAmount())
                        {
                        case 1:
                            return urand(8000, 12000);
                        case 2:
                            return urand(6000, 10000);
                        case 3:
                            return urand(4000, 7000);
                        }
                    }

            return urand(10000, 14000);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_BARREL_TOSS:
                    DoCastBarrel();
                    events.ScheduleEvent(EVENT_BARREL_TOSS, GetBarrelTimer());
                    break;
                }
            }
        }

    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_hozen_hollererAI(creature);
    }
};

class spell_ook_ook_barrel_ride : public SpellScriptLoader
{
public:
    spell_ook_ook_barrel_ride() : SpellScriptLoader("spell_ook_ook_barrel_ride") {}

    class spell_ook_ook_barrel_ride_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ook_ook_barrel_ride_AuraScript);

        void OnApply(const AuraEffect*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* barrelBase = GetTarget())
            {
                if (Unit* caster = GetCaster())
                {
                    //barrelBase->SetCharmedBy(GetCaster(), CHARM_TYPE_VEHICLE);
                    caster->CastSpell(barrelBase, SPELL_CANCEL_BARREL_AURA, true);
                    caster->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FORCE_MOVEMENT);
                    caster->CastSpell(caster, SPELL_ROLLING_BARREL_COSMETIC, true);
                }
            }
        }

        // unused atm
        void OnRemove(const AuraEffect*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* caster = GetCaster();
            Unit* target = GetTarget();

            if (caster && target)
            {
                caster->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FORCE_MOVEMENT);
                caster->RemoveAurasDueToSpell(SPELL_ROLLING_BARREL_COSMETIC);
            }
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_ook_ook_barrel_ride_AuraScript::OnApply, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_ook_ook_barrel_ride_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_ook_ook_barrel_ride_AuraScript();
    }
};

// Barrel Hostile 107351
class spell_barrel_hostile : public SpellScriptLoader
{
public:
    spell_barrel_hostile() : SpellScriptLoader("spell_barrel_hostile") {}

    class spell_barrel_hostile_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_barrel_hostile_SpellScript);

        void SelectTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if([=](WorldObject* obj) { return obj && (obj->ToPlayer() || obj->GetEntry() == NPC_BARREL_TOSS_BUNNY); });
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_barrel_hostile_SpellScript::SelectTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENTRY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_barrel_hostile_SpellScript();
    }
};

class spell_ground_pound : public SpellScriptLoader
{
public:
    spell_ground_pound() : SpellScriptLoader("spell_ground_pound") {}

    class spell_ground_pound_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_ground_pound_AuraScript);

        void HandleOnApply(const AuraEffect* aurEff, AuraEffectHandleModes mode)
        {
            GetCaster()->AddUnitState(UNIT_STATE_CANNOT_TURN);
        }

        void HandleOnPeriodic(AuraEffect const* aurEff)
        {
            if (Unit* owner = GetOwner()->ToUnit())
            {
                PreventDefaultAction();
                owner->CastSpell(owner, 106808, true);
            }
        }

        void HandleOnRemove(const AuraEffect* aurEff, AuraEffectHandleModes mode)
        {
            GetCaster()->ClearUnitState(UNIT_STATE_CANNOT_TURN);
        }

        void Register() override
        {
            OnEffectApply += AuraEffectApplyFn(spell_ground_pound_AuraScript::HandleOnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_ground_pound_AuraScript::HandleOnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            //OnEffectPeriodic += AuraEffectPeriodicFn(spell_ground_pound_AuraScript::HandleOnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_ground_pound_AuraScript();
    }
};

// Brew Barrel Ride 106614
class spell_brew_barrel_ride : public SpellScriptLoader
{
public:
    spell_brew_barrel_ride() : SpellScriptLoader("spell_brew_barrel_ride") {}

    class spell_brew_barrel_ride_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_brew_barrel_ride_AuraScript);

        void OnTrigger(AuraEffect const* /*aurEff*/)
        {
            if (Unit* caster = GetOwner()->ToUnit())
                if (CheckIfAgainstUnit(caster, caster->GetGUID()))
                {
                    caster->CastSpell(caster, SPELL_BARREL_EXPLOSION_HOSTILE, false);
                    caster->CastSpell(caster, SPELL_BARREL_EXPLOSION_PLAYER, false);
                    caster->Kill(caster);
                }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_brew_barrel_ride_AuraScript::OnTrigger, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_brew_barrel_ride_AuraScript();
    }
};

void AddSC_boss_ook_ook()
{
    new boss_ook_ook();
    new npc_barrel();
    new npc_hozen_hollerer();
    new spell_ook_ook_barrel_ride();
    new spell_barrel_hostile();
    new spell_ground_pound();
    new spell_brew_barrel_ride();
}
