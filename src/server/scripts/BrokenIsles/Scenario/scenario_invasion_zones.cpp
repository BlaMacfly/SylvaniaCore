/*
 * Assauts de la Legion -- etape finale de Val'sharah (1704), Haut-Roc (1706) et Tornheim (1707).
 * Porte de LegionCore (scripts/Scenario/LegionInvasion) le 08/10/2026, sur le modele d'Azsuna
 * (scenario_invasion_azsuna.cpp, qui contient aussi le script commun des chefs de faction).
 *
 * Etapes lues dans ScenarioStep/CriteriaTree/Criteria.db2 (~/tmp/scen_steps.py <scenario>).
 * Source de chaque evenement : C++ LegionCore, ou SmartAI LegionCore (action maison 205 = « evenement de
 * scenario »). Notre moteur n'a pas le crochet « etape suivante » de LegionCore : chaque instance surveille
 * l'etape courante dans Update().
 *
 * VAL'SHARAH, scenario 1271, quete 45856
 *   0 56398      dialogue avec Cenarius (118749)        -> ici : s'approcher de lui (menu 20813 absent chez nous)
 *   1 kill       Crushfist (117838)                      automatique
 *   2 56314 x3   clic sur les Fel Centrum (117930)       SmartAI LC
 *   3 56399      s'approcher d'Akrazar (117833)          C++ LC
 *   4 kill       Akrazar                                  automatique
 *   5 kill x10   Shrieking Hellbat (118570)               automatique
 *   6 56400      vol en hippogriffe (118687)              C++ LC ; chemin 9859007 absent -> vol direct vers le pont
 *                                                         du vizir (point tire des creatures LC posees a cote de lui)
 *   7 58659      mort du vizir Gra'tork (118180)          SmartAI LC (la source forcait l'etape 8 en plus)
 *   8 56408      sortie                                  envoye NULLE PART chez LC (le griffon de sortie teleportait) :
 *                                                         ici envoye 10 s apres l'etape 8, puis retour en Val'sharah
 * HAUT-ROC, scenario 1299, quete 46182
 *   0 barre 100  57174 clic chaman (119855), 57173 infernaux tues (119859/120097/120099), 57659 (source inconnue,
 *                non necessaire : la barre se remplit par poids)
 *   1 57177      s'approcher de Mayla (119850)           C++ LC (type 73 : evenement de sort)
 *   2 57182 x2   deux vagues d'assaillants vaincues       C++ LC (invocations reprises telles quelles)
 *   3 57595      tuer 119959 (invoque par le geomancien) C++ LC
 *   4 57189      monter sur un aigle (119857)             C++ LC
 *   5 57209      arrivee de l'aigle                       chemin 10993801 absent -> vol direct vers WorldSafeLocs 5946
 *   6 57210 x5   cages (119994)                           C++ LC
 *   7 57211 x5   dynamite (119981)                        C++ LC
 *   8 58656      DEDUIT : mort du commandant Erixtol (119579), objectif de la quete ; le portail 120081 y mene
 *   9 57212      DEDUIT : clic sur l'aigle de retour (120048, sort de sortie 241681), puis retour en Haut-Roc
 * TORNHEIM, scenario 1282, quete 46110
 *   0 56603 x3   clic sur Aleifir, Erilar, Hrafsir        SmartAI LC
 *   1 barre      56622 demons tues                        C++ LC
 *   2 56604      vol en drake                             chemins 10993814-16 absents -> vol direct vers WorldSafeLocs 5911
 *   3 barre      56826 / 56606 demons tues                C++ LC
 *   4 58657 +    mort du lord-commandant Alexius (118840) DEDUIT (meme schema que les trois autres zones)
 *     56671 x4   cristaux de bouclier (118859)            SmartAI LC
 *   5 56607      sortie                                  envoye nulle part chez LC : 10 s apres l'etape 5, retour
 *
 * Les evenements ne partent que pendant leur etape (sinon ils pre-validaient l'etape suivante).
 */

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "InstanceScenario.h"
#include "Scenario.h"
#include "ScriptedCreature.h"
#include "MotionMaster.h"
#include "Player.h"
#include "Vehicle.h"
#include "Conversation.h"
#include "TemporarySummon.h"
#include "DB2Stores.h"

namespace
{
    enum Communs
    {
        DATA_ETAPE          = 1,
        DATA_SORTIE         = 2,
        POINT_ARRIVEE       = 1,
        SPELL_RIDE_VEHICLE  = 52391,
        SPELL_CHUTE_LENTE   = 55001,
    };

    uint32 EtapeDe(InstanceMap const* map)
    {
        if (InstanceScenario const* scenario = map->GetInstanceScenario())
            if (ScenarioStepEntry const* step = scenario->GetStep())
                return step->OrderIndex;
        return 0;
    }

    uint32 EtapeDe(WorldObject const* obj)
    {
        if (InstanceScript* instance = obj->GetInstanceScript())
            return instance->GetData(DATA_ETAPE);
        return 0;
    }

    void EvenementSiEtape(WorldObject* obj, uint32 etape, uint32 evenement)
    {
        if (InstanceScript* instance = obj->GetInstanceScript())
            if (instance->GetData(DATA_ETAPE) == etape)
                instance->DoSendEventScenario(evenement);
    }

    // Base commune : etape courante, sortie differee, retour des joueurs sans la quete
    struct InstanceAssaut : public InstanceScript
    {
        InstanceAssaut(InstanceMap* map, uint32 quete, Position const& sortie) : InstanceScript(map), _quete(quete), _sortie(sortie) { }

        uint32 _quete;
        Position _sortie;
        uint32 _etapeVue = 0;
        uint32 _sortieTimer = 0;
        uint32 _evenementSortie = 0;
        bool _sortieLancee = false;

        uint32 GetData(uint32 type) const override
        {
            return type == DATA_ETAPE ? EtapeDe(instance) : 0;
        }

        void OnPlayerEnter(Player* player) override
        {
            InstanceScript::OnPlayerEnter(player);
            if (!player)
                return;

            if (player->GetQuestStatus(_quete) != QUEST_STATUS_INCOMPLETE)
            {
                Position sortie = _sortie;
                player->AddDelayedEvent(2000, [player, sortie]() -> void { player->TeleportTo(1220, sortie); });
                return;
            }
            JoueurEntre(player);
        }

        virtual void JoueurEntre(Player* /*player*/) { }
        virtual void NouvelleEtape(uint32 /*etape*/) { }

        // evenement final puis retour sur les Iles brisees
        void LancerSortie(uint32 evenement, uint32 delai)
        {
            if (_sortieLancee)
                return;
            _sortieLancee = true;
            _evenementSortie = evenement;
            _sortieTimer = delai;
        }

        void Update(uint32 diff) override
        {
            uint32 etape = EtapeDe(instance);
            while (_etapeVue < etape)
                NouvelleEtape(++_etapeVue);

            if (_sortieTimer)
            {
                if (_sortieTimer <= diff)
                {
                    _sortieTimer = 0;
                    if (_evenementSortie)
                        DoSendEventScenario(_evenementSortie);
                    Position sortie = _sortie;
                    Map::PlayerList const& liste = instance->GetPlayers();
                    for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                        if (Player* player = i->GetSource())
                            player->AddDelayedEvent(5000, [player, sortie]() -> void { player->TeleportTo(1220, sortie); });
                }
                else
                    _sortieTimer -= diff;
            }
        }

        void ToutMontrer(GuidList const& liste)
        {
            for (ObjectGuid const& guid : liste)
                if (Creature* c = instance->GetCreature(guid))
                    c->SetVisible(true);
        }
    };

    // Monture : vole droit vers un point, credite l'arrivee, depose le passager en chute lente
    struct MontureAssaut : public ScriptedAI
    {
        MontureAssaut(Creature* creature, uint32 etapeDepart, uint32 evMonte, uint32 evArrive, Position arrivee)
            : ScriptedAI(creature), _etape(etapeDepart), _evMonte(evMonte), _evArrive(evArrive), _arrivee(arrivee) { }

        uint32 _etape, _evMonte, _evArrive;
        Position _arrivee;

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply) override
        {
            if (!apply || !who->IsPlayer())
                return;
            if (_evMonte)
                EvenementSiEtape(me, _etape, _evMonte);
            me->SetCanFly(true);
            me->SetDisableGravity(true);
            me->AddDelayedEvent(1500, [this]() -> void { me->GetMotionMaster()->MovePoint(POINT_ARRIVEE, _arrivee); });
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_ARRIVEE)
                return;
            if (Vehicle* kit = me->GetVehicleKit())
            {
                if (Unit* passager = kit->GetPassenger(0))
                    passager->AddAura(SPELL_CHUTE_LENTE, passager);
                kit->RemoveAllPassengers();
            }
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->DoSendEventScenario(_evArrive);
            me->DespawnOrUnsummon(500);
        }
    };
}

/* ============================================================== VAL'SHARAH */

namespace Valsharah
{
    enum
    {
        MAP                 = 1704,
        QUETE               = 45856,
        NPC_CENARIUS        = 118749,
        NPC_GRYPH           = 118687,
        NPC_GRATORK         = 118180,
        EV_CENARIUS         = 56398,
        EV_CENTRUM          = 56314,
        EV_AKRAZAR          = 56399,
        EV_GRYPH            = 56400,
        EV_GRATORK          = 58659,
        EV_SORTIE           = 56408,
    };
    Position const Sortie  = { 2281.60f, 6596.24f, 137.58f, 0.0f };   // pres de Cenarius (118440), receveur
    Position const PontVizir = { 2969.7f, 7768.0f, 296.0f, 0.0f };   // creatures LC du pont du vizir, z 294.1
}

class scenario_invasion_valsharah : public InstanceMapScript
{
public:
    scenario_invasion_valsharah() : InstanceMapScript("scenario_invasion_valsharah", Valsharah::MAP) { }

    struct script : public InstanceAssaut
    {
        script(InstanceMap* map) : InstanceAssaut(map, Valsharah::QUETE, Valsharah::Sortie) { }

        GuidList gryphs;

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            if (creature->GetEntry() == Valsharah::NPC_GRYPH)
            {
                gryphs.push_back(creature->GetGUID());
                creature->SetVisible(EtapeDe(InstanceScript::instance) >= 6);
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->GetEntry() == Valsharah::NPC_GRATORK)
                DoSendEventScenario(Valsharah::EV_GRATORK);
        }

        void NouvelleEtape(uint32 etape) override
        {
            if (etape == 6)
                ToutMontrer(gryphs);
            if (etape == 8)
                LancerSortie(Valsharah::EV_SORTIE, 10000);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override { return new script(map); }
};

// 118749 Cenarius : l'assaut commence quand on le rejoint
struct npc_invasion_valsharah_cenarius : public ScriptedAI
{
    npc_invasion_valsharah_cenarius(Creature* creature) : ScriptedAI(creature) { }
    bool fait = false;

    void MoveInLineOfSight(Unit* who) override
    {
        if (fait || !who->IsPlayer() || !me->IsWithinDistInMap(who, 15.0f) || EtapeDe(me) != 0)
            return;
        fait = true;
        EvenementSiEtape(me, 0, Valsharah::EV_CENARIUS);
    }
};

// 117838 Crushfist
struct npc_invasion_valsharah_crushfist : public ScriptedAI
{
    npc_invasion_valsharah_crushfist(Creature* creature) : ScriptedAI(creature) { }
    bool saut = false;
    uint32 t1 = 0, t2 = 0;

    void Reset() override { t1 = 4000; t2 = 8000; }
    void EnterEvadeMode(EvadeReason why) override { saut = false; ScriptedAI::EnterEvadeMode(why); }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!saut && who->IsPlayer() && me->IsWithinDistInMap(who, 75.0f))
        {
            saut = true;
            me->GetMotionMaster()->MoveJump(3215.36f, 7862.98f, 0.39f, 0.0f, 10.0f, 10.0f);
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;
        if (t1 <= diff) { DoCastVictim(234473); t1 = 17000; } else t1 -= diff;
        if (t2 <= diff) { DoCastVictim(234446); t2 = 16000; } else t2 -= diff;
        DoMeleeAttackIfReady();
    }
};

// 117833 Wrath-Lord Akrazar
struct npc_invasion_valsharah_akrazar : public ScriptedAI
{
    npc_invasion_valsharah_akrazar(Creature* creature) : ScriptedAI(creature) { }
    bool vu = false;
    uint32 t1 = 0, t2 = 0;

    void Reset() override { t1 = 12000; t2 = 16000; }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!vu && who->IsPlayer() && me->IsWithinDistInMap(who, 35.0f) && EtapeDe(me) == 3)
        {
            vu = true;
            EvenementSiEtape(me, 3, Valsharah::EV_AKRAZAR);
        }
        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;
        if (t1 <= diff) { DoCastVictim(234694); t1 = 23000; } else t1 -= diff;
        if (t2 <= diff) { DoCastVictim(235048); t2 = 16000; } else t2 -= diff;
        DoMeleeAttackIfReady();
    }
};

// 117930 Fel Centrum : un clic le detruit
struct npc_invasion_valsharah_centrum : public ScriptedAI
{
    npc_invasion_valsharah_centrum(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer() || EtapeDe(me) != 2)
            return;
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        EvenementSiEtape(me, 2, Valsharah::EV_CENTRUM);
        me->DespawnOrUnsummon(10);
    }
};

// 118687 Hippogryph : vol vers le pont du vizir
struct npc_invasion_valsharah_gryph : public MontureAssaut
{
    npc_invasion_valsharah_gryph(Creature* creature) : MontureAssaut(creature, 6, 0, Valsharah::EV_GRYPH, Valsharah::PontVizir) { }
};

/* ============================================================== HAUT-ROC */

namespace Hautroc
{
    enum
    {
        MAP                 = 1706,
        QUETE               = 46182,
        NPC_GEOMANCIEN      = 119942,
        NPC_MAYLA           = 119850,
        NPC_AIGLE           = 119857,
        NPC_AIGLE_RETOUR    = 120048,
        NPC_PORTAIL         = 120081,
        NPC_CIBLE_ETAPE3    = 119959,
        NPC_ALLIE_ETAPE3    = 119957,
        NPC_ERIXTOL         = 119579,
        NPC_ASSAILLANT      = 120060,
        NPC_ASSAILLANT_2    = 119860,
        NPC_DEFENSEUR       = 119854,
        EV_CHAMAN           = 57174,
        EV_INFERNAL         = 57173,
        EV_MAYLA            = 57177,
        EV_VAGUE            = 57182,
        EV_ETAPE3           = 57595,
        EV_AIGLE            = 57189,
        EV_AIGLE_ARRIVE     = 57209,
        EV_CAGE             = 57210,
        EV_DYNAMITE         = 57211,
        EV_ERIXTOL          = 58656,
        EV_SORTIE           = 57212,
    };
    Position const Sortie   = { 4268.68f, 4563.80f, 670.46f, 0.0f };  // destination du sort de sortie 241681 (LC)
    Position const Sommet   = { 4374.42f, 4613.79f, 967.66f, 0.0f };  // WorldSafeLocs 5946 (etapes 6+)
    Position const Erixtol  = { 4441.61f, 4541.58f, 900.37f, 3.59f };  // destination du portail 120081 (SmartAI LC)
}

class scenario_invasion_highmountain : public InstanceMapScript
{
public:
    scenario_invasion_highmountain() : InstanceMapScript("scenario_invasion_highmountain", Hautroc::MAP) { }

    struct script : public InstanceAssaut
    {
        script(InstanceMap* map) : InstanceAssaut(map, Hautroc::QUETE, Hautroc::Sortie) { }

        ObjectGuid geomancien, mayla;
        GuidList aigles, aiglesRetour;
        uint32 restants = 0;
        uint32 vague = 1;

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            switch (creature->GetEntry())
            {
                case Hautroc::NPC_GEOMANCIEN: geomancien = creature->GetGUID(); break;
                case Hautroc::NPC_MAYLA:      mayla = creature->GetGUID(); break;
                case Hautroc::NPC_AIGLE:
                    aigles.push_back(creature->GetGUID());
                    creature->SetVisible(EtapeDe(InstanceScript::instance) >= 4);
                    break;
                case Hautroc::NPC_AIGLE_RETOUR:
                    aiglesRetour.push_back(creature->GetGUID());
                    creature->SetVisible(EtapeDe(InstanceScript::instance) >= 9);
                    break;
                default: break;
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            uint32 etape = EtapeDe(InstanceScript::instance);
            switch (unit->GetEntry())
            {
                case 119859: case 120097: case 120099:
                    if (etape == 0)
                        DoSendEventScenario(Hautroc::EV_INFERNAL);
                    break;
                case Hautroc::NPC_CIBLE_ETAPE3:
                    if (etape == 3)
                        DoSendEventScenario(Hautroc::EV_ETAPE3);
                    break;
                case Hautroc::NPC_ASSAILLANT:
                case Hautroc::NPC_ASSAILLANT_2:
                    if (etape == 2 && restants && --restants == 0)
                    {
                        DoSendEventScenario(Hautroc::EV_VAGUE);
                        if (vague <= 2)
                            Vague(vague++);
                    }
                    break;
                case Hautroc::NPC_ERIXTOL:
                    if (etape == 8)
                        DoSendEventScenario(Hautroc::EV_ERIXTOL);
                    break;
                default: break;
            }
        }

        void Assaillant(Creature* source, uint32 entry, float x, float y, float z)
        {
            if (Creature* add = source->SummonCreature(entry, x, y, z, 0.0f, TEMPSUMMON_DEAD_DESPAWN))
                if (Creature* cible = add->FindNearestCreature(Hautroc::NPC_DEFENSEUR, 80.0f, true))
                    add->AI()->AttackStart(cible);
        }

        // vagues reprises de LegionCore (positions et compositions identiques)
        void Vague(uint32 numero)
        {
            if (numero == 1)
            {
                if (Creature* geo = InstanceScript::instance->GetCreature(geomancien))
                {
                    Assaillant(geo, Hautroc::NPC_ASSAILLANT, 4057.25f, 4434.91f, 665.91f);
                    Assaillant(geo, Hautroc::NPC_ASSAILLANT, 4100.33f, 4436.91f, 665.91f);
                    Assaillant(geo, Hautroc::NPC_ASSAILLANT_2, 4143.27f, 4396.79f, 666.76f);
                    restants = 3;
                }
            }
            else if (Creature* may = InstanceScript::instance->GetCreature(mayla))
            {
                Assaillant(may, Hautroc::NPC_ASSAILLANT, 4057.25f, 4434.91f, 665.91f);
                Assaillant(may, Hautroc::NPC_ASSAILLANT, 4100.33f, 4436.91f, 665.91f);
                Assaillant(may, Hautroc::NPC_ASSAILLANT_2, 4057.25f, 4434.91f, 665.91f);
                Assaillant(may, Hautroc::NPC_ASSAILLANT_2, 4100.33f, 4436.91f, 665.91f);
                restants = 4;
                may->SummonCreature(Hautroc::NPC_ALLIE_ETAPE3, 4132.62f, 4398.68f, 667.63f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN);
            }
        }

        void NouvelleEtape(uint32 etape) override
        {
            switch (etape)
            {
                case 2:
                    Vague(vague++);
                    break;
                case 3:
                    if (Creature* geo = InstanceScript::instance->GetCreature(geomancien))
                    {
                        geo->SummonCreature(Hautroc::NPC_ALLIE_ETAPE3, 4100.27f, 4432.45f, 666.99f, 0.0f, TEMPSUMMON_MANUAL_DESPAWN);
                        geo->SummonCreature(Hautroc::NPC_CIBLE_ETAPE3, 4083.18f, 4385.35f, 670.62f, 0.0f, TEMPSUMMON_DEAD_DESPAWN);
                        geo->KillSelf();
                    }
                    break;
                case 4:
                    ToutMontrer(aigles);
                    break;
                case 9:
                    ToutMontrer(aiglesRetour);
                    break;
                default: break;
            }
        }

        void SetData(uint32 type, uint32 value) override
        {
            if (type == DATA_SORTIE && value && EtapeDe(InstanceScript::instance) >= 9)
                LancerSortie(Hautroc::EV_SORTIE, 1);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override { return new script(map); }
};

// 119855 Rivermane Shaman : un clic le libere
struct npc_invasion_hautroc_chaman : public ScriptedAI
{
    npc_invasion_hautroc_chaman(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer() || EtapeDe(me) != 0)
            return;
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        clicker->CastSpell(clicker, 241017, true);
        EvenementSiEtape(me, 0, Hautroc::EV_CHAMAN);
        me->DespawnOrUnsummon(5000);
    }
};

// 119850 Mayla Highmountain
struct npc_invasion_hautroc_mayla : public ScriptedAI
{
    npc_invasion_hautroc_mayla(Creature* creature) : ScriptedAI(creature) { }
    bool vue = false;

    void MoveInLineOfSight(Unit* who) override
    {
        if (vue || !who->IsPlayer() || !me->IsWithinDistInMap(who, 20.0f) || EtapeDe(me) != 1)
            return;
        vue = true;
        // type 73 : evenement de sort, a envoyer a chaque joueur
        if (Map* map = me->GetMap())
        {
            Map::PlayerList const& liste = map->GetPlayers();
            for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                if (Player* player = i->GetSource())
                    player->UpdateCriteria(CRITERIA_TYPE_SEND_EVENT, Hautroc::EV_MAYLA);
        }
    }
};

// 119857 War Eagle : vol vers le sommet
struct npc_invasion_hautroc_aigle : public MontureAssaut
{
    npc_invasion_hautroc_aigle(Creature* creature) : MontureAssaut(creature, 4, Hautroc::EV_AIGLE, Hautroc::EV_AIGLE_ARRIVE, Hautroc::Sommet) { }
};

// 119994 cage, 119981 dynamite, 120048 aigle de retour
struct npc_invasion_hautroc_misc : public ScriptedAI
{
    npc_invasion_hautroc_misc(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer())
            return;
        uint32 etape = EtapeDe(me);
        switch (me->GetEntry())
        {
            case 119994:
                if (etape != 6)
                    return;
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                EvenementSiEtape(me, 6, Hautroc::EV_CAGE);
                if (Creature* tauren = me->FindNearestCreature(119993, 10.0f, true))
                    tauren->DespawnOrUnsummon(1000);
                me->DespawnOrUnsummon(10);
                break;
            case 119981:
                if (etape != 7)
                    return;
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                EvenementSiEtape(me, 7, Hautroc::EV_DYNAMITE);
                me->RemoveAura(164141);
                break;
            case Hautroc::NPC_AIGLE_RETOUR:
                if (InstanceScript* instance = me->GetInstanceScript())
                    instance->SetData(DATA_SORTIE, 1);
                break;
            default:
                break;
        }
    }
};

// 120081 Portal to Fel Commander : mene au commandant Erixtol (le SmartAI LC teleportait sur clic)
struct npc_invasion_hautroc_portail : public ScriptedAI
{
    npc_invasion_hautroc_portail(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
            if (me->IsWithinDistInMap(player, 3.0f) && EtapeDe(me) >= 8)
                player->NearTeleportTo(Hautroc::Erixtol.GetPositionX(), Hautroc::Erixtol.GetPositionY(), Hautroc::Erixtol.GetPositionZ(), Hautroc::Erixtol.GetOrientation());
    }
};

/* ============================================================== TORNHEIM */

namespace Tornheim
{
    enum
    {
        MAP                 = 1707,
        QUETE               = 46110,
        CREDIT_ASSAUT       = 118779,   // objectif « Assault begun » de 46110
        NPC_DRAKE           = 119196,
        NPC_ALEXIUS         = 118840,
        EV_VALKYR           = 56603,
        EV_DEMON_1          = 56622,
        EV_DEMON_2A         = 56826,
        EV_DEMON_2B         = 56606,
        EV_DRAKE_ARRIVE     = 56604,
        EV_ALEXIUS          = 58657,
        EV_CRISTAL          = 56671,
        EV_SORTIE           = 56607,
    };
    Position const Sortie  = { 2414.27f, 872.90f, 253.03f, 3.9f };  // destination du sort de sortie 239255 (LC), pres d'Odyn
    Position const Arrivee = { 2801.50f, 1396.51f, 348.18f, 0.0f };  // WorldSafeLocs 5911 (etapes 2+)
}

class scenario_invasion_stormheim : public InstanceMapScript
{
public:
    scenario_invasion_stormheim() : InstanceMapScript("scenario_invasion_stormheim", Tornheim::MAP) { }

    struct script : public InstanceAssaut
    {
        script(InstanceMap* map) : InstanceAssaut(map, Tornheim::QUETE, Tornheim::Sortie) { }

        void JoueurEntre(Player* player) override
        {
            player->KilledMonsterCredit(Tornheim::CREDIT_ASSAUT);
        }

        void OnUnitDeath(Unit* unit) override
        {
            uint32 etape = EtapeDe(InstanceScript::instance);
            switch (unit->GetEntry())
            {
                case 119016: case 118838: case 118915: case 118808: case 118800: case 118807:
                    if (etape == 1)
                        DoSendEventScenario(Tornheim::EV_DEMON_1);
                    else if (etape == 3)
                    {
                        DoSendEventScenario(Tornheim::EV_DEMON_2A);
                        DoSendEventScenario(Tornheim::EV_DEMON_2B);
                    }
                    break;
                case Tornheim::NPC_ALEXIUS:
                    if (etape == 4)
                        DoSendEventScenario(Tornheim::EV_ALEXIUS);
                    break;
                default: break;
            }
        }

        void NouvelleEtape(uint32 etape) override
        {
            if (etape == 2)
            {
                // chaque joueur recoit un drake qui l'emmene vers la forteresse
                Map::PlayerList const& liste = InstanceScript::instance->GetPlayers();
                for (Map::PlayerList::const_iterator i = liste.begin(); i != liste.end(); ++i)
                    if (Player* player = i->GetSource())
                        if (Creature* drake = player->SummonCreature(Tornheim::NPC_DRAKE, player->GetPositionX(), player->GetPositionY(),
                                player->GetPositionZ() + 2.0f, player->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 120000))
                            player->CastSpell(drake, SPELL_RIDE_VEHICLE, true);
            }
            if (etape == 5)
                LancerSortie(Tornheim::EV_SORTIE, 10000);
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override { return new script(map); }
};

// 118789 Aleifir, 119200 Erilar, 119201 Hrafsir : les liberer lance l'assaut
struct npc_invasion_tornheim_valkyr : public ScriptedAI
{
    npc_invasion_tornheim_valkyr(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer() || EtapeDe(me) != 0)
            return;
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        EvenementSiEtape(me, 0, Tornheim::EV_VALKYR);
    }
};

// 118859 Legion Shield Crystal
struct npc_invasion_tornheim_cristal : public ScriptedAI
{
    npc_invasion_tornheim_cristal(Creature* creature) : ScriptedAI(creature) { }

    void OnSpellClick(Unit* clicker, bool& /*result*/) override
    {
        if (!clicker->IsPlayer() || EtapeDe(me) != 4)
            return;
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
        EvenementSiEtape(me, 4, Tornheim::EV_CRISTAL);
        me->DespawnOrUnsummon(10);
    }
};

// 119196 drake de Tornheim : vol vers la forteresse
struct npc_invasion_tornheim_drake : public MontureAssaut
{
    npc_invasion_tornheim_drake(Creature* creature) : MontureAssaut(creature, 2, 0, Tornheim::EV_DRAKE_ARRIVE, Tornheim::Arrivee)
    {
        me->SetReactState(REACT_PASSIVE);
    }
};

void AddSC_scenario_invasion_zones()
{
    new scenario_invasion_valsharah();
    RegisterCreatureAI(npc_invasion_valsharah_cenarius);
    RegisterCreatureAI(npc_invasion_valsharah_crushfist);
    RegisterCreatureAI(npc_invasion_valsharah_akrazar);
    RegisterCreatureAI(npc_invasion_valsharah_centrum);
    RegisterCreatureAI(npc_invasion_valsharah_gryph);

    new scenario_invasion_highmountain();
    RegisterCreatureAI(npc_invasion_hautroc_chaman);
    RegisterCreatureAI(npc_invasion_hautroc_mayla);
    RegisterCreatureAI(npc_invasion_hautroc_aigle);
    RegisterCreatureAI(npc_invasion_hautroc_misc);
    RegisterCreatureAI(npc_invasion_hautroc_portail);

    new scenario_invasion_stormheim();
    RegisterCreatureAI(npc_invasion_tornheim_valkyr);
    RegisterCreatureAI(npc_invasion_tornheim_cristal);
    RegisterCreatureAI(npc_invasion_tornheim_drake);
}
