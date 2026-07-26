/*
 * SylvaniaCore : raciaux worgen a la validation des quetes de Gilneas
 * (reconstruit 23/07/2026). Le gate Blizzlike vit dans Player::AddSpell
 * (68992 Sombre Course <- quete 14222, 68996 Deux Formes <- quete 14375) ;
 * ce script apprend le sort des que la quete correspondante est rendue,
 * sans attendre un relog ou une montee de niveau.
 */

#include "ScriptMgr.h"
#include "Player.h"

enum WorgenRacials
{
    SPELL_DARKFLIGHT    = 68992,
    SPELL_TWO_FORMS     = 68996,
    QUEST_DARKFLIGHT    = 14222,
    QUEST_TWO_FORMS     = 14375,
    RACE_WORGEN_ID      = 22,
};

class custom_worgen_racials : public PlayerScript
{
public:
    custom_worgen_racials() : PlayerScript("custom_worgen_racials") { }

    void OnQuestStatusChange(Player* player, uint32 questId) override
    {
        if (player->getRace() != RACE_WORGEN_ID)
            return;

        if (questId == QUEST_DARKFLIGHT && player->GetQuestRewardStatus(QUEST_DARKFLIGHT) && !player->HasSpell(SPELL_DARKFLIGHT))
            player->LearnSpell(SPELL_DARKFLIGHT, false);
        if (questId == QUEST_TWO_FORMS && player->GetQuestRewardStatus(QUEST_TWO_FORMS) && !player->HasSpell(SPELL_TWO_FORMS))
            player->LearnSpell(SPELL_TWO_FORMS, false);
    }
};

void AddSC_custom_worgen_racials()
{
    new custom_worgen_racials();
}
