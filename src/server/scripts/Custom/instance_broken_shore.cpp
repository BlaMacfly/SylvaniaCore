/*
 * SylvaniaCore — Scenario "The Battle for Broken Shore" (scenario 786, map 1460)
 * INCREMENT 2 : orchestration minimale defensive.
 * A l'entree d'un joueur : progression temporisee des 9 phases du scenario
 * (l'UI avance), puis CompleteScenario() + credit quete 42740 (108920 + 90918).
 * Pas de spawn (surface de crash minimale) — contenu/demons = increment 3.
 * Registration : RegisterInstanceScript(instance_broken_shore, 1460) via AddCustomScripts().
 */
#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "Map.h"
#include "Player.h"
#include "DB2Stores.h"
#include "ScenarioMgr.h"
#include "InstanceScenario.h"

// Namespace anonyme : evite toute collision de symboles dans l'unity build (cotire).
namespace
{

// Steps du scenario 786, dans l'ordre OrderIndex 0..8 (ids ScenarioStep.db2 — dump core).
uint32 const BS_STEP_IDS[9] = { 1504, 1522, 2685, 1589, 1532, 1505, 1506, 1761, 2084 };

// Credits de la quete 42740 (independants des steps du scenario).
enum BrokenShoreCredits
{
    NPC_CREDIT_ANGELICA = 108920, // "Ship taken"
    NPC_CREDIT_FINALE   = 90918   // "assaulted"
};

class instance_broken_shore : public InstanceScript
{
public:
    explicit instance_broken_shore(InstanceMap* map) : InstanceScript(map),
        _phase(0), _timer(6000), _running(false), _done(false) { }

    void OnPlayerEnter(Player* player) override
    {
        InstanceScript::OnPlayerEnter(player);
        // (re)arme la sequence a la premiere entree
        if (!_running && !_done)
        {
            _running = true;
            _phase = 0;
            _timer = 6000; // 6s avant la 1ere phase
        }
    }

    Player* GetAnyPlayer() const
    {
        Map::PlayerList const& players = instance->GetPlayers();
        for (Map::PlayerList::const_iterator it = players.begin(); it != players.end(); ++it)
            if (Player* p = it->GetSource())
                return p;
        return nullptr;
    }

    void Update(uint32 diff) override
    {
        if (!_running || _done)
            return;
        if (_timer > diff) { _timer -= diff; return; }
        _timer = 7000; // 7s entre phases

        Player* player = GetAnyPlayer();
        if (!player)            // plus personne -> on patiente
            return;

        InstanceScenario* scenario = instance->GetInstanceScenario();
        if (!scenario)          // pas de scenario sur cette instance
            return;

        if (_phase < 9)
        {
            // marque le step courant DONE (sinon le moteur re-selectionne toujours le step 0)
            if (ScenarioStepEntry const* cur = sScenarioStepStore.LookupEntry(BS_STEP_IDS[_phase]))
                scenario->SetStepState(cur, SCENARIO_STEP_DONE);
            ++_phase;
            if (_phase < 9)
            {
                // avance l'UI vers le step suivant
                if (ScenarioStepEntry const* nxt = sScenarioStepStore.LookupEntry(BS_STEP_IDS[_phase]))
                    scenario->SetStep(nxt);
            }
            else
            {
                // tous les steps DONE -> scenario complet + credit quete 42740
                scenario->CompleteScenario();
                player->KilledMonsterCredit(NPC_CREDIT_ANGELICA);
                player->KilledMonsterCredit(NPC_CREDIT_FINALE);
                _done = true;
                _running = false;
            }
        }
    }

private:
    uint8  _phase;
    uint32 _timer;
    bool   _running;
    bool   _done;
};

} // namespace anonyme

void AddSC_instance_broken_shore()
{
    RegisterInstanceScript(instance_broken_shore, 1460);
}
