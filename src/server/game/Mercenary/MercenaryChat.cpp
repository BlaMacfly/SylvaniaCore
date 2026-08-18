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

#include "MercenaryChat.h"
#include "Chat.h"
#include "ChatPackets.h"
#include "Config.h"
#include "Group.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "Timer.h"
#include "World.h"
#include "WorldSession.h"

#include <curl/curl.h>

#include <algorithm>
#include <sstream>

namespace
{
    // Adresses par defaut. Le joueur peut fournir la sienne pour tout service
    // parlant le dialecte d OpenAI (Mistral, Groq, OpenRouter, Ollama, LM Studio).
    char const* OPENAI_DEFAULT_URL    = "https://api.openai.com/v1/chat/completions";
    char const* ANTHROPIC_DEFAULT_URL = "https://api.anthropic.com/v1/messages";
    char const* GEMINI_DEFAULT_HOST   = "https://generativelanguage.googleapis.com/v1beta/models/";
    char const* MISTRAL_DEFAULT_URL   = "https://api.mistral.ai/v1/chat/completions";

    std::string JsonEscape(std::string const& text)
    {
        std::string out;
        out.reserve(text.size() + 16);
        for (std::string::const_iterator it = text.begin(); it != text.end(); ++it)
        {
            unsigned char c = static_cast<unsigned char>(*it);
            switch (c)
            {
                case '"':  out += "\\\""; break;
                case '\\': out += "\\\\"; break;
                case '\n': out += "\\n";  break;
                case '\r': out += "\\r";  break;
                case '\t': out += "\\t";  break;
                default:
                    if (c < 0x20)
                    {
                        char buf[8];
                        snprintf(buf, sizeof(buf), "\\u%04x", c);
                        out += buf;
                    }
                    else
                        out += char(c);
                    break;
            }
        }
        return out;
    }

    // Lecture d une chaine JSON, le curseur pointant sur le guillemet ouvrant.
    // Ecrit a la main faute de mieux : le rapidjson embarque dans le core est
    // trop ancien pour ce compilateur - son document.h ne compile plus - et le
    // core lui-meme ne s en sert que par le lecteur evenementiel.
    std::string DecodeJsonString(std::string const& src, size_t open)
    {
        std::string out;
        for (size_t i = open + 1; i < src.size(); ++i)
        {
            char const c = src[i];
            if (c == '"')
                break;
            if (c != '\\')
            {
                out += c;
                continue;
            }
            if (++i >= src.size())
                break;
            switch (src[i])
            {
                case 'n': out += '\n'; break;
                case 'r': out += '\r'; break;
                case 't': out += '\t'; break;
                case 'b': out += '\b'; break;
                case 'f': out += '\f'; break;
                case '"': out += '"';  break;
                case '\\': out += '\\'; break;
                case '/': out += '/';  break;
                case 'u':
                {
                    if (i + 4 >= src.size())
                        return out;
                    uint32 code = uint32(strtoul(src.substr(i + 1, 4).c_str(), nullptr, 16));
                    i += 4;
                    // Paire d indirection UTF-16 : le fournisseur encode ainsi
                    // les emojis et les caracteres rares.
                    if (code >= 0xD800 && code <= 0xDBFF && i + 6 < src.size()
                        && src[i + 1] == '\\' && src[i + 2] == 'u')
                    {
                        uint32 const low = uint32(strtoul(src.substr(i + 3, 4).c_str(), nullptr, 16));
                        if (low >= 0xDC00 && low <= 0xDFFF)
                        {
                            code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00);
                            i += 6;
                        }
                    }
                    if (code < 0x80)
                        out += char(code);
                    else if (code < 0x800)
                    {
                        out += char(0xC0 | (code >> 6));
                        out += char(0x80 | (code & 0x3F));
                    }
                    else if (code < 0x10000)
                    {
                        out += char(0xE0 | (code >> 12));
                        out += char(0x80 | ((code >> 6) & 0x3F));
                        out += char(0x80 | (code & 0x3F));
                    }
                    else
                    {
                        out += char(0xF0 | (code >> 18));
                        out += char(0x80 | ((code >> 12) & 0x3F));
                        out += char(0x80 | ((code >> 6) & 0x3F));
                        out += char(0x80 | (code & 0x3F));
                    }
                    break;
                }
                default:
                    out += src[i];
                    break;
            }
        }
        return out;
    }

    // Cherche « "cle" : "valeur" » a partir d une position donnee.
    bool FindJsonString(std::string const& body, char const* key, size_t from, std::string& out)
    {
        std::string const needle = std::string("\"") + key + "\"";
        size_t pos = body.find(needle, from);
        if (pos == std::string::npos)
            return false;

        pos = body.find(':', pos + needle.size());
        if (pos == std::string::npos)
            return false;

        size_t const open = body.find('"', pos + 1);
        if (open == std::string::npos)
            return false;

        out = DecodeJsonString(body, open);
        return true;
    }

    size_t CurlWrite(void* contents, size_t size, size_t count, void* userData)
    {
        size_t total = size * count;
        static_cast<std::string*>(userData)->append(static_cast<char*>(contents), total);
        return total;
    }

    // Le client ne sait afficher qu une ligne : on replie les retours a la ligne
    // et on borne la longueur pour ne pas faire deborder le paquet de chat.
    std::string Flatten(std::string text, size_t maxLength = 240)
    {
        std::replace(text.begin(), text.end(), '\n', ' ');
        std::replace(text.begin(), text.end(), '\r', ' ');
        if (text.size() > maxLength)
        {
            text.resize(maxLength);
            // Ne pas couper au milieu d une sequence UTF-8.
            while (!text.empty() && (static_cast<unsigned char>(text.back()) & 0xC0) == 0x80)
                text.erase(text.size() - 1);
            text += "...";
        }
        return text;
    }
}

void MercenaryCredential::Wipe()
{
    std::fill(apiKey.begin(), apiKey.end(), '\0');
    apiKey.clear();
    model.clear();
    baseUrl.clear();
    provider = MERC_LLM_UNKNOWN;
}

void MercenaryChatRequest::Wipe()
{
    std::fill(apiKey.begin(), apiKey.end(), '\0');
    apiKey.clear();
}

MercenaryChatMgr::MercenaryChatMgr() :
    m_running(false), m_enabled(false), m_cooldown(5), m_timeout(30),
    m_maxTokens(160), m_historyDepth(6), m_maxPending(32)
{
}

MercenaryChatMgr::~MercenaryChatMgr()
{
    Stop();
}

MercenaryChatMgr* MercenaryChatMgr::instance()
{
    static MercenaryChatMgr instance;
    return &instance;
}

void MercenaryChatMgr::LoadConfig()
{
    m_enabled      = sConfigMgr->GetIntDefault("pbotmerc_chat", 0) != 0;
    m_cooldown     = sConfigMgr->GetIntDefault("pbotmerc_chat_cooldown", 5);
    m_timeout      = sConfigMgr->GetIntDefault("pbotmerc_chat_timeout", 30);
    m_maxTokens    = sConfigMgr->GetIntDefault("pbotmerc_chat_maxtokens", 160);
    m_historyDepth = sConfigMgr->GetIntDefault("pbotmerc_chat_history", 6);
    m_maxPending   = sConfigMgr->GetIntDefault("pbotmerc_chat_queue", 32);

    TC_LOG_INFO("server.loading", "Mercenaires (dialogue): %s, delai %u s, expiration %u s, %u jetons, %u echanges memorises.",
        m_enabled ? "actif" : "inactif", m_cooldown, m_timeout, m_maxTokens, m_historyDepth);
}

void MercenaryChatMgr::Start()
{
    if (m_running)
        return;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    m_running = true;
    m_worker = std::thread(&MercenaryChatMgr::WorkerLoop, this);
}

void MercenaryChatMgr::Stop()
{
    if (!m_running)
        return;

    m_running = false;
    m_pendingSignal.notify_all();
    if (m_worker.joinable())
        m_worker.join();

    // Aucun secret ne survit a l arret du royaume.
    std::lock_guard<std::mutex> guard(m_credentialLock);
    for (std::map<ObjectGuid, MercenaryCredential>::iterator it = m_credentials.begin(); it != m_credentials.end(); ++it)
        it->second.Wipe();
    m_credentials.clear();

    curl_global_cleanup();
}

char const* MercenaryChatMgr::GetProviderName(uint8 provider)
{
    switch (provider)
    {
        case MERC_LLM_OPENAI:    return "OpenAI";
        case MERC_LLM_ANTHROPIC: return "Anthropic";
        case MERC_LLM_GEMINI:    return "Gemini";
        case MERC_LLM_MISTRAL:   return "Mistral";
        default:                 return "inconnu";
    }
}

uint8 MercenaryChatMgr::ParseProvider(std::string const& name)
{
    std::string lowered = name;
    std::transform(lowered.begin(), lowered.end(), lowered.begin(), ::tolower);

    if (lowered == "mistral" || lowered == "lechat")
        return MERC_LLM_MISTRAL;
    if (lowered == "openai" || lowered == "compatible" || lowered == "openrouter"
        || lowered == "groq" || lowered == "ollama" || lowered == "cerebras")
        return MERC_LLM_OPENAI;
    if (lowered == "anthropic" || lowered == "claude")
        return MERC_LLM_ANTHROPIC;
    if (lowered == "gemini" || lowered == "google")
        return MERC_LLM_GEMINI;
    return MERC_LLM_UNKNOWN;
}

bool MercenaryChatMgr::HasCredential(ObjectGuid ownerGuid) const
{
    std::lock_guard<std::mutex> guard(m_credentialLock);
    return m_credentials.find(ownerGuid) != m_credentials.end();
}

void MercenaryChatMgr::ClearCredential(ObjectGuid ownerGuid)
{
    std::lock_guard<std::mutex> guard(m_credentialLock);
    std::map<ObjectGuid, MercenaryCredential>::iterator it = m_credentials.find(ownerGuid);
    if (it == m_credentials.end())
        return;
    it->second.Wipe();
    m_credentials.erase(it);
}

void MercenaryChatMgr::ForgetBot(ObjectGuid botGuid)
{
    m_history.erase(botGuid);
}

// « !api <fournisseur> <modele> <cle> [adresse] », « !api off », « !api » pour l aide.
// Le message n est jamais journalise ni rediffuse : c est l appelant, dans le
// gestionnaire de chat, qui interrompt le traitement quand cette fonction rend true.
bool MercenaryChatMgr::HandleApiCommand(Player* owner, std::string const& arguments)
{
    if (!owner)
        return true;

    ChatHandler handler(owner->GetSession());

    if (!m_enabled)
    {
        handler.PSendSysMessage("|cffff0000[Mercenaire]|r Le dialogue par intelligence artificielle est desactive sur ce royaume.");
        return true;
    }

    std::istringstream stream(arguments);
    std::string first;
    stream >> first;

    if (first.empty() || first == "aide" || first == "help")
    {
        handler.PSendSysMessage("|cff00ff00[Mercenaire]|r Pour delier la langue de votre mercenaire, fournissez votre propre cle :");
        handler.PSendSysMessage("  |cffffd100!api <fournisseur> <modele> <cle>|r");
        handler.PSendSysMessage("  fournisseurs : |cffffd100mistral|r, |cffffd100anthropic|r, |cffffd100openai|r, |cffffd100gemini|r");
        handler.PSendSysMessage("  exemple : |cffffd100!api mistral mistral-small-latest VOTRE_CLE|r");
        handler.PSendSysMessage("  |cffff8800Gemini ne repond pas depuis ce royaume|r (Google refuse les serveurs).");
        handler.PSendSysMessage("  service compatible OpenAI (Groq, OpenRouter...) : ajoutez l'adresse en fin de ligne.");
        handler.PSendSysMessage("  |cffffd100!api off|r retire votre cle immediatement.");
        handler.PSendSysMessage("Votre cle n'est jamais enregistree : elle vit en memoire et disparait a la rupture du contrat ou a votre deconnexion.");
        return true;
    }

    if (first == "off" || first == "stop" || first == "clear")
    {
        ClearCredential(owner->GetGUID());
        handler.PSendSysMessage("|cff00ff00[Mercenaire]|r Votre cle a ete effacee. Vos mercenaires redeviennent muets.");
        return true;
    }

    uint8 const provider = ParseProvider(first);
    if (provider == MERC_LLM_UNKNOWN)
    {
        handler.PSendSysMessage("|cffff0000[Mercenaire]|r Fournisseur inconnu. Attendus : openai, anthropic, gemini.");
        return true;
    }

    std::string model, key, url;
    stream >> model >> key >> url;

    if (model.empty() || key.empty())
    {
        handler.PSendSysMessage("|cffff0000[Mercenaire]|r Il manque le modele ou la cle. Tapez |cffffd100!api|r pour l'aide.");
        return true;
    }

    MercenaryCredential credential;
    credential.provider = provider;
    credential.model = model;
    credential.apiKey = key;
    credential.baseUrl = url;

    {
        std::lock_guard<std::mutex> guard(m_credentialLock);
        std::map<ObjectGuid, MercenaryCredential>::iterator it = m_credentials.find(owner->GetGUID());
        if (it != m_credentials.end())
            it->second.Wipe();
        m_credentials[owner->GetGUID()] = credential;
    }

    // La longueur seule est renvoyee : de quoi verifier une faute de frappe sans
    // jamais reafficher le secret.
    handler.PSendSysMessage("|cff00ff00[Mercenaire]|r Cle acceptee (%s, modele %s, %u caracteres). Vos mercenaires peuvent desormais vous repondre.",
        GetProviderName(provider), model.c_str(), uint32(key.size()));
    handler.PSendSysMessage("Parlez-leur normalement : chuchotement, canal de groupe ou a voix haute. Les ordres, eux, commencent par |cffffd100!|r.");

    TC_LOG_INFO("server.worldserver", "Mercenaires (dialogue): %s a fourni une cle %s (modele %s).",
        owner->GetName().c_str(), GetProviderName(provider), model.c_str());
    return true;
}

namespace
{
    char const* RaceName(uint8 race)
    {
        switch (race)
        {
            case RACE_HUMAN:            return "humain";
            case RACE_ORC:              return "orc";
            case RACE_DWARF:            return "nain";
            case RACE_NIGHTELF:         return "elfe de la nuit";
            case RACE_UNDEAD_PLAYER:    return "mort-vivant reprouve";
            case RACE_TAUREN:           return "tauren";
            case RACE_GNOME:            return "gnome";
            case RACE_TROLL:            return "troll";
            case RACE_GOBLIN:           return "gobelin";
            case RACE_BLOODELF:         return "elfe de sang";
            case RACE_DRAENEI:          return "draenei";
            case RACE_WORGEN:           return "worgen";
            default:                    return "aventurier";
        }
    }
}

std::string MercenaryChatMgr::BuildSystemPrompt(Player* owner, Player* bot) const
{
    char const* className = "aventurier";
    switch (bot->getClass())
    {
        case CLASS_WARRIOR:      className = "guerrier";            break;
        case CLASS_PALADIN:      className = "paladin";             break;
        case CLASS_HUNTER:       className = "chasseur";            break;
        case CLASS_ROGUE:        className = "voleur";              break;
        case CLASS_PRIEST:       className = "pretre";              break;
        case CLASS_DEATH_KNIGHT: className = "chevalier de la mort"; break;
        case CLASS_SHAMAN:       className = "chaman";              break;
        case CLASS_MAGE:         className = "mage";                break;
        case CLASS_WARLOCK:      className = "demoniste";           break;
        case CLASS_DRUID:        className = "druide";              break;
        default: break;
    }

    bool const alliance = bot->GetTeamId() == TEAM_ALLIANCE;

    std::ostringstream prompt;
    prompt << "Tu es " << bot->GetName() << ", " << RaceName(bot->getRace()) << " " << className
           << " de niveau " << uint32(bot->getLevel()) << ", mercenaire "
           << (alliance ? "de l'Alliance" : "de la Horde")
           << " au service de " << owner->GetName() << " en Azeroth. "
           << "Un portail magique t'a arrache a tes affaires contre cent pieces d'or : tu sers cet employeur "
           << "tant que dure le contrat, ni plus, ni moins.\n"

           << "PARLER : francais, une a trois phrases, jamais davantage. Registre medieval-fantastique, "
           << "rude et image, celui d'un soudard qui a vu trop de champs de bataille. "
           << "Tu tutoies ton employeur ; tu l'appelles parfois « patron », « chef » ou par son nom. "
           << "Tu jures par ce que jure ton peuple : "
           << (alliance ? "« Par la Lumiere ! », « Par la barbe de mes ancetres ! », « Par Elune ! »"
                        : "« Par les esprits ! », « Lok'tar ! », « Que les ancetres me foudroient ! »")
           << ". Tu parles d'or, d'acier, de sang, de gnognote et de bonne biere.\n"

           << "INTERDIT : tout mot du monde moderne (d'accord, ok, super, cool, probleme technique, "
           << "systeme, application, internet, robot, intelligence artificielle, modele, invite). "
           << "Tu n'es pas un programme et tu ne romps jamais l'illusion : si on te demande ce que tu es, "
           << "tu es une lame a louer, rien d'autre. Pas d'emoticone, pas d'asterisque, pas de didascalie.\n"

           << "CARACTERE : venal mais loyal tant qu'on paie, fier de ton metier, moqueur avec les nobles, "
           << "sec devant le danger. Tu grommelles volontiers, tu ne flattes jamais.\n"

           << "ORDRES : tu obeis aux ordres precedes d'un point d'exclamation (!follow, !stop, !attack, "
           << "!summon). Si ton employeur te demande d'agir en pleine conversation, reponds-lui en personnage "
           << "et rappelle-lui de crier son ordre avec le point d'exclamation.";

    prompt << "\nSITUATION : ";
    if (Group* group = owner->GetGroup())
        prompt << "vous chevauchez a " << uint32(group->GetMembersCount()) << " en compagnie. ";

    if (bot->GetHealthPct() < 50.0f)
        prompt << "Tu saignes (" << uint32(bot->GetHealthPct()) << " pour cent de tes forces) et tu le fais savoir. ";

    if (bot->IsInCombat())
        prompt << "L'acier chante, vous etes aux prises : une phrase, pas plus, et retourne au combat. ";

    return prompt.str();
}

bool MercenaryChatMgr::Talk(Player* owner, Player* bot, uint8 channel, std::string const& message, Player* speaker)
{
    if (!m_enabled || !m_running || !owner || !bot || message.empty())
        return false;

    MercenaryChatRequest request;
    {
        std::lock_guard<std::mutex> guard(m_credentialLock);
        std::map<ObjectGuid, MercenaryCredential>::const_iterator it = m_credentials.find(owner->GetGUID());
        if (it == m_credentials.end())
            return false;

        request.provider = it->second.provider;
        request.model    = it->second.model;
        request.apiKey   = it->second.apiKey;
        request.baseUrl  = it->second.baseUrl;
    }

    // Anti-spam : une replique par employeur et par delai. Le joueur paie ses
    // propres jetons, une macro bavarde lui couterait cher.
    uint32 const now = getMSTime();
    std::map<ObjectGuid, uint32>::iterator itLast = m_lastTalk.find(owner->GetGUID());
    if (itLast != m_lastTalk.end() && GetMSTimeDiffToNow(itLast->second) < m_cooldown * IN_MILLISECONDS)
    {
        request.Wipe();
        return false;
    }

    {
        std::lock_guard<std::mutex> guard(m_pendingLock);
        if (m_pending.size() >= m_maxPending)
        {
            request.Wipe();
            return false;
        }
    }

    m_lastTalk[owner->GetGUID()] = now;

    request.ownerGuid      = owner->GetGUID();
    request.botGuid        = bot->GetGUID();
    request.channel        = channel;
    request.systemPrompt   = BuildSystemPrompt(owner, bot);
    // Quand la voix n est pas celle du patron, on le dit au mercenaire : il doit
    // savoir a qui il repond, et a qui il doit deference ou pas.
    request.userMessage    = (speaker && speaker != owner)
        ? (speaker->GetName() + " (compagnon de la troupe, pas ton employeur) te lance : " + message)
        : message;
    request.maxTokens      = m_maxTokens;
    request.timeoutSeconds = m_timeout;

    std::map<ObjectGuid, std::vector<std::pair<std::string, std::string> > >::const_iterator itHist = m_history.find(bot->GetGUID());
    if (itHist != m_history.end())
        request.history = itHist->second;

    {
        std::lock_guard<std::mutex> guard(m_pendingLock);
        m_pending.push_back(request);
    }
    m_pendingSignal.notify_one();

    // La replique du joueur entre dans l historique maintenant : la copie posee
    // dans la file, elle, portait l historique d avant, plus le message courant.
    std::vector<std::pair<std::string, std::string> >& history = m_history[bot->GetGUID()];
    history.push_back(std::make_pair(std::string("user"), message));
    while (history.size() > m_historyDepth)
        history.erase(history.begin());

    // La copie locale garde une trace du secret : on l efface, la file en a la sienne.
    request.Wipe();
    return true;
}

void MercenaryChatMgr::WorkerLoop()
{
    while (m_running)
    {
        MercenaryChatRequest request;
        {
            std::unique_lock<std::mutex> guard(m_pendingLock);
            m_pendingSignal.wait(guard, [this] { return !m_pending.empty() || !m_running; });
            if (!m_running)
                break;
            request = m_pending.front();
            m_pending.pop_front();
        }

        std::string answer;
        std::string error;
        bool const ok = Perform(request, answer, error);

        MercenaryChatReply reply;
        reply.ownerGuid = request.ownerGuid;
        reply.botGuid   = request.botGuid;
        reply.channel   = request.channel;
        reply.failed    = !ok;
        reply.text      = ok ? answer : error;

        // Le secret disparait des que l appel est termine.
        request.Wipe();

        std::lock_guard<std::mutex> guard(m_replyLock);
        m_replies.push_back(reply);
    }
}

std::string MercenaryChatMgr::BuildUrl(MercenaryChatRequest const& request)
{
    if (!request.baseUrl.empty() && request.provider != MERC_LLM_GEMINI)
        return request.baseUrl;

    switch (request.provider)
    {
        case MERC_LLM_ANTHROPIC:
            return ANTHROPIC_DEFAULT_URL;
        case MERC_LLM_MISTRAL:
            return MISTRAL_DEFAULT_URL;
        case MERC_LLM_GEMINI:
        {
            // Gemini porte la cle dans l adresse et le modele dans le chemin.
            std::string host = request.baseUrl.empty() ? GEMINI_DEFAULT_HOST : request.baseUrl;
            return host + request.model + ":generateContent?key=" + request.apiKey;
        }
        default:
            return OPENAI_DEFAULT_URL;
    }
}

std::string MercenaryChatMgr::BuildPayload(MercenaryChatRequest const& request)
{
    std::ostringstream json;

    if (request.provider == MERC_LLM_GEMINI)
    {
        json << "{\"system_instruction\":{\"parts\":[{\"text\":\"" << JsonEscape(request.systemPrompt) << "\"}]},"
             << "\"contents\":[";
        for (size_t i = 0; i < request.history.size(); ++i)
        {
            char const* role = request.history[i].first == "assistant" ? "model" : "user";
            json << "{\"role\":\"" << role << "\",\"parts\":[{\"text\":\""
                 << JsonEscape(request.history[i].second) << "\"}]},";
        }
        json << "{\"role\":\"user\",\"parts\":[{\"text\":\"" << JsonEscape(request.userMessage) << "\"}]}],"
             << "\"generationConfig\":{\"maxOutputTokens\":" << request.maxTokens << "}}";
        return json.str();
    }

    if (request.provider == MERC_LLM_ANTHROPIC)
    {
        // Anthropic sort l invite systeme du tableau des messages.
        json << "{\"model\":\"" << JsonEscape(request.model) << "\","
             << "\"max_tokens\":" << request.maxTokens << ","
             << "\"system\":\"" << JsonEscape(request.systemPrompt) << "\","
             << "\"messages\":[";
        for (size_t i = 0; i < request.history.size(); ++i)
        {
            json << "{\"role\":\"" << JsonEscape(request.history[i].first) << "\",\"content\":\""
                 << JsonEscape(request.history[i].second) << "\"},";
        }
        json << "{\"role\":\"user\",\"content\":\"" << JsonEscape(request.userMessage) << "\"}]}";
        return json.str();
    }

    json << "{\"model\":\"" << JsonEscape(request.model) << "\","
         << "\"max_tokens\":" << request.maxTokens << ","
         << "\"messages\":[{\"role\":\"system\",\"content\":\"" << JsonEscape(request.systemPrompt) << "\"},";
    for (size_t i = 0; i < request.history.size(); ++i)
    {
        json << "{\"role\":\"" << JsonEscape(request.history[i].first) << "\",\"content\":\""
             << JsonEscape(request.history[i].second) << "\"},";
    }
    json << "{\"role\":\"user\",\"content\":\"" << JsonEscape(request.userMessage) << "\"}]}";
    return json.str();
}

bool MercenaryChatMgr::Perform(MercenaryChatRequest const& request, std::string& answer, std::string& error)
{
    CURL* curl = curl_easy_init();
    if (!curl)
    {
        error = "Le portail ne parvient pas a ouvrir la voie.";
        return false;
    }

    std::string const url = BuildUrl(request);
    std::string const payload = BuildPayload(request);
    std::string body;

    curl_slist* headers = nullptr;
    headers = curl_slist_append(headers, "Content-Type: application/json");

    switch (request.provider)
    {
        case MERC_LLM_ANTHROPIC:
        {
            std::string keyHeader = "x-api-key: " + request.apiKey;
            headers = curl_slist_append(headers, keyHeader.c_str());
            headers = curl_slist_append(headers, "anthropic-version: 2023-06-01");
            std::fill(keyHeader.begin(), keyHeader.end(), '\0');
            break;
        }
        case MERC_LLM_GEMINI:
            break;      // la cle voyage dans l adresse
        default:
        {
            std::string keyHeader = "Authorization: Bearer " + request.apiKey;
            headers = curl_slist_append(headers, keyHeader.c_str());
            std::fill(keyHeader.begin(), keyHeader.end(), '\0');
            break;
        }
    }

    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_POST, 1L);
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, payload.c_str());
    curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, long(payload.size()));
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, long(request.timeoutSeconds));
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 10L);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, CurlWrite);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &body);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_USERAGENT, "SylvaniaCore-Mercenary/1.0");

    CURLcode const result = curl_easy_perform(curl);
    long httpCode = 0;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &httpCode);

    curl_slist_free_all(headers);
    curl_easy_cleanup(curl);

    if (result != CURLE_OK)
    {
        error = std::string("Le lien s'est rompu (") + curl_easy_strerror(result) + ").";
        return false;
    }

    if (httpCode >= 400)
    {
        // Le fournisseur explique presque toujours son refus dans le corps de la
        // reponse - modele inconnu, quota depasse, cle sans droits. Renvoyer un
        // code nu au joueur lui cachait justement la seule information utile.
        std::string detail;
        size_t const errorSection = body.find("\"error\"");
        if (errorSection != std::string::npos)
            FindJsonString(body, "message", errorSection, detail);

        std::ostringstream text;
        if (httpCode == 401 || httpCode == 403)
            text << "Votre cle a ete refusee";
        else if (httpCode == 404)
            text << "Modele introuvable pour votre cle";
        else if (httpCode == 429)
            text << "Votre fournisseur refuse le rythme";
        else
            text << "Le fournisseur a repondu par une erreur";

        text << " (" << httpCode << ")";
        if (!detail.empty())
            text << " : " << Flatten(detail, 180);
        else
            text << ".";

        error = text.str();

        // Trace de diagnostic : le corps envoye, jamais l adresse - chez Gemini
        // la cle voyage dans l URL. Le refus d un fournisseur porte presque
        // toujours sur ce qu on lui a transmis.
        TC_LOG_ERROR("server.worldserver", "Mercenaires (dialogue): refus %ld du fournisseur %s. Corps envoye : %s",
            httpCode, GetProviderName(request.provider), payload.c_str());
        TC_LOG_ERROR("server.worldserver", "Mercenaires (dialogue): reponse recue : %s", body.c_str());

        return false;
    }

    std::string parseError;
    answer = ExtractAnswer(request.provider, body, parseError);
    if (answer.empty())
    {
        error = parseError.empty() ? "Reponse vide du fournisseur." : parseError;
        return false;
    }
    return true;
}

// Chaque fournisseur enfouit la replique a un endroit different. On se cale sur
// le marqueur de section propre a chacun, puis on lit la premiere chaine utile :
// cela evite de confondre le texte de la reponse avec un champ homonyme place
// ailleurs dans le corps (message d erreur, metadonnees d usage...).
std::string MercenaryChatMgr::ExtractAnswer(uint8 provider, std::string const& body, std::string& error)
{
    // Le fournisseur signale ses refus par un objet « error » : on le remonte au
    // joueur, c est plus utile qu un « reponse vide ».
    size_t const errorSection = body.find("\"error\"");
    if (errorSection != std::string::npos)
    {
        std::string detail;
        if (FindJsonString(body, "message", errorSection, detail) && !detail.empty())
        {
            error = "Le fournisseur refuse : " + detail;
            return "";
        }
    }

    char const* section = "\"choices\"";
    char const* key = "content";

    if (provider == MERC_LLM_ANTHROPIC)
    {
        section = "\"content\"";
        key = "text";
    }
    else if (provider == MERC_LLM_GEMINI)
    {
        section = "\"candidates\"";
        key = "text";
    }

    size_t const start = body.find(section);
    if (start == std::string::npos)
    {
        error = "Reponse illisible du fournisseur.";
        return "";
    }

    std::string answer;
    if (!FindJsonString(body, key, start, answer))
    {
        error = "Reponse illisible du fournisseur.";
        return "";
    }
    return answer;
}

void MercenaryChatMgr::Update(uint32 /*diff*/)
{
    if (!m_enabled)
        return;

    std::deque<MercenaryChatReply> ready;
    {
        std::lock_guard<std::mutex> guard(m_replyLock);
        if (m_replies.empty())
            return;
        ready.swap(m_replies);
    }

    for (std::deque<MercenaryChatReply>::iterator it = ready.begin(); it != ready.end(); ++it)
    {
        Player* owner = ObjectAccessor::FindConnectedPlayer(it->ownerGuid);
        if (!owner || !owner->IsInWorld())
            continue;

        Player* bot = ObjectAccessor::FindConnectedPlayer(it->botGuid);
        if (!bot || !bot->IsInWorld())
            continue;

        if (it->failed)
        {
            ChatHandler(owner->GetSession()).PSendSysMessage("|cffff0000[%s]|r %s",
                bot->GetName().c_str(), it->text.c_str());
            continue;
        }

        std::string const text = Flatten(it->text);

        switch (it->channel)
        {
            case MERC_REPLY_PARTY:
            {
                if (Group* group = bot->GetGroup())
                {
                    WorldPackets::Chat::Chat packet;
                    packet.Initialize(CHAT_MSG_PARTY, LANG_UNIVERSAL, bot, nullptr, text);
                    group->BroadcastPacket(packet.Write(), false);
                }
                else
                    bot->Whisper(text, LANG_UNIVERSAL, owner);
                break;
            }
            case MERC_REPLY_SAY:
                bot->Say(text, LANG_UNIVERSAL);
                break;
            default:
                bot->Whisper(text, LANG_UNIVERSAL, owner);
                break;
        }

        // Memoire courte : seuls les derniers echanges accompagnent la requete
        // suivante, pour borner le cout en jetons.
        std::vector<std::pair<std::string, std::string> >& history = m_history[it->botGuid];
        history.push_back(std::make_pair(std::string("assistant"), text));
        while (history.size() > m_historyDepth)
            history.erase(history.begin());
    }
}
