/*
 * Runner generique de scenarios d'artefact — pilote par les tables world
 * `scenario_artifact_config` (map, entree, sortie, credit) et
 * `scenario_artifact_stage` (map, etape, invocations, teleport optionnel).
 *
 * Ajouter un scenario = 1 ligne config + N lignes stage + 1 macro
 * REGISTER_ARTIFACT_RUNNER(map) + instance_template.script adapte.
 * Deroule : intro -> etapes (vagues/boss, kills comptes via OnUnitDeath)
 * -> CompleteScenario -> credit optionnel -> teleport de sortie.
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "InstanceScenario.h"
#include "ScriptedCreature.h"
#include "PhasingHandler.h"
#include "TemporarySummon.h"
#include "Player.h"
#include "DatabaseEnv.h"
#include "TaskScheduler.h"
#include <unordered_map>

namespace ArtifactRunner
{
    struct StageSpawn
    {
        uint32 entry = 0;
        float x = 0.f, y = 0.f, z = 0.f, o = 0.f;
        uint8 count = 1;
        uint8 level = 0;
        bool teleport = false;
    };

    struct Config
    {
        Position entrance;
        uint32 exitMap = 0;
        Position exit;
        uint32 creditEntry = 0;
        std::map<uint8, std::vector<StageSpawn>> stages;
    };

    static std::unordered_map<uint32, Config> _configs;
    static bool _loaded = false;

    void LoadAll()
    {
        if (_loaded)
            return;
        _loaded = true;

        if (QueryResult result = WorldDatabase.Query("SELECT map, entrance_x, entrance_y, entrance_z, entrance_o, exit_map, exit_x, exit_y, exit_z, exit_o, credit_entry FROM scenario_artifact_config"))
        {
            do
            {
                Field* f = result->Fetch();
                Config& c = _configs[f[0].GetUInt16()];
                c.entrance.Relocate(f[1].GetFloat(), f[2].GetFloat(), f[3].GetFloat(), f[4].GetFloat());
                c.exitMap = f[5].GetUInt16();
                c.exit.Relocate(f[6].GetFloat(), f[7].GetFloat(), f[8].GetFloat(), f[9].GetFloat());
                c.creditEntry = f[10].GetUInt32();
            } while (result->NextRow());
        }

        if (QueryResult result = WorldDatabase.Query("SELECT map, stage, entry, x, y, z, o, cnt, lvl, teleport FROM scenario_artifact_stage ORDER BY map, stage, idx"))
        {
            do
            {
                Field* f = result->Fetch();
                auto itr = _configs.find(f[0].GetUInt16());
                if (itr == _configs.end())
                    continue;
                StageSpawn s;
                s.entry = f[2].GetUInt32();
                s.x = f[3].GetFloat(); s.y = f[4].GetFloat(); s.z = f[5].GetFloat(); s.o = f[6].GetFloat();
                s.count = f[7].GetUInt8();
                s.level = f[8].GetUInt8();
                s.teleport = f[9].GetUInt8() != 0;
                itr->second.stages[f[1].GetUInt8()].push_back(s);
            } while (result->NextRow());
        }
    }

    Config const* GetConfig(uint32 mapId)
    {
        LoadAll();
        auto itr = _configs.find(mapId);
        return itr != _configs.end() ? &itr->second : nullptr;
    }
}

struct scenario_artifact_runner : public InstanceScript
{
    scenario_artifact_runner(InstanceMap* map) : InstanceScript(map) { }

    void Initialize() override
    {
        SetBossNumber(12);
        config = ArtifactRunner::GetConfig(instance->GetId());
        stage = 0;
        aliveCount = 0;
        introDone = false;
    }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);
        PhasingHandler::AddPhase(player, 169, true);

        if (!introDone && config)
        {
            introDone = true;
            scheduler.Schedule(Seconds(8), [this](TaskContext /*context*/)
            {
                CompleteStep(); // etape d'intro du scenario
                StartStage(1);
            });
        }
    }

    void Update(uint32 diff) override
    {
        InstanceScript::Update(diff);
        scheduler.Update(diff);
    }

    void CompleteStep()
    {
        if (Scenario* scenario = instance->GetInstanceScenario())
            scenario->CompleteCurrStep();
    }

    void StartStage(uint8 newStage)
    {
        if (!config)
            return;

        auto itr = config->stages.find(newStage);
        if (itr == config->stages.end())
        {
            Finish();
            return;
        }

        stage = newStage;
        aliveCount = 0;
        stageEntries.clear();

        bool teleported = false;
        for (ArtifactRunner::StageSpawn const& s : itr->second)
        {
            if (s.teleport && !teleported)
            {
                teleported = true;
                float tx = s.x, ty = s.y, tz = s.z, to = s.o;
                DoOnPlayers([tx, ty, tz, to](Player* player)
                {
                    player->NearTeleportTo(tx, ty, tz, to);
                });
            }
            for (uint8 i = 0; i < s.count; ++i)
            {
                float dx = (i % 3) * 6.0f - 6.0f;
                float dy = (i / 3) * 6.0f - 3.0f;
                Position pos = { s.x + dx + 12.0f, s.y + dy + 8.0f, s.z, s.o };
                if (TempSummon* summon = instance->SummonCreature(s.entry, pos))
                {
                    if (s.level)
                    {
                        summon->SetLevel(s.level);
                        summon->SetFullHealth();
                    }
                    stageEntries.insert(s.entry);
                    ++aliveCount;
                }
            }
        }

        if (!aliveCount) // etape vide : on enchaine
        {
            CompleteStep();
            StartStage(stage + 1);
        }
    }

    void OnUnitDeath(Unit* unit) override
    {
        Creature* creature = unit->ToCreature();
        if (!creature || !config || !stage)
            return;
        if (stageEntries.find(creature->GetEntry()) == stageEntries.end())
            return;

        if (aliveCount && --aliveCount == 0)
        {
            CompleteStep();
            StartStage(stage + 1);
        }
    }

    void Finish()
    {
        if (Scenario* scenario = instance->GetInstanceScenario())
            scenario->CompleteScenario();

        uint32 credit = config ? config->creditEntry : 0;
        DoOnPlayers([credit](Player* player)
        {
            if (credit)
                player->KilledMonsterCredit(credit);
        });

        if (config && config->exitMap)
        {
            uint32 exitMap = config->exitMap;
            Position out = config->exit;
            scheduler.Schedule(Seconds(8), [this, exitMap, out](TaskContext /*context*/)
            {
                DoOnPlayers([exitMap, out](Player* player)
                {
                    player->TeleportTo(exitMap, out.GetPositionX(), out.GetPositionY(), out.GetPositionZ(), out.GetOrientation());
                });
            });
        }
    }

private:
    ArtifactRunner::Config const* config = nullptr;
    uint8 stage = 0;
    uint32 aliveCount = 0;
    std::set<uint32> stageEntries;
    bool introDone = false;
    TaskScheduler scheduler;
};

// Une sous-classe par map configuree ; le nom doit correspondre a instance_template.script.
#define REGISTER_ARTIFACT_RUNNER(mapid) \
    struct scenario_artifact_runner_##mapid : public scenario_artifact_runner \
    { \
        scenario_artifact_runner_##mapid(InstanceMap* map) : scenario_artifact_runner(map) { } \
    }; \
    RegisterInstanceScript(scenario_artifact_runner_##mapid, mapid)

void AddSC_scenario_artifact_runner()
{
    // Marche-vent moine - « The Thundering Heavens » (Skywall, boss Typhinius)
    REGISTER_ARTIFACT_RUNNER(1528);
    // DK Givre - The Blades of the Fallen Prince (Couronne de glace)
    REGISTER_ARTIFACT_RUNNER(1480);
    // Paladin Sacre - The Silver Hand (Espoir de Lumiere)
    REGISTER_ARTIFACT_RUNNER(1611);
    // DK Impie - Apocalypse (monastere Ecarlate)
    REGISTER_ARTIFACT_RUNNER(1618);
    // Voleur Finesse - Fangs of the Devourer (Akaari)
    REGISTER_ARTIFACT_RUNNER(1607);
    // Demoniste Destruction - Scepter of Sargeras (Tol Barad)
    REGISTER_ARTIFACT_RUNNER(1630);
    // Chaman Elementaire - Fist of Ra-den (pic du Vortex)
    REGISTER_ARTIFACT_RUNNER(1602);
    // Chasseur BM - Titanstrike (temple des Orages)
    REGISTER_ARTIFACT_RUNNER(1609);
    // Voleur Assassinat - Kingslayers (manoir Ravenholdt)
    REGISTER_ARTIFACT_RUNNER(1620);
    // Arcway (Suramar) - Duskwatch
    REGISTER_ARTIFACT_RUNNER(1632);
    // Niskara - invasion (monde de la Legion)
    REGISTER_ARTIFACT_RUNNER(1604);
    // Terres de Feu - la Fournaise
    REGISTER_ARTIFACT_RUNNER(1605);
}
