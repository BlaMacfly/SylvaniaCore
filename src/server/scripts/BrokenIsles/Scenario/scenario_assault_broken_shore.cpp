/*
 * Scenario : Assaut du Rivage brise (ScenarioID 1280, carte 1666)
 *
 * Contenu de la 7.2, a ne pas confondre avec le scenario d'INTRODUCTION
 * de la 7.0 (ScenarioID 786, carte 1460, scenario_broken_shore_intro.cpp)
 * ou l'on suit Varian, Vol'jin, Krosus et Gul'dan. Celui-ci est l'assaut
 * mene depuis Dalaran, et c'est LUI dont dependent les quetes bloquees
 * 45102 « Begin the Assault » et 46734 « Assault on Broken Shore ».
 *
 * PORTAGE, PAS TRANSCRIPTION
 * Source : dufernst/LegionCore-7.3.5 (AssaultBrokenShore.cpp 500 lignes +
 * instance_AssaultBrokenShore.cpp 308 lignes), meme lignee uwow que notre
 * fork. Son architecture repose sur des extensions que nous n'avons PAS :
 *
 *   onScenarionNextStep(step) / getScenarionStep()  hook de progression
 *   CRITERIA_TYPE_SCRIPT_EVENT_2                    type de critere
 *   FunctionProcessor                               ordonnanceur
 *   GetClosestGraveYard(x,y,z)                      surcharge d'instance
 *
 * Aucun de ces quatre elements n'existe ici. La progression est donc
 * inversee : au lieu d'etre RAPPELE a chaque etape, le script alimente
 * les criteres officiels et le moteur avance de lui-meme, exactement
 * comme sur la carte 1460.
 *
 * CRITERES OFFICIELS, releves dans les DB2 du build 7.3.5.26972
 * (ScenarioStep / CriteriaTree / Criteria), et non recopies de la source :
 *
 *   ordre  arbre   critere  type  asset    montant  intitule
 *     0    56811   35285     92   56460       1     Into the Fray
 *     1    56872   35328     92   56697       3     Vanguard of the Assault
 *     2    56874   35329     92   56500       1     Might of the Legion
 *     3    57180   35496     92   56779     200     Rifts of Chaos (barre)
 *          57185   35495     73   56778       3     ... + les 3 portails
 *     4    57183   35497     92   56780       1     The Doomguard's Command
 *     5    57293   35551     68  267955       1     Gateway to Ruin
 *     6    58303   36178     92   57574       7     Pillar of Fire
 *     7    59170   36179     92   57579       1     Mephistroth
 *
 *   type 92 = CRITERIA_TYPE_SEND_EVENT_SCENARIO -> DoSendEventScenario
 *   type 73 = CRITERIA_TYPE_SEND_EVENT          -> UpdateCriteria
 *   type 68 = CRITERIA_TYPE_USE_GAMEOBJECT      -> UpdateCriteria
 *
 * Les identifiants d'asset de la source coincident avec les officiels :
 * verification faite, ils sont conserves.
 *
 * ECARTS D'API TRAITES, tous constates dans notre code et non supposes :
 *   DamageTaken(Unit*, uint32&)              2 arguments, pas 3
 *   OnSpellClick(Unit*, bool&)               2 arguments, pas 1
 *   EnterEvadeMode(EvadeReason)              prend un motif
 *   GameObjectScript::OnGossipHello(Player*, GameObject*)
 *   MotionMaster::MovePath(id, repeatable)   2 arguments, pas 4
 *   PlayerList : GetSource(), pas getSource()
 *   CreateConversation n'existe QUE sur Player -- la source l'appelle
 *   sur une creature, cela n'aurait pas compile.
 *
 * NON PORTE, deliberement : player_scripts_for_start_assault, qui
 * sondait CHAQUE joueur a chaque tick pour lui imposer la quete 46730.
 * Un donneur de quete en base fait le meme travail sans le cout.
 *
 * Le nom d'enregistrement « scenario_7.2_broken_shore_intro » est celui
 * qu'exige deja instance_template pour la carte 1666. Il contient un
 * point, donc ne peut pas passer par la macro RegisterInstanceScript :
 * la classe est ecrite a la main pour ne pas avoir a toucher la base.
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Scenario.h"
#include "InstanceScenario.h"
#include "ScriptedCreature.h"
#include "MotionMaster.h"
#include "Player.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "TemporarySummon.h"
#include "ObjectAccessor.h"
#include "Conversation.h"

enum AssautCreatures
{
    // hostiles nommes
    NPC_KALGORATH               = 116291, // etape 2
    NPC_ARGANOTH                = 118551, // etape 4, invisible au depart
    NPC_MEPHISTROTH             = 120746, // etape 7, invisible au depart
    NPC_ILLIDAN                 = 119130,

    // allies accompagnant l'assaut
    NPC_ALLIE_MAIEV             = 119133,
    NPC_ALLIE_MAGE_KIRIN_TOR    = 118412,
    NPC_ALLIE_BLOOMER           = 121232,
    NPC_ALLIE_CHAMAN            = 118966,
    NPC_ALLIE_GRAND_PRETRE      = 121146,
    NPC_ALLIE_ILLIDARI          = 118969,
    NPC_ALLIE_HAUTE_GARDE       = 118945,
    NPC_ALLIE_GARDIEN_KIRIN_TOR = 118444,

    // vehicule d'arrivee
    NPC_CORBEAU_ARCANIQUE       = 118517,

    // interactifs
    NPC_PORTAIL_LEGION          = 118558, // etape 3, a fermer x3
    NPC_BOMBE_ARCANIQUE         = 120743, // etape 6, a poser x7

    NPC_INFERNAL_INTRO          = 118416,
};

// Elites de la plage : etape 1, trois suffisent.
uint32 const ELITES_PLAGE[] = { 118654, 118453, 118886, 118456 };

// Pietaille comptant pour la barre de progression de l'etape 3.
uint32 const PIETAILLE_RIFTS[] =
{
    120511, 118711, 118644, 118647, 118645, 118656, 118655, 118708,
    118658, 118563, 118659, 118646, 118650, 118648, 118652, 118653,
    118707, 118688, 118457, 118416
};

enum AssautCriteres
{
    ASSET_ARRIVEE               = 56460, // etape 0, x1
    ASSET_ELITE_PLAGE           = 56697, // etape 1, x3
    ASSET_KALGORATH             = 56500, // etape 2, x1
    ASSET_PIETAILLE             = 56779, // etape 3, barre de 200
    ASSET_PORTAIL_FERME         = 56778, // etape 3, x3  (type 73)
    ASSET_ARGANOTH              = 56780, // etape 4, x1
    ASSET_PASSERELLE            = 267955,// etape 5, x1  (type 68)
    ASSET_BOMBE                 = 57574, // etape 6, x7
    ASSET_MEPHISTROTH           = 57579, // etape 7, x1
};

enum AssautConversations
{
    CONV_ARRIVEE                = 4828,
    CONV_DEBARQUEMENT           = 4829,
    CONV_PLAGE_1                = 4831,
    CONV_PLAGE_2                = 4832,
    CONV_KALGORATH              = 4887,
    CONV_MEPHISTROTH            = 4870,
    CONV_FINALE                 = 4892,
    CONV_ENTREE                 = 4526,
};

enum AssautSorts
{
    SPELL_ENTREE_AURA           = 240155,
    SPELL_ENTREE_INVOCATION     = 243303,
    SPELL_ENTREE_A_RETIRER      = 240188,
    SPELL_MONTER_CORBEAU        = 52391,
    SPELL_PASSERELLE            = 236671,
    SPELL_FINALE                = 243824,
    SPELL_INFERNAL_1            = 205266,
    SPELL_INFERNAL_2            = 239649,
    SPELL_MAGE_REACTION         = 46604,
    SPELL_BOMBE_VISUEL          = 144373,
};

enum AssautChemins
{
    CHEMIN_CORBEAU              = 11322708,
    CHEMIN_ALLIES_PLAGE         = 11322705,
    CHEMIN_ALLIES_APRES_MAIEV   = 11322706,
    CHEMIN_ALLIES_ARGANOTH      = 11322709,
    CHEMIN_ALLIES_DEBUT         = 11322707,
};

// Signaux envoyes a l'instance par les scripts de creature et d'objet.
// On passe par SetData plutot que d'appeler DoSendEventScenario depuis
// l'exterieur : l'instance reste seule maitresse de la progression.
enum AssautSignaux
{
    DATA_ARRIVEE_ACCOMPLIE      = 9201,
    DATA_PORTAIL_FERME          = 9202,
    DATA_BOMBE_POSEE            = 9203,
    DATA_PASSERELLE_UTILISEE    = 9204,
};

enum AssautQuetes
{
    QUETE_ASSAUT                = 46734,
    CREDIT_SPIRE_1              = 116253, // « First Legion Spire destroyed »
    CREDIT_SPIRE_2              = 116279, // « Second Legion Spire destroyed »
    CREDIT_KHADGAR              = 120215, // « Speak to Khadgar »
};

static bool EstDansListe(uint32 entree, uint32 const* liste, size_t taille)
{
    for (size_t i = 0; i < taille; ++i)
        if (liste[i] == entree)
            return true;
    return false;
}

class instance_assaut_rivage_brise : public InstanceMapScript
{
public:
    instance_assaut_rivage_brise() : InstanceMapScript("scenario_7.2_broken_shore_intro", 1666) { }

    struct instance_assaut_rivage_brise_InstanceMapScript : public InstanceScript
    {
        instance_assaut_rivage_brise_InstanceMapScript(InstanceMap* map) : InstanceScript(map) { }

        GuidList allies;
        ObjectGuid arganothGuid;
        ObjectGuid illidanGuid;
        ObjectGuid mephistrothGuid;

        uint32 elitesTues    = 0;
        uint32 portailsFermes = 0;
        uint32 bombesPosees  = 0;
        bool   arganothRevele = false;
        bool   mephistrothRevele = false;

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ALLIE_MAIEV:
                case NPC_ALLIE_MAGE_KIRIN_TOR:
                case NPC_ALLIE_BLOOMER:
                case NPC_ALLIE_CHAMAN:
                case NPC_ALLIE_GRAND_PRETRE:
                case NPC_ALLIE_ILLIDARI:
                case NPC_ALLIE_HAUTE_GARDE:
                case NPC_ALLIE_GARDIEN_KIRIN_TOR:
                    allies.push_back(creature->GetGUID());
                    break;
                case NPC_ARGANOTH:
                    // Reste hors d'atteinte jusqu'a l'etape 4.
                    creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
                    creature->SetVisible(false);
                    arganothGuid = creature->GetGUID();
                    break;
                case NPC_ILLIDAN:
                    illidanGuid = creature->GetGUID();
                    break;
                case NPC_MEPHISTROTH:
                    creature->SetVisible(false);
                    mephistrothGuid = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnPlayerEnter(Player* player) override
        {
            // SONDE TEMPORAIRE RIVAGEDBG
            TC_LOG_ERROR("misc", "RIVAGEDBG OnPlayerEnter : %s en (%.0f, %.0f, %.0f)",
                player ? player->GetName().c_str() : "aucun",
                player ? player->GetPositionX() : 0.f,
                player ? player->GetPositionY() : 0.f,
                player ? player->GetPositionZ() : 0.f);

            if (!player)
                return;

            player->CastSpell(player, SPELL_ENTREE_AURA, true);

            // FILET DE SECURITE, temporaire.
            // L'etape 0 n'est creditee que par l'arrivee du corbeau. Si
            // celui-ci ne vole pas, le scenario reste bloque des la
            // premiere etape et le reste devient intestable. On credite
            // donc l'arrivee au bout de 20 s si elle ne l'a pas ete.
            // A RETIRER une fois le vol repare.
            InstanceScript* moi = this;
            player->AddDelayedEvent(20000, [moi]() -> void
            {
                moi->SetData(DATA_ARRIVEE_ACCOMPLIE, 1);
            });

            player->AddDelayedEvent(5000, [player]() -> void
            {
                // SONDE TEMPORAIRE RIVAGEDBG
                TC_LOG_ERROR("misc", "RIVAGEDBG invocation du corbeau (sort %u)", uint32(SPELL_ENTREE_INVOCATION));
                player->CastSpell(player, SPELL_ENTREE_INVOCATION, true);

                std::list<Creature*> escorte;
                GetCreatureListWithEntryInGrid(escorte, player, NPC_ALLIE_MAGE_KIRIN_TOR, 50.0f);
                for (Creature* c : escorte)
                    c->CastSpell(c, SPELL_ENTREE_INVOCATION, true);

                player->AddDelayedEvent(4000, [player]() -> void
                {
                    player->RemoveAura(SPELL_ENTREE_A_RETIRER);
                    Conversation::CreateConversation(CONV_ENTREE, player, player->GetPosition(), { player->GetGUID() });
                });
            });
        }

        // Diffuse une conversation a tous les joueurs de l'instance.
        // La source la jouait pour le PREMIER joueur seulement (break dans
        // la boucle) : correct en solo, muet pour les autres en groupe.
        void ConversationPourTous(uint32 conversationId)
        {
            Map::PlayerList const& liste = instance->GetPlayers();
            for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                if (Player* player = i->GetSource())
                    Conversation::CreateConversation(conversationId, player, player->GetPosition(), { player->GetGUID() });
        }

        void CritereJoueurs(CriteriaTypes type, uint32 asset)
        {
            Map::PlayerList const& liste = instance->GetPlayers();
            for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                if (Player* player = i->GetSource())
                    player->UpdateCriteria(type, asset);
        }

        void CreditJoueurs(uint32 creditEntry)
        {
            Map::PlayerList const& liste = instance->GetPlayers();
            for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                if (Player* player = i->GetSource())
                    player->KilledMonsterCredit(creditEntry);
        }

        void DeplacerAllies(uint32 cheminId)
        {
            for (ObjectGuid const& guid : allies)
                if (Creature* allie = instance->GetCreature(guid))
                {
                    allie->GetMotionMaster()->Clear();
                    allie->GetMotionMaster()->MovePath(cheminId, false);
                }
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            switch (type)
            {
                case DATA_ARRIVEE_ACCOMPLIE:
                    // Etape 0 : le corbeau a depose le joueur sur la plage.
                    DoSendEventScenario(ASSET_ARRIVEE);
                    ConversationPourTous(CONV_DEBARQUEMENT);
                    DeplacerAllies(CHEMIN_ALLIES_PLAGE);
                    break;

                case DATA_PORTAIL_FERME:
                    // Etape 3 : critere de type 73, trois portails.
                    CritereJoueurs(CRITERIA_TYPE_SEND_EVENT, ASSET_PORTAIL_FERME);
                    ++portailsFermes;

                    // Les deux premiers portails valent aussi les credits
                    // de la quete 45102, qui parle de « First » et
                    // « Second Legion Spire destroyed ».
                    if (portailsFermes == 1)
                        CreditJoueurs(CREDIT_SPIRE_1);
                    else if (portailsFermes == 2)
                        CreditJoueurs(CREDIT_SPIRE_2);
                    break;

                case DATA_BOMBE_POSEE:
                    // Etape 6 : sept bombes.
                    ++bombesPosees;
                    DoSendEventScenario(ASSET_BOMBE);
                    break;

                case DATA_PASSERELLE_UTILISEE:
                    // Etape 5 : critere de type 68.
                    CritereJoueurs(CRITERIA_TYPE_USE_GAMEOBJECT, ASSET_PASSERELLE);
                    break;

                default:
                    break;
            }
        }

        void OnCreatureKilled(Creature* creature, Player* /*killer*/) override
        {
            if (!creature)
                return;

            uint32 const entree = creature->GetEntry();

            if (entree == NPC_KALGORATH)
            {
                // Etape 2. Le credit de quete porte la meme entree : la
                // mort suffit, aucun credit supplementaire a accorder.
                DoSendEventScenario(ASSET_KALGORATH);
                ConversationPourTous(CONV_KALGORATH);
                DeplacerAllies(CHEMIN_ALLIES_APRES_MAIEV);
                return;
            }

            if (entree == NPC_ARGANOTH)
            {
                // Etape 4.
                DoSendEventScenario(ASSET_ARGANOTH);
                RevelerMephistroth();
                return;
            }

            if (entree == NPC_MEPHISTROTH)
            {
                // Etape 7, fin du scenario.
                DoSendEventScenario(ASSET_MEPHISTROTH);
                Finale();
                return;
            }

            if (EstDansListe(entree, ELITES_PLAGE, std::extent<decltype(ELITES_PLAGE)>::value))
            {
                // Etape 1 : trois elites.
                ++elitesTues;
                DoSendEventScenario(ASSET_ELITE_PLAGE);

                if (elitesTues == 1)
                    ConversationPourTous(CONV_PLAGE_1);
                else if (elitesTues == 2)
                    ConversationPourTous(CONV_PLAGE_2);
                else if (elitesTues >= 3)
                    RevelerArganoth();
                return;
            }

            if (EstDansListe(entree, PIETAILLE_RIFTS, std::extent<decltype(PIETAILLE_RIFTS)>::value))
            {
                // Etape 3 : barre de progression de 200. La source
                // envoyait 2 a 3 unites par mort ; on conserve ce rythme,
                // faute de source officielle sur la valeur exacte.
                uint32 const pas = urand(2, 3);
                for (uint32 i = 0; i < pas; ++i)
                    DoSendEventScenario(ASSET_PIETAILLE);
                return;
            }
        }

        void RevelerArganoth()
        {
            if (arganothRevele)
                return;
            arganothRevele = true;

            Creature* arganoth = instance->GetCreature(arganothGuid);
            if (!arganoth)
                return;

            arganoth->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
            arganoth->SetVisible(true);
            arganoth->GetMotionMaster()->Clear();

            if (Creature* illidan = instance->GetCreature(illidanGuid))
            {
                arganoth->GetMotionMaster()->MovePoint(0, illidan->GetPositionX(), illidan->GetPositionY(), illidan->GetPositionZ());
                illidan->AI()->AttackStart(arganoth);
                arganoth->AI()->AttackStart(illidan);
            }

            DeplacerAllies(CHEMIN_ALLIES_ARGANOTH);
        }

        void RevelerMephistroth()
        {
            if (mephistrothRevele)
                return;
            mephistrothRevele = true;

            if (Creature* mephistroth = instance->GetCreature(mephistrothGuid))
                mephistroth->SetVisible(true);

            // CreateConversation n'existe que sur Player dans ce coeur :
            // la source l'appelait sur la creature, ce qui n'aurait pas
            // compile. On la joue pour les joueurs presents.
            ConversationPourTous(CONV_MEPHISTROTH);
        }

        void Finale()
        {
            Map::PlayerList const& liste = instance->GetPlayers();
            for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
            {
                Player* player = i->GetSource();
                if (!player)
                    continue;

                player->AddDelayedEvent(4000, [player]() -> void
                {
                    Conversation::CreateConversation(CONV_FINALE, player, player->GetPosition(), { player->GetGUID() });
                    player->CastSpell(player, SPELL_FINALE, true);
                    player->KilledMonsterCredit(CREDIT_KHADGAR);
                });
            }
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_assaut_rivage_brise_InstanceMapScript(map);
    }
};

// Les allies qui accompagnent l'assaut. Chacun a sa rotation propre,
// reprise telle quelle de la source : ce sont des donnees, pas des choix.
class npc_assaut_allie : public CreatureScript
{
public:
    npc_assaut_allie() : CreatureScript("npc_assaut_allie") { }

    struct npc_assaut_allieAI : public ScriptedAI
    {
        npc_assaut_allieAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = me->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            switch (me->GetEntry())
            {
                case NPC_ALLIE_MAIEV:
                    DoCast(225184);
                    events.RescheduleEvent(1, 6000);
                    break;
                case NPC_ALLIE_MAGE_KIRIN_TOR:
                    events.RescheduleEvent(2, 2500);
                    events.RescheduleEvent(3, 18000);
                    break;
                case NPC_ALLIE_BLOOMER:
                    DoCast(79833);
                    events.RescheduleEvent(4, 2300);
                    events.RescheduleEvent(5, 14000);
                    break;
                case NPC_ALLIE_CHAMAN:
                    events.RescheduleEvent(6, 4000);
                    events.RescheduleEvent(7, 35000);
                    events.RescheduleEvent(8, 11000);
                    events.RescheduleEvent(9, 14000);
                    break;
                case NPC_ALLIE_GRAND_PRETRE:
                    events.RescheduleEvent(10, 3000);
                    events.RescheduleEvent(11, 13000);
                    events.RescheduleEvent(12, 15000);
                    break;
                case NPC_ALLIE_ILLIDARI:
                    events.RescheduleEvent(13, 7000);
                    events.RescheduleEvent(14, 27000);
                    events.RescheduleEvent(15, 21000);
                    events.RescheduleEvent(16, 31000);
                    break;
                case NPC_ALLIE_HAUTE_GARDE:
                    events.RescheduleEvent(17, 4000);
                    events.RescheduleEvent(18, 9000);
                    events.RescheduleEvent(19, 39000);
                    events.RescheduleEvent(20, 31000);
                    break;
                case NPC_ALLIE_GARDIEN_KIRIN_TOR:
                    events.RescheduleEvent(21, 3000);
                    events.RescheduleEvent(22, 20000);
                    break;
                default:
                    break;
            }
        }

        // Les allies doivent tenir jusqu'au bout de l'assaut : les degats
        // recus sont divises d'autant plus fort qu'ils sont bas en vie.
        // Formule reprise de la source ; le diviseur vaut au minimum 1,
        // donc pas de division par zero.
        void DamageTaken(Unit* /*attacker*/, uint32& damage) override
        {
            uint32 const diviseur = 11 - uint32(me->GetHealthPct() / 10.0f);
            damage /= std::max<uint32>(1, diviseur);
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());

            if (type == WAYPOINT_MOTION_TYPE)
                ChercherUnAdversaire();
        }

        // Cherche un hostile a portee et l'engage.
        bool ChercherUnAdversaire()
        {
            std::list<Creature*> hostiles;
            for (uint32 entree : PIETAILLE_RIFTS)
                GetCreatureListWithEntryInGrid(hostiles, me, entree, 40.0f);
            for (uint32 entree : ELITES_PLAGE)
                GetCreatureListWithEntryInGrid(hostiles, me, entree, 40.0f);

            for (Creature* cible : hostiles)
                if (cible->IsAlive())
                {
                    AttackStart(cible);
                    return true;
                }

            return false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->HasUnitState(UNIT_STATE_STUNNED))
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (uint32 eventId = events.ExecuteEvent())
            {
                struct Rotation { uint32 evenement; uint32 sort; uint32 rappel; };
                static Rotation const rotations[] =
                {
                    {  1, 226063,  6000 },
                    {  2, 183108,  2500 }, {  3, 183075, 18000 },
                    {  4, 182856,  2300 }, {  5, 182854, 14000 },
                    {  6, 190330,  4000 }, {  7, 189804, 35000 },
                    {  8, 190332, 11000 }, {  9, 190331, 14000 },
                    { 10, 183555,  3000 }, { 11, 183553, 13000 }, { 12, 183549, 15000 },
                    { 13, 222971,  7000 }, { 14, 223061, 27000 }, { 15, 223109, 21000 }, { 16, 223903, 31000 },
                    { 17, 183894,  4000 }, { 18, 183897,  9000 }, { 19, 183898, 39000 }, { 20, 190010, 31000 },
                    { 21, 183108,  3000 }, { 22,  13730, 20000 },
                };

                for (Rotation const& r : rotations)
                    if (r.evenement == eventId)
                    {
                        DoCast(r.sort);
                        events.RescheduleEvent(r.evenement, r.rappel);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_assaut_allieAI(creature);
    }
};

// 118517 : le corbeau arcanique qui depose le joueur sur la plage.
// Sa fin de trajet vaut l'etape 0 du scenario.
class npc_assaut_corbeau_arcanique : public CreatureScript
{
public:
    npc_assaut_corbeau_arcanique() : CreatureScript("npc_assaut_corbeau_arcanique") { }

    struct npc_assaut_corbeau_arcaniqueAI : public ScriptedAI
    {
        npc_assaut_corbeau_arcaniqueAI(Creature* creature) : ScriptedAI(creature) { }

        void IsSummonedBy(Unit* summoner) override
        {
            // SONDE TEMPORAIRE RIVAGEDBG
            TC_LOG_ERROR("misc", "RIVAGEDBG corbeau invoque par %s en (%.0f, %.0f, %.0f)",
                summoner ? summoner->GetName().c_str() : "personne",
                me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());

            SetFlyMode(true);
            if (summoner)
                summoner->CastSpell(me, SPELL_MONTER_CORBEAU, true);
        }

        void PassengerBoarded(Unit* passager, int8 /*seatId*/, bool apply) override
        {
            // SONDE TEMPORAIRE RIVAGEDBG
            TC_LOG_ERROR("misc", "RIVAGEDBG passager %s %s le corbeau",
                passager ? passager->GetName().c_str() : "inconnu", apply ? "monte sur" : "descend de");

            Creature* moi = me;
            me->AddDelayedEvent(4000, [moi]() -> void
            {
                moi->GetMotionMaster()->MovePath(CHEMIN_CORBEAU, false);
            });
        }

        void MovementInform(uint32 moveType, uint32 pointId) override
        {
            if (moveType != WAYPOINT_MOTION_TYPE || pointId != 20)
                return;

            Unit* proprietaire = me->GetAnyOwner();
            if (proprietaire && proprietaire->IsPlayer())
            {
                Conversation::CreateConversation(CONV_ARRIVEE, proprietaire, proprietaire->GetPosition(), { proprietaire->GetGUID() });

                if (InstanceScript* instance = me->GetInstanceScript())
                    instance->SetData(DATA_ARRIVEE_ACCOMPLIE, 1);

                // Un infernal s'ecrase a l'arrivee, et un mage du Kirin Tor
                // y reagit : mise en scene reprise de la source.
                if (Creature* infernal = me->SummonCreature(NPC_INFERNAL_INTRO, me->GetPositionX() + 5.0f, me->GetPositionY() + 5.0f, me->GetPositionZ()))
                {
                    infernal->CastSpell(infernal, SPELL_INFERNAL_1, true);
                    infernal->CastSpell(infernal, SPELL_INFERNAL_2, true);

                    if (Creature* mage = infernal->FindNearestCreature(NPC_ALLIE_MAGE_KIRIN_TOR, 30.0f, true))
                    {
                        mage->CastSpell(mage, SPELL_MAGE_REACTION, true);
                        mage->AI()->Talk(0);
                    }
                }
            }

            me->DespawnOrUnsummon(500);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_assaut_corbeau_arcaniqueAI(creature);
    }
};

// 118558 : portail de la Legion a fermer (etape 3, trois fois).
// 120743 : bombe arcanique a poser (etape 6, sept fois).
// Les deux s'activent au clic de sort.
class npc_assaut_interactif : public CreatureScript
{
public:
    npc_assaut_interactif() : CreatureScript("npc_assaut_interactif") { }

    struct npc_assaut_interactifAI : public ScriptedAI
    {
        npc_assaut_interactifAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag64(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }
        void UpdateAI(uint32 /*diff*/) override { }

        void OnSpellClick(Unit* clicker, bool& /*result*/) override
        {
            if (!clicker || !clicker->IsPlayer())
                return;

            // Un seul usage : on retire le drapeau avant tout traitement.
            me->RemoveFlag64(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            InstanceScript* instance = me->GetInstanceScript();
            if (!instance)
                return;

            if (me->GetEntry() == NPC_PORTAIL_LEGION)
                instance->SetData(DATA_PORTAIL_FERME, 1);
            else if (me->GetEntry() == NPC_BOMBE_ARCANIQUE)
            {
                instance->SetData(DATA_BOMBE_POSEE, 1);
                me->RemoveAura(SPELL_BOMBE_VISUEL);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_assaut_interactifAI(creature);
    }
};

// 267955 : la passerelle demoniaque menant au vaisseau amiral (etape 5).
class go_assaut_passerelle_demoniaque : public GameObjectScript
{
public:
    go_assaut_passerelle_demoniaque() : GameObjectScript("go_assaut_passerelle_demoniaque") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player || !go)
            return false;

        InstanceScript* instance = go->GetInstanceScript();
        if (!instance)
            return false;

        // Tout le groupe franchit la passerelle ensemble.
        Map::PlayerList const& liste = go->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
            if (Player* p = i->GetSource())
                p->CastSpell(p, SPELL_PASSERELLE, true);

        instance->SetData(DATA_PASSERELLE_UTILISEE, 1);
        return true;
    }
};

void AddSC_scenario_assaut_rivage_brise()
{
    new instance_assaut_rivage_brise();
    new npc_assaut_allie();
    new npc_assaut_corbeau_arcanique();
    new npc_assaut_interactif();
    new go_assaut_passerelle_demoniaque();
}
