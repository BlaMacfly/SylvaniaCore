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

// Nalorakk n'avait qu'une coquille de script : il frappait en melee et rien d'autre,
// ni sorts ni changement de forme. Le combat est ici ecrit a partir du script amont
// TrinityCore, en gardant NOTRE numerotation de creature_text (0-11).
// Ce qui n'est pas porte : les quatre vagues de trolls qui l'annoncent dans la rampe.
// L'amont les pilote par des spawn groups et des chemins de waypoints que ce core
// n'a pas (pas de table spawn_group) -- cela demanderait de recreer les donnees.

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulaman.h"

enum Says
{
    SAY_WAVE_1              = 0,
    SAY_WAVE_2              = 1,
    SAY_WAVE_3              = 2,
    SAY_WAVE_4              = 3,
    SAY_AGGRO               = 4,
    SAY_PLAYER_KILL         = 5,
    SAY_SURGE               = 6,
    EMOTE_SURGE             = 7,
    EMOTE_BEAR              = 8,
    SAY_BEAR                = 9,
    SAY_TROLL               = 10,
    SAY_DEATH               = 11
};

enum Spells
{
    // Forme troll
    SPELL_BRUTAL_SWIPE      = 42384,
    SPELL_MANGLE            = 42389,
    SPELL_SURGE             = 44019,

    // Forme d'ours
    SPELL_LACERATING_SLASH  = 42395,
    SPELL_REND_FLESH        = 42397,
    SPELL_DEAFENING_ROAR    = 42398,

    // Communs
    SPELL_SHAPE_OF_THE_BEAR = 42377,
    SPELL_BERSERK           = 45078
};

enum Events
{
    EVENT_BRUTAL_SWIPE      = 1,
    EVENT_MANGLE,
    EVENT_SURGE,

    EVENT_LACERATING_SLASH,
    EVENT_REND_FLESH,
    EVENT_DEAFENING_ROAR,

    EVENT_SHAPESHIFT,
    EVENT_BERSERK
};

class boss_nalorakk : public CreatureScript
{
    public:

        boss_nalorakk() : CreatureScript("boss_nalorakk") { }

        struct boss_nalorakkAI : public BossAI
        {
            boss_nalorakkAI(Creature* creature) : BossAI(creature, DATA_NALORAKK), _bearForm(false) { }

            void Reset() override
            {
                _Reset();
                _bearForm = false;
                me->RemoveAurasDueToSpell(SPELL_SHAPE_OF_THE_BEAR);
            }

            void EnterCombat(Unit* /*who*/) override
            {
                Talk(SAY_AGGRO);
                _EnterCombat();

                ScheduleTrollEvents();
                events.ScheduleEvent(EVENT_SHAPESHIFT, 45000);
                events.ScheduleEvent(EVENT_BERSERK, 600000);
            }

            void JustDied(Unit* /*killer*/) override
            {
                Talk(SAY_DEATH);
                _JustDied();
            }

            void KilledUnit(Unit* victim) override
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_PLAYER_KILL);
            }

            void ScheduleTrollEvents()
            {
                events.ScheduleEvent(EVENT_BRUTAL_SWIPE, urand(10000, 20000));
                events.ScheduleEvent(EVENT_MANGLE, urand(15000, 20000));
                events.ScheduleEvent(EVENT_SURGE, urand(20000, 25000));
            }

            void ScheduleBearEvents()
            {
                events.ScheduleEvent(EVENT_LACERATING_SLASH, urand(10000, 15000));
                events.ScheduleEvent(EVENT_REND_FLESH, urand(12000, 18000));
                events.ScheduleEvent(EVENT_DEAFENING_ROAR, urand(20000, 25000));
            }

            void CancelFormEvents()
            {
                events.CancelEvent(EVENT_BRUTAL_SWIPE);
                events.CancelEvent(EVENT_MANGLE);
                events.CancelEvent(EVENT_SURGE);
                events.CancelEvent(EVENT_LACERATING_SLASH);
                events.CancelEvent(EVENT_REND_FLESH);
                events.CancelEvent(EVENT_DEAFENING_ROAR);
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
                        case EVENT_BRUTAL_SWIPE:
                            DoCastVictim(SPELL_BRUTAL_SWIPE);
                            events.ScheduleEvent(EVENT_BRUTAL_SWIPE, urand(10000, 20000));
                            break;
                        case EVENT_MANGLE:
                            DoCastVictim(SPELL_MANGLE);
                            events.ScheduleEvent(EVENT_MANGLE, urand(15000, 20000));
                            break;
                        case EVENT_SURGE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankTargetSelector(me)))
                            {
                                Talk(SAY_SURGE);
                                Talk(EMOTE_SURGE, target);
                                DoCast(target, SPELL_SURGE);
                            }
                            events.ScheduleEvent(EVENT_SURGE, urand(20000, 25000));
                            break;
                        case EVENT_LACERATING_SLASH:
                            DoCastVictim(SPELL_LACERATING_SLASH);
                            events.ScheduleEvent(EVENT_LACERATING_SLASH, urand(10000, 15000));
                            break;
                        case EVENT_REND_FLESH:
                            DoCastVictim(SPELL_REND_FLESH);
                            events.ScheduleEvent(EVENT_REND_FLESH, urand(12000, 18000));
                            break;
                        case EVENT_DEAFENING_ROAR:
                            DoCast(me, SPELL_DEAFENING_ROAR);
                            events.ScheduleEvent(EVENT_DEAFENING_ROAR, urand(20000, 25000));
                            break;
                        case EVENT_SHAPESHIFT:
                            CancelFormEvents();
                            _bearForm = !_bearForm;

                            if (_bearForm)
                            {
                                Talk(SAY_BEAR);
                                Talk(EMOTE_BEAR);
                                DoCast(me, SPELL_SHAPE_OF_THE_BEAR);
                                ScheduleBearEvents();
                                events.ScheduleEvent(EVENT_SHAPESHIFT, 45000);
                            }
                            else
                            {
                                Talk(SAY_TROLL);
                                me->RemoveAurasDueToSpell(SPELL_SHAPE_OF_THE_BEAR);
                                ScheduleTrollEvents();
                                events.ScheduleEvent(EVENT_SHAPESHIFT, 45000);
                            }
                            break;
                        case EVENT_BERSERK:
                            DoCast(me, SPELL_BERSERK);
                            break;
                        default:
                            break;
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                        return;
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool _bearForm;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetZulAmanAI<boss_nalorakkAI>(creature);
        }
};

void AddSC_boss_nalorakk()
{
    new boss_nalorakk();
}
