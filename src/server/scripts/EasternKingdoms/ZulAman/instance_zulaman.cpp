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
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "WorldStatePackets.h"
#include "zulaman.h"

// Les otages de la course contre la montre sont ceux de la version Cataclysm,
// poses en base pres de leur boss gardien, chacun avec son cadavre en flammes a
// quelques metres. Boss tue dans les temps : l'otage est sauve et remet son coffre
// quand on lui parle. Delai depasse : les otages non sauves disparaissent et leur
// cadavre apparait. Le cadavre ne doit jamais se voir avant, sinon les joueurs
// voient l'otage bruler des l'entree, chrono en cours.
//
// Les captifs de l'epoque Burning Crusade (Tanzar, Harkor, Ashli, Kraz) qu'on
// invoquait a la mort du boss faisaient doublon avec eux : ils ne le sont plus.
struct HostageFateEntry
{
    uint32 Boss;
    uint32 Hostage;
    uint32 Corpse;
};

static HostageFateEntry const HostageFate[4] =
{
    { DATA_NALORAKK, NPC_HAZLEK,   NPC_HAZLEK_CORPSE   },
    { DATA_AKILZON,  NPC_BAKKALZU, NPC_BAKKALZU_CORPSE },
    { DATA_JANALAI,  NPC_NORKANI,  NPC_NORKANI_CORPSE  },
    { DATA_HALAZZI,  NPC_KASHA,    NPC_KASHA_CORPSE    }
};

class instance_zulaman : public InstanceMapScript
{
    public:
        instance_zulaman() : InstanceMapScript(ZulAmanScriptName, 568) { }

        struct instance_zulaman_InstanceScript : public InstanceScript
        {
            instance_zulaman_InstanceScript(InstanceMap* map) : InstanceScript(map)
            {
                SetHeaders(DataHeader);
                SetBossNumber(EncounterCount);

                SpeedRunTimer           = 16;
                ZulAmanState            = NOT_STARTED;
                ZulAmanBossCount        = 0;
                HostagesSaved           = 0;
                HostagesFreed           = 0;
            }

            void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override
            {
                packet.Worldstates.emplace_back(uint32(WORLD_STATE_ZULAMAN_TIMER_ENABLED), int32(ZulAmanState ? 1 : 0));
                packet.Worldstates.emplace_back(uint32(WORLD_STATE_ZULAMAN_TIMER), int32(SpeedRunTimer));
            }

            void OnCreatureCreate(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_AKILZON:
                        AkilzonGUID = creature->GetGUID();
                        break;
                    case NPC_NALORAKK:
                        NalorakkGUID = creature->GetGUID();
                        break;
                    case NPC_JANALAI:
                        JanalaiGUID = creature->GetGUID();
                        break;
                    case NPC_HALAZZI:
                        HalazziGUID = creature->GetGUID();
                        break;
                    case NPC_HEXLORD:
                        HexLordMalacrassGUID = creature->GetGUID();
                        break;
                    case NPC_DAAKARA:
                        DaakaraGUID = creature->GetGUID();
                        break;
                    case NPC_VOLJIN:
                        VoljinGUID = creature->GetGUID();
                        break;
                    case NPC_HEXLORD_TRIGGER:
                        HexLordTriggerGUID = creature->GetGUID();
                        break;
                    default:
                        for (uint8 i = 0; i < 4; ++i)
                        {
                            if (creature->GetEntry() == HostageFate[i].Hostage)
                            {
                                HostageGUIDs[i] = creature->GetGUID();
                                ApplyHostageState(creature, i);
                            }
                            else if (creature->GetEntry() == HostageFate[i].Corpse)
                            {
                                HostageCorpseGUIDs[i] = creature->GetGUID();
                                creature->SetVisible(IsHostageLost(i));
                            }
                        }
                        break;
                }
            }

            bool IsHostageLost(uint8 i) const
            {
                return ZulAmanState == FAIL && !(HostagesSaved & (1 << i));
            }

            // Toujours intouchable ; on ne peut lui parler qu'une fois sauve, et une seule
            // fois : le coffre ne doit pas se redonner apres un redemarrage.
            void ApplyHostageState(Creature* hostage, uint8 i)
            {
                hostage->SetVisible(!IsHostageLost(i));
                hostage->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

                if ((HostagesSaved & (1 << i)) && !(HostagesFreed & (1 << i)))
                    hostage->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                else
                    hostage->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }

            void RefreshHostage(uint8 i)
            {
                if (Creature* hostage = instance->GetCreature(HostageGUIDs[i]))
                    ApplyHostageState(hostage, i);
                if (Creature* corpse = instance->GetCreature(HostageCorpseGUIDs[i]))
                    corpse->SetVisible(IsHostageLost(i));
            }

            // Delai depasse : les otages des boss encore en vie sont perdus.
            void BurnLostHostages()
            {
                for (uint8 i = 0; i < 4; ++i)
                    RefreshHostage(i);
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_STRANGE_GONG:
                        StrangeGongGUID = go->GetGUID();
                        break;
                    case GO_MASSIVE_GATE:
                        MasiveGateGUID = go->GetGUID();
                        AddDoor(go, true);
                        if (ZulAmanState != NOT_STARTED)
                            go->SetGoState(GO_STATE_ACTIVE);
                        break;
                    default:
                        break;
                }
            }

            void OnGameObjectRemove(GameObject* go) override
            {
                switch (go->GetEntry())
                {
                    case GO_MASSIVE_GATE:
                        AddDoor(go, false);
                        break;
                    default:
                        break;
                }
            }

            ObjectGuid GetGuidData(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_AKILZON:
                        return AkilzonGUID;
                    case DATA_NALORAKK:
                        return NalorakkGUID;
                    case DATA_JANALAI:
                        return JanalaiGUID;
                    case DATA_HALAZZI:
                        return HalazziGUID;
                    case DATA_HEXLORD:
                        return HexLordMalacrassGUID;
                    case DATA_DAAKARA:
                        return DaakaraGUID;
                    case DATA_HEXLORD_TRIGGER:
                        return HexLordTriggerGUID;
                    case DATA_STRANGE_GONG:
                        return StrangeGongGUID;
                    case DATA_MASSIVE_GATE:
                        return MasiveGateGUID;
                    default:
                        break;
                }

                return ObjectGuid::Empty;
            }

            void SetData(uint32 type, uint32 data) override
            {
                switch (type)
                {
                    case DATA_ZULAMAN_STATE:
                    {
                        if (data == IN_PROGRESS)
                        {
                            DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER_ENABLED, 1);
                            DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER, 15);
                            events.ScheduleEvent(EVENT_UPDATE_ZULAMAN_TIMER, 60000);
                            SpeedRunTimer = 15;
                            ZulAmanState = data;
                            SaveToDB();
                        }
                        break;
                    }
                    case DATA_HOSTAGE_FREED:
                        for (uint8 i = 0; i < 4; ++i)
                        {
                            if (HostageFate[i].Hostage != data)
                                continue;

                            HostagesFreed |= 1 << i;
                            RefreshHostage(i);
                            SaveToDB();
                        }
                        break;
                    default:
                        break;
                }
            }

            uint32 GetData(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_ZULAMAN_STATE:
                        return ZulAmanState;
                    default:
                        break;
                }

                return 0;
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                // A evaluer avant le decompte : le quatrieme boss clot la course.
                bool const killedInTime = state == DONE && ZulAmanState == IN_PROGRESS && SpeedRunTimer;

                if (state == DONE)
                {
                    if (ZulAmanState == IN_PROGRESS && SpeedRunTimer)
                    {
                        ++ZulAmanBossCount;

                        if (ZulAmanBossCount < 2)
                        {
                            SpeedRunTimer = SpeedRunTimer + 5;
                            DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER, SpeedRunTimer);
                        }
                        else if (ZulAmanBossCount == 4)
                        {
                            DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER_ENABLED, 0);
                            events.CancelEvent(EVENT_UPDATE_ZULAMAN_TIMER);
                            ZulAmanState = DONE;
                        }
                    }
                }

                if (killedInTime)
                {
                    for (uint8 i = 0; i < 4; ++i)
                    {
                        if (HostageFate[i].Boss != type)
                            continue;

                        HostagesSaved |= 1 << i;
                        RefreshHostage(i);
                        SaveToDB();
                    }
                }

                return true;
            }

            void ProcessEvent(WorldObject* /*obj*/, uint32 eventId) override
            {
                switch (eventId)
                {
                    case EVENT_START_ZULAMAN:
                        if (Creature* voljin = instance->GetCreature(VoljinGUID))
                        {
                            if (voljin->IsAIEnabled)
                                voljin->AI()->DoAction(ACTION_START_ZULAMAN);
                        }
                        break;
                    default:
                        break;
                }
            }

            void Update(uint32 diff) override
            {
                if (events.Empty())
                    return;

                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_UPDATE_ZULAMAN_TIMER:
                            SaveToDB();
                            DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER, --SpeedRunTimer);
                            if (SpeedRunTimer)
                                events.ScheduleEvent(EVENT_UPDATE_ZULAMAN_TIMER, 60000);
                            else
                            {
                                DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER_ENABLED, 0);
                                events.CancelEvent(EVENT_UPDATE_ZULAMAN_TIMER);
                                ZulAmanState = FAIL;
                                SaveToDB();
                                BurnLostHostages();
                            }
                            break;
                        default:
                            break;
                    }
                }
            }

            void WriteSaveDataMore(std::ostringstream& data) override
            {
                data << ZulAmanState  << ' '
                     << SpeedRunTimer << ' '
                     << ZulAmanBossCount << ' '
                     << HostagesSaved << ' '
                     << HostagesFreed;
            }

            void ReadSaveDataMore(std::istringstream& data) override
            {
                data >> ZulAmanState;
                data >> SpeedRunTimer;
                data >> ZulAmanBossCount;
                data >> HostagesSaved;      // absents des sauvegardes anterieures : restent a 0
                data >> HostagesFreed;

                if (ZulAmanState == IN_PROGRESS && SpeedRunTimer && SpeedRunTimer <= 15)
                {
                    events.ScheduleEvent(EVENT_UPDATE_ZULAMAN_TIMER, 60000);
                    DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER_ENABLED, 1);
                    DoUpdateWorldState(WORLD_STATE_ZULAMAN_TIMER, SpeedRunTimer);
                }
            }

        protected:
            EventMap events;
            ObjectGuid AkilzonGUID;
            ObjectGuid NalorakkGUID;
            ObjectGuid JanalaiGUID;
            ObjectGuid HalazziGUID;
            ObjectGuid HexLordMalacrassGUID;
            ObjectGuid DaakaraGUID;
            ObjectGuid VoljinGUID;
            ObjectGuid HexLordTriggerGUID;
            ObjectGuid StrangeGongGUID;
            ObjectGuid MasiveGateGUID;
            ObjectGuid HostageGUIDs[4];
            ObjectGuid HostageCorpseGUIDs[4];
            uint32 SpeedRunTimer;
            uint32 ZulAmanState;
            uint32 ZulAmanBossCount;
            uint32 HostagesSaved;           // bit i : otage HostageFate[i] sauve dans les temps
            uint32 HostagesFreed;           // bit i : otage HostageFate[i] a deja remis son coffre
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_zulaman_InstanceScript(map);
        }
};

void AddSC_instance_zulaman()
{
    new instance_zulaman();
}
