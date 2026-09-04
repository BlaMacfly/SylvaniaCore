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
#include "GameObject.h"
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

    // ==============================================================
    // SylvaniaCore - etape 1 « Storm The Beach » : seuils OFFICIELS.
    //
    // SIGNALE EN JEU : « la phase 1 ou il fallait tuer 33 demons ainsi
    // que d'autres objectifs a ete skip et je suis passe en phase 3
    // direct », et « les objectifs ne se remplissent jamais ».
    //
    // Le script comptait ses propres demons et cloturait l'etape a 12,
    // un chiffre invente qui ne correspondait a rien. Pendant ce temps
    // le client affichait les vrais criteres, figes a zero.
    //
    // Les valeurs ci-dessous viennent de l'arbre de criteres 42935
    // (« Broken Shore - Stage 1 », operateur ALL) du build 7.3.5.26972 :
    //     43010  Demons slain             33   critere 27653
    //     46549  Fel Lords slain           3   critere 29377
    //     46548  Spires of Woe destroyed   3   critere 27619
    //
    // Les trois criteres sont de type CRITERIA_TYPE_SEND_EVENT_SCENARIO
    // (92) : ils ne se remplissent PAS en tuant, mais quand le script
    // emet l'evenement correspondant. C'est ce qui manquait.
    // ==============================================================
    KILLS_BEACH             = 33,   // etait 12, valeur inventee
    FEL_LORDS_BEACH         = 3,
    SPIRES_BEACH            = 3,

    EVENT_DEMONS_SLAIN      = 44095,
    EVENT_FEL_LORDS_SLAIN   = 52643,
    EVENT_SPIRES_DESTROYED  = 44077,

    GO_SPIRE_OF_WOE         = 240194,
    DATA_SPIRE_USED         = 9001,   // signal envoye par le script d'objet

    // ==============================================================
    // Criteres officiels des etapes 2 a 4, releves dans ScenarioStep,
    // CriteriaTree et Criteria du build 7.3.5.26972 :
    //     etape 2  arbre 43554  critere 30883  type 92  asset 45131  x1
    //     etape 3  arbre 43589  critere 28017  type 92  asset 45228  x1
    //     etape 4  arbre 43415  critere 27940  type 92  asset 45288  x4
    //
    // L'ancre du portail a ete identifiee sur la VIDEO de la bataille
    // fournie par l'exploitant, et non deduite : l'objectif y affiche
    // « 0/4 Ancres blindees detruites », puis 2/4, puis 3/4. Il s'agit
    // donc de 101667 « Shielded Anchor », dont la carte porte QUINZE
    // exemplaires deja poses autour de (1107, 2061) -- et non des deux
    // ancres dimensionnelles 90637 que le script invoquait lui-meme.
    // ==============================================================
    NPC_SHIELDED_ANCHOR     = 101667,

    EVENT_COMMANDER_SLAIN   = 45131,
    EVENT_LEADER_FOUND      = 45228,
    EVENT_ANCHOR_DESTROYED  = 45288,

    // ==============================================================
    // Etape 6, « Raser la cite noire ». Son arbre 42770 porte
    // l'operateur 9, CRITERIA_TREE_OPERATOR_SUM_CHILDREN_WEIGHT : la
    // barre vaut 300 points et chaque enfant y contribue selon SON
    // poids, releve dans les DB2 du build 7.3.5.26972 :
    //
    //     asset 44384  poids  1   ->  0,33 % par activation
    //     asset 53062  poids  2   ->  0,67 %
    //     asset 53063  poids  5   ->  1,67 %
    //     asset 53064  poids 10   ->  3,33 %
    //
    // SIGNALE EN JEU : « la phase 6 ne progresse pas en tuant, la
    // progression reste a 0 % ». Le script n'envoyait aucun de ces
    // quatre evenements : il comptait dix morts dans son coin et
    // forcait le passage, laissant la barre morte.
    //
    // DEDUCTION ASSUMEE, ET NON DONNEE : rien n'indique quel ennemi
    // porte quel poids. La cite ne contient que DEUX categories --
    // 94 demons ordinaires et 17 elites -- la ou les poids en
    // supposent quatre. On attribue donc le poids 2 aux ordinaires et
    // le poids 5 aux elites, ce qui fait progresser la barre a
    // proportion de la difficulte. Les poids 1 et 10 restent
    // inemployes faute de savoir ce qu'ils designent.
    // ==============================================================
    EVENT_CITY_TRASH        = 53062,  // poids 2
    EVENT_CITY_ELITE        = 53063,  // poids 5

    // Etapes 7 a 9, criteres releves dans les memes DB2 :
    //     etape 7  arbre 42772  critere 29715  asset 50027  x1
    //     etape 8  arbre 43765  critere 28055  asset 44669  x1
    //     etape 9  arbre 47225  critere 29714  asset 44826  x1
    // Le quatrieme poids de la barre de l'etape 6, longtemps inemploye.
    // SIGNALE EN JEU : « les gameobject Legion Cage ne comptent pas »,
    // puis « oui la barre bouge de 1 % » -- les cages alimentent donc
    // bien la barre. Le poids 1 est le seul des quatre qui restait
    // libre, et il correspond a une action mineure : 1 point sur 300,
    // soit 0,33 %, ce qui s'affiche comme 1 % des la deuxieme cage.
    EVENT_CITY_CAGE         = 44384,
    GO_LEGION_CAGE          = 240535,
    GO_LEGION_CAGE_2        = 248819,
    DATA_CAGE_OPENED        = 9002,

    EVENT_TIRION_REACHED    = 50027,
    EVENT_KROSUS_SLAIN      = 44669,
    EVENT_GULDAN_STOPPED    = 44826,

    KILLS_CITY              = 10,
    KILLS_FINALE            = 8,
    ANCHORS_PORTAL          = 4,    // etait 2, valeur inventee
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
        felLordKills = 0;
        spiresDown = 0;
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

        // ==========================================================
        // SylvaniaCore : phasage retire.
        //
        // SIGNALE EN JEU : les creatures etaient visibles, hostiles, mais
        // impossibles a cibler. Une sonde posee dans _IsValidAttackTarget
        // a donne le verdict :
        //     reaction=1 (hostile), aucun drapeau bloquant, vivante,
        //     mesPhases=0  sesPhases=1
        //
        // Deux objets ne se voient que s'ils PARTAGENT une phase
        // (PhaseShift::CanSee, intersection des phases), et
        // UpdateUnphasedFlag retire le statut « non phase » des qu'un
        // objet en possede une. Le joueur n'en avait aucune : aucune
        // intersection possible.
        //
        // Le phasage etait de toute facon une invention locale : le dump
        // de reference laisse les 757 placements de cette carte SANS
        // phase (PhaseId vide). On revient donc a cette configuration --
        // tout le monde non phase, tout le monde se voit.
        //
        // La phase 169 n'existe d'ailleurs pas dans Phase.db2 du build
        // 7.3.5.26972, ce qui la rendait d'autant plus douteuse.
        // ==========================================================

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

    // =================================================================
    // SylvaniaCore : retenir le chef POSE SUR LA CARTE.
    //
    // SIGNALE EN JEU : « je suis en phase 4, je suis juste a cote de
    // Varian et rien ne se valide ».
    //
    // La carte 1460 porte deja les vrais protagonistes -- Varian en
    // (1120, 2484), Vol'jin en (568, 1887), Sylvanas et Jaina -- parmi
    // les 757 creatures transposees. Or le script en invoquait une
    // SECONDE copie sur la plage et ne surveillait que celle-la. Le
    // joueur se tenait donc devant le vrai Varian pendant que l'etape
    // guettait un sosie ailleurs, ou deja disparu.
    //
    // Le spawnId distingue les deux sans ambiguite : une creature issue
    // de la base en porte un, une invocation non.
    // =================================================================
    void OnCreatureCreate(Creature* creature) override
    {
        InstanceScript::OnCreatureCreate(creature);

        if (!creature || !creature->GetSpawnId())
            return;

        if (creature->GetEntry() == NPC_KING_VARIAN)
            placedVarianGUID = creature->GetGUID();
        else if (creature->GetEntry() == NPC_VOLJIN)
            placedVoljinGUID = creature->GetGUID();
    }

    // Le chef a rejoindre : celui de la carte s'il existe, sinon la
    // copie invoquee par le script.
    Creature* FindLeader() const
    {
        ObjectGuid const pose = (team == TEAM_HORDE) ? placedVoljinGUID : placedVarianGUID;
        if (Creature* leader = instance->GetCreature(pose))
            return leader;
        return instance->GetCreature(leaderGUID);
    }

    void CompleteStep()
    {
        if (Scenario* scenario = instance->GetInstanceScenario())
            scenario->CompleteCurrStep();
    }

    // Cale le Z au sol : les ancres officielles sont sures mais les offsets peuvent sortir du terrain.
    void SnapToGround(Position& pos) const
    {
        float gz = instance->GetHeight(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ() + 8.0f, true, 60.0f);
        if (gz > INVALID_HEIGHT && gz - pos.GetPositionZ() < 60.0f && pos.GetPositionZ() - gz < 60.0f)
            pos.m_positionZ = gz + 0.5f;
    }

    // Toute invocation doit partager la phase des joueurs (OnPlayerEnter les met en 169),
    // sinon elle est invisible/intangible : cible de quete introuvable, vague intuable.
    // (defaut systemique detecte par le harnais bot le 26/07, deja corrige dans le runner d artefacts)
    // SylvaniaCore : ne phase plus rien. Laisser la phase 169 ici alors
    // que le joueur n'en a aucune rendrait les invocations invisibles --
    // le probleme meme qu'on vient de corriger, en sens inverse.
    // Conservee comme point de passage unique pour les invocations, au
    // cas ou un traitement commun redevienne necessaire.
    TempSummon* FinalizeSummon(TempSummon* summon) const
    {
        return summon;
    }

    TempSummon* Summon(uint32 entry, Position const& pos)
    {
        Position p = pos;
        SnapToGround(p);
        return FinalizeSummon(instance->SummonCreature(entry, p));
    }

    TempSummon* SummonAt(uint32 entry, Position const& base, float dx, float dy)
    {
        Position pos = { base.GetPositionX() + dx, base.GetPositionY() + dy, base.GetPositionZ(), base.GetOrientation() };
        SnapToGround(pos);
        return FinalizeSummon(instance->SummonCreature(entry, pos));
    }

    void SummonWave(Position const& base, uint8 count)
    {
        static uint32 const demons[5] = { NPC_CHAOS_MINION, NPC_FELBLOOD_PACKHOUND, NPC_FELBLADE_DESTROYER, NPC_EREDAR_SUMMONER, NPC_INFERNAL_DESTROYER };
        for (uint8 i = 0; i < count; ++i)
        {
            float dx = (i % 4) * 7.0f - 10.5f + (i >= 4 ? 3.5f : 0.0f);
            float dy = (i / 4) * 8.0f - 8.0f;
            if (TempSummon* demon = SummonAt(demons[i % 5], base, dx + 15.0f, dy + 15.0f))
            {
                // les TempSummon de Map n aggro pas seules : on engage la vague explicitement
                demon->SetReactState(REACT_AGGRESSIVE);
                demon->SetInCombatWithZone();
            }
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
                OnDemonDied(creature);
                break;
            // Les treize Seigneurs gangrebois places sur la carte. L'etape
            // en exige trois ; on les enumere explicitement plutot que de
            // filtrer sur le nom, qui n'est pas une donnee stable.
            case 91588:  case 102703: case 102704: case 102705:
            case 109586: case 109587: case 111156: case 113036:
            case 113037: case 113038: case 113057: case 113058:
            case 113059:
                if (stage == STAGE_STORM_BEACH)
                {
                    ++felLordKills;
                    DoSendEventScenario(EVENT_FEL_LORDS_SLAIN);
                    TryFinishBeach();
                }
                break;
            case NPC_ARGANOTH:
                if (stage == STAGE_COMMANDER)
                {
                    creature->AI()->Talk(1);
                    DoSendEventScenario(EVENT_COMMANDER_SLAIN);
                    stage = STAGE_FIND_LEADER;
                    StartFindLeader();
                }
                break;
            case NPC_SHIELDED_ANCHOR:
                if (stage != STAGE_PORTAL)
                    break;

                // Une activation par ancre : le critere en exige quatre.
                DoSendEventScenario(EVENT_ANCHOR_DESTROYED);

                if (++anchorsDown >= ANCHORS_PORTAL)
                {
                    stage = STAGE_RAZE_CITY;
                    SummonWave(Anchors().city, 5);
                    SummonWave(Anchors().city, 5);
                }
                break;
            case NPC_KROSUS:
                if (stage == STAGE_KROSUS)
                {
                    DoSendEventScenario(EVENT_KROSUS_SLAIN);
                    stage = STAGE_STOP_GULDAN;
                    StartFinale();
                }
                break;
            default:
                // =====================================================
                // SylvaniaCore : tout demon compte pour l objectif.
                //
                // SIGNALE EN JEU : « les molosses sont maintenant
                // attaquables mais ne comptent pas dans l objectif du
                // scenario ».
                //
                // Le script ne reconnaissait que les CINQ entrees qu il
                // invoque lui-meme. Or la carte porte 101 entrees de
                // demons placees, affrontees tout au long de l assaut :
                // elles ne crediraient rien.
                //
                // Plutot que d enumerer 101 entrees -- liste qui
                // vieillirait mal --, on s appuie sur la donnee : le type
                // demon. Tous les demons de cette carte sont desormais
                // hostiles (faction 16). Les Seigneurs gangrebois,
                // Arganoth, Krosus et Gul dan sont traites avant et n
                // arrivent jamais ici : ils ont leurs propres criteres.
                // =====================================================
                if (creature->GetCreatureTemplate()->type == CREATURE_TYPE_DEMON)
                    OnDemonDied(creature);
                break;
        }
    }

    // Le script d'objet des Fleches de la Detresse passe par ici : un
    // objet de type 10 est ACTIONNE, pas detruit, et aucun point d'entree
    // d'instance ne rapporte cette utilisation.
    void SetData(uint32 type, uint32 /*data*/) override
    {
        if (type == DATA_CAGE_OPENED)
        {
            // Une cage ne vaut que pendant l'assaut de la cite.
            if (stage == STAGE_RAZE_CITY)
                DoSendEventScenario(EVENT_CITY_CAGE);
            return;
        }

        if (type != DATA_SPIRE_USED || stage != STAGE_STORM_BEACH)
            return;

        ++spiresDown;
        DoSendEventScenario(EVENT_SPIRES_DESTROYED);
        TryFinishBeach();
    }

    // L'etape ne s'acheve que si les TROIS criteres officiels sont
    // remplis -- operateur ALL de l'arbre 42935.
    void TryFinishBeach()
    {
        if (stage != STAGE_STORM_BEACH)
            return;

        if (beachKills < KILLS_BEACH || felLordKills < FEL_LORDS_BEACH || spiresDown < SPIRES_BEACH)
            return;

        // Les trois criteres officiels ont ete alimentes a chaque mort :
        // le moteur acheve l'etape de lui-meme. Un CompleteStep() ici
        // ferait avancer une SECONDE fois -- c'est la cause du saut
        // d'etapes signale en jeu (« j'ai passe ma phase 2 et ca m'a
        // switche jusqu'a la 5 sans rien faire »).
        stage = STAGE_COMMANDER;

        if (Creature* arganoth = Summon(NPC_ARGANOTH, Anchors().commander))
        {
            arganoth->AI()->Talk(0);
            arganoth->SetInCombatWithZone();
        }
    }

    void OnDemonDied(Creature* mort)
    {
        switch (stage)
        {
            case STAGE_STORM_BEACH:
                ++beachKills;
                DoSendEventScenario(EVENT_DEMONS_SLAIN);
                TryFinishBeach();
                break;
            case STAGE_RAZE_CITY:
            {
                // La barre officielle avance selon la valeur de l'ennemi.
                bool const elite = mort && mort->GetCreatureTemplate()->rank > 0;
                DoSendEventScenario(elite ? EVENT_CITY_ELITE : EVENT_CITY_TRASH);
                ++cityKills;

                // Des vagues continuent d'affluer tant que la cite tient :
                // sans cela la barre ne pourrait pas se remplir, la zone ne
                // comptant pas assez de defenseurs pour ses 300 points.
                //
                // SIGNALE EN JEU : « en phase 6 j'ai des invocations de
                // demon sur ma tronche ». Elles naissaient au point de
                // ralliement, c'est-a-dire au milieu du combat. Elles
                // arrivent desormais de la peripherie et chargent.
                if ((cityKills % 6) == 0)
                    SummonWaveLoin();

                // FILET DE SECURITE, pas un mecanisme. Si la barre restait
                // bloquee pour une raison qui nous echappe, le joueur ne
                // doit pas rester prisonnier de l'etape.
                if (cityKills >= 90)
                {
                    stage = STAGE_HIGHLORD;
                    CompleteStep();
                    StartHighlord();
                }
                break;
            }
            case STAGE_STOP_GULDAN:
                if (++finaleKills >= KILLS_FINALE)
                    FinishScenario();
                break;
            default:
                break;
        }
    }

    // Renforts de la cite : ils surgissent en peripherie, a une
    // cinquantaine de metres, sur un cercle dont l'orientation change a
    // chaque vague -- puis ils chargent. Aucun demon ne se materialise
    // dans le dos du joueur.
    void SummonWaveLoin()
    {
        static uint32 const demons[5] =
            { NPC_CHAOS_MINION, NPC_FELBLOOD_PACKHOUND, NPC_FELBLADE_DESTROYER,
              NPC_EREDAR_SUMMONER, NPC_INFERNAL_DESTROYER };

        FactionAnchors const& a = Anchors();
        float const depart = frand(0.0f, float(M_PI) * 2.0f);

        for (uint8 i = 0; i < 5; ++i)
        {
            float const angle = depart + float(i) * (float(M_PI) * 2.0f / 5.0f);
            float const rayon = frand(45.0f, 60.0f);

            if (TempSummon* demon = SummonAt(demons[i], a.city,
                                             std::cos(angle) * rayon,
                                             std::sin(angle) * rayon))
            {
                demon->SetReactState(REACT_AGGRESSIVE);
                demon->SetInCombatWithZone();
            }
        }
    }

    void StartFindLeader()
    {
        FactionAnchors const& a = Anchors();

        // On ne DEPLACE plus le chef. L'etape s'intitule « Trouver
        // Varian » : le joueur doit aller a lui, la ou la carte le pose.
        // Le teleporter au point de ralliement revenait a le mettre
        // sous les pieds du joueur, et la detection de proximite se
        // declenchait alors dans la seconde.
        SummonAt(NPC_KHADGAR, a.city, 4.0f, 3.0f);
        for (uint8 i = 0; i < 3; ++i)
            SummonAt(TroopEntry(), a.city, -6.0f + i * 6.0f, -5.0f);

        // « Find Varian » : detection de proximite
        scheduler.Schedule(Seconds(2), [this](TaskContext context)
        {
            if (stage != STAGE_FIND_LEADER)
                return;
            bool found = false;
            Creature* leader = FindLeader();
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
                DoSendEventScenario(EVENT_LEADER_FOUND);
                stage = STAGE_PORTAL;
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
        // Les ancres blindees (101667) sont DEJA posees sur la carte,
        // quinze exemplaires autour de (1107, 2061). Rien a invoquer :
        // le script en fabriquait deux fausses, d'une autre entree, que
        // le critere officiel ne reconnaissait pas.
        SummonAt(NPC_EREDAR_SUMMONER, a.portal, 0.0f, 6.0f);
        SummonAt(NPC_CHAOS_MINION, a.portal, -5.0f, 8.0f);
        SummonAt(NPC_CHAOS_MINION, a.portal, 5.0f, 8.0f);
    }

    void StartHighlord()
    {
        // =============================================================
        // SylvaniaCore : l'etape s'intitule « Atteindre Tirion ».
        //
        // SIGNALE EN JEU : « la 7 c'est Tirion, il est passe
        // automatiquement et ca me passe en 8 ».
        //
        // La minuterie de douze secondes validait l'etape SANS LE
        // JOUEUR, et Tirion disparaissait au bout de vingt secondes --
        // impossible de l'atteindre meme en courant. Meme defaut que
        // « Trouver Varian » : le script decidait a la place du joueur.
        //
        // On attend desormais qu'un joueur le rejoigne, et on alimente
        // le critere officiel 50027. Tirion reste en place : il agonise
        // dans la crevasse, il n'a aucune raison de s'evaporer.
        // =============================================================
        FactionAnchors const& a = Anchors();
        if (Creature* tirion = Summon(NPC_TIRION, a.crevasse))
        {
            tirionGUID = tirion->GetGUID();
            tirion->AI()->Talk(0);
            tirion->SetStandState(UNIT_STAND_STATE_KNEEL);
        }

        scheduler.Schedule(Seconds(2), [this](TaskContext context)
        {
            if (stage != STAGE_HIGHLORD)
                return;

            Creature* tirion = instance->GetCreature(tirionGUID);
            if (!tirion)
                return;

            bool atteint = false;
            DoOnPlayers([&atteint, tirion](Player* player)
            {
                if (player->IsWithinDist(tirion, 25.0f, false))
                    atteint = true;
            });

            if (!atteint)
            {
                context.Repeat(Seconds(2));
                return;
            }

            DoSendEventScenario(EVENT_TIRION_REACHED);
            stage = STAGE_KROSUS;
            SceneMortTirion();
        });
    }

    // =================================================================
    // SylvaniaCore : la mort de Tirion, mise en scene.
    //
    // SIGNALE EN JEU : « p7 c'est Krosus qui plonge Tirion dans le fiel
    // normalement, et la pas de script de scenario ». Le script se
    // contentait d'invoquer Krosus douze secondes plus tard.
    //
    // Sequence officielle, relevee sur Warcraft Wiki :
    //   Tirion  « Stay back... it's a trap... »
    //   Gul'dan « Ha, you fool! You stand before the temple of a GOD... »
    //   Krosus surgit de la lave.
    //   Gul'dan « Destroy him. »
    //   Krosus souffle sur Tirion, qui sombre sous la lave.
    //   Thrall  « Fordring! »
    //   Gul'dan « All you have worked for... » puis « Destroy them! »
    //
    // Les huit repliques portent leur BroadcastTextId et leur Sound
    // d'origine : le client joue la voix et affiche sa propre langue.
    //
    // Gul'dan est invoque des maintenant, au sommet du tombeau. Il y
    // domine toute la fin du scenario -- c'est de la qu'il parle, et la
    // finale le reutilise au lieu d'en invoquer un second.
    // =================================================================
    void SceneMortTirion()
    {
        FactionAnchors const& a = Anchors();

        if (Creature* guldan = Summon(NPC_GULDAN, a.tomb))
        {
            guldanGUID = guldan->GetGUID();
            guldan->SetReactState(REACT_PASSIVE);
            guldan->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
        }

        auto dire = [this](ObjectGuid const& guid, uint8 groupe)
        {
            if (Creature* qui = instance->GetCreature(guid))
                qui->AI()->Talk(groupe);
        };

        // 0 s -- Tirion comprend le piege
        dire(tirionGUID, 20);

        scheduler.Schedule(Seconds(5), [this, dire](TaskContext /*c*/)
        {
            dire(guldanGUID, 20);                       // « Ha, you fool!... »
        });

        scheduler.Schedule(Seconds(11), [this](TaskContext /*c*/)
        {
            // Krosus surgit de la lave, encore passif
            if (Creature* krosus = Summon(NPC_KROSUS, Anchors().crevasse))
            {
                krosusGUID = krosus->GetGUID();
                krosus->SetReactState(REACT_PASSIVE);
                krosus->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
            }
        });

        scheduler.Schedule(Seconds(14), [this, dire](TaskContext /*c*/)
        {
            dire(guldanGUID, 21);                       // « Destroy him. »
        });

        scheduler.Schedule(Seconds(17), [this, dire](TaskContext /*c*/)
        {
            // Le souffle de Krosus emporte Tirion
            Creature* krosus = instance->GetCreature(krosusGUID);
            Creature* tirion = instance->GetCreature(tirionGUID);
            if (krosus && tirion)
                krosus->SetFacingToObject(tirion);

            dire(tirionGUID, 21);                       // « The Light... ahh! »
        });

        scheduler.Schedule(Seconds(20), [this](TaskContext /*c*/)
        {
            // Il sombre sous la lave
            if (Creature* tirion = instance->GetCreature(tirionGUID))
            {
                tirion->SetStandState(UNIT_STAND_STATE_DEAD);
                tirion->DespawnOrUnsummon(4000);
            }
        });

        scheduler.Schedule(Seconds(23), [this, dire](TaskContext /*c*/)
        {
            dire(leaderGUID, 20);                       // riposte du chef
            DoOnPlayers([](Player* /*player*/) { });
        });

        scheduler.Schedule(Seconds(27), [this, dire](TaskContext /*c*/)
        {
            dire(guldanGUID, 22);                       // « All you have worked for... »
        });

        scheduler.Schedule(Seconds(33), [this, dire](TaskContext /*c*/)
        {
            dire(guldanGUID, 23);                       // « Destroy them! »

            if (Creature* krosus = instance->GetCreature(krosusGUID))
            {
                krosus->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
                krosus->SetReactState(REACT_AGGRESSIVE);
                krosus->SetInCombatWithZone();
            }
        });
    }

    void StartFinale()
    {
        FactionAnchors const& a = Anchors();

        // Gul'dan est deja au sommet du tombeau depuis la mort de
        // Tirion : on ne l'invoque une seconde fois que s'il a disparu.
        Creature* guldan = instance->GetCreature(guldanGUID);
        if (!guldan)
        {
            guldan = Summon(NPC_GULDAN, a.tomb);
            if (guldan)
            {
                guldanGUID = guldan->GetGUID();
                guldan->SetReactState(REACT_PASSIVE);
            }
        }
        if (guldan)
            guldan->AI()->Talk(0);
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
        DoSendEventScenario(EVENT_GULDAN_STOPPED);
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
    uint8 felLordKills = 0;
    uint8 spiresDown = 0;
    uint8 cityKills = 0;
    uint8 finaleKills = 0;
    uint8 anchorsDown = 0;
    TeamId team = TEAM_ALLIANCE;
    ObjectGuid leaderGUID;
    ObjectGuid jainaGUID;
    ObjectGuid sylvanasGUID;
    ObjectGuid placedVarianGUID;
    ObjectGuid placedVoljinGUID;
    ObjectGuid tirionGUID;
    ObjectGuid krosusGUID;
    ObjectGuid guldanGUID;
    TaskScheduler scheduler;
};

// Fleche de la Detresse : objet de type 10 (actionnable). GameObject::Use
// appelle sScriptMgr->OnGossipHello avant tout traitement specifique, ce
// qui nous donne le seul point d'accroche disponible. On renvoie false
// pour laisser le comportement normal se poursuivre.
// Les cages de la Legion, disseminees dans la cite. Les liberer fait
// avancer la barre de l'etape 6.
class go_legion_cage : public GameObjectScript
{
public:
    go_legion_cage() : GameObjectScript("go_legion_cage") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            instance->SetData(DATA_CAGE_OPENED, 1);

        return false;   // on laisse le comportement normal se poursuivre
    }
};

class go_spire_of_woe : public GameObjectScript
{
public:
    go_spire_of_woe() : GameObjectScript("go_spire_of_woe") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            instance->SetData(DATA_SPIRE_USED, 1);

        return false;
    }
};

void AddSC_scenario_broken_shore_intro()
{
    RegisterInstanceScript(scenario_broken_shore_intro, 1460);
    new go_spire_of_woe();
    new go_legion_cage();
}
