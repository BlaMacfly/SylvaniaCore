/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Boss_Headless_Horseman
SD%Complete:
SDComment:
SDCategory: Scarlet Monastery
EndScriptData */

#include "ScriptMgr.h"
#include "GameObject.h"
#include "Group.h"
#include "InstanceScript.h"
#include "LFGMgr.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "scarlet_monastery.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"

//this texts are already used by 3975 and 3976
enum Says
{
    SAY_LOST_HEAD               = 0,
    SAY_PLAYER_DEATH            = 1,

    SAY_ENTRANCE                = 0,
    SAY_REJOINED                = 1,
    SAY_CONFLAGRATION           = 2,
    SAY_SPROUTING_PUMPKINS      = 3,
    SAY_DEATH                   = 4,
};

uint32 RandomLaugh[] = {11965, 11975, 11976};

enum Entry
{
    HH_MOUNTED                  = 23682,
    HH_DISMOUNTED               = 23800,
    HEAD                        = 23775,
    PULSING_PUMPKIN             = 23694,
    PUMPKIN_FIEND               = 23545,
    HELPER                      = 23686,
    WISP_INVIS                  = 24034
};

enum Spells
{
    SPELL_CLEAVE                = 42587,
    SPELL_CONFLAGRATION         = 42380,       //Phase 2, can't find real spell(Dim Fire?)
 // SPELL_CONFL_SPEED           = 22587,       //8% increase speed, value 22587 from SPELL_CONFLAGRATION mains that spell?
    SPELL_SUMMON_PUMPKIN        = 42394,

    SPELL_WHIRLWIND             = 43116,
    SPELL_IMMUNE                = 42556,
    SPELL_BODY_REGEN            = 42403,
    SPELL_CONFUSE               = 43105,

    SPELL_FLYING_HEAD           = 42399,       //visual flying head
    SPELL_HEAD                  = 42413,       //visual buff, "head"
    SPELL_HEAD_IS_DEAD          = 42428,       //at killing head, Phase 3

    SPELL_PUMPKIN_AURA          = 42280,
    SPELL_PUMPKIN_AURA_GREEN    = 42294,
    SPELL_SQUASH_SOUL           = 42514,
    SPELL_SPROUTING             = 42281,
    SPELL_SPROUT_BODY           = 42285,

    //Effects
    SPELL_RHYME_BIG             = 42909,
 // SPELL_RHYME_SMALL           = 42910,
    SPELL_HEAD_SPEAKS           = 43129,
    SPELL_HEAD_LANDS            = 42400,
    SPELL_BODY_FLAME            = 42074,
    SPELL_HEAD_FLAME            = 42971,
 // SPELL_ENRAGE_VISUAL         = 42438,       // he uses this spell?
    SPELL_WISP_BLUE             = 42821,
    SPELL_WISP_FLIGHT_PORT      = 42818,
 // SPELL_WISP_INVIS            = 42823,
    SPELL_SMOKE                 = 42355,
    SPELL_DEATH                 = 42566       //not correct spell
};

// Positions de la carte 1004 (Monastere ecarlate refait a MoP) : le donjon d'evenement 285 s'y joue
// en 7.x. Les anciennes etaient celles du vieux Cimetiere (carte 189) et faisaient voler le Cavalier
// dans le vide (signalement du 24/10/2026). Trajet = parcours de LegionCore-Reforged (waypoint 23682 :
// monticule -> 1094 606 -> 1108 620 -> 1096 634 -> atterrissage 1086.24 627.44), interpole sur les 21
// points qu'attend MovementInform (actions aux points 0, 1, 6, 19 et 20).
Position const FlightPoint[]=
{
    {1089.40f, 612.17f, 3.00f},
    {1090.83f, 610.25f, 5.18f},
    {1092.27f, 608.32f, 7.36f},
    {1093.70f, 606.40f, 9.54f},
    {1095.80f, 607.80f, 10.26f},
    {1098.08f, 610.08f, 10.58f},
    {1100.36f, 612.36f, 10.91f},
    {1102.65f, 614.65f, 11.24f},
    {1104.93f, 616.93f, 11.56f},
    {1107.21f, 619.21f, 11.89f},
    {1106.66f, 621.57f, 11.55f},
    {1104.59f, 623.97f, 10.86f},
    {1102.53f, 626.38f, 10.18f},
    {1100.47f, 628.78f, 9.49f},
    {1098.41f, 631.19f, 8.80f},
    {1096.35f, 633.60f, 8.12f},
    {1093.88f, 632.58f, 7.13f},
    {1091.33f, 630.86f, 6.09f},
    {1088.79f, 629.15f, 5.04f},
    {1086.24f, 627.44f, 4.00f},
    {1086.24f, 627.44f, -0.05f}
};

Position const Spawn[]=
{
    {1105.11f, 610.36f, -0.43f},        //spawn point for pumpkin shrine mob (flammes, LegionCore)
    {1088.97f, 611.83f, 0.07f}          //spawn point for smoke (monticule 186314)
};

static char const* Text[]=
{
    "Horseman rise...",
    "Your time is nigh...",
    "You felt death once...",
    "Now, know demise!"
};

class npc_wisp_invis : public CreatureScript
{
public:
    npc_wisp_invis() : CreatureScript("npc_wisp_invis") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_wisp_invisAI>(creature);
    }

    struct npc_wisp_invisAI : public ScriptedAI
    {
        npc_wisp_invisAI(Creature* creature) : ScriptedAI(creature)
        {
            Creaturetype = delay = _spell = _spell2 = 0;
        }

        uint32 Creaturetype;
        uint32 delay;
        uint32 _spell;
        uint32 _spell2;
        void Reset() override { }
        void EnterCombat(Unit* /*who*/) override { }
        void SetType(uint32 _type)
        {
            switch (Creaturetype = _type)
            {
                case 1:
                    _spell = SPELL_PUMPKIN_AURA_GREEN;
                    break;
                case 2:
                    delay = 15000;
                    _spell = SPELL_BODY_FLAME;
                    _spell2 = SPELL_DEATH;
                    break;
                case 3:
                    delay = 15000;
                    _spell = SPELL_SMOKE;
                    break;
                case 4:
                    delay = 7000;
                    _spell2 = SPELL_WISP_BLUE;
                    break;
            }
            if (_spell)
                DoCast(me, _spell);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell) override
        {
            if (spell->Id == SPELL_WISP_FLIGHT_PORT && Creaturetype == 4)
                me->SetDisplayId(2027);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who || Creaturetype != 1 || !who->isTargetableForAttack())
                return;

            if (me->IsWithinDist(who, 0.1f, false) && !who->HasAura(SPELL_SQUASH_SOUL))
                DoCast(who, SPELL_SQUASH_SOUL);
        }

        void UpdateAI(uint32 diff) override
        {
            if (delay)
            {
                if (delay <= diff)
                {
                    me->RemoveAurasDueToSpell(SPELL_SMOKE);
                    if (_spell2)
                        DoCast(me, _spell2);
                    delay = 0;
                } else delay -= diff;
            }
        }
    };
};

class npc_head : public CreatureScript
{
public:
    npc_head() : CreatureScript("npc_head") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_headAI>(creature);
    }

    struct npc_headAI : public ScriptedAI
    {
        npc_headAI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            Phase = 0;
            bodyGUID.Clear();
            die = false;
            withbody = true;
            wait = 1000;
            laugh = urand(15000, 30000);
        }

        ObjectGuid bodyGUID;

        uint32 Phase;
        uint32 laugh;
        uint32 wait;

        bool withbody;
        bool die;

        void Reset() override
        {
            Initialize();
        }

        void EnterCombat(Unit* /*who*/) override { }

        void SaySound(uint8 textEntry, Unit* target = 0)
        {
            Talk(textEntry, target);

            //DoCast(me, SPELL_HEAD_SPEAKS, true);
            if (Creature* speaker = DoSpawnCreature(HELPER, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 1000))
                speaker->CastSpell(speaker, SPELL_HEAD_SPEAKS, false);
            laugh += 3000;
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage) override
        {
            if (withbody)
                return;

            switch (Phase)
            {
                case 1:
                    if (me->HealthBelowPctDamaged(67, damage))
                        Disappear();
                    break;
                case 2:
                    if (me->HealthBelowPctDamaged(34, damage))
                        Disappear();
                    break;
                case 3:
                    if (damage >= me->GetHealth())
                    {
                        die = true;
                        withbody = true;
                        wait = 300;
                        damage = me->GetHealth() - me->CountPctFromMaxHealth(1);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        me->StopMoving();
                        //me->GetMotionMaster()->MoveIdle();
                        DoCast(me, SPELL_HEAD_IS_DEAD);
                    }
                    break;
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) override
        {
            if (!withbody)
                return;

            if (spell->Id == SPELL_FLYING_HEAD)
            {
                if (Phase < 3)
                    ++Phase;
                else
                    Phase = 3;

                withbody = false;
                if (!bodyGUID)
                    bodyGUID = caster->GetGUID();
                me->RemoveAllAuras();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                DoCast(me, SPELL_HEAD_LANDS, true);
                DoCast(me, SPELL_HEAD, false);
                SaySound(SAY_LOST_HEAD);
                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MoveFleeing(caster->GetVictim());
            }
        }

        void Disappear();
        void UpdateAI(uint32 diff) override
        {
            if (!withbody)
            {
                if (wait <= diff)
                {
                    wait = 1000;
                    if (!me->GetVictim())
                        return;
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveFleeing(me->GetVictim());
                }
                else wait -= diff;

                if (laugh <= diff)
                {
                    laugh = urand(15000, 30000);
                    DoPlaySoundToSet(me, RandomLaugh[urand(0, 2)]);
                    //DoCast(me, SPELL_HEAD_SPEAKS, true); //this spell remove buff "head"
                    Creature* speaker = DoSpawnCreature(HELPER, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 1000);
                    if (speaker)
                        speaker->CastSpell(speaker, SPELL_HEAD_SPEAKS, false);
                }
                else laugh -= diff;
            }
            else
            {
                if (die)
                {
                    if (wait <= diff)
                    {
                        die = false;
                        if (Unit* body = ObjectAccessor::GetUnit(*me, bodyGUID))
                            body->KillSelf();
                        me->KillSelf();
                    }
                    else wait -= diff;
                }
            }
        }
    };
};

class boss_headless_horseman : public CreatureScript
{
public:
    boss_headless_horseman() : CreatureScript("boss_headless_horseman") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_headless_horsemanAI>(creature);
    }

    struct boss_headless_horsemanAI : public ScriptedAI
    {
        boss_headless_horsemanAI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
            instance = creature->GetInstanceScript();
            id = 0;
            whirlwind = 0;
            wp_reached = false;
        }

        void Initialize()
        {
            Phase = 1;
            conflagrate = 15000;
            summonadds = 15000;
            laugh = urand(16000, 20000);
            cleave = 2000;
            regen = 1000;
            burn = 6000;
            count = 0;
            say_timer = 3000;

            withhead = true;
            returned = true;
            burned = false;
            IsFlying = false;
        }

        InstanceScript* instance;

        ObjectGuid headGUID;
        ObjectGuid PlayerGUID;

        uint32 Phase;
        uint32 id;
        uint32 count;
        uint32 say_timer;

        uint32 conflagrate;
        uint32 summonadds;
        uint32 cleave;
        uint32 regen;
        uint32 whirlwind;
        uint32 laugh;
        uint32 burn;

        bool withhead;
        bool returned;
        bool IsFlying;
        bool wp_reached;
        bool burned;

        void Reset() override
        {
            Initialize();
            DoCast(me, SPELL_HEAD);
            if (!headGUID.IsEmpty())
            {
                if (Creature* Head = ObjectAccessor::GetCreature((*me), headGUID))
                    Head->DespawnOrUnsummon();

                headGUID.Clear();
            }

            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            //instance->SetBossState(DATA_HORSEMAN_EVENT, NOT_STARTED);
        }

        void FlyMode()
        {
            me->SetVisible(false);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetDisableGravity(true);
            me->SetSpeedRate(MOVE_WALK, 5.0f);
            wp_reached = false;
            count = 0;
            say_timer = 3000;
            id = 0;
            Phase = 0;
        }

        void MovementInform(uint32 type, uint32 i) override
        {
            if (type != POINT_MOTION_TYPE || !IsFlying || i != id)
                return;

            wp_reached = true;

            switch (id)
            {
                case 0:
                    me->SetVisible(true);
                    break;
                case 1:
                {
                    if (Creature* smoke = me->SummonCreature(HELPER, Spawn[1], TEMPSUMMON_TIMED_DESPAWN, 20000))
                        ENSURE_AI(npc_wisp_invis::npc_wisp_invisAI, smoke->AI())->SetType(3);
                    DoCast(me, SPELL_RHYME_BIG);
                    break;
                }
                case 6:
                    instance->SetData(DATA_PUMPKIN_SHRINE, 0);   //hide gameobject
                    break;
                case 19:
                    me->SetDisableGravity(false);
                    break;
                case 20:
                {
                    Phase = 1;
                    IsFlying = false;
                    wp_reached = false;
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    SaySound(SAY_ENTRANCE);
                    if (Unit* player = ObjectAccessor::GetUnit(*me, PlayerGUID))
                        DoStartMovement(player);
                    break;
                }
            }
            ++id;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            instance->SetBossState(DATA_HORSEMAN_EVENT, IN_PROGRESS);
            DoZoneInCombat();
        }

        void AttackStart(Unit* who) override
        {
            ScriptedAI::AttackStart(who);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (withhead && Phase != 0)
                ScriptedAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit* player) override
        {
            if (player->GetTypeId() == TYPEID_PLAYER)
            {
                if (withhead)
                    SaySound(SAY_PLAYER_DEATH);
                //maybe possible when player dies from conflagration
                else if (Creature* Head = ObjectAccessor::GetCreature((*me), headGUID))
                    ENSURE_AI(npc_head::npc_headAI, Head->AI())->SaySound(SAY_PLAYER_DEATH);
            }
        }

        void SaySound(uint8 textEntry, Unit* target = 0)
        {
            Talk(textEntry, target);
            laugh += 4000;
        }

        Player* SelectRandomPlayer(float range = 0.0f, bool checkLoS = true)
        {
            Map::PlayerList const &PlayerList = me->GetMap()->GetPlayers();
            if (PlayerList.isEmpty())
                return NULL;

            std::list<Player*> temp;
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                if ((me->IsWithinLOSInMap(i->GetSource()) || !checkLoS) && me->GetVictim() != i->GetSource() &&
                    me->IsWithinDistInMap(i->GetSource(), range) && i->GetSource()->IsAlive())
                    temp.push_back(i->GetSource());

            if (!temp.empty())
            {
                std::list<Player*>::const_iterator j = temp.begin();
                advance(j, rand32() % temp.size());
                return (*j);
            }
            return NULL;
        }

        void SpellHitTarget(Unit* unit, const SpellInfo* spell) override
        {
            if (spell->Id == SPELL_CONFLAGRATION && unit->HasAura(SPELL_CONFLAGRATION))
                SaySound(SAY_CONFLAGRATION, unit);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->StopMoving();
            //me->GetMotionMaster()->MoveIdle();
            SaySound(SAY_DEATH);
            if (Creature* flame = DoSpawnCreature(HELPER, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 60000))
                flame->CastSpell(flame, SPELL_BODY_FLAME, false);
            if (Creature* wisp = DoSpawnCreature(WISP_INVIS, 0, 0, 0, 0, TEMPSUMMON_TIMED_DESPAWN, 60000))
                ENSURE_AI(npc_wisp_invis::npc_wisp_invisAI, wisp->AI())->SetType(4);
            instance->SetBossState(DATA_HORSEMAN_EVENT, DONE);

            Map::PlayerList const& players = me->GetMap()->GetPlayers();
            if (!players.isEmpty())
            {
                if (Group* group = players.begin()->GetSource()->GetGroup())
                    if (group->isLFGGroup())
                        sLFGMgr->FinishDungeon(group->GetGUID(), 285);
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) override
        {
            if (withhead)
                return;

            if (spell->Id == SPELL_FLYING_HEAD)
            {
                if (Phase < 3)
                    ++Phase;
                else
                    Phase = 3;
                withhead = true;
                me->RemoveAllAuras();
                me->SetName("Headless Horseman");
                me->SetFullHealth();
                SaySound(SAY_REJOINED);
                DoCast(me, SPELL_HEAD);
                caster->GetMotionMaster()->Clear(false);
                caster->GetMotionMaster()->MoveFollow(me, 6, float(urand(0, 5)));
                //DoResetThreat();//not sure if need
                ThreatContainer::StorageType threatlist = caster->getThreatManager().getThreatList();
                for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
                {
                    Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
                    if (unit && unit->IsAlive() && unit != caster)
                        me->AddThreat(unit, caster->getThreatManager().getThreat(unit));
                }
            }
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage) override
        {
            if (damage >= me->GetHealth() && withhead)
            {
                withhead = false;
                returned = false;
                damage = me->GetHealth() - me->CountPctFromMaxHealth(1);
                me->RemoveAllAuras();
                me->SetName("Headless Horseman, Unhorsed");

                if (!headGUID)
                    headGUID = DoSpawnCreature(HEAD, float(rand32() % 6), float(rand32() % 6), 0, 0, TEMPSUMMON_DEAD_DESPAWN, 0)->GetGUID();

                Unit* Head = ObjectAccessor::GetUnit(*me, headGUID);
                if (Head && Head->IsAlive())
                {
                    Head->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    //Head->CastSpell(Head, SPELL_HEAD_INVIS, false);
                    me->InterruptNonMeleeSpells(false);
                    DoCast(me, SPELL_IMMUNE, true);
                    DoCast(me, SPELL_BODY_REGEN, true);
                    DoCast(Head, SPELL_FLYING_HEAD, true);
                    DoCast(me, SPELL_CONFUSE, false);                     //test
                    whirlwind = urand(4000, 8000);
                    regen = 0;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (withhead)
            {
                switch (Phase)
                {
                    case 0:
                    {
                        if (!IsFlying)
                        {
                            if (say_timer <= diff)
                            {
                                say_timer = 3000;
                                Player* player = SelectRandomPlayer(100.0f, false);
                                if (count < 3)
                                {
                                    if (player)
                                        player->Say(Text[count], LANG_UNIVERSAL);
                                }
                                else
                                {
                                    DoCast(me, SPELL_RHYME_BIG);
                                    if (player)
                                    {
                                        player->Say(Text[count], LANG_UNIVERSAL);
                                        player->HandleEmoteCommand(ANIM_EMOTE_SHOUT);
                                    }
                                    wp_reached = true;
                                    IsFlying = true;
                                    count = 0;
                                    break;
                                }
                                ++count;
                            }
                            else say_timer -= diff;
                        }
                        else
                        {
                            if (wp_reached)
                            {
                                wp_reached = false;
                                me->GetMotionMaster()->Clear(false);
                                me->GetMotionMaster()->MovePoint(id, FlightPoint[id]);
                            }
                        }
                    }
                    break;
                    case 1:
                        if (burned)
                            break;
                        if (burn <= diff)
                        {
                            if (Creature* flame = me->SummonCreature(HELPER, Spawn[0], TEMPSUMMON_TIMED_DESPAWN, 17000))
                                ENSURE_AI(npc_wisp_invis::npc_wisp_invisAI, flame->AI())->SetType(2);
                            burned = true;
                        }
                        else burn -= diff;
                        break;
                    case 2:
                        if (conflagrate <= diff)
                        {
                            if (Unit* player = SelectRandomPlayer(30.0f))
                                DoCast(player, SPELL_CONFLAGRATION, false);
                            conflagrate = urand(10000, 16000);
                        }
                        else conflagrate -= diff;
                        break;
                    case 3:
                        if (summonadds <= diff)
                        {
                            me->InterruptNonMeleeSpells(false);
                            DoCast(me, SPELL_SUMMON_PUMPKIN);
                            SaySound(SAY_SPROUTING_PUMPKINS);
                            summonadds = urand(25000, 35000);
                        }
                        else summonadds -= diff;
                        break;
                }

                if (laugh <= diff)
                {
                    laugh = urand(11000, 22000);
                    DoPlaySoundToSet(me, RandomLaugh[rand32() % 3]);
                }
                else laugh -= diff;

                if (UpdateVictim())
                {
                    DoMeleeAttackIfReady();
                    if (cleave <= diff)
                    {
                        DoCastVictim(SPELL_CLEAVE);
                        cleave = urand(2000, 6000);       //1 cleave per 2.0f-6.0fsec
                    }
                    else cleave -= diff;
                }
            }
            else
            {
                if (regen <= diff)
                {
                    regen = 1000;                   //"body calls head"
                    if (me->IsFullHealth() && !returned)
                    {
                        if (Phase > 1)
                            --Phase;
                        else
                            Phase = 1;
                        Creature* Head = ObjectAccessor::GetCreature((*me), headGUID);
                        if (Head && Head->IsAlive())
                        {
                            ENSURE_AI(npc_head::npc_headAI, Head->AI())->Phase = Phase;
                            ENSURE_AI(npc_head::npc_headAI, Head->AI())->Disappear();
                        }
                        return;
                    }
                }
                else regen -= diff;

                if (whirlwind <= diff)
                {
                    whirlwind = urand(4000, 8000);
                    if (urand(0, 1))
                    {
                        me->RemoveAurasDueToSpell(SPELL_CONFUSE);
                        DoCast(me, SPELL_WHIRLWIND, true);
                        DoCast(me, SPELL_CONFUSE);
                    }
                    else
                        me->RemoveAurasDueToSpell(SPELL_WHIRLWIND);
                }
                else whirlwind -= diff;
            }
        }
    };
};

class npc_pulsing_pumpkin : public CreatureScript
{
public:
    npc_pulsing_pumpkin() : CreatureScript("npc_pulsing_pumpkin") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_pulsing_pumpkinAI>(creature);
    }

    struct npc_pulsing_pumpkinAI : public ScriptedAI
    {
        npc_pulsing_pumpkinAI(Creature* creature) : ScriptedAI(creature)
        {
            sprouted = false;
        }

        bool sprouted;
        ObjectGuid debuffGUID;

        void Reset() override
        {
            float x, y, z;
            me->GetPosition(x, y, z);   //this visual aura some under ground
            me->SetPosition(x, y, z + 0.35f, 0.0f);
            debuffGUID.Clear();
            Despawn();
            Creature* debuff = DoSpawnCreature(HELPER, 0, 0, 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 14500);
            if (debuff)
            {
                debuff->SetDisplayId(me->GetDisplayId());
                debuff->CastSpell(debuff, SPELL_PUMPKIN_AURA_GREEN, false);
                ENSURE_AI(npc_wisp_invis::npc_wisp_invisAI, debuff->AI())->SetType(1);
                debuffGUID = debuff->GetGUID();
            }
            sprouted = false;
            DoCast(me, SPELL_PUMPKIN_AURA, true);
            DoCast(me, SPELL_SPROUTING);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
        }

        void EnterCombat(Unit* /*who*/) override { }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell) override
        {
            if (spell->Id == SPELL_SPROUTING)
            {
                sprouted = true;
                me->RemoveAllAuras();
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED);
                DoCast(me, SPELL_SPROUT_BODY, true);
                me->UpdateEntry(PUMPKIN_FIEND);
                DoStartMovement(me->GetVictim());
            }
        }

        void Despawn()
        {
            if (!debuffGUID)
                return;

            Unit* debuff = ObjectAccessor::GetUnit(*me, debuffGUID);
            if (debuff)
            {
                debuff->SetVisible(false);
                debuffGUID.Clear();
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (!sprouted)
                Despawn();
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who || !me->IsValidAttackTarget(who) || me->GetVictim())
                return;

            me->AddThreat(who, 0.0f);
            if (sprouted)
                DoStartMovement(who);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (sprouted && UpdateVictim())
                DoMeleeAttackIfReady();
        }
    };
};

enum LooselyTurnedSoil
{
    QUEST_CALL_THE_HEADLESS_HORSEMAN = 11405
};

class go_loosely_turned_soil : public GameObjectScript
{
public:
    go_loosely_turned_soil() : GameObjectScript("go_loosely_turned_soil") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        InstanceScript* instance = player->GetInstanceScript();

        // Donjon d'evenement de la recherche de groupe (difficulte 19) : personne n'y donne la quete
        // d'appel, le monticule appelle donc le Cavalier lui-meme (comme LegionCore-Reforged).
        if (instance && go->GetMap()->GetDifficultyID() == DIFFICULTY_EVENT_DUNGEON)
        {
            if (instance->GetBossState(DATA_HORSEMAN_EVENT) == IN_PROGRESS || instance->GetBossState(DATA_HORSEMAN_EVENT) == DONE)
                return true;

            if (go->FindNearestCreature(HH_MOUNTED, 200.0f))
                return true;

            SummonHorseman(player, go);
            return true;
        }

        if (instance)
            if (instance->GetBossState(DATA_HORSEMAN_EVENT) == IN_PROGRESS || player->GetQuestStatus(QUEST_CALL_THE_HEADLESS_HORSEMAN) != QUEST_STATUS_COMPLETE)
                return true;

        return false;
    }

    static void SummonHorseman(Player* player, GameObject* go)
    {
        player->AreaExploredOrEventHappens(11405);
        if (Creature* horseman = go->SummonCreature(HH_MOUNTED, FlightPoint[20], TEMPSUMMON_MANUAL_DESPAWN, 0))
        {
            ENSURE_AI(boss_headless_horseman::boss_headless_horsemanAI, horseman->AI())->PlayerGUID = player->GetGUID();
            ENSURE_AI(boss_headless_horseman::boss_headless_horsemanAI, horseman->AI())->FlyMode();
        }
    }

    bool OnQuestReward(Player* player, GameObject* go, Quest const* /*quest*/, uint32 /*opt*/) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            if (instance->GetBossState(DATA_HORSEMAN_EVENT) == IN_PROGRESS)
                return false;

        SummonHorseman(player, go);
        return true;
    }
};

void npc_head::npc_headAI::Disappear()
{
    if (withbody)
        return;

    if (!bodyGUID.IsEmpty())
    {
        Creature* body = ObjectAccessor::GetCreature((*me), bodyGUID);
        if (body && body->IsAlive())
        {
            withbody = true;
            me->RemoveAllAuras();
            body->RemoveAurasDueToSpell(SPELL_IMMUNE);//hack, SpellHit doesn't calls if body has immune aura
            DoCast(body, SPELL_FLYING_HEAD);
            me->SetFullHealth();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->GetMotionMaster()->MoveIdle();
            ENSURE_AI(boss_headless_horseman::boss_headless_horsemanAI, body->AI())->returned = true;
        }
    }
}

void AddSC_boss_headless_horseman()
{
    new boss_headless_horseman();
    new npc_head();
    new npc_pulsing_pumpkin();
    new npc_wisp_invis();
    new go_loosely_turned_soil();
}
