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

#include "MercenaryMgr.h"
#include "BotGroupAI.h"
#include "CapitalSiegeMgr.h"
#include "Chat.h"
#include "MercenaryChat.h"
#include "Config.h"
#include "DB2Stores.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerBotMgr.h"
#include "PlayerBotSession.h"
#include "PlayerBotSetting.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSession.h"

MercenaryMgr::MercenaryMgr() :
    m_enabled(false), m_cost(100 * MERCENARY_COPPER_PER_GOLD), m_maxPerPlayer(MERCENARY_HARD_CAP),
    m_minLevel(10), m_updateTimer(0), m_releasing(false)
{
}

MercenaryMgr* MercenaryMgr::instance()
{
    static MercenaryMgr instance;
    return &instance;
}

void MercenaryMgr::LoadConfig()
{
    m_enabled = sConfigMgr->GetIntDefault("pbotmerc", 0) != 0;

    uint32 const gold = sConfigMgr->GetIntDefault("pbotmerc_cost", 100);
    m_cost = gold * MERCENARY_COPPER_PER_GOLD;

    m_maxPerPlayer = sConfigMgr->GetIntDefault("pbotmerc_max", MERCENARY_HARD_CAP);
    if (m_maxPerPlayer > MERCENARY_HARD_CAP)
        m_maxPerPlayer = MERCENARY_HARD_CAP;    // au-dela, le groupe deborde

    m_minLevel = sConfigMgr->GetIntDefault("pbotmerc_minlevel", 10);

    TC_LOG_INFO("server.loading", "Mercenaires: %s, %u po par invocation, %u au maximum, niveau %u requis.",
        m_enabled ? "actif" : "inactif", GetCostGold(), m_maxPerPlayer, m_minLevel);
}

char const* MercenaryMgr::GetRoleName(uint8 role)
{
    switch (role)
    {
        case ROLE_TANK:   return "protecteur";
        case ROLE_HEALER: return "guerisseur";
        default:          return "combattant";
    }
}

char const* MercenaryMgr::GetErrorText(MercenaryResult result)
{
    switch (result)
    {
        case MERC_ERR_DISABLED:    return "Le portail est éteint. Aucun mercenaire ne répond à l'appel.";
        case MERC_ERR_BAD_PLACE:   return "Le portail ne peut percer le voile depuis un champ de bataille ou une arène.";
        case MERC_ERR_IN_COMBAT:   return "Impossible d'invoquer un mercenaire en plein combat.";
        case MERC_ERR_LEVEL:       return "Vous êtes trop inexpérimenté pour commander un mercenaire.";
        case MERC_ERR_NOT_LEADER:  return "Seul le chef du groupe peut invoquer un mercenaire.";
        case MERC_ERR_GROUP_FULL:  return "Votre groupe est déjà complet.";
        case MERC_ERR_MAX_REACHED: return "Vous commandez déjà autant de mercenaires que le portail l'autorise.";
        case MERC_ERR_NO_MONEY:    return "Vous n'avez pas assez d'or pour payer ce mercenaire.";
        case MERC_ERR_NO_BOT:      return "Aucun mercenaire de cette spécialité n'est disponible pour le moment. Votre or ne vous a pas été prélevé.";
        case MERC_ERR_PENDING:     return "Une invocation est déjà en cours. Patientez.";
        default:                   return "";
    }
}

// Seules ces classes disposent d une IA de groupe (AI/PlayerAI/BotGroupAI).
// Le moine et le chasseur de demons n en ont pas : un mercenaire de ces classes
// resterait plante sans rien faire.
bool MercenaryMgr::IsMercenaryCapableClass(uint8 playerClass)
{
    switch (playerClass)
    {
        case CLASS_WARRIOR:
        case CLASS_PALADIN:
        case CLASS_HUNTER:
        case CLASS_ROGUE:
        case CLASS_PRIEST:
        case CLASS_DEATH_KNIGHT:
        case CLASS_SHAMAN:
        case CLASS_MAGE:
        case CLASS_WARLOCK:
        case CLASS_DRUID:
            return true;
        default:
            return false;
    }
}

// Index de specialisation a passer au re-level (BGSType_Settting attend 1 a 3).
// Au-dela de l index 2, le core refuse la specialisation.
int32 MercenaryMgr::FindSpecIndexForRole(uint8 playerClass, uint8 role)
{
    for (uint32 i = 0; i < sChrSpecializationStore.GetNumRows(); ++i)
    {
        ChrSpecializationEntry const* spec = sChrSpecializationStore.LookupEntry(i);
        if (!spec || spec->ClassID != int8(playerClass) || spec->IsPetSpecialization())
            continue;
        if (spec->Role != int8(role))
            continue;
        if (spec->OrderIndex > 2)
            continue;
        return int32(spec->OrderIndex);
    }
    return -1;
}

uint32 MercenaryMgr::CountContracts(ObjectGuid ownerGuid) const
{
    uint32 count = 0;
    for (MercenaryContract const& contract : m_contracts)
        if (contract.ownerGuid == ownerGuid)
            ++count;
    return count;
}

bool MercenaryMgr::IsMercenary(ObjectGuid botGuid) const
{
    for (MercenaryContract const& contract : m_contracts)
        if (contract.botGuid == botGuid)
            return true;
    return false;
}

bool MercenaryMgr::IsMercenaryOf(ObjectGuid botGuid, ObjectGuid ownerGuid) const
{
    for (MercenaryContract const& contract : m_contracts)
        if (contract.botGuid == botGuid && contract.ownerGuid == ownerGuid)
            return true;
    return false;
}

Player* MercenaryMgr::PickMercenaryFor(Player* owner, std::string const& message) const
{
    if (!owner)
        return nullptr;

    Player* fallback = nullptr;
    for (MercenaryContract const& contract : m_contracts)
    {
        if (contract.ownerGuid != owner->GetGUID() || contract.stage != MERC_STAGE_ACTIVE)
            continue;

        Player* bot = ObjectAccessor::FindConnectedPlayer(contract.botGuid);
        if (!bot || !bot->IsInWorld())
            continue;

        // Interpelle par son nom : c est lui qui repond, sans ambiguite.
        if (!message.empty() && message.find(bot->GetName()) != std::string::npos)
            return bot;

        if (!fallback)
            fallback = bot;
    }
    return fallback;
}

Player* MercenaryMgr::PickMercenaryInGroup(Player* speaker, std::string const& message, Player*& outOwner) const
{
    outOwner = nullptr;
    if (!speaker)
        return nullptr;

    Group* group = speaker->GetGroup();
    if (!group)
        return nullptr;

    Player* fallback = nullptr;
    Player* fallbackOwner = nullptr;

    for (MercenaryContract const& contract : m_contracts)
    {
        if (contract.stage != MERC_STAGE_ACTIVE)
            continue;

        Player* bot = ObjectAccessor::FindConnectedPlayer(contract.botGuid);
        if (!bot || !bot->IsInWorld() || bot->GetGroup() != group)
            continue;   // mercenaire d une autre troupe

        Player* owner = ObjectAccessor::FindConnectedPlayer(contract.ownerGuid);
        if (!owner || !owner->IsInWorld())
            continue;   // l employeur doit etre la : c est sa cle qui paie

        if (!message.empty() && message.find(bot->GetName()) != std::string::npos)
        {
            outOwner = owner;
            return bot;
        }

        if (!fallback)
        {
            fallback = bot;
            fallbackOwner = owner;
        }
    }

    outOwner = fallbackOwner;
    return fallback;
}

bool MercenaryMgr::IsAccountHired(uint32 accountId) const
{
    for (MercenaryContract const& contract : m_contracts)
        if (contract.accountId == accountId)
            return true;
    return false;
}

// Reserve un compte bot capable de tenir le role demande dans la faction du
// joueur. Priorite aux bots deja connectes et desoeuvres : pas de connexion a
// payer et ils sont deja charges en memoire.
bool MercenaryMgr::FindCandidate(Player* owner, uint8 role, uint32& accountId, uint64& charGuid, bool& alreadyOnline) const
{
    SessionMap const& sessions = sWorld->GetAllSessions();
    std::vector<uint32> onlineCandidates;
    std::vector<std::pair<uint32, uint64> > offlineCandidates;

    for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
    {
        if (!it->second->IsBotSession())
            continue;

        PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(it->second);
        if (!session || session->PlayerLoading() || session->HasSchedules() || session->IsAccountBotSession())
            continue;
        if (IsAccountHired(session->GetAccountId()))
            continue;
        if (sCapitalSiegeMgr->IsAccountEngaged(session->GetAccountId()))
            continue;   // deja enrole dans l assaut quotidien

        Player* bot = session->GetPlayer();
        if (!bot)
            continue;

        if (bot->IsLoading() || !bot->IsInWorld() || !bot->IsSettingFinish())
            continue;
        if (bot->GetGroup())
            continue;   // deja au service de quelqu un
        if (bot->InBattleground() || bot->InArena() || bot->InBattlegroundQueue())
            continue;
        if (bot->GetMap()->IsDungeon() || bot->isUsingLfg())
            continue;
        if (bot->GetTeamId() != owner->GetTeamId())
            continue;
        if (!IsMercenaryCapableClass(bot->getClass()))
            continue;
        if (FindSpecIndexForRole(bot->getClass(), role) < 0)
            continue;

        onlineCandidates.push_back(session->GetAccountId());
    }

    // Tirage au sort parmi TOUS les candidats, et non premier trouve : la carte
    // des sessions est ordonnee par identifiant de compte, si bien qu un choix
    // sequentiel ramenait invariablement le meme mercenaire.
    if (!onlineCandidates.empty())
    {
        accountId = onlineCandidates[urand(0, uint32(onlineCandidates.size()) - 1)];
        charGuid = 0;
        alreadyOnline = true;
        return true;
    }

    // Second choix : une session bot hors ligne, sur laquelle on connecte
    // explicitement un personnage de la bonne faction et du bon role. Laisser
    // le core tirer au sort (BGSType_Online) ne garantit ni l un ni l autre.
    for (SessionMap::const_iterator it = sessions.begin(); it != sessions.end(); ++it)
    {
        if (!it->second->IsBotSession())
            continue;

        PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(it->second);
        if (!session || session->PlayerLoading() || session->HasSchedules() || session->IsAccountBotSession())
            continue;
        if (session->GetPlayer())
            continue;
        if (IsAccountHired(session->GetAccountId()))
            continue;
        if (sCapitalSiegeMgr->IsAccountEngaged(session->GetAccountId()))
            continue;

        PlayerBotBaseInfo* accountInfo = sPlayerBotMgr->GetPlayerBotAccountInfo(session->GetAccountId());
        if (!accountInfo)
            accountInfo = sPlayerBotMgr->GetAccountBotAccountInfo(session->GetAccountId());
        if (!accountInfo)
            continue;

        for (PlayerBotBaseInfo::CharInfoMap::iterator itChar = accountInfo->characters.begin();
            itChar != accountInfo->characters.end(); ++itChar)
        {
            PlayerBotCharBaseInfo& charInfo = itChar->second;
            if (charInfo.GetCamp() != owner->GetTeamId())
                continue;
            if (!IsMercenaryCapableClass(uint8(charInfo.profession)))
                continue;
            if (FindSpecIndexForRole(uint8(charInfo.profession), role) < 0)
                continue;

            offlineCandidates.push_back(std::make_pair(session->GetAccountId(), charInfo.guid));
            break;      // un seul personnage retenu par compte
        }
    }

    if (!offlineCandidates.empty())
    {
        std::pair<uint32, uint64> const& picked =
            offlineCandidates[urand(0, uint32(offlineCandidates.size()) - 1)];
        accountId = picked.first;
        charGuid = picked.second;
        alreadyOnline = false;
        return true;
    }

    return false;
}

MercenaryResult MercenaryMgr::Summon(Player* owner, uint8 role)
{
    if (!m_enabled)
        return MERC_ERR_DISABLED;
    if (!owner || owner->IsPlayerBot())
        return MERC_ERR_DISABLED;

    if (owner->InBattleground() || owner->InArena() || owner->InBattlegroundQueue())
        return MERC_ERR_BAD_PLACE;
    if (owner->IsInCombat())
        return MERC_ERR_IN_COMBAT;
    if (owner->getLevel() < m_minLevel)
        return MERC_ERR_LEVEL;

    uint32 const contracts = CountContracts(owner->GetGUID());
    if (contracts >= m_maxPerPlayer)
        return MERC_ERR_MAX_REACHED;

    if (Group* group = owner->GetGroup())
    {
        if (group->isBGGroup() || group->isBFGroup() || group->isLFGGroup() || group->isRaidGroup())
            return MERC_ERR_BAD_PLACE;
        if (group->GetLeaderGUID() != owner->GetGUID())
            return MERC_ERR_NOT_LEADER;

        // Les invocations en cours occupent deja leur place a venir.
        uint32 pending = 0;
        for (MercenaryContract const& contract : m_contracts)
            if (contract.ownerGuid == owner->GetGUID() && contract.stage == MERC_STAGE_SUMMONING)
                ++pending;

        if (group->GetMembersCount() + pending >= MERCENARY_GROUP_SIZE)
            return MERC_ERR_GROUP_FULL;
    }

    if (!owner->HasEnoughMoney(uint64(m_cost)))
        return MERC_ERR_NO_MONEY;

    uint32 accountId = 0;
    uint64 charGuid = 0;
    bool alreadyOnline = false;
    if (!FindCandidate(owner, role, accountId, charGuid, alreadyOnline))
        return MERC_ERR_NO_BOT;

    WorldSession* worldSession = sWorld->FindSession(accountId);
    PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(worldSession);
    if (!session)
        return MERC_ERR_NO_BOT;

    // Le mercenaire existe : on encaisse.
    owner->ModifyMoney(-int64(m_cost));

    uint32 const level = PlayerBotSetting::CheckMaxLevel(owner->getLevel());

    // Classe du personnage qui va porter le contrat : deja connue s il est en
    // jeu, lue dans la fiche du compte s il faut encore le connecter.
    uint8 botClass = 0;
    if (alreadyOnline)
        botClass = session->GetPlayer()->getClass();
    else
    {
        PlayerBotBaseInfo* accountInfo = sPlayerBotMgr->GetPlayerBotAccountInfo(accountId);
        if (!accountInfo)
            accountInfo = sPlayerBotMgr->GetAccountBotAccountInfo(accountId);
        if (accountInfo)
        {
            PlayerBotBaseInfo::CharInfoMap::iterator itChar = accountInfo->characters.find(uint32(charGuid));
            if (itChar != accountInfo->characters.end())
                botClass = uint8(itChar->second.profession);
        }

        BotGlobleSchedule online(BotGlobleScheduleType::BGSType_Online_GUID, charGuid);
        session->PushScheduleToQueue(online);
    }

    int32 const specIndex = FindSpecIndexForRole(botClass, role);

    // Mise au niveau du maitre et specialisation imposee par le role achete.
    // 1 a 3 forcent la specialisation, 4 laisserait celle du personnage.
    BotGlobleSchedule setting(BotGlobleScheduleType::BGSType_Settting, 0);
    setting.parameter1 = level;
    setting.parameter2 = level;
    setting.parameter3 = specIndex >= 0 ? uint32(specIndex) + 1 : 4;
    session->PushScheduleToQueue(setting);

    MercenaryContract contract;
    contract.accountId = accountId;
    contract.ownerGuid = owner->GetGUID();
    contract.role = role;
    contract.stage = MERC_STAGE_SUMMONING;
    m_contracts.push_back(contract);

    TC_LOG_INFO("server.worldserver", "Mercenaires: %s a paye %u po pour un %s (compte bot %u).",
        owner->GetName().c_str(), GetCostGold(), GetRoleName(role), accountId);

    return MERC_OK;
}

void MercenaryMgr::Refund(ObjectGuid ownerGuid, char const* reason)
{
    Player* owner = ObjectAccessor::FindConnectedPlayer(ownerGuid);
    if (!owner)
        return;

    owner->ModifyMoney(int64(m_cost));
    ChatHandler(owner->GetSession()).PSendSysMessage("|cff00ff00[Portail]|r %s Vos %u pièces d'or vous sont rendues.",
        reason, GetCostGold());
}

// Congedie le bot d un contrat : sortie du groupe puis deconnexion. Le contrat
// doit avoir ete retire de la liste AVANT l appel (reentrance des hooks).
void MercenaryMgr::ReleaseBot(MercenaryContract const& contract)
{
    // Le contrat s arrete : le mercenaire perd la memoire de vos echanges, et si
    // vous ne commandez plus personne, votre cle d API est effacee sur-le-champ.
    if (!contract.botGuid.IsEmpty())
        sMercenaryChatMgr->ForgetBot(contract.botGuid);
    if (!CountContracts(contract.ownerGuid))
        sMercenaryChatMgr->ClearCredential(contract.ownerGuid);

    WorldSession* session = sWorld->FindSession(contract.accountId);
    if (!session || !session->IsBotSession())
        return;

    m_releasing = true;

    if (Player* bot = session->GetPlayer())
    {
        if (bot->IsInWorld())
        {
            if (bot->IsInCombat())
                bot->CombatStop(true);
            if (bot->GetGroup())
                bot->RemoveFromGroup(RemoveMethod::GROUP_REMOVEMETHOD_LEAVE);
        }
        session->LogoutPlayer(false);
    }
    else if (PlayerBotSession* botSession = dynamic_cast<PlayerBotSession*>(session))
        botSession->ClearAllSchedule();     // invocation abandonnee avant l arrivee

    m_releasing = false;
}

void MercenaryMgr::DismissOne(ObjectGuid botGuid)
{
    if (m_releasing)
        return;

    for (std::vector<MercenaryContract>::iterator it = m_contracts.begin(); it != m_contracts.end(); ++it)
    {
        if (it->botGuid != botGuid)
            continue;

        MercenaryContract const contract = *it;
        m_contracts.erase(it);

        if (Player* owner = ObjectAccessor::FindConnectedPlayer(contract.ownerGuid))
            ChatHandler(owner->GetSession()).PSendSysMessage(
                "|cff00ff00[Portail]|r Votre %s retourne d'où il vient. Il vous faudra payer de nouveau pour en invoquer un autre.",
                GetRoleName(contract.role));

        ReleaseBot(contract);
        return;
    }
}

void MercenaryMgr::DismissAll(ObjectGuid ownerGuid)
{
    if (m_releasing)
        return;

    std::vector<MercenaryContract> released;
    for (std::vector<MercenaryContract>::iterator it = m_contracts.begin(); it != m_contracts.end(); )
    {
        if (it->ownerGuid != ownerGuid)
        {
            ++it;
            continue;
        }
        released.push_back(*it);
        it = m_contracts.erase(it);
    }

    for (MercenaryContract const& contract : released)
        ReleaseBot(contract);
}

// Un membre a quitte un groupe, de son plein gre ou expulse. Si c est un
// mercenaire, son contrat s arrete la ; si c est son employeur, toute sa
// compagnie se dissout.
//
// On se contente de MARQUER les contrats, la liberation a lieu au tick suivant.
// Ce hook est appele depuis Group::RemoveMember et depuis Group::Disband ;
// congedier sur-le-champ rappelle Group::RemoveMember par en dessous, or
// RemoveMember disband le groupe des qu il repasse sous deux membres et
// Disband() se termine par `delete this`. L appel exterieur reprenait alors la
// main sur un Group libere et le liberait une seconde fois -- double liberation
// qui corrompait le tas et faisait tomber le serveur bien plus tard, dans un
// malloc sans rapport.
void MercenaryMgr::OnPlayerLeftGroup(ObjectGuid guid)
{
    if (m_releasing)
        return;

    for (MercenaryContract& contract : m_contracts)
        if (contract.botGuid == guid || contract.ownerGuid == guid)
            contract.pendingRelease = true;
}

void MercenaryMgr::OnGroupDisband(Group* group)
{
    if (m_releasing || !group || m_contracts.empty())
        return;

    // Meme regle que ci-dessus : ne rien toucher pendant que le core demonte le
    // groupe. Disband() retire lui-meme tous les membres juste apres ce hook.
    for (Group::MemberSlot const& slot : group->GetMemberSlots())
        for (MercenaryContract& contract : m_contracts)
            if (contract.botGuid == slot.guid || contract.ownerGuid == slot.guid)
                contract.pendingRelease = true;
}

void MercenaryMgr::OnPlayerLogout(Player* player)
{
    if (!player || player->IsPlayerBot())
        return;

    DismissAll(player->GetGUID());
}

void MercenaryMgr::Update(uint32 diff)
{
    if (!m_enabled || m_contracts.empty())
        return;

    m_updateTimer += diff;
    if (m_updateTimer < 1000)
        return;
    m_updateTimer = 0;

    for (std::vector<MercenaryContract>::iterator it = m_contracts.begin(); it != m_contracts.end(); )
    {
        // Contrat rompu par un hook de groupe : la liberation a ete differee
        // jusqu ici pour ne pas reentrer dans Group::RemoveMember / Disband().
        if (it->pendingRelease)
        {
            MercenaryContract const contract = *it;
            it = m_contracts.erase(it);

            if (Player* owner = ObjectAccessor::FindConnectedPlayer(contract.ownerGuid))
                ChatHandler(owner->GetSession()).PSendSysMessage(
                    "|cff00ff00[Portail]|r Votre %s retourne d'où il vient. Il vous faudra payer de nouveau pour en invoquer un autre.",
                    GetRoleName(contract.role));

            ReleaseBot(contract);
            continue;
        }

        // L employeur d abord : plus de maitre, plus de contrat. C est le filet
        // de securite si un hook n a pas ete appele (crash client, timeout...).
        Player* owner = ObjectAccessor::FindConnectedPlayer(it->ownerGuid);
        if (!owner || !owner->IsInWorld())
        {
            MercenaryContract const contract = *it;
            it = m_contracts.erase(it);
            ReleaseBot(contract);
            continue;
        }

        if (it->stage == MERC_STAGE_ACTIVE)
        {
            Player* bot = ObjectAccessor::FindConnectedPlayer(it->botGuid);
            Group* group = owner->GetGroup();
            if (!bot || !bot->IsInWorld() || !group || bot->GetGroup() != group)
            {
                MercenaryContract const contract = *it;
                it = m_contracts.erase(it);
                ReleaseBot(contract);
                continue;
            }

            // Materialisation aupres de l employeur, au premier tick qui suit
            // l entree dans le groupe. On passe par l ordre « summon » de l IA
            // plutot que par un TeleportTo direct : un bot n a pas de client
            // pour accuser reception du teleport, c est BotAITeleport qui
            // simule cet echange en trois etapes. Un TeleportTo pose ici laisse
            // le mercenaire a son ancienne place aux yeux de tout le monde.
            if (it->summonPending)
            {
                if (BotGroupAI* groupAI = dynamic_cast<BotGroupAI*>(bot->GetAI()))
                {
                    groupAI->ProcessBotCommand(owner, "summon");
                    it->summonPending = false;
                }
            }

            ++it;
            continue;
        }

        // Invocation en cours.
        ++it->waitSeconds;

        WorldSession* worldSession = sWorld->FindSession(it->accountId);
        PlayerBotSession* session = dynamic_cast<PlayerBotSession*>(worldSession);
        if (!session)
        {
            Refund(it->ownerGuid, "Le mercenaire ne s'est jamais présenté.");
            it = m_contracts.erase(it);
            continue;
        }

        Player* bot = session->GetPlayer();
        bool const ready = bot && bot->IsInWorld() && !session->PlayerLoading()
            && !session->HasSchedules() && bot->IsSettingFinish();

        if (!ready)
        {
            if (it->waitSeconds > MERCENARY_SUMMON_TIMEOUT)
            {
                MercenaryContract const contract = *it;
                it = m_contracts.erase(it);
                Refund(contract.ownerGuid, "Le mercenaire ne s'est jamais présenté.");
                ReleaseBot(contract);
                continue;
            }
            ++it;
            continue;
        }

        // Le groupe est cree au moment ou le premier mercenaire arrive, pas a
        // l achat : un paiement qui echoue ne doit pas laisser de groupe vide.
        Group* group = owner->GetGroup();
        if (!group)
        {
            group = new Group;
            if (!group->Create(owner))
            {
                delete group;
                MercenaryContract const contract = *it;
                it = m_contracts.erase(it);
                Refund(contract.ownerGuid, "Le pacte n'a pas pu être scellé.");
                ReleaseBot(contract);
                continue;
            }
            sGroupMgr->AddGroup(group);
        }

        if (group->IsFull() || !group->AddMember(bot))
        {
            MercenaryContract const contract = *it;
            it = m_contracts.erase(it);
            Refund(contract.ownerGuid, "Votre groupe est complet.");
            ReleaseBot(contract);
            continue;
        }

        it->botGuid = bot->GetGUID();
        it->stage = MERC_STAGE_ACTIVE;
        // Le mercenaire doit encore se materialiser aupres de son employeur :
        // c est fait au tick suivant, une fois que l IA de groupe aura reconnu
        // son maitre. Voir la branche MERC_STAGE_ACTIVE.
        it->summonPending = true;

        PlayerBotMgr::SwitchPlayerBotAI(bot, PlayerBotAIType::PBAIT_GROUP, true);

        ChatHandler(owner->GetSession()).PSendSysMessage(
            "|cff00ff00[Portail]|r %s, %s mercenaire, répond à votre appel.",
            bot->GetName().c_str(), GetRoleName(it->role));

        TC_LOG_INFO("server.worldserver", "Mercenaires: %s rejoint le groupe de %s (role %s).",
            bot->GetName().c_str(), owner->GetName().c_str(), GetRoleName(it->role));

        ++it;
    }
}
