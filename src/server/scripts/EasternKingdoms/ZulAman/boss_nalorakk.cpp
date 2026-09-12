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

// Nalorakk n'avait qu'une coquille de script : ni sorts, ni formes, ni les quatre
// vagues de trolls de la rampe.
//
// L'evenement suit AzerothCore, qui tient la meilleure version de ce contenu BC :
// le boss attend au pied de la rampe, lance sur les joueurs le groupe de trolls
// pose autour de lui, ATTEND QUE LA VAGUE SOIT MORTE, puis recule d'un palier en
// lancant « Make way for da Nalorakk! ». Il n'est attaquable qu'apres la quatrieme.
// Les deplacements passent par des positions en dur (reprises de l'ancien script
// TrinityCore) : ni spawn groups ni chemins de waypoints n'existent sur ce core.
//
// Numerotation des textes : celle de NOTRE creature_text (verifiee ligne a ligne),
// qui est l'ancienne numerotation BC et non celle des cores modernes.

#include "ScriptMgr.h"
#include "Creature.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
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
    SAY_SHIFT_TO_BEAR       = 9,
    SAY_MAKE_WAY            = 10,   // « Make way for da Nalorakk! » : il recule d'un palier
    SAY_DEATH               = 11
};

enum Spells
{
    // Forme troll
    SPELL_BRUTAL_SWIPE      = 42384,
    SPELL_MANGLE            = 42389,
    SPELL_SURGE             = 42402,

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

enum WaveCreatures
{
    NPC_AMANISHI_AXE_THROWER    = 23542,
    NPC_AMANISHI_WARBRINGER     = 23580,
    NPC_AMANISHI_MEDICINE_MAN   = 23581,
    NPC_AMANISHI_TRIBESMAN      = 23582
};

// Le chemin de la rampe. Les paliers ou il s'arrete pour lancer une vague sont
// 0, 1, 5 et 8 ; les autres points ne sont que des etapes de trajet.
static float const NalorakkWay[9][3] =
{
    {  18.569f, 1414.512f, 11.42f },    // palier 1
    { -17.264f, 1419.551f, 12.62f },    // palier 2
    { -52.642f, 1419.357f, 27.31f },
    { -69.908f, 1419.721f, 27.31f },
    { -79.929f, 1395.958f, 27.31f },
    { -80.072f, 1374.555f, 40.87f },    // palier 3
    { -80.072f, 1314.398f, 40.87f },
    { -80.072f, 1295.775f, 48.60f },
    { -80.072f, 1362.000f, 40.87f }     // palier 4
};

class boss_nalorakk : public CreatureScript
{
    public:

        boss_nalorakk() : CreatureScript("boss_nalorakk") { }

        struct boss_nalorakkAI : public BossAI
        {
            boss_nalorakkAI(Creature* creature) : BossAI(creature, DATA_NALORAKK),
                _bearForm(false), _waveEvent(true), _waveInProgress(false), _inMove(false),
                _wave(0), _currentPoint(0), _targetPoint(0), _checkTimer(0), _moveTimeout(0) { }

            void Reset() override
            {
                _Reset();
                _bearForm = false;
                me->RemoveAurasDueToSpell(SPELL_SHAPE_OF_THE_BEAR);

                if (!_waveEvent)
                    return;

                // Une fois l'evenement joue, il ne recommence pas : sans cela un simple
                // repli rendrait le boss intouchable pour de bon.
                _waveInProgress = false;
                _inMove = false;
                _wave = 0;
                _currentPoint = 0;
                _targetPoint = 0;
                _checkTimer = 0;
                _moveTimeout = 0;
                _waveGuids.clear();

                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetSpeedRate(MOVE_RUN, 2.0f);
                me->SetWalk(false);

                // Notre spawn est pose a la position finale du boss, en haut de la rampe :
                // on le remet au pied, sinon l'evenement se deroulerait a l'envers.
                me->NearTeleportTo(NalorakkWay[0][0], NalorakkWay[0][1], NalorakkWay[0][2], 3.14f);
                me->SetHomePosition(NalorakkWay[0][0], NalorakkWay[0][1], NalorakkWay[0][2], 3.14f);
            }

            // Tant que les vagues durent, il ne repond pas aux provocations.
            void AttackStart(Unit* who) override
            {
                if (!_waveEvent)
                    BossAI::AttackStart(who);
            }

            void GatherWave(uint32 entry, float radius)
            {
                std::list<Creature*> found;
                me->GetCreatureListWithEntryInGrid(found, entry, radius);
                for (Creature* creature : found)
                    if (creature->IsAlive())
                        _waveGuids.push_back(creature->GetGUID());
            }

            void LaunchWave(Unit* target)
            {
                _waveGuids.clear();

                switch (_wave)
                {
                    case 0:
                        GatherWave(NPC_AMANISHI_AXE_THROWER, 10.0f);
                        GatherWave(NPC_AMANISHI_TRIBESMAN, 10.0f);
                        break;
                    case 1:
                        GatherWave(NPC_AMANISHI_AXE_THROWER, 10.0f);
                        GatherWave(NPC_AMANISHI_TRIBESMAN, 10.0f);
                        GatherWave(NPC_AMANISHI_MEDICINE_MAN, 10.0f);
                        break;
                    case 2:
                        GatherWave(NPC_AMANISHI_WARBRINGER, 10.0f);
                        break;
                    case 3:
                        GatherWave(NPC_AMANISHI_WARBRINGER, 25.0f);
                        GatherWave(NPC_AMANISHI_MEDICINE_MAN, 25.0f);
                        break;
                    default:
                        break;
                }

                Talk(uint8(SAY_WAVE_1 + _wave));

                for (ObjectGuid const& guid : _waveGuids)
                    if (Creature* member = ObjectAccessor::GetCreature(*me, guid))
                    {
                        member->SetNoCallAssistance(true);
                        member->AI()->AttackStart(target);
                    }

                // La quatrieme vague est la derniere : il descend dans l'arene.
                if (_wave == 3)
                {
                    EndWaveEvent();
                    return;
                }

                _waveInProgress = true;
                _checkTimer = 2000;
            }

            bool WaveIsDead() const
            {
                for (ObjectGuid const& guid : _waveGuids)
                    if (Creature* member = ObjectAccessor::GetCreature(*me, guid))
                        if (member->IsAlive())
                            return false;

                return true;
            }

            // Fin de l'evenement : il redevient un boss ordinaire. Appele aussi en filet
            // de securite si un joueur lui arrive au contact, parce qu'une immunite
            // d'introduction qui ne se leve jamais rend un boss definitivement intuable.
            void EndWaveEvent()
            {
                if (!_waveEvent)
                    return;

                _waveEvent = false;
                _waveInProgress = false;
                _inMove = false;
                _waveGuids.clear();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            }

            void MoveInLineOfSight(Unit* who) override
            {
                if (!_waveEvent)
                {
                    BossAI::MoveInLineOfSight(who);
                    return;
                }

                if (who->GetTypeId() != TYPEID_PLAYER || !me->IsHostileTo(who) || !who->IsAlive())
                    return;

                if (me->IsWithinDistInMap(who, 8.0f))
                {
                    EndWaveEvent();
                    return;
                }

                if (_waveInProgress || _inMove)
                    return;

                float const range = (_wave == 0 || _wave == 3) ? 50.0f : 40.0f;
                if (me->IsWithinDistInMap(who, range))
                    LaunchWave(who);
            }

            void MoveToNextStop()
            {
                Talk(SAY_MAKE_WAY);

                _waveInProgress = false;
                _inMove = true;
                ++_wave;

                switch (_wave)
                {
                    case 1: _targetPoint = 1; break;
                    case 2: _targetPoint = 5; break;
                    case 3: _targetPoint = 8; break;
                    default: _targetPoint = _currentPoint; break;
                }

                AdvanceOnePoint();
            }

            void AdvanceOnePoint()
            {
                uint32 next = (_currentPoint < 7 && _targetPoint != 8) ? _currentPoint + 1
                            : (_targetPoint == 8 ? 8 : _targetPoint);

                _currentPoint = next;
                _moveTimeout = 20000;
                me->GetMotionMaster()->MovePoint(_currentPoint, NalorakkWay[_currentPoint][0], NalorakkWay[_currentPoint][1], NalorakkWay[_currentPoint][2]);
            }

            // Arrivee a une etape -- soit annoncee par le moteur de deplacement, soit
            // forcee par le chrono ci-dessous quand la montee se bloque.
            void OnReachedPoint()
            {
                _moveTimeout = 0;

                if (_currentPoint == _targetPoint)
                {
                    _inMove = false;
                    me->SetFacingTo(float(M_PI) * 0.5f);
                    return;
                }

                AdvanceOnePoint();
            }

            void MovementInform(uint32 type, uint32 id) override
            {
                if (!_waveEvent || type != POINT_MOTION_TYPE || !_inMove || _currentPoint != id)
                    return;

                OnReachedPoint();
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
                events.ScheduleEvent(EVENT_BRUTAL_SWIPE, urand(7000, 12000));
                events.ScheduleEvent(EVENT_MANGLE, urand(10000, 15000));
                events.ScheduleEvent(EVENT_SURGE, urand(15000, 20000));
            }

            void ScheduleBearEvents()
            {
                events.ScheduleEvent(EVENT_LACERATING_SLASH, 2000);
                events.ScheduleEvent(EVENT_REND_FLESH, 3000);
                events.ScheduleEvent(EVENT_DEAFENING_ROAR, urand(5000, 10000));
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
                // Le trajet entre deux paliers passe par un escalier bati en VMAP : si le
                // calcul de chemin cale, le boss reste plante en route et l'evenement ne
                // repart jamais. Au-dela de vingt secondes on le pose d'office sur l'etape.
                if (_inMove && _moveTimeout)
                {
                    if (_moveTimeout <= diff)
                    {
                        me->GetMotionMaster()->Clear(false);
                        me->NearTeleportTo(NalorakkWay[_currentPoint][0], NalorakkWay[_currentPoint][1], NalorakkWay[_currentPoint][2], me->GetOrientation());
                        OnReachedPoint();
                    }
                    else
                        _moveTimeout -= diff;
                }

                // Deroulement des vagues : il ne recule qu'une fois la vague abattue.
                if (_waveInProgress)
                {
                    if (_checkTimer <= diff)
                    {
                        if (WaveIsDead())
                            MoveToNextStop();
                        else
                            _checkTimer = 2000;
                    }
                    else
                        _checkTimer -= diff;
                }

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
                            events.ScheduleEvent(EVENT_BRUTAL_SWIPE, urand(7000, 12000));
                            break;
                        case EVENT_MANGLE:
                            DoCastVictim(SPELL_MANGLE);
                            events.ScheduleEvent(EVENT_MANGLE, urand(10000, 15000));
                            break;
                        case EVENT_SURGE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankTargetSelector(me)))
                            {
                                Talk(SAY_SURGE);
                                Talk(EMOTE_SURGE, target);
                                DoCast(target, SPELL_SURGE);
                            }
                            events.ScheduleEvent(EVENT_SURGE, urand(15000, 20000));
                            break;
                        case EVENT_LACERATING_SLASH:
                            DoCastVictim(SPELL_LACERATING_SLASH);
                            events.ScheduleEvent(EVENT_LACERATING_SLASH, urand(18000, 22000));
                            break;
                        case EVENT_REND_FLESH:
                            DoCastVictim(SPELL_REND_FLESH);
                            events.ScheduleEvent(EVENT_REND_FLESH, urand(10000, 15000));
                            break;
                        case EVENT_DEAFENING_ROAR:
                            DoCast(me, SPELL_DEAFENING_ROAR);
                            events.ScheduleEvent(EVENT_DEAFENING_ROAR, urand(10000, 15000));
                            break;
                        case EVENT_SHAPESHIFT:
                            CancelFormEvents();
                            _bearForm = !_bearForm;

                            if (_bearForm)
                            {
                                Talk(SAY_SHIFT_TO_BEAR);
                                Talk(EMOTE_BEAR);
                                DoCast(me, SPELL_SHAPE_OF_THE_BEAR);
                                ScheduleBearEvents();
                                events.ScheduleEvent(EVENT_SHAPESHIFT, urand(20000, 25000));
                            }
                            else
                            {
                                me->RemoveAurasDueToSpell(SPELL_SHAPE_OF_THE_BEAR);
                                ScheduleTrollEvents();
                                events.ScheduleEvent(EVENT_SHAPESHIFT, urand(45000, 50000));
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
            bool _waveEvent;
            bool _waveInProgress;
            bool _inMove;
            uint32 _wave;
            uint32 _currentPoint;
            uint32 _targetPoint;
            uint32 _checkTimer;
            uint32 _moveTimeout;
            std::vector<ObjectGuid> _waveGuids;
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
