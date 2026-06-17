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
#include "SpellAuras.h"

 // 113865 - gandling
 // 113647 - bone weaver
 // 114231 - lillian cosmetic eyes
 // 114057 - soul flame visual

enum ScriptTexts
{
    SAY_RATTLE_AGGRO = 0,
};

enum RattleSpells
{
    SPELL_BONE_WHIRLWIND = 114079,

    SPELL_RUSTING = 113763,
    SPELL_RUSTING_AURA = 113765,
    SPELL_BONE_SPIKE = 113999,

    SPELL_SOULFLAME = 114007,
    SPELL_SOULFLAME_DMG = 114009,
    SPELL_SOULFLAME_VISUAL = 114057,

    SPELL_BONE_ARMOR = 113996,
};

enum RattleEvents
{
    EVENT_SOULFLAME = 1,
    EVENT_BONE_SPIKE,
    EVENT_INTRO,
    EVENT_INTRO_1,
};

enum RattleActions
{
    ACTION_INTRO_RATTLEGORE = 1
};

enum RattleAdds
{
    NPC_SOULFLAME = 59316,
    NPC_BONE_PILE = 59304,
};

static Position const bonepilePos[6] =
{
    {276.793091f,  99.967239f, 113.726151f, 1.665531f},
    {276.503754f, 117.604439f, 114.303345f, 1.586118f},
    {246.722977f, 117.852592f, 113.728531f, 3.504235f},
    {246.668045f, 101.072517f, 114.031090f, 4.719858f},
    {246.814392f,  81.480064f, 113.744370f, 4.719858f},
    {276.381165f,  80.856049f, 113.728592f, 0.480017f}
};

class boss_rattlegore : public CreatureScript
{
public:
    boss_rattlegore() : CreatureScript("boss_rattlegore") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_rattlegoreAI(creature);
    }

    struct boss_rattlegoreAI : public BossAI
    {
        boss_rattlegoreAI(Creature* creature) : BossAI(creature, DATA_RATTLEGORE)
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

            isIntro = false;
            summoners = 0;
            achievement = true;
        }

        void Reset()
        {
            _Reset();

            // Boss-Event-Flag entscheidet, ob er schon freigeschaltet wurde
            if (instance && instance->GetData(DATA_RATTLEGORE_EVENT) == DONE)
            {
                // Bereits ?aktiviert?: normal sichtbar und angreifbar
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                me->SetDisplayId(me->GetNativeDisplayId());
                me->SetReactState(REACT_AGGRESSIVE);
            }
            else
            {
                // Noch nicht freigeschaltet: unsichtbarer Dummy / unanklickbar
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                me->SetReactState(REACT_PASSIVE);

                // 11686 ist das übliche ?Invisible Stalker? / Dummy-Display
                me->SetDisplayId(11686);

                // Event-Zähler zurücksetzen
                summoners = 0;
                isIntro = false;
            }

            if (instance)
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BONE_ARMOR);

            achievement = true;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_RATTLE_AGGRO);

            // Bonepiles + Soulflames spawnen beim Kampfstart
            for (uint8 i = 0; i < 6; ++i)
            {
                me->SummonCreature(NPC_BONE_PILE, bonepilePos[i]);
                me->SummonCreature(NPC_SOULFLAME, bonepilePos[i]);
            }

            // Rusting (für das Achievement)
            me->AddAura(SPELL_RUSTING, me);

            events.ScheduleEvent(EVENT_BONE_SPIKE, 8000);
            events.ScheduleEvent(EVENT_SOULFLAME, urand(1000, 3000));

            DoZoneInCombat();
            if (instance)
                instance->SetBossState(DATA_RATTLEGORE, IN_PROGRESS);
        }

        void DoAction(int32 const action)
        {
            if (action != ACTION_INTRO_RATTLEGORE)
                return;

            if (!instance)
                return;

            // Wenn der Event schon abgeschlossen ist, nichts mehr tun
            if (instance->GetData(DATA_RATTLEGORE_EVENT) == DONE)
                return;

            // Falls aus irgendeinem Grund der AreaTrigger nicht gegriffen hat,
            // setzen wir den Event jetzt auf IN_PROGRESS
            if (instance->GetData(DATA_RATTLEGORE_EVENT) == NOT_STARTED)
                instance->SetData(DATA_RATTLEGORE_EVENT, IN_PROGRESS);

            if (instance->GetData(DATA_RATTLEGORE_EVENT) != IN_PROGRESS)
                return;

            // Jeder tote Boneweaver ruft DoAction(1) -> wir zählen
            ++summoners;

            // 6 Boneweaver tot => Intro starten
            if (summoners >= 6 && !isIntro)
            {
                instance->SetData(DATA_RATTLEGORE_EVENT, DONE);

                isIntro = true;

                // Whirlwind-Intro (Bone-Wirbel in der Mitte)
                DoCast(me, SPELL_BONE_WHIRLWIND);
                events.ScheduleEvent(EVENT_INTRO, 2000); // 2s ?Spawn-Animation?
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();

            if (instance)
            {
                instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_BONE_ARMOR);
            }

            TrySpawnDoctorKrastinov();
        }

        bool AllowAchievement()
        {
            return achievement;
        }

        void UpdateAI(uint32 const diff)
        {
            // Während des Intros soll er Events verarbeiten, auch ohne Ziel
            if (!isIntro && !UpdateVictim())
                return;

            // Fail-Safe: Wenn er aus dem Kampfbereich gezogen wird, evaden
            if (me->GetPositionY() < 61.0f || me->GetPositionY() > 134.0f)
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            // Achievement-Check: Rusting-Stacks <= 5
            if (achievement)
            {
                if (Aura const* aur = me->GetAura(SPELL_RUSTING_AURA))
                {
                    if (aur->GetStackAmount() > 5)
                        achievement = false;
                }
            }

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_INTRO:
                    // Sichtbar machen, aber noch in Whirlwind
                    me->SetDisplayId(me->GetNativeDisplayId());
                    me->SetReactState(REACT_PASSIVE);
                    events.ScheduleEvent(EVENT_INTRO_1, 4000);
                    break;

                case EVENT_INTRO_1:
                    // Intro fertig: Whirlwind runter, angreifbar machen
                    isIntro = false;
                    me->RemoveAura(SPELL_BONE_WHIRLWIND);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
                    me->SetReactState(REACT_AGGRESSIVE);
                    break;

                case EVENT_BONE_SPIKE:
                {
                    Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 0.0f, true);
                    if (!target)
                        target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true);
                    if (target)
                        DoCast(target, SPELL_BONE_SPIKE);

                    events.ScheduleEvent(EVENT_BONE_SPIKE, 8000);
                    break;
                }

                case EVENT_SOULFLAME:
                {
                    std::list<Creature*> creatures;
                    std::list<Creature*> newcreatures;

                    me->GetCreatureListWithEntryInGrid(creatures, NPC_SOULFLAME, 200.0f); // Reichweite ggf. anpassen

                    for (std::list<Creature*>::const_iterator itr = creatures.begin(); itr != creatures.end(); ++itr)
                    {
                        if ((*itr)->HasAura(SPELL_SOULFLAME))
                        {
                            (*itr)->RemoveAura(SPELL_SOULFLAME);
                        }
                        else
                        {
                            if (newcreatures.size() < 2)
                                newcreatures.push_back((*itr));
                        }
                    }

                    for (std::list<Creature*>::const_iterator itr = newcreatures.begin(); itr != newcreatures.end(); ++itr)
                        (*itr)->AddAura(SPELL_SOULFLAME, (*itr));

                    events.ScheduleEvent(EVENT_SOULFLAME, urand(7000, 10000));
                    break;
                }

                default:
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:

        void TrySpawnDoctorKrastinov()
        {
            if (!IsHeroic())
                return;

            if (!roll_chance_i(DOCTOR_THEOLEN_KRASTINOV_CHANCE))
                return;

            if (Creature* pKrastinov = me->GetMap()->SummonCreature(NPC_DOCTOR_THEOLEN_KRASTINOV, krastinovPos))
            {
                // SummonCreature setzt keinen Owner -> IsSummonedBy manuell triggern
                pKrastinov->AI()->IsSummonedBy(me);
            }
        }

        bool  isIntro;
        uint8 summoners;
        bool  achievement;
    };
};

class npc_rattlegore_soulflame : public CreatureScript
{
public:
    npc_rattlegore_soulflame() : CreatureScript("npc_rattlegore_soulflame") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_rattlegore_soulflameAI(creature);
    }

    struct npc_rattlegore_soulflameAI : public Scripted_NoMovementAI
    {
        npc_rattlegore_soulflameAI(Creature* creature) : Scripted_NoMovementAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_IMMUNE_TO_PC);
        }

        void Reset()
        {
            me->AddAura(SPELL_SOULFLAME_VISUAL, me);
        }
    };
};

class npc_rattlegore_bone_pile : public CreatureScript
{
public:
    npc_rattlegore_bone_pile() : CreatureScript("npc_rattlegore_bone_pile") {}

    bool OnGossipHello(Player* player, Creature* /*creature*/)
    {
        player->CastSpell(player, SPELL_BONE_ARMOR, true);
        return true;
    }
};

class spell_rattlegore_soul_flame_dmg : public SpellScriptLoader
{
public:
    spell_rattlegore_soul_flame_dmg() : SpellScriptLoader("spell_rattlegore_soul_flame_dmg") {}

    class spell_rattlegore_soul_flame_dmg_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_rattlegore_soul_flame_dmg_SpellScript);

        void ScaleRange(std::list<WorldObject*>& targets)
        {
            if (Unit* caster = GetCaster())
                targets.remove_if(ExactDistanceCheck(caster, caster->GetFloatValue(OBJECT_FIELD_SCALE_X)));
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rattlegore_soul_flame_dmg_SpellScript::ScaleRange, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        }

    private:

        class ExactDistanceCheck
        {
        public:
            ExactDistanceCheck(Unit* source, float dist) : _source(source), _dist(dist) {}

            bool operator()(WorldObject* unit) const
            {
                return _source->GetExactDist2d(unit) > _dist;
            }

        private:
            Unit* _source;
            float _dist;
        };
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_rattlegore_soul_flame_dmg_SpellScript();
    }
};

class spell_rattlegore_bone_armor : public SpellScriptLoader
{
public:
    spell_rattlegore_bone_armor() : SpellScriptLoader("spell_rattlegore_bone_armor") {}

    class spell_rattlegore_bone_armor_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_rattlegore_bone_armor_AuraScript);

        void HandleAbsorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
        {
            if (dmgInfo.GetSpellInfo() && dmgInfo.GetSpellInfo()->Id == SPELL_BONE_SPIKE)
            {
                absorbAmount = dmgInfo.GetDamage();
            }
            else
            {
                // Nur Bone Spike darf von Bone Armor geschluckt werden
                PreventDefaultAction();
            }
        }

        void Register()
        {
            OnEffectAbsorb += AuraEffectAbsorbFn(spell_rattlegore_bone_armor_AuraScript::HandleAbsorb, EFFECT_0);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_rattlegore_bone_armor_AuraScript();
    }
};

class at_rattlegore : public AreaTriggerScript
{
public:
    at_rattlegore() : AreaTriggerScript("at_rattlegore") {}

    bool OnTrigger(Player* player, AreaTriggerEntry const* /*areaTrigger*/, bool /*p_Enter*/)
    {
        if (InstanceScript* pInstance = player->GetInstanceScript())
        {
            if (pInstance->GetData(DATA_RATTLEGORE_EVENT) == NOT_STARTED)
                pInstance->SetData(DATA_RATTLEGORE_EVENT, IN_PROGRESS);
        }

        return true;
    }
};

typedef boss_rattlegore::boss_rattlegoreAI RattlegoreAI;

class achievement_rattle_no_more : public AchievementCriteriaScript
{
public:
    achievement_rattle_no_more() : AchievementCriteriaScript("achievement_rattle_no_more") {}

    bool OnCheck(Player* /*source*/, Unit* target)
    {
        if (!target)
            return false;

        if (RattlegoreAI* rattlegoreAI = CAST_AI(RattlegoreAI, target->GetAI()))
            return rattlegoreAI->AllowAchievement();

        return false;
    }
};

void AddSC_boss_rattlegore()
{
    new boss_rattlegore();
    new npc_rattlegore_soulflame();         // 59316
    new npc_rattlegore_bone_pile();         // 59304
    new spell_rattlegore_soul_flame_dmg();
    new spell_rattlegore_bone_armor();
    new at_rattlegore();
    new achievement_rattle_no_more();
}
