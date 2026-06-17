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
#include "GameObject.h"

class instance_scholomance : public InstanceMapScript
{
public:
    instance_scholomance() : InstanceMapScript("instance_scholomance", 1007) {}

    struct instance_scholomance_InstanceMapScript : public InstanceScript
    {
        instance_scholomance_InstanceMapScript(InstanceMap* map) : InstanceScript(map)
        {
        }

        void Initialize() override
        {
            SetBossNumber(MAX_ENCOUNTER);

            chillHeartGUID.Clear();
            jandiceBarovGUID.Clear();
            rattlegoreGUID.Clear();
            lillianVossGUID.Clear();
            gandlingGUID.Clear();
            gadlingEventGUID.Clear();

            phylacteryGUID.Clear();
            lillianVossSoulGUID.Clear();

            cafferOfForgottenSoulsGUID.Clear();
            cafferOfForgottenSoulsHeroicGUID.Clear();

            rattlegoreEvent = NOT_STARTED;
            lilianEntrance = NOT_STARTED;

            /*
            // Need to look into challenge mode before implementing this
            if (instance->IsChallengeMode())
            {
                m_ChallengeController(eScenarioDatas::ScenarioID);
                m_ChallengeController.AddBossCriteria(Data::DATA_INSTRUCTOR_CHILLHEART, eScenarioDatas::Chillheart);
                m_ChallengeController.AddBossCriteria(Data::DATA_JANDICE_BAROV, eScenarioDatas::Barov);
                m_ChallengeController.AddBossCriteria(Data::DATA_RATTLEGORE, eScenarioDatas::RattleGore);
                m_ChallengeController.AddBossCriteria(Data::DATA_LILLIAN_VOSS, eScenarioDatas::LilianVoss);
                m_ChallengeController.AddBossCriteria(Data::DATA_GANDLING, eScenarioDatas::Gandling);
                m_ChallengeController.AddChallengeCriteria(eScenarioDatas::Ennemies, eScenarioDatas::KillCount);
            }
            */
        }

        void OnCreatureKilled(Creature* p_Creature, Player* /*p_Player*/) override
        {
            // Challenge Mode-Logik aktuell noch auskommentiert / nicht implementiert
            if (!instance || !instance->IsChallengeMode() || !IsChallengeModeStarted())
                return;

            if (!p_Creature)
                return;

            if (!p_Creature->isElite() || p_Creature->IsDungeonBoss())
                return;

            // m_ChallengeController.UpdateChallengeCriteria(eScenarioDatas::Ennemies);
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
            case NPC_JANDICE_BAROV:
                jandiceBarovGUID = creature->GetGUID();
                break;
            case NPC_RATTLEGORE:
                rattlegoreGUID = creature->GetGUID();
                break;
            case NPC_LILLIAN_VOSS:
                lillianVossGUID = creature->GetGUID();
                break;
            case NPC_LILLIAN_VOSS_SOUL:
                lillianVossSoulGUID = creature->GetGUID();
                break;
            case NPC_DARKMASTER_GANDLING:
                gandlingGUID = creature->GetGUID();
                break;
            case NPC_INSTRUCTOR_CHILLHEART:
                chillHeartGUID = creature->GetGUID();
                break;
            case NPC_PHYLACTERY:
                phylacteryGUID = creature->GetGUID();
                break;
            case NPC_DARKMASTER_GANDLING_1:
                gadlingEventGUID = creature->GetGUID();
                break;
            }
        }

        void OnGameObjectCreate(GameObject* p_GameObject) override
        {
            switch (p_GameObject->GetEntry())
            {
            case GO_COFFER_OF_FORGOTTEN_SOULS:
                cafferOfForgottenSoulsGUID = p_GameObject->GetGUID();
                break;
            case GO_COFFER_OF_FORGOTTEN_SOULS_H:
                cafferOfForgottenSoulsHeroicGUID = p_GameObject->GetGUID();
                break;
                /*
                case GameObjects::ChallengeDoor:
                    m_ChallengeController.SetChallengeDoorGuid(p_GameObject->GetGUID());
                    break;
                */
            default:
                break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
            case DATA_RATTLEGORE_EVENT:
                rattlegoreEvent = data;
                break;
            case DATA_LILIAN_ENTRANCE:
                lilianEntrance = data;
                break;
            default:
                break;
            }

            if (data == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
            case DATA_RATTLEGORE_EVENT:
                return rattlegoreEvent;
            case DATA_LILIAN_ENTRANCE:
                return lilianEntrance;
            default:
                break;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
            case DATA_JANDICE_BAROV:
                return jandiceBarovGUID;
            case DATA_RATTLEGORE:
                return rattlegoreGUID;
            case DATA_LILLIAN_VOSS:
                return lillianVossGUID;
            case DATA_LILLIAN_VOSS_SOUL:
                return lillianVossSoulGUID;
            case DATA_GANDLING:
                return gandlingGUID;
            case DATA_INSTRUCTOR_CHILLHEART:
                return chillHeartGUID;
            case DATA_PHYLACTERY:
                return phylacteryGUID;
            case DATA_COFFER_OF_FORGOTTEN_SOULS:
                return cafferOfForgottenSoulsGUID;
            case DATA_COFFER_OF_FORGOTTEN_SOULS_HEROIC:
                return cafferOfForgottenSoulsHeroicGUID;
            case DATA_GANDLING_EVENT:
                return gadlingEventGUID;
            default:
                break;
            }

            return ObjectGuid::Empty;
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            return true;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << rattlegoreEvent << ' ' << lilianEntrance << ' ';
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> rattlegoreEvent;
            if (rattlegoreEvent != DONE)
                rattlegoreEvent = NOT_STARTED;

            data >> lilianEntrance;
            if (lilianEntrance != DONE)
                lilianEntrance = NOT_STARTED;
        }

        void Update(uint32 diff) override
        {
            InstanceScript::Update(diff);
        }

    private:
        ObjectGuid jandiceBarovGUID;
        ObjectGuid rattlegoreGUID;
        ObjectGuid lillianVossGUID;
        ObjectGuid gandlingGUID;
        ObjectGuid chillHeartGUID;
        ObjectGuid phylacteryGUID;
        ObjectGuid lillianVossSoulGUID;
        ObjectGuid gadlingEventGUID;

        ObjectGuid cafferOfForgottenSoulsGUID;
        ObjectGuid cafferOfForgottenSoulsHeroicGUID;

        uint32 rattlegoreEvent;
        uint32 lilianEntrance;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_scholomance_InstanceMapScript(map);
    }
};

void AddSC_instance_scholomance()
{
    new instance_scholomance();
}
