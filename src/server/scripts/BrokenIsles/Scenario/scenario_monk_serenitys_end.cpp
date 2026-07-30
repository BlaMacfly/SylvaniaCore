/*
 * Scenario: Serenity's End (ScenarioID 943, Map 1014)
 * Monk order hall campaign intro - the Peak of Serenity falls to the Legion.
 * Quest 12103 "Before the Storm".
 * Positions derived from the identical MoP terrain spawns (map 870).
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "InstanceScenario.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "PhasingHandler.h"
#include "TemporarySummon.h"
#include "MotionMaster.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "TaskScheduler.h"

enum SerenitysEndData
{
    DATA_STAGE_COUNCIL      = 1,
    DATA_STAGE_CRANE        = 2,
    DATA_STAGE_JOURNEY      = 3,
    DATA_STAGE_TIGER        = 4,
    DATA_STAGE_CARGO        = 5,
    DATA_STAGE_PORTAL_BOSS  = 6,
    DATA_STAGE_FEL_STONE    = 7,
    DATA_MAX_STAGES         = 8,

    DATA_COUNCIL_TALKED     = 20,
    DATA_DESTROYER_DEAD     = 21,
    DATA_VIZZNAK_DEAD       = 22,
    DATA_JIA_TELEPORT       = 23,
    DATA_MORVATH_DEAD       = 24,
    DATA_INVADER_DEAD       = 25,
    DATA_ESCORT_ARRIVED     = 26,
    DATA_JORVINAX_DEAD      = 27,
    DATA_FEL_STONE_DEAD     = 28,

    DATA_CURRENT_STAGE      = 50,
};

enum SerenitysEndCreatures
{
    NPC_MASTER_HIGHT_COUNCIL    = 97778,
    NPC_MASTER_HIGHT_PORTAL     = 98515,
    NPC_IRON_BODY_PONSHU        = 97777,
    NPC_JIA_COUNCIL             = 97774,
    NPC_JIA_CRANE               = 98939,
    NPC_MASTER_CHANG            = 97954,
    NPC_MASTER_HWANG            = 97958,
    NPC_ASPIRING_MONK           = 97679,
    NPC_INITIATE_CHUANG         = 98001,
    NPC_JUNIOR_TRAINEE          = 98074,
    NPC_CHEN_STORMSTOUT         = 100307,
    NPC_LADY_KELETRESS          = 104755,
    NPC_INFERNAL_DESTROYER      = 98011,
    NPC_CHAOS_MINION            = 98286,
    NPC_EYE_OF_KELETRESS        = 105256,
    NPC_FELBLADE_DESTROYER      = 97966,
    NPC_FELBLOOD_PACKHOUND      = 98785,
    NPC_EREDAR_SUMMONER         = 98505,
    NPC_INFERNAL_INVADER        = 98496,
    NPC_VIZZNAK                 = 97968,
    NPC_MORVATH_THE_REAVER      = 97811,
    NPC_PORTAL_MASTER_JORVINAX  = 98217,
    NPC_MASTER_FEL_STONE        = 98353,
    NPC_CREDIT_PILGRIMAGE       = 98514,
};

enum SerenitysEndMisc
{
    QUEST_BEFORE_THE_STORM  = 12103,
    PHASE_NORMAL            = 169,
    MAP_WANDERING_ISLE      = 1514,
};

// --- Shrine of the Ox (temple) ---
Position const PosHight       = { 3826.0f, 1794.0f, 950.92f, 0.05f };
Position const PosPonshu      = { 3824.5f, 1788.5f, 950.92f, 0.60f };
Position const PosJiaCouncil  = { 3824.5f, 1799.5f, 950.92f, 5.70f };
Position const PosChang       = { 3830.0f, 1788.0f, 950.92f, 1.20f };
Position const PosHwang       = { 3830.0f, 1800.0f, 950.92f, 5.20f };
Position const PosMonkA       = { 3833.5f, 1791.0f, 950.92f, 2.80f };
Position const PosMonkB       = { 3833.5f, 1797.0f, 950.92f, 3.40f };
Position const PosChuang      = { 3846.0f, 1794.0f, 951.00f, 3.14f };
Position const PosDestroyer   = { 3853.0f, 1794.0f, 951.50f, 3.14f };
// --- road to the Crane shrine (north-west) ---
Position const PosPackA[3]    = { { 3836.0f, 1858.0f, 944.0f, 4.7f }, { 3841.0f, 1861.0f, 944.0f, 4.7f }, { 3838.5f, 1865.0f, 944.2f, 4.7f } };
Position const PosPackB[3]    = { { 3828.0f, 1925.0f, 939.0f, 4.9f }, { 3833.0f, 1928.0f, 939.0f, 4.9f }, { 3830.5f, 1932.0f, 939.2f, 4.9f } };
Position const PosJiaCrane    = { 3823.0f, 1990.0f, 936.20f, 3.60f };
Position const PosVizznak     = { 3818.0f, 1994.0f, 936.20f, 0.40f };
Position const PosKeletress   = { 3855.0f, 1862.0f, 988.00f, 3.60f };
// --- Tiger courtyard (east) ---
Position const PosTigerArrival= { 4008.0f, 1700.0f, 924.80f, 0.30f };
Position const PosChen        = { 4033.0f, 1693.0f, 924.80f, 2.90f };
Position const PosHounds[3]   = { { 4038.0f, 1688.0f, 924.8f, 2.9f }, { 4040.0f, 1697.0f, 924.8f, 3.1f }, { 4035.0f, 1701.0f, 924.8f, 3.4f } };
Position const PosSummoner    = { 4044.0f, 1700.0f, 924.80f, 3.10f };
Position const PosMorvath     = { 4047.0f, 1688.0f, 924.80f, 3.00f };
Position const PosTrainees[3] = { { 4028.0f, 1690.0f, 924.8f, 2.9f }, { 4029.0f, 1695.0f, 924.8f, 2.9f }, { 4026.0f, 1698.0f, 924.8f, 2.9f } };
// --- escort waypoints (mmaps pathfinding smooths the Z) ---
Position const WPEscort[4]    = { { 4005.0f, 1720.0f, 921.0f }, { 3975.0f, 1750.0f, 915.0f }, { 3955.0f, 1770.0f, 910.0f }, { 3937.0f, 1782.0f, 904.5f } };
Position const PosAmbush      = { 3958.0f, 1778.0f, 910.00f, 4.60f };
// --- portal site (training grounds) ---
Position const PosJorvinax    = { 3915.0f, 1790.0f, 904.30f, 0.10f };
Position const PosHightPortal = { 3938.0f, 1778.0f, 904.30f, 2.90f };
Position const PosFelStone    = { 3910.0f, 1796.0f, 904.30f, 0.00f };
Position const PosWakeUp      = { 739.77f, 3440.22f, 122.19f, 3.10f };

struct scenario_monk_serenitys_end : public InstanceScript
{
    scenario_monk_serenitys_end(InstanceMap* map) : InstanceScript(map) { }

    void Initialize() override
    {
        SetBossNumber(DATA_MAX_STAGES);
        stage = 0;
        introDone = false;
        ambushDone = false;
    }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);
        if (player->GetMapId() != 1014)
            return;

        PhasingHandler::AddPhase(player, PHASE_NORMAL, true);
        player->KilledMonsterCredit(NPC_CREDIT_PILGRIMAGE);

        if (!introDone)
        {
            introDone = true;
            stage = DATA_STAGE_COUNCIL;
            SummonCouncil();
        }
    }

    // Cale le Z au sol (les offsets peuvent sortir du terrain sur les terrasses du pic).
    void SnapToGround(Position& pos) const
    {
        float gz = instance->GetHeight(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ() + 8.0f, true, 60.0f);
        if (gz > INVALID_HEIGHT && gz - pos.GetPositionZ() < 60.0f && pos.GetPositionZ() - gz < 60.0f)
            pos.m_positionZ = gz + 0.5f;
    }

    // Une invocation faite par la MAP n herite d aucune phase (contrairement a un summon
    // fait par une creature) : sans ca elle est invisible/intangible pour le joueur, qui est
    // place en phase 169 par OnPlayerEnter -> PNJ de quete introuvable, vague intuable.
    // (defaut systemique detecte par le harnais bot le 26/07, deja corrige dans le runner d artefacts)
    TempSummon* SummonPhased(uint32 entry, Position const& pos)
    {
        Position p = pos;
        SnapToGround(p);
        TempSummon* summon = instance->SummonCreature(entry, p);
        if (summon)
            PhasingHandler::AddPhase(summon, PHASE_NORMAL, true);
        return summon;
    }

    void SummonCouncil()
    {
        if (Creature* hight = SummonPhased(NPC_MASTER_HIGHT_COUNCIL, PosHight))
            hightGUID = hight->GetGUID();
        SummonPhased(NPC_IRON_BODY_PONSHU, PosPonshu);
        SummonPhased(NPC_JIA_COUNCIL, PosJiaCouncil);
        SummonPhased(NPC_MASTER_CHANG, PosChang);
        SummonPhased(NPC_MASTER_HWANG, PosHwang);
        SummonPhased(NPC_ASPIRING_MONK, PosMonkA);
        SummonPhased(NPC_ASPIRING_MONK, PosMonkB);
    }

    void CompleteStep()
    {
        if (Scenario* scenario = instance->GetInstanceScenario())
            scenario->CompleteCurrStep();
    }

    Creature* GetKeletress() { return instance->GetCreature(keletressGUID); }

    void SetData(uint32 type, uint32 data) override
    {
        InstanceScript::SetData(type, data);
        if (data != DONE)
            return;

        switch (type)
        {
            case DATA_COUNCIL_TALKED: // stage 1: council speech, then the Legion crashes in
            {
                if (Creature* hight = instance->GetCreature(hightGUID))
                {
                    hight->AI()->Talk(1);
                    hight->GetScheduler().Schedule(Seconds(8), [this](TaskContext /*context*/)
                    {
                        if (Creature* chuang = SummonPhased(NPC_INITIATE_CHUANG, PosChuang))
                            chuang->AI()->Talk(0);
                    }).Schedule(Seconds(12), [this](TaskContext /*context*/)
                    {
                        if (Creature* hight2 = instance->GetCreature(hightGUID))
                            hight2->AI()->Talk(2);
                        if (Creature* destroyer = SummonPhased(NPC_INFERNAL_DESTROYER, PosDestroyer))
                            destroyer->SetInCombatWithZone();
                    });
                }
                break;
            }
            case DATA_DESTROYER_DEAD: // stage 1 -> 2
            {
                stage = DATA_STAGE_CRANE;
                CompleteStep();
                if (Creature* hight = instance->GetCreature(hightGUID))
                    hight->AI()->Talk(3);
                for (uint8 i = 0; i < 3; ++i)
                {
                    SummonPhased(i < 2 ? NPC_CHAOS_MINION : NPC_EYE_OF_KELETRESS, PosPackA[i]);
                    SummonPhased(i < 2 ? NPC_CHAOS_MINION : NPC_FELBLADE_DESTROYER, PosPackB[i]);
                }
                if (Creature* keletress = SummonPhased(NPC_LADY_KELETRESS, PosKeletress))
                {
                    keletressGUID = keletress->GetGUID();
                    keletress->SetCanFly(true);
                    keletress->SetDisableGravity(true);
                    keletress->AI()->Talk(0);
                }
                if (Creature* jia = SummonPhased(NPC_JIA_CRANE, PosJiaCrane))
                {
                    jiaGUID = jia->GetGUID();
                    if (Creature* vizznak = SummonPhased(NPC_VIZZNAK, PosVizznak))
                    {
                        jia->AI()->Talk(0);
                        jia->AI()->AttackStart(vizznak);
                        vizznak->AI()->AttackStart(jia);
                    }
                }
                break;
            }
            case DATA_VIZZNAK_DEAD: // stage 2 -> 3 (Jia offers her chi teleport)
            {
                stage = DATA_STAGE_JOURNEY;
                CompleteStep();
                if (Creature* keletress = GetKeletress())
                    keletress->AI()->Talk(1);
                if (Creature* jia = instance->GetCreature(jiaGUID))
                    jia->AI()->Talk(1);
                break;
            }
            case DATA_JIA_TELEPORT: // stage 3 -> 4 (rescue Chen)
            {
                stage = DATA_STAGE_TIGER;
                CompleteStep();
                if (Creature* chen = SummonPhased(NPC_CHEN_STORMSTOUT, PosChen))
                {
                    chenGUID = chen->GetGUID();
                    chen->AI()->Talk(0);
                }
                for (uint8 i = 0; i < 3; ++i)
                {
                    SummonPhased(NPC_JUNIOR_TRAINEE, PosTrainees[i]);
                    if (Creature* hound = SummonPhased(NPC_FELBLOOD_PACKHOUND, PosHounds[i]))
                        if (Creature* chen = instance->GetCreature(chenGUID))
                            hound->AI()->AttackStart(chen);
                }
                SummonPhased(NPC_EREDAR_SUMMONER, PosSummoner);
                SummonPhased(NPC_MORVATH_THE_REAVER, PosMorvath);
                break;
            }
            case DATA_MORVATH_DEAD: // stage 4 -> 5 (escort back)
            {
                stage = DATA_STAGE_CARGO;
                CompleteStep();
                if (Creature* chen = instance->GetCreature(chenGUID))
                {
                    chen->AI()->Talk(2);
                    chen->AI()->DoAction(1); // start escort
                }
                break;
            }
            case DATA_INVADER_DEAD: // ambush cleared, resume escort
            {
                if (Creature* chen = instance->GetCreature(chenGUID))
                    chen->AI()->DoAction(2);
                break;
            }
            case DATA_ESCORT_ARRIVED: // stage 5 -> 6 (Jorvinax)
            {
                stage = DATA_STAGE_PORTAL_BOSS;
                CompleteStep();
                if (Creature* keletress = GetKeletress())
                    keletress->AI()->Talk(2);
                if (Creature* hight = SummonPhased(NPC_MASTER_HIGHT_PORTAL, PosHightPortal))
                    hightPortalGUID = hight->GetGUID();
                if (Creature* jorvinax = SummonPhased(NPC_PORTAL_MASTER_JORVINAX, PosJorvinax))
                    jorvinax->SetInCombatWithZone();
                break;
            }
            case DATA_JORVINAX_DEAD: // stage 6 -> 7 (destroy the fel stone)
            {
                stage = DATA_STAGE_FEL_STONE;
                CompleteStep();
                if (Creature* hight = instance->GetCreature(hightPortalGUID))
                    hight->AI()->Talk(0);
                SummonPhased(NPC_MASTER_FEL_STONE, PosFelStone);
                break;
            }
            case DATA_FEL_STONE_DEAD: // scenario complete -> wake up at the Wandering Isle
            {
                CompleteStep();
                if (Scenario* scenario = instance->GetInstanceScenario())
                    scenario->CompleteScenario();
                if (Creature* keletress = GetKeletress())
                    keletress->DespawnOrUnsummon(2000);
                if (Creature* hight = instance->GetCreature(hightPortalGUID))
                {
                    hight->AI()->Talk(1);
                    hight->GetScheduler().Schedule(Seconds(7), [this](TaskContext /*context*/)
                    {
                        DoOnPlayers([](Player* player)
                        {
                            player->KilledMonsterCredit(NPC_MASTER_FEL_STONE);
                            player->TeleportTo(MAP_WANDERING_ISLE, PosWakeUp.GetPositionX(), PosWakeUp.GetPositionY(), PosWakeUp.GetPositionZ(), PosWakeUp.GetOrientation());
                        });
                    });
                }
                break;
            }
            default:
                break;
        }
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == DATA_CURRENT_STAGE)
            return stage;
        return InstanceScript::GetData(type);
    }

    bool StartAmbush()
    {
        if (ambushDone)
            return false;
        ambushDone = true;
        return true;
    }

private:
    uint32 stage = 0;
    bool introDone = false;
    bool ambushDone = false;
    ObjectGuid hightGUID;
    ObjectGuid hightPortalGUID;
    ObjectGuid jiaGUID;
    ObjectGuid chenGUID;
    ObjectGuid keletressGUID;
};

// Master Hight (council) - talking to him starts the meeting and credits quest objective
struct npc_serenity_master_hight : public ScriptedAI
{
    npc_serenity_master_hight(Creature* creature) : ScriptedAI(creature), talked(false) { }

    void sGossipHello(Player* player) override
    {
        CloseGossipMenuFor(player);
        player->KilledMonsterCredit(me->GetEntry());
        if (talked)
            return;
        talked = true;
        Talk(0);
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(DATA_COUNCIL_TALKED, DONE);
    }

private:
    bool talked;
};

// Number Nine Jia (Crane shrine) - her chi sends the player to the Tiger courtyard
struct npc_serenity_number_nine_jia : public ScriptedAI
{
    npc_serenity_number_nine_jia(Creature* creature) : ScriptedAI(creature), sent(false) { }

    void sGossipHello(Player* player) override
    {
        CloseGossipMenuFor(player);
        InstanceScript* instance = me->GetInstanceScript();
        if (!instance || instance->GetData(DATA_CURRENT_STAGE) != DATA_STAGE_JOURNEY)
            return;
        player->NearTeleportTo(PosTigerArrival.GetPositionX(), PosTigerArrival.GetPositionY(), PosTigerArrival.GetPositionZ(), PosTigerArrival.GetOrientation());
        if (!sent)
        {
            sent = true;
            instance->SetData(DATA_JIA_TELEPORT, DONE);
        }
    }

private:
    bool sent;
};

// generic hostile that reports its death to the instance
struct npc_serenity_death_reporter : public ScriptedAI
{
    npc_serenity_death_reporter(Creature* creature, uint32 dataType) : ScriptedAI(creature), _dataType(dataType) { }

    void JustDied(Unit* /*killer*/) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(_dataType, DONE);
    }

private:
    uint32 _dataType;
};

struct npc_serenity_infernal_destroyer : public npc_serenity_death_reporter
{
    npc_serenity_infernal_destroyer(Creature* creature) : npc_serenity_death_reporter(creature, DATA_DESTROYER_DEAD) { }
};

struct npc_serenity_vizznak : public npc_serenity_death_reporter
{
    npc_serenity_vizznak(Creature* creature) : npc_serenity_death_reporter(creature, DATA_VIZZNAK_DEAD) { }
};

struct npc_serenity_morvath : public npc_serenity_death_reporter
{
    npc_serenity_morvath(Creature* creature) : npc_serenity_death_reporter(creature, DATA_MORVATH_DEAD) { }
};

struct npc_serenity_invader : public npc_serenity_death_reporter
{
    npc_serenity_invader(Creature* creature) : npc_serenity_death_reporter(creature, DATA_INVADER_DEAD) { }
};

struct npc_serenity_jorvinax : public ScriptedAI
{
    npc_serenity_jorvinax(Creature* creature) : ScriptedAI(creature) { }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(0);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(1);
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(DATA_JORVINAX_DEAD, DONE);
    }
};

// Master Fel Stone - a destructible fel crystal (no melee, no movement)
struct npc_serenity_fel_stone : public ScriptedAI
{
    npc_serenity_fel_stone(Creature* creature) : ScriptedAI(creature)
    {
        SetCombatMovement(false);
        me->SetControlled(true, UNIT_STATE_ROOT);
    }

    void AttackStart(Unit* /*who*/) override { }
    void UpdateAI(uint32 /*diff*/) override { }

    void JustDied(Unit* /*killer*/) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->SetData(DATA_FEL_STONE_DEAD, DONE);
    }
};

// Chen Stormstout - fights at the Tiger courtyard, then escorts the trainees back
struct npc_serenity_chen : public ScriptedAI
{
    npc_serenity_chen(Creature* creature) : ScriptedAI(creature), wp(0), escorting(false) { }

    void DoAction(int32 action) override
    {
        InstanceScript* instance = me->GetInstanceScript();
        if (!instance)
            return;

        if (action == 1) // start the escort
        {
            escorting = true;
            wp = 0;
            me->SetWalk(true);
            MoveNext();
        }
        else if (action == 2) // ambush cleared, keep going
        {
            Talk(1);
            MoveNext();
        }
    }

    void MoveNext()
    {
        if (wp < 4)
            me->GetMotionMaster()->MovePoint(wp + 1, WPEscort[wp], true);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || !escorting)
            return;

        InstanceScript* instance = me->GetInstanceScript();
        if (!instance)
            return;

        wp = id;
        if (id == 2) // ambush halfway
        {
            if (scenario_monk_serenitys_end* script = dynamic_cast<scenario_monk_serenitys_end*>(instance))
            {
                if (script->StartAmbush())
                {
                    Talk(3);
                    if (Creature* invader = me->SummonCreature(NPC_INFERNAL_INVADER, PosAmbush, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000))
                        invader->AI()->AttackStart(me);
                    return; // wait for DoAction(2)
                }
            }
            MoveNext();
        }
        else if (id >= 4) // arrived at the portal site
        {
            escorting = false;
            instance->SetData(DATA_ESCORT_ARRIVED, DONE);
        }
        else
            MoveNext();
    }

private:
    uint8 wp;
    bool escorting;
};

void AddSC_scenario_monk_serenitys_end()
{
    RegisterInstanceScript(scenario_monk_serenitys_end, 1014);
    RegisterCreatureAI(npc_serenity_master_hight);
    RegisterCreatureAI(npc_serenity_number_nine_jia);
    RegisterCreatureAI(npc_serenity_infernal_destroyer);
    RegisterCreatureAI(npc_serenity_vizznak);
    RegisterCreatureAI(npc_serenity_morvath);
    RegisterCreatureAI(npc_serenity_invader);
    RegisterCreatureAI(npc_serenity_jorvinax);
    RegisterCreatureAI(npc_serenity_fel_stone);
    RegisterCreatureAI(npc_serenity_chen);
}
