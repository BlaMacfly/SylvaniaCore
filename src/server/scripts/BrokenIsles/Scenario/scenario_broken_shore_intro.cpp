/*
 * Scenario: The Battle for Broken Shore (ScenarioID 786, Map 1460)
 * Legion intro scenario - both factions, faction-aware cast.
 * Quests: 42740 (Alliance, credits 90918 + 108920) / 44543 (Horde, credit 90918).
 * Anchors: official WorldSafeLocs of map 1460 (Beach/Portal/City/Crevasse/Tomb).
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "InstanceScenario.h"
#include "ScriptedCreature.h"
#include "PhasingHandler.h"
#include "TemporarySummon.h"
#include "MotionMaster.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "TaskScheduler.h"

enum BrokenShoreData
{
    DATA_BS_MAX_STAGES      = 10,
};

enum BrokenShoreStage
{
    STAGE_INTRO             = 0, // step 1504 The Broken Shore
    STAGE_STORM_BEACH       = 1, // step 1522 Storm The Beach
    STAGE_COMMANDER         = 2, // step 2685 Defeat the Commander (Arganoth)
    STAGE_FIND_LEADER       = 3, // step 1589 Find Varian
    STAGE_PORTAL            = 4, // step 1532 Destroy the Portal
    STAGE_RAZE_CITY         = 5, // step 1505 Raze the Black City
    STAGE_HIGHLORD          = 6, // step 1506 The Highlord (Tirion)
    STAGE_KROSUS            = 7, // step 1761 Krosus
    STAGE_STOP_GULDAN       = 8, // step 2084 Stop Gul'dan
    STAGE_DONE              = 9,
};

enum BrokenShoreCreatures
{
    // cast Alliance
    NPC_KING_VARIAN         = 90713,
    NPC_JAINA               = 90714,
    NPC_MEKKATORQUE         = 90716,
    NPC_GENN                = 90717,
    NPC_ALLIANCE_SOLDIER    = 90751,
    // cast Horde
    NPC_VOLJIN              = 90708,
    NPC_SYLVANAS            = 90709,
    NPC_BAINE               = 90710,
    NPC_THRALL              = 90711,
    NPC_HORDE_GRUNT         = 90750,
    // communs
    NPC_KHADGAR             = 90707,
    NPC_ARGANOTH            = 90705,
    NPC_TIRION              = 90367,
    NPC_KROSUS              = 90544,
    NPC_GULDAN              = 90413,
    NPC_DIMENSIONAL_ANCHOR  = 90637,
    // vagues de demons (gabarits deja combat-ready, reutilises du scenario moine)
    NPC_INFERNAL_DESTROYER  = 98011,
    NPC_CHAOS_MINION        = 98286,
    NPC_FELBLADE_DESTROYER  = 97966,
    NPC_FELBLOOD_PACKHOUND  = 98785,
    NPC_EREDAR_SUMMONER     = 98505,
    // credits de quete
    NPC_CREDIT_FINALE       = 90918,  // 42740 obj0 / 44543 obj0
    NPC_CREDIT_SHIP         = 108920, // 42740 obj1 (Angelica)
};

enum BrokenShoreMisc
{
    PHASE_NORMAL            = 169,
    KILLS_BEACH             = 12,
    KILLS_CITY              = 10,
    KILLS_FINALE            = 8,
    ANCHORS_PORTAL          = 2,
};

struct FactionAnchors
{
    Position beach;
    Position commander;
    Position city;      // "Find Varian" + Raze the Black City
    Position portal;
    Position crevasse;  // Tirion + Krosus
    Position tomb;      // Gul'dan
};

// WorldSafeLocs officiels map 1460
FactionAnchors const AllianceAnchors =
{
    { 443.8f, 2076.1f, 0.9f, 0.40f },
    { 495.0f, 2125.0f, 1.5f, 3.50f },
    { 1094.9f, 2350.7f, 20.0f, 0.40f },
    { 1123.5f, 2506.5f, 41.8f, 4.90f },
    { 1503.2f, 1886.1f, 39.1f, 0.30f },
    { 1572.4f, 1719.1f, 77.4f, 5.30f },
};

FactionAnchors const HordeAnchors =
{
    { 525.4f, 1967.5f, 0.9f, 5.90f },
    { 570.0f, 1955.0f, 1.5f, 3.00f },
    { 982.1f, 1847.4f, 21.6f, 5.90f },
    { 865.6f, 1841.3f, 54.1f, 0.90f },
    { 1360.9f, 1754.4f, 34.0f, 5.90f },
    { 1543.0f, 1523.8f, 130.1f, 3.80f },
};

Position const ExitAlliance = { -1590.9f, 3131.6f, 134.6f, 1.85f }; // Dalaran, pres de Genn Greymane
Position const ExitHorde    = { 1352.0f, -4398.0f, 29.2f, 2.30f };  // Orgrimmar, dock (Eitrigg/Holgar)

struct scenario_broken_shore_intro : public InstanceScript
{
    scenario_broken_shore_intro(InstanceMap* map) : InstanceScript(map) { }

    void Initialize() override
    {
        SetBossNumber(DATA_BS_MAX_STAGES);
        stage = STAGE_INTRO;
        introDone = false;
        beachKills = 0;
        cityKills = 0;
        finaleKills = 0;
        anchorsDown = 0;
        team = TEAM_ALLIANCE;
    }

    FactionAnchors const& Anchors() const { return team == TEAM_HORDE ? HordeAnchors : AllianceAnchors; }
    uint32 LeaderEntry() const { return team == TEAM_HORDE ? NPC_VOLJIN : NPC_KING_VARIAN; }
    uint32 TroopEntry() const { return team == TEAM_HORDE ? NPC_HORDE_GRUNT : NPC_ALLIANCE_SOLDIER; }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);
        if (player->GetMapId() != 1460)
            return;

        PhasingHandler::AddPhase(player, PHASE_NORMAL, true);
        // objectif « embarquement » (Alliance) : credite aussi ici au cas ou
        player->KilledMonsterCredit(NPC_CREDIT_SHIP);

        if (!introDone)
        {
            introDone = true;
            team = player->GetTeamId();
            StartIntro();
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

    TempSummon* Summon(uint32 entry, Position const& pos)
    {
        return instance->SummonCreature(entry, pos);
    }

    TempSummon* SummonAt(uint32 entry, Position const& base, float dx, float dy)
    {
        Position pos = { base.GetPositionX() + dx, base.GetPositionY() + dy, base.GetPositionZ(), base.GetOrientation() };
        return instance->SummonCreature(entry, pos);
    }

    void SummonWave(Position const& base, uint8 count)
    {
        static uint32 const demons[5] = { NPC_CHAOS_MINION, NPC_FELBLOOD_PACKHOUND, NPC_FELBLADE_DESTROYER, NPC_EREDAR_SUMMONER, NPC_INFERNAL_DESTROYER };
        for (uint8 i = 0; i < count; ++i)
        {
            float dx = (i % 4) * 7.0f - 10.5f + (i >= 4 ? 3.5f : 0.0f);
            float dy = (i / 4) * 8.0f - 8.0f;
            SummonAt(demons[i % 5], base, dx + 15.0f, dy + 15.0f);
        }
    }

    void StartIntro()
    {
        FactionAnchors const& a = Anchors();

        // debarquement : chef de faction + escorte
        if (Creature* leader = Summon(LeaderEntry(), a.beach))
        {
            leaderGUID = leader->GetGUID();
            leader->AI()->Talk(0);
        }
        if (team == TEAM_HORDE)
        {
            if (Creature* sylvanas = SummonAt(NPC_SYLVANAS, a.beach, 4.0f, 4.0f))
                sylvanasGUID = sylvanas->GetGUID();
            SummonAt(NPC_BAINE, a.beach, -4.0f, 4.0f);
            SummonAt(NPC_THRALL, a.beach, 4.0f, -4.0f);
        }
        else
        {
            if (Creature* jaina = SummonAt(NPC_JAINA, a.beach, 4.0f, 4.0f))
                jainaGUID = jaina->GetGUID();
            SummonAt(NPC_GENN, a.beach, -4.0f, 4.0f);
            SummonAt(NPC_MEKKATORQUE, a.beach, 4.0f, -4.0f);
        }
        for (uint8 i = 0; i < 4; ++i)
            SummonAt(TroopEntry(), a.beach, -8.0f + i * 5.0f, -8.0f);

        // etape 0 « The Broken Shore » : courte mise en scene puis assaut
        scheduler.Schedule(Seconds(12), [this](TaskContext /*context*/)
        {
            stage = STAGE_STORM_BEACH;
            CompleteStep();
            SummonWave(Anchors().beach, 6);
            SummonWave(Anchors().commander, 6);
        });
    }

    void OnUnitDeath(Unit* unit) override
    {
        Creature* creature = unit->ToCreature();
        if (!creature)
            return;

        switch (creature->GetEntry())
        {
            case NPC_CHAOS_MINION:
            case NPC_FELBLOOD_PACKHOUND:
            case NPC_FELBLADE_DESTROYER:
            case NPC_EREDAR_SUMMONER:
            case NPC_INFERNAL_DESTROYER:
                OnDemonDied();
                break;
            case NPC_ARGANOTH:
                if (stage == STAGE_COMMANDER)
                {
                    creature->AI()->Talk(1);
                    stage = STAGE_FIND_LEADER;
                    CompleteStep();
                    StartFindLeader();
                }
                break;
            case NPC_DIMENSIONAL_ANCHOR:
                if (stage == STAGE_PORTAL && ++anchorsDown >= ANCHORS_PORTAL)
                {
                    stage = STAGE_RAZE_CITY;
                    CompleteStep();
                    SummonWave(Anchors().city, 5);
                    SummonWave(Anchors().city, 5);
                }
                break;
            case NPC_KROSUS:
                if (stage == STAGE_KROSUS)
                {
                    stage = STAGE_STOP_GULDAN;
                    CompleteStep();
                    StartFinale();
                }
                break;
            default:
                break;
        }
    }

    void OnDemonDied()
    {
        switch (stage)
        {
            case STAGE_STORM_BEACH:
                if (++beachKills >= KILLS_BEACH)
                {
                    stage = STAGE_COMMANDER;
                    CompleteStep();
                    if (Creature* arganoth = Summon(NPC_ARGANOTH, Anchors().commander))
                    {
                        arganoth->AI()->Talk(0);
                        arganoth->SetInCombatWithZone();
                    }
                }
                break;
            case STAGE_RAZE_CITY:
                if (++cityKills >= KILLS_CITY)
                {
                    stage = STAGE_HIGHLORD;
                    CompleteStep();
                    StartHighlord();
                }
                break;
            case STAGE_STOP_GULDAN:
                if (++finaleKills >= KILLS_FINALE)
                    FinishScenario();
                break;
            default:
                break;
        }
    }

    void StartFindLeader()
    {
        FactionAnchors const& a = Anchors();

        // le chef et son etat-major se replacent au point de ralliement (la Cite noire)
        if (Creature* leader = instance->GetCreature(leaderGUID))
            leader->NearTeleportTo(a.city.GetPositionX(), a.city.GetPositionY(), a.city.GetPositionZ(), a.city.GetOrientation());
        SummonAt(NPC_KHADGAR, a.city, 4.0f, 3.0f);
        for (uint8 i = 0; i < 3; ++i)
            SummonAt(TroopEntry(), a.city, -6.0f + i * 6.0f, -5.0f);

        // « Find Varian » : detection de proximite
        scheduler.Schedule(Seconds(2), [this](TaskContext context)
        {
            if (stage != STAGE_FIND_LEADER)
                return;
            bool found = false;
            Creature* leader = instance->GetCreature(leaderGUID);
            if (leader)
            {
                DoOnPlayers([&found, leader](Player* player)
                {
                    if (player->IsWithinDist(leader, 35.0f, false))
                        found = true;
                });
            }
            if (found)
            {
                stage = STAGE_PORTAL;
                CompleteStep();
                if (Creature* second = instance->GetCreature(team == TEAM_HORDE ? sylvanasGUID : jainaGUID))
                    second->AI()->Talk(0);
                StartPortal();
            }
            else
                context.Repeat(Seconds(2));
        });
    }

    void StartPortal()
    {
        FactionAnchors const& a = Anchors();
        SummonAt(NPC_DIMENSIONAL_ANCHOR, a.portal, -8.0f, 0.0f);
        SummonAt(NPC_DIMENSIONAL_ANCHOR, a.portal, 8.0f, 0.0f);
        SummonAt(NPC_EREDAR_SUMMONER, a.portal, 0.0f, 6.0f);
        SummonAt(NPC_CHAOS_MINION, a.portal, -5.0f, 8.0f);
        SummonAt(NPC_CHAOS_MINION, a.portal, 5.0f, 8.0f);
    }

    void StartHighlord()
    {
        FactionAnchors const& a = Anchors();
        if (Creature* tirion = Summon(NPC_TIRION, a.crevasse))
        {
            tirion->AI()->Talk(0);
            tirion->SetStandState(UNIT_STAND_STATE_KNEEL);
            tirion->DespawnOrUnsummon(20000);
        }
        scheduler.Schedule(Seconds(12), [this](TaskContext /*context*/)
        {
            stage = STAGE_KROSUS;
            CompleteStep();
            if (Creature* krosus = Summon(NPC_KROSUS, Anchors().crevasse))
                krosus->SetInCombatWithZone();
        });
    }

    void StartFinale()
    {
        FactionAnchors const& a = Anchors();
        if (Creature* guldan = Summon(NPC_GULDAN, a.tomb))
        {
            guldanGUID = guldan->GetGUID();
            guldan->SetReactState(REACT_PASSIVE);
            guldan->AI()->Talk(0);
        }
        SummonWave(a.tomb, 4);
        scheduler.Schedule(Seconds(20), [this](TaskContext /*context*/)
        {
            if (stage == STAGE_STOP_GULDAN && finaleKills < KILLS_FINALE)
                SummonWave(Anchors().tomb, 4);
            if (Creature* guldan = instance->GetCreature(guldanGUID))
                guldan->AI()->Talk(1);
        });
    }

    void FinishScenario()
    {
        stage = STAGE_DONE;
        CompleteStep();
        if (Scenario* scenario = instance->GetInstanceScenario())
            scenario->CompleteScenario();

        if (Creature* guldan = instance->GetCreature(guldanGUID))
        {
            guldan->AI()->Talk(2);
            guldan->DespawnOrUnsummon(6000);
        }
        if (Creature* leader = instance->GetCreature(leaderGUID))
            leader->AI()->Talk(1); // sacrifice de Varian / repli de Vol'jin

        DoOnPlayers([](Player* player)
        {
            player->KilledMonsterCredit(NPC_CREDIT_FINALE);
        });

        bool horde = (team == TEAM_HORDE);
        scheduler.Schedule(Seconds(10), [this, horde](TaskContext /*context*/)
        {
            Position const& out = horde ? ExitHorde : ExitAlliance;
            uint32 mapId = horde ? 1 : 1220;
            DoOnPlayers([&out, mapId](Player* player)
            {
                player->TeleportTo(mapId, out.GetPositionX(), out.GetPositionY(), out.GetPositionZ(), out.GetOrientation());
            });
        });
    }

private:
    uint32 stage = STAGE_INTRO;
    bool introDone = false;
    uint8 beachKills = 0;
    uint8 cityKills = 0;
    uint8 finaleKills = 0;
    uint8 anchorsDown = 0;
    TeamId team = TEAM_ALLIANCE;
    ObjectGuid leaderGUID;
    ObjectGuid jainaGUID;
    ObjectGuid sylvanasGUID;
    ObjectGuid guldanGUID;
    TaskScheduler scheduler;
};

void AddSC_scenario_broken_shore_intro()
{
    RegisterInstanceScript(scenario_broken_shore_intro, 1460);
}
