/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
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
#include "CreatureTextMgr.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "zulaman.h"

enum Says
{
    // Vol'jin
    SAY_INTRO_1                 = 0,
    SAY_INTRO_2                 = 1,
    SAY_INTRO_3                 = 2,
    SAY_INTRO_4                 = 3,
    SAY_INTRO_FAIL              = 4,

    // Hex Lord Malacrass
    SAY_HEXLOR_INTRO            = 0
};

enum Spells
{
    // Vol'jin
    SPELL_BANGING_THE_GONG      = 45225
};

enum Events
{
    EVENT_INTRO_MOVEPOINT_1     = 1,
    EVENT_INTRO_MOVEPOINT_2     = 2,
    EVENT_INTRO_MOVEPOINT_3     = 3,
    EVENT_BANGING_THE_GONG      = 4,
    EVENT_START_DOOR_OPENING_1  = 5,
    EVENT_START_DOOR_OPENING_2  = 6,
    EVENT_START_DOOR_OPENING_3  = 7,
    EVENT_START_DOOR_OPENING_4  = 8,
    EVENT_START_DOOR_OPENING_5  = 9,
    EVENT_START_DOOR_OPENING_6  = 10,
    EVENT_START_DOOR_OPENING_7  = 11
};

enum Points
{
    POINT_INTRO                 = 1,
    POINT_STRANGE_GONG          = 2,
    POINT_START_DOOR_OPENING_1  = 3,
    POINT_START_DOOR_OPENING_2  = 4
};

enum Misc
{
    ITEM_VIRTUAL_ITEM           = 5301
};

Position const VoljinIntroWaypoint[4] =
{
    { 117.7349f, 1662.77f, 42.02156f, 0.0f },
    { 132.14f, 1645.143f, 42.02158f, 0.0f },
    { 121.8901f, 1639.118f, 42.23253f, 0.0f },
    { 122.618f, 1639.546f, 42.11659f, 0.0f },
};

class npc_voljin_zulaman : public CreatureScript
{
    public:
        npc_voljin_zulaman() : CreatureScript("npc_voljin_zulaman") { }

        struct npc_voljin_zulamanAI : public ScriptedAI
        {
            npc_voljin_zulamanAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
            {
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid1);
                if (_instance->GetData(DATA_ZULAMAN_STATE) == NOT_STARTED)
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            void Reset() override
            {
                _gongCount = 0;
            }

            void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
            {
                if (_instance->GetData(DATA_ZULAMAN_STATE) != NOT_STARTED)
                    return;

                if (me->GetCreatureTemplate()->GossipMenuId == menuId && !gossipListId)
                {
                    _events.Reset();
                    me->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    me->SetUInt32Value(OBJECT_DYNAMIC_FLAGS, UNIT_DYNFLAG_NONE);
                    _events.ScheduleEvent(EVENT_INTRO_MOVEPOINT_1, 1000);
                    Talk(SAY_INTRO_1, player);
                    me->SetWalk(true);
                }
            }

            void DoAction(int32 action) override
            {
                if (action == ACTION_START_ZULAMAN)
                {
                    if (++_gongCount == 10)
                        _events.ScheduleEvent(EVENT_START_DOOR_OPENING_1, 500);
                }
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);
                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_INTRO_MOVEPOINT_1:
                            me->GetMotionMaster()->MovePoint(POINT_INTRO, VoljinIntroWaypoint[0]);
                            _events.ScheduleEvent(EVENT_INTRO_MOVEPOINT_2, 1000);
                            break;
                        case EVENT_INTRO_MOVEPOINT_2:
                            me->GetMotionMaster()->MovePoint(POINT_STRANGE_GONG, VoljinIntroWaypoint[1]);
                            _events.ScheduleEvent(EVENT_INTRO_MOVEPOINT_3, 4000);
                            break;
                        case EVENT_INTRO_MOVEPOINT_3:
                            Talk(SAY_INTRO_2);
                            _events.ScheduleEvent(EVENT_BANGING_THE_GONG, 3000);
                            break;
                        case EVENT_BANGING_THE_GONG:
                            DoCast(me, SPELL_BANGING_THE_GONG);
                            if (GameObject* strangeGong = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(DATA_STRANGE_GONG)))
                                strangeGong->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                            me->SetVirtualItem(0, uint32(ITEM_VIRTUAL_ITEM));
                            break;
                        case EVENT_START_DOOR_OPENING_1:
                            me->RemoveAura(SPELL_BANGING_THE_GONG);
                            _events.ScheduleEvent(EVENT_START_DOOR_OPENING_2, 500);
                            break;
                        case EVENT_START_DOOR_OPENING_2:
                            me->SetVirtualItem(0, uint32(0));
                            if (GameObject* strangeGong = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(DATA_STRANGE_GONG)))
                                strangeGong->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                            _events.ScheduleEvent(EVENT_START_DOOR_OPENING_3, 500);
                            break;
                        case EVENT_START_DOOR_OPENING_3:
                            me->GetMotionMaster()->MovePoint(POINT_START_DOOR_OPENING_1, VoljinIntroWaypoint[2]);
                            break;
                        case EVENT_START_DOOR_OPENING_4:
                            _instance->SetData(DATA_ZULAMAN_STATE, IN_PROGRESS);
                            if (GameObject* masiveGate = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(DATA_MASSIVE_GATE)))
                                masiveGate->SetGoState(GO_STATE_ACTIVE);
                            _events.ScheduleEvent(EVENT_START_DOOR_OPENING_5, 3000);
                            break;
                        case EVENT_START_DOOR_OPENING_5:
                            Talk(SAY_INTRO_4);
                            _events.ScheduleEvent(EVENT_START_DOOR_OPENING_6, 6000);
                            break;
                        case EVENT_START_DOOR_OPENING_6:
                            _events.ScheduleEvent(EVENT_START_DOOR_OPENING_7, 6000);
                            break;
                        case EVENT_START_DOOR_OPENING_7:
                            if (Creature* hexLordTrigger = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_HEXLORD_TRIGGER)))
                                sCreatureTextMgr->SendChat(hexLordTrigger, SAY_HEXLOR_INTRO, 0, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_MAP);
                            break;
                        default:
                            break;
                    }
                }
            }

            void MovementInform(uint32 movementType, uint32 pointId) override
            {
                if (movementType != POINT_MOTION_TYPE)
                    return;

                switch (pointId)
                {
                    case POINT_STRANGE_GONG:
                        if (GameObject* strangeGong = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(DATA_STRANGE_GONG)))
                            me->SetFacingToObject(strangeGong); // setInFront
                        break;
                    case POINT_START_DOOR_OPENING_1:
                        me->SetFacingTo(4.747295f);
                        me->GetMotionMaster()->MovePoint(POINT_START_DOOR_OPENING_2, VoljinIntroWaypoint[3]);
                        Talk(SAY_INTRO_3);
                        _events.ScheduleEvent(EVENT_START_DOOR_OPENING_4, 4500);
                        break;
                    default:
                        break;
                }
            }

        private:
            InstanceScript* _instance;
            EventMap _events;
            uint8 _gongCount = 0;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetZulAmanAI<npc_voljin_zulamanAI>(creature);
        }
};

// 45226 - Banging the Gong
class spell_banging_the_gong : public SpellScriptLoader
{
    public:
        spell_banging_the_gong() : SpellScriptLoader("spell_banging_the_gong") { }

        class spell_banging_the_gong_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_banging_the_gong_SpellScript);

            void Activate(SpellEffIndex index)
            {
                PreventHitDefaultEffect(index);
                GetHitGObj()->SendCustomAnim(0);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_banging_the_gong_SpellScript::Activate, EFFECT_1, SPELL_EFFECT_ACTIVATE_OBJECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_banging_the_gong_SpellScript();
        }
};

// Tanzar, Harkor, Ashli et Kraz : les captifs liberes par la course contre la
// montre. Ils sont invoques par l'instance a la mort de leur boss ; leur seule
// raison d'etre est de remettre le coffre de recompense quand on leur parle.
// Rien ne les scriptait, donc meme invoques ils n'auraient rien donne.
class npc_zulaman_hostage : public CreatureScript
{
public:
    npc_zulaman_hostage() : CreatureScript("npc_zulaman_hostage") { }

    enum Hostages
    {
        NPC_TANZAR      = 23790,
        NPC_HARKOR      = 23999,
        NPC_ASHLI       = 24001,
        NPC_KRAZ        = 24024,

        GO_HAZLEKS_TRUNK        = 186648,   // Tanzar
        GO_BAKKALZUS_SATCHEL    = 187021,   // Harkor
        GO_KASHAS_BAG           = 186672,   // Ashli
        GO_NORKANIS_PACKAGE     = 186667,   // Kraz

        ACTION_FREE_HOSTAGE     = GOSSIP_ACTION_INFO_DEF + 1
    };

    static uint32 ChestForHostage(uint32 entry)
    {
        switch (entry)
        {
            case NPC_TANZAR: return GO_HAZLEKS_TRUNK;
            case NPC_HARKOR: return GO_BAKKALZUS_SATCHEL;
            case NPC_ASHLI:  return GO_KASHAS_BAG;
            case NPC_KRAZ:   return GO_NORKANIS_PACKAGE;
            default:         return 0;
        }
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Vous etes libre ! Partez d'ici !", GOSSIP_SENDER_MAIN, ACTION_FREE_HOSTAGE);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        CloseGossipMenuFor(player);

        if (action != ACTION_FREE_HOSTAGE)
            return true;

        // Un seul coffre par captif, quel que soit le nombre de joueurs qui lui parlent.
        if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

        if (uint32 chest = ChestForHostage(creature->GetEntry()))
            creature->SummonGameObject(chest, creature->GetPositionX() - 2.0f, creature->GetPositionY(),
                creature->GetPositionZ(), 0.0f, QuaternionData(), WEEK);

        return true;
    }
};

void AddSC_zulaman()
{
    new npc_zulaman_hostage();
    new npc_voljin_zulaman();
    new spell_banging_the_gong();
}
