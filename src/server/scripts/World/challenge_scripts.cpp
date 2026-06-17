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
#include "Battleground.h"
#include "CellImpl.h"
#include "DB2Stores.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Item.h"
#include "LFGMgr.h"
#include "Log.h"
#include "NPCPackets.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "SkillDiscovery.h"
#include "SpellAuraEffects.h"
#include "SpellHistory.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Vehicle.h"
#include "AreaTriggerAI.h"

 // 206150 Challengers Might
class spell_challengers_might : public SpellScriptLoader
{
public:
    spell_challengers_might() : SpellScriptLoader("spell_challengers_might") {}

    enum eSpell
    {
        SPELL_ENRAGE = 228318,
    };

    class spell_challengers_might_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_challengers_might_AuraScript);

        uint8 volcanicTimer = 0;
        uint32 felExplosivesTimer = 0;
        uint32 necroticProcDelay = 0;

        void OnProc(AuraEffect const* aurEff, ProcEventInfo& p_EventInfo)
        {
            PreventDefaultAction();
            ;
            if (!GetUnitOwner())
                return;
            //??
            if (AuraEffect* aurEff1 = aurEff->GetBase()->GetEffect(EFFECT_2))
            {
                if (aurEff1->GetBaseAmount())
                {
                    if (!GetUnitOwner()->ToCreature()->IsDungeonBoss())
                    {
                        if (GetUnitOwner()->GetHealthPct() <= 30.f)
                            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_ENRAGE, true);
                        else
                            GetUnitOwner()->RemoveAurasDueToSpell(SPELL_ENRAGE);
                    }
                }
            }
        }

        // 3 Volcanic
        void OnTick(AuraEffect const* aurEff)
        {
            if (!aurEff->GetAmount() || !GetCaster()->IsInCombat())
                return;

            if (volcanicTimer == 7)
                volcanicTimer = 0;
            else
            {
                ++volcanicTimer;
                return;
            }

            auto caster = GetCaster()->ToCreature();
            if (!caster || caster->IsAffixDisabled() || (caster->AI() && (caster->AI() && (caster->HasAuraType(SPELL_AURA_MOD_STUN) || caster->HasAuraType(SPELL_AURA_MOD_FEAR) ||
                caster->HasAuraType(SPELL_AURA_MOD_CHARM) || caster->HasAuraType(SPELL_AURA_MOD_CONFUSE) ||
                caster->HasAuraType(SPELL_AURA_MOD_ROOT) || caster->HasAuraType(SPELL_AURA_MOD_FEAR_2)))) || !caster->IsHostileToPlayers())
                return;

            if (auto owner = caster->GetOwner())
            {
                if (owner->IsPlayer())
                    return;

                if (owner->IsCreature() && !owner->ToCreature()->IsDungeonBoss())
                    return;
            }

            auto _map = caster->GetMap();
            if (!_map)
                return;

            Map::PlayerList const& players = _map->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (auto player = itr->GetSource())
                {
                    if (player->IsInCombat() && player->IsValidAttackTarget(caster))
                        if (caster->GetDistance(player) > 15.0f && caster->GetDistance(player) < 60.0f) // Offlike 10m
                            caster->CastSpell(player, ChallengerSummonVolcanicPlume, true);
                }
            }
        }

        // 4 Necrotic
        void OnProc2(AuraEffect const* /*auraEffect*/, ProcEventInfo& eventInfo)
        {
            if (necroticProcDelay)
                PreventDefaultAction();
            else
                necroticProcDelay = 1000;
        }

        // Fel Explosives 13 Explosive
        void OnUpdate(const uint32 diff)
        {
            if (necroticProcDelay)
            {
                if (necroticProcDelay <= diff)
                    necroticProcDelay = 0;
                else
                    necroticProcDelay -= diff;
            }

            if (!GetCaster()->IsInCombat())
                return;

            if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                if (!instance->HasAffix(Affixes::FelExplosives))
                    return;

            if (felExplosivesTimer <= diff)
                felExplosivesTimer = urandms(8, 16);
            else
            {
                felExplosivesTimer -= diff;
                return;
            }

            auto caster = GetCaster()->ToCreature();
            if (!caster || caster->IsAffixDisabled() || (caster->AI() && (caster->HasAuraType(SPELL_AURA_MOD_STUN) || caster->HasAuraType(SPELL_AURA_MOD_FEAR) ||
                caster->HasAuraType(SPELL_AURA_MOD_CHARM) || caster->HasAuraType(SPELL_AURA_MOD_CONFUSE) ||
                caster->HasAuraType(SPELL_AURA_MOD_ROOT) || caster->HasAuraType(SPELL_AURA_MOD_FEAR_2))) || !caster->IsHostileToPlayers())
                return;

            if (auto owner = caster->GetOwner())
            {
                if (owner->IsPlayer())
                    return;

                if (owner->IsCreature() && !owner->ToCreature()->IsDungeonBoss())
                    return;
            }

            auto _map = caster->GetMap();
            if (!_map)
                return;

            Map::PlayerList const& players = _map->GetPlayers();
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (auto player = itr->GetSource())
                {
                    if (player->IsInCombat() && player->IsValidAttackTarget(caster))
                        if (caster->GetDistance(player) < 60.0f)
                        {
                            caster->CastSpell(caster, SPELL_FEL_EXPLOSIVES_SUMMON_2, true);
                            return;
                        }
                }
            }
        }

        void Register() override
        {
            OnEffectProc += AuraEffectProcFn(spell_challengers_might_AuraScript::OnProc, EFFECT_2, SPELL_AURA_DUMMY);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_challengers_might_AuraScript::OnTick, EFFECT_7, SPELL_AURA_PERIODIC_DUMMY);
            OnEffectProc += AuraEffectProcFn(spell_challengers_might_AuraScript::OnProc2, EFFECT_8, SPELL_AURA_DUMMY);
            OnAuraUpdate += AuraUpdateFn(spell_challengers_might_AuraScript::OnUpdate);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_challengers_might_AuraScript();
    }
};

// 105877 Vulcanic Plume
struct npc_volcanic_plume_105877 : public ScriptedAI
{
    npc_volcanic_plume_105877(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        SetCombatMovement(false);
        me->SetReactState(REACT_PASSIVE);
        me->AddUnitState(UNIT_STATE_CANNOT_TURN);
        me->SetDisableGravity(true);
        me->setFaction(16);
        me->SetDisplayId(16925);
        me->DespawnOrUnsummon(3000);
        events.Reset();
        events.ScheduleEvent(1, 250);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case 1:
                me->CastSpell(me, ChallengerVolcanicPlume, false);
                break;
            default:
                break;
            }
        }
    }
};

// 120651 Fel Explosives
struct npc_challenger_fel_explosives : ScriptedAI
{
    npc_challenger_fel_explosives(Creature* creature) : ScriptedAI(creature)
    {
        me->AddUnitTypeMask(UNIT_MASK_TOTEM);
        me->SetReactState(REACT_PASSIVE);
    }

    EventMap events;

    void Reset() override {}

    void IsSummonedBy(Unit* summoner) override
    {
        DoCast(me, SPELL_FEL_EXPLOSIVES_VISUAL, true);
        events.ScheduleEvent(1, 500);
    }

    void OnSpellCasted(SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_FEL_EXPLOSIVES_DMG)
            me->DespawnOrUnsummon(100);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case 1:
                DoCast(SPELL_FEL_EXPLOSIVES_DMG);
                break;
            }
        }
    }
};

// 209859 Bolster
class spell_challengers_bolster : public SpellScriptLoader
{
public:
    spell_challengers_bolster() : SpellScriptLoader("spell_challengers_bolster") {}

    class spell_challengers_bolster_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_challengers_bolster_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            if (targets.empty())
                return;

            std::list<WorldObject*> temp;
            for (auto object : targets)
            {
                if (auto unit = object->ToUnit())
                {
                    if (!unit->IsInCombat() || unit->IsPlayer())
                        continue;

                    auto owner = unit->GetOwner();
                    if (owner && owner->IsPlayer())
                        continue;

                    if (Creature* creature = unit->ToCreature())
                        if (creature->IsDungeonBoss())
                            continue;

                    temp.push_back(object);
                }
            }
            targets = temp;
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_challengers_bolster_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_challengers_bolster_SpellScript::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ALLY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_challengers_bolster_SpellScript::FilterTargets, EFFECT_2, TARGET_UNIT_SRC_AREA_ALLY);
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_challengers_bolster_SpellScript::FilterTargets, EFFECT_3, TARGET_UNIT_SRC_AREA_ALLY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_challengers_bolster_SpellScript();
    }
};

// 240443 Burst
class spell_challengers_burst : public SpellScriptLoader
{
public:
    spell_challengers_burst() : SpellScriptLoader("spell_challengers_burst") {}

    class spell_challengers_burst_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_challengers_burst_AuraScript);

        void OnTick(AuraEffect const* /*aurEff*/)
        {
            Unit* target = GetTarget();
            if (!target)
                return;

            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(243237))
            {
                int32 bp = spellInfo->GetEffect(EFFECT_0)->BasePoints * target->GetAuraCount(GetId());
                target->CastCustomSpell(target, 243237, &bp, NULL, NULL, true);
            }

        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_challengers_burst_AuraScript::OnTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_challengers_burst_AuraScript();
    }
};

class challange_player_instance_handler : public PlayerScript {
public:
    challange_player_instance_handler() : PlayerScript("challange_player_instance_handler")
    {
    }

    void OnSuccessfulSpellCast(Player* player, Spell* spell)
    {
        if (spell->GetSpellInfo()->Id == 227334)
            player->TaxiFlightNearestNode();
    }

    void OnStartChallengeMode(Player* player, uint8 level, uint8 affix1, uint8 affix2, uint8 affix3)
    {
        isstarted = true;
        _affix1 = affix1;
        _affix2 = affix2;
        _affix3 = affix3;
    }

    bool CheckChallengeModeStarted(Player* player)
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            isstarted = instance->IsChallengeModeStarted();
        else
            isstarted = false;
        return isstarted;
    }

    void OnTakeDamage(Player* player, uint32 /*damage*/, SpellSchoolMask schoolMask)
    {
        if (isstarted)
        {
            isstarted = CheckChallengeModeStarted(player);
            if (InstanceScript* instance = player->GetInstanceScript())
            {
                if (instance->HasAffix(Affixes::Necrotic) && schoolMask == SPELL_SCHOOL_MASK_NORMAL)//necrotic
                {
                    //player->AddAura(209858);
                }

                if (instance->HasAffix(Affixes::Grievous))//grievous
                {
                    if (player->GetHealthPct() < 90.f && !player->HasAura(240559) && player->IsInCombat())
                        player->CastSpell(player, 240559, true);

                    if (player->GetHealthPct() > 90.f || player->GetHealthPct() < 60.f)
                        player->RemoveAurasDueToSpell(240559);
                }
            }

        }
    }

    void OnUpdate(Player* player, uint32 diff)
    {
        if (checkTimer <= diff)
        {
            if (isstarted)
            {
                isstarted = CheckChallengeModeStarted(player);

                if (InstanceScript* instance = player->GetInstanceScript())
                {
                    if (instance->HasAffix(Affixes::Quaking) && player->IsInCombat())//quaking
                    {
                        player->AddAura(240447);
                    }
                }

            }
            checkTimer = 20000;
        }
        else checkTimer -= diff;

    }
    uint32 checkTimer = 10000;
    bool isstarted = false;
    uint8 _affix1;
    uint8 _affix2;
    uint8 _affix3;
};

// 226489 Sanguine Ichor / sanguine_ichor AT 12765
struct at_challenge_sanguine_ichor : AreaTriggerAI
{
    at_challenge_sanguine_ichor(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) {}

    void OnUnitEnter(Unit* unit) override
    {
        if (!unit)
            return;
        if (unit->IsPlayer())
            unit->CastSpell(unit, 226512, true);
        else
            unit->CastSpell(unit, 226510, true);
    }

    void OnUnitExit(Unit* unit) override
    {
        if (!unit)
            return;

        if (unit->HasAura(226512))
            unit->RemoveAura(226512);
        if (unit->HasAura(226510))
            unit->RemoveAura(226510);
    }

    void OnRemove() override
    {
        Unit* caster = at->GetCaster();

        if (!caster)
            return;

        for (auto guid : at->GetInsideUnits())
            if (Unit* unit = ObjectAccessor::GetUnit(*caster, guid))
            {
                if (unit->HasAura(226512))
                    unit->RemoveAura(226512);
                if (unit->HasAura(226510))
                    unit->RemoveAura(226510);
            }
    }
};

// 226512 Sanguine Ichor
class spell_challenge_sanguine_ichor : public SpellScriptLoader
{
public:
    spell_challenge_sanguine_ichor() : SpellScriptLoader("spell_challenge_sanguine_ichor") {}

    class spell_challenge_sanguine_ichor_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_challenge_sanguine_ichor_AuraScript);

        void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (aurEff->GetCaster()->IsPlayer())
                amount = 5;
            else
                amount = 1;
        }

        void Register() override
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_challenge_sanguine_ichor_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_challenge_sanguine_ichor_AuraScript();
    }
};

void AddSC_challenge_scripts()
{
    new spell_challengers_might();
    RegisterCreatureAI(npc_volcanic_plume_105877);
    RegisterCreatureAI(npc_challenger_fel_explosives);
    new spell_challengers_bolster();
    new spell_challengers_burst();
    new challange_player_instance_handler();
    RegisterAreaTriggerAI(at_challenge_sanguine_ichor);
}
