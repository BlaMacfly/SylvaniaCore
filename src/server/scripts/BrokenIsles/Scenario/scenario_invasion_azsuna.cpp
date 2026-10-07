/*
 * Assaut de la Legion sur Azsuna -- etape finale : scenario « Battle for Azsuna » (carte 1705, scenario 1290).
 *
 * Porte de LegionCore (Titans-Project/LegionCore-Reforged, scripts/Scenario/LegionInvasion/Azsuna),
 * le 08/10/2026. Etapes lues dans ScenarioStep/CriteriaTree/Criteria.db2 :
 *
 *   ordre  evenement  type  quantite  declencheur
 *     0    56889      92    5         Faulty Construct (119483) delivre      -- barre de progression (100)
 *          56895      92    5         Jailer's Cage (119454) ouverte
 *          56887/88   92    4/8       demons tues (119515/16/17, 119466/67)
 *          56890      73    10        evenement de sort (clic sur cristal 119494, sort 237240)
 *     1    56891      92    1         monter sur un drake azur (119456)
 *     2    56892      92    1         arrivee du drake au sommet
 *     3    56893      92    1         Felweaver Axtris (119453) tuee
 *     4    58658      92    1         Xeritas (118975) tue  -- DEDUIT : la source n'envoie cet evenement nulle part ;
 *                                     la quete 46199 attend « Xeritas » et c'est le boss du sommet.
 *     5    56885      92    1         clic sur le drake du retour (119459)
 *
 * ECARTS AVEC LA SOURCE, tous voulus :
 *   - UpdateAchievementCriteria(CRITERIA_TYPE_SCRIPT_EVENT_2, x) -> DoSendEventScenario(x) (type 92 chez nous) ;
 *   - la cage (119454) envoyait 56889 au lieu de 56895 (variable calculee puis ignoree) : corrige ;
 *   - le chemin de vol 10993803 n'existe ni chez LegionCore ni chez nous : le drake vole droit vers le point
 *     de resurrection de l'etape 3 (WorldSafeLocs 5918), qui est le sommet ;
 *   - les evenements touchaient le PREMIER joueur seulement (break) : tous les joueurs de l'instance ;
 *   - entree par la recherche de groupe (LFG 1480) remplacee par une teleportation depuis le prince Farondis ;
 *   - les drakes etaient ranges dans les calques de scenario 7000 (aller) / 7001 (retour) : ici le script les
 *     montre a l'etape 1 / 5 et ignore tout clic hors etape (sinon on sautait des etapes).
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "InstanceScenario.h"
#include "Scenario.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "MotionMaster.h"
#include "Player.h"
#include "Vehicle.h"
#include "Conversation.h"
#include "DB2Stores.h"
#include "WorldQuestMgr.h"

enum InvasionAzsuna
{
    MAP_INVASION_AZSUNA       = 1705,

    // evenements de scenario
    EVENT_CONSTRUCT           = 56889,
    EVENT_CAGE                = 56895,
    EVENT_DEMON_A             = 56887,
    EVENT_DEMON_B             = 56888,
    EVENT_DRAKE_MONTE         = 56891,
    EVENT_DRAKE_ARRIVE        = 56892,
    EVENT_AXTRIS              = 56893,
    EVENT_XERITAS             = 58658,
    EVENT_RETOUR              = 56885,

    NPC_JAILERS_CAGE          = 119454,
    NPC_FAULTY_CONSTRUCT      = 119483,
    NPC_DRAKE_ALLER           = 119456,
    NPC_DRAKE_RETOUR          = 119459,
    NPC_FEL_IMP               = 119633,
    NPC_AXTRIS                = 119453,
    NPC_XERITAS               = 118975,
    NPC_BOMBARDIER            = 119130,

    SPELL_RIDE_VEHICLE        = 52391,
    SPELL_CHUTE_LENTE         = 55001,
    SPELL_BOMBE               = 235084,
    SPELL_IMP_AURA            = 237720,
    SPELL_IMP_EXPLOSION       = 237716,
    SPELL_AXTRIS_SORT         = 234497,

    CONV_ENTREE               = 4587,
    CONV_ARRIVEE              = 4590,
    CONV_AXTRIS               = 4591,

    POINT_SOMMET              = 1,
    DATA_ETAPE                = 1,
};

// Sommet (WorldSafeLocs 5918) : arrivee du drake
Position const PosSommet = { 1423.64f, 6199.63f, 455.0f, 0.0f };
// Sortie du scenario : le prince Farondis qui reprend la quete (88115, Azsuna)
Position const PosSortie = { -11.0f, 6734.0f, 56.0f, 0.0f };

static void ConversationPour(Player* player, uint32 id)
{
    // Les conversations 4587/4590/4591 n'existent pas encore chez nous : CreateConversation renvoie nullptr
    if (player)
        Conversation::CreateConversation(id, player, player->GetPosition(), { player->GetGUID() });
}

class scenario_invasion_azsuna : public InstanceMapScript
{
public:
    scenario_invasion_azsuna() : InstanceMapScript("scenario_invasion_azsuna", MAP_INVASION_AZSUNA) { }

    struct scenario_invasion_azsuna_InstanceMapScript : public InstanceScript
    {
        scenario_invasion_azsuna_InstanceMapScript(InstanceMap* map) : InstanceScript(map) { }

        ObjectGuid bombardierGuid;
        GuidList drakesAller;
        GuidList drakesRetour;
        uint32 etapeVue = 0;
        uint32 bombesTimer = urand(45000, 90000);
        bool termine = false;
        uint32 sortieTimer = 0;

        uint32 EtapeCourante() const
        {
            if (InstanceScenario const* scenario = instance->GetInstanceScenario())
                if (ScenarioStepEntry const* step = scenario->GetStep())
                    return step->OrderIndex;
            return 0;
        }

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);
            if (!player)
                return;

            // Sans la quete de scenario en cours, rien a faire ici : retour en Azsuna
            if (player->GetQuestStatus(46199) != QUEST_STATUS_INCOMPLETE)
            {
                player->AddDelayedEvent(2000, [player]() -> void { player->TeleportTo(1220, PosSortie); });
                return;
            }

            player->AddDelayedEvent(5000, [player]() -> void { ConversationPour(player, CONV_ENTREE); });
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            switch (creature->GetEntry())
            {
                case NPC_BOMBARDIER:
                    bombardierGuid = creature->GetGUID();
                    break;
                case NPC_DRAKE_ALLER:
                    drakesAller.push_back(creature->GetGUID());
                    creature->SetVisible(EtapeCourante() >= 1);
                    break;
                case NPC_DRAKE_RETOUR:
                    drakesRetour.push_back(creature->GetGUID());
                    creature->SetVisible(EtapeCourante() >= 5);
                    break;
                default:
                    break;
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            switch (unit->GetEntry())
            {
                case 119515:
                case 119516:
                case 119517:
                case 119466:
                case 119467:
                    DoSendEventScenario(urand(0, 1) ? EVENT_DEMON_A : EVENT_DEMON_B);
                    break;
                case NPC_XERITAS:
                    DoSendEventScenario(EVENT_XERITAS);
                    break;
                default:
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            return type == DATA_ETAPE ? EtapeCourante() : 0;
        }

        void SetData(uint32 type, uint32 value) override
        {
            // appele par le drake du retour : le scenario est fini, on raccompagne les joueurs
            if (type == EVENT_RETOUR && value && !termine && EtapeCourante() >= 5)
            {
                termine = true;
                sortieTimer = 10000;
            }
        }

        void MontrerDrakes(GuidList const& liste)
        {
            for (ObjectGuid const& guid : liste)
                if (Creature* drake = instance->GetCreature(guid))
                    drake->SetVisible(true);
        }

        void Update(uint32 diff) override
        {
            uint32 etape = EtapeCourante();
            if (etape != etapeVue)
            {
                if (etape >= 1 && etapeVue < 1)
                    MontrerDrakes(drakesAller);
                if (etape >= 5 && etapeVue < 5)
                    MontrerDrakes(drakesRetour);
                etapeVue = etape;
            }

            if (termine && sortieTimer)
            {
                if (sortieTimer <= diff)
                {
                    sortieTimer = 0;
                    Map::PlayerList const& liste = instance->GetPlayers();
                    for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                        if (Player* player = i->GetSource())
                            player->TeleportTo(1220, PosSortie);
                }
                else
                    sortieTimer -= diff;
            }

            if (EtapeCourante() >= 2)
                return;

            // Le bombardier demoniaque arrose les joueurs pendant la montee
            if (bombesTimer <= diff)
            {
                if (Creature* bombardier = instance->GetCreature(bombardierGuid))
                {
                    Map::PlayerList const& liste = instance->GetPlayers();
                    for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                        if (Player* player = i->GetSource())
                            if (player->IsAlive() && !player->IsGameMaster())
                                bombardier->CastSpell(player, SPELL_BOMBE, false);
                }
                bombesTimer = urand(45000, 90000);
            }
            else
                bombesTimer -= diff;
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new scenario_invasion_azsuna_InstanceMapScript(map);
    }
};

// 119454 Jailer's Cage, 119483 Faulty Construct : un clic libere le prisonnier
struct npc_invasion_azsuna_misc : public ScriptedAI
{
    npc_invasion_azsuna_misc(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer())
            return;

        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->DoSendEventScenario(me->GetEntry() == NPC_JAILERS_CAGE ? EVENT_CAGE : EVENT_CONSTRUCT);
        me->DespawnOrUnsummon(10);
    }
};

// 119456 (aller) et 119459 (retour) Azure War-Drake
struct npc_invasion_azsuna_drake : public ScriptedAI
{
    npc_invasion_azsuna_drake(Creature* creature) : ScriptedAI(creature) { }

    bool introFaite = false;

    void Reset() override
    {
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
    }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer())
            return;

        if (me->GetEntry() == NPC_DRAKE_RETOUR)
        {
            if (InstanceScript* instance = me->GetInstanceScript())
            {
                if (instance->GetData(DATA_ETAPE) < 5)
                    return;
                instance->DoSendEventScenario(EVENT_RETOUR);
                instance->SetData(EVENT_RETOUR, 1);
            }
        }
        else if (InstanceScript* instance = me->GetInstanceScript())
        {
            if (instance->GetData(DATA_ETAPE) >= 1)
                clicker->CastSpell(me, SPELL_RIDE_VEHICLE, true);
        }
    }

    void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
    {
        if (!apply || !who->IsPlayer())
            return;

        me->SetCanFly(true);
        me->SetDisableGravity(true);
        me->GetMotionMaster()->MovePoint(POINT_SOMMET, PosSommet);
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->DoSendEventScenario(EVENT_DRAKE_MONTE);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (introFaite || me->GetEntry() != NPC_DRAKE_ALLER || !who->IsPlayer() || who->IsOnVehicle())
            return;

        InstanceScript* instance = me->GetInstanceScript();
        if (!instance || instance->GetData(DATA_ETAPE) != 1)
            return;

        if (me->IsWithinDistInMap(who, 5.0f))
        {
            introFaite = true;
            who->CastSpell(me, SPELL_RIDE_VEHICLE, true);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE || id != POINT_SOMMET)
            return;

        if (Vehicle* kit = me->GetVehicleKit())
        {
            if (Unit* passager = kit->GetPassenger(0))
            {
                if (Player* player = passager->ToPlayer())
                    ConversationPour(player, CONV_ARRIVEE);
                passager->AddAura(SPELL_CHUTE_LENTE, passager);
            }
            kit->RemoveAllPassengers();
        }

        if (InstanceScript* instance = me->GetInstanceScript())
            instance->DoSendEventScenario(EVENT_DRAKE_ARRIVE);
        me->DespawnOrUnsummon(500);
    }
};

// 119633 Fel Imp : invoque par Axtris, court vers les joueurs et explose
struct npc_invasion_azsuna_fel_imp : public ScriptedAI
{
    npc_invasion_azsuna_fel_imp(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    bool explose = false;

    void Exploser()
    {
        if (explose)
            return;
        explose = true;
        DoCast(me, SPELL_IMP_EXPLOSION, true);
        me->KillSelf();
    }

    void IsSummonedBy(Unit* /*summoner*/) override
    {
        me->SetCanFly(true);
        me->AddDelayedEvent(3000, [this]() -> void
        {
            // la source visait z = 1.71 (sous le sommet) : on reste a la hauteur de la plate-forme
            me->GetMotionMaster()->MovePoint(1, 1436.24f + irand(-2, 2), 6172.45f + irand(-2, 2), 479.0f);
            me->CastSpell(me, SPELL_IMP_AURA, false);
        });
    }

    void EnterCombat(Unit* /*who*/) override { Exploser(); }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsPlayer() && me->IsWithinDistInMap(who, 4.0f))
            Exploser();
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == 1)
            Exploser();
    }
};

// 119453 Felweaver Axtris : invoque des diablotins jusqu'au combat
struct npc_invasion_azsuna_axtris : public ScriptedAI
{
    npc_invasion_azsuna_axtris(Creature* creature) : ScriptedAI(creature) { }

    bool invoque = true;
    uint32 invocationTimer = urand(1000, 3000);
    uint32 sortTimer = 0;

    void Reset() override
    {
        sortTimer = 0;
    }

    void EnterCombat(Unit* /*who*/) override
    {
        invoque = false;
        sortTimer = 3000;
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            instance->DoSendEventScenario(EVENT_AXTRIS);
        if (Player* player = me->SelectNearestPlayer(50.0f))
            ConversationPour(player, CONV_AXTRIS);
    }

    void UpdateAI(uint32 diff) override
    {
        if (invoque)
        {
            if (invocationTimer <= diff)
            {
                me->SummonCreature(NPC_FEL_IMP, 1444.47f + irand(-2, 2), 6090.65f + irand(-2, 2), 480.33f, 0.0f,
                    TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                invocationTimer = urand(1000, 3000);
            }
            else
                invocationTimer -= diff;
        }

        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (sortTimer <= diff)
        {
            DoCastVictim(SPELL_AXTRIS_SORT);
            sortTimer = 3000;
        }
        else
            sortTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

/*
 * Chefs de faction de l'assaut : donnent la quete de scenario et y font entrer.
 * Seule Azsuna est peuplee pour l'instant ; les autres zones s'ajouteront a ce tableau.
 */
struct ChefAssaut
{
    uint32 Npc;
    uint32 QueteScenario;
    uint32 CreditParler;    // objectif « Speak with ... » de la quete de scenario
    uint32 QueteAssaut;     // quete principale de l'assaut (45812/45838/45839/45840)
    uint32 CreditRejoindre; // objectif « Meet ... » de la quete principale (0 si aucun)
    uint32 Carte;
    Position Entree;        // WorldSafeLocs du debut du scenario
};

static ChefAssaut const ChefsAssaut[] =
{
    { 119002, 46199, 119013, 45838, 118944, MAP_INVASION_AZSUNA, { 865.93f, 5986.82f, 140.56f, 1.30f } }, // Azsuna, WSL 5917
    { 118183, 45856, 118194, 45812, 118237, 1704, { 3109.09f, 7731.93f, 6.08f, 2.15f } },    // Val'sharah (Jarod), WSL 5885
    { 119676, 46182, 119676, 45840, 0,      1706, { 4111.02f, 4299.73f, 768.13f, 1.65f } },  // Haut-Roc (Lasan), WSL 5945
    // Tornheim : la Val'kyr d'Odyn (118778, donneuse chez LegionCore) n'est posee nulle part, meme chez LC ;
    // c'est Vethir, que la quete principale fait « rejoindre », qui lance l'assaut et donne son credit.
    { 116868, 46110, 118778, 45839, 116868, 1707, { 2564.96f, 1023.75f, 217.14f, 0.79f } },  // Tornheim (Vethir), WSL 5913
};

static ChefAssaut const* TrouverChef(uint32 npc)
{
    for (ChefAssaut const& chef : ChefsAssaut)
        if (chef.Npc == npc)
            return &chef;
    return nullptr;
}

struct npc_invasion_chef_assaut : public ScriptedAI
{
    npc_invasion_chef_assaut(Creature* creature) : ScriptedAI(creature) { }

    // Farondis a son menu en base (20846) ; les autres chefs n'en ont pas : on construit le leur ici
    void sGossipHello(Player* player) override
    {
        if (me->GetCreatureTemplate()->GossipMenuId)
            return;

        ChefAssaut const* chef = TrouverChef(me->GetEntry());
        ClearGossipMenuFor(player);
        player->PrepareQuestMenu(me->GetGUID());
        if (chef && player->GetQuestStatus(chef->QueteScenario) == QUEST_STATUS_INCOMPLETE && sWorldQuestMgr->IsQuestActive(chef->QueteAssaut))
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Je suis prêt : lancez l'assaut décisif.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, me->GetGUID());
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (ChefAssaut const* chef = TrouverChef(me->GetEntry()))
            if (quest->GetQuestId() == chef->QueteScenario && chef->CreditRejoindre)
                player->KilledMonsterCredit(chef->CreditRejoindre);
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 /*gossipListId*/) override
    {
        CloseGossipMenuFor(player);
        ChefAssaut const* chef = TrouverChef(me->GetEntry());
        if (!chef || player->GetQuestStatus(chef->QueteScenario) != QUEST_STATUS_INCOMPLETE)
            return;

        // l'assaut doit etre encore en cours
        if (!sWorldQuestMgr->IsQuestActive(chef->QueteAssaut))
            return;

        if (chef->CreditRejoindre)
            player->KilledMonsterCredit(chef->CreditRejoindre);
        player->KilledMonsterCredit(chef->CreditParler);
        player->TeleportTo(chef->Carte, chef->Entree);
    }
};

void AddSC_scenario_invasion_azsuna()
{
    new scenario_invasion_azsuna();
    RegisterCreatureAI(npc_invasion_azsuna_misc);
    RegisterCreatureAI(npc_invasion_azsuna_drake);
    RegisterCreatureAI(npc_invasion_azsuna_fel_imp);
    RegisterCreatureAI(npc_invasion_azsuna_axtris);
    RegisterCreatureAI(npc_invasion_chef_assaut);
}
