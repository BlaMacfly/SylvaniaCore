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

// SylvaniaCore - Module "Mercenaires", volet conversation
//
// Le mercenaire parle par l intermediaire du modele de langage du joueur qui
// l emploie, avec la cle d API de ce joueur. Deux regles gouvernent tout ce
// fichier :
//
//   1. La cle n est JAMAIS persistee. Elle vit en memoire, le temps du contrat,
//      et son emplacement est efface caractere par caractere a la liberation.
//      Aucune ecriture en base, aucune trace dans les journaux.
//   2. Aucun appel reseau ne part du fil du monde. Les requetes partent dans un
//      fil dedie ; les reponses reviennent par une file relue au tick. Un appel
//      d API prend de une a dix secondes : le faire dans la boucle du monde
//      figerait le royaume entier a chaque replique.

#ifndef __MERCENARYCHAT_H__
#define __MERCENARYCHAT_H__

#include "Common.h"
#include "ObjectGuid.h"

#include <atomic>
#include <condition_variable>
#include <deque>
#include <map>
#include <mutex>
#include <string>
#include <thread>
#include <vector>

class Player;

enum MercenaryLlmProvider
{
    MERC_LLM_OPENAI    = 0,     // et tout service compatible : Mistral, Groq, OpenRouter, Ollama...
    MERC_LLM_ANTHROPIC = 1,
    MERC_LLM_GEMINI    = 2,
    MERC_LLM_UNKNOWN   = 255
};

// Canal de reponse : le mercenaire repond toujours la ou on lui a parle.
enum MercenaryReplyChannel
{
    MERC_REPLY_WHISPER = 0,
    MERC_REPLY_PARTY   = 1,
    MERC_REPLY_SAY     = 2
};

// Identifiants d acces d un joueur. Volontairement depourvu de toute methode de
// serialisation : rien ici ne doit pouvoir atteindre un disque.
struct MercenaryCredential
{
    MercenaryCredential() : provider(MERC_LLM_UNKNOWN) { }

    uint8       provider;
    std::string model;
    std::string apiKey;
    std::string baseUrl;    // vide = adresse par defaut du fournisseur

    // Ecrase la cle en place avant de la liberer : un simple clear() laisserait
    // le secret lisible dans la memoire du processus.
    void Wipe();
};

struct MercenaryChatRequest
{
    MercenaryChatRequest() : channel(MERC_REPLY_WHISPER), provider(MERC_LLM_UNKNOWN),
        maxTokens(0), timeoutSeconds(0) { }

    ObjectGuid  ownerGuid;
    ObjectGuid  botGuid;
    uint8       channel;

    uint8       provider;
    std::string model;
    std::string apiKey;
    std::string baseUrl;

    std::string systemPrompt;
    // Historique en paires (role, texte) : « user » pour le joueur, « assistant »
    // pour le mercenaire.
    std::vector<std::pair<std::string, std::string> > history;
    std::string userMessage;

    uint32      maxTokens;
    uint32      timeoutSeconds;

    void Wipe();
};

struct MercenaryChatReply
{
    MercenaryChatReply() : channel(MERC_REPLY_WHISPER), failed(false) { }

    ObjectGuid  ownerGuid;
    ObjectGuid  botGuid;
    uint8       channel;
    std::string text;
    bool        failed;
};

class TC_GAME_API MercenaryChatMgr
{
    public:
        static MercenaryChatMgr* instance();

        void LoadConfig();
        void Start();
        void Stop();

        bool IsEnabled() const { return m_enabled; }
        uint32 GetCooldown() const { return m_cooldown; }

        // Commande « !api ». Renvoie true si le message a ete consomme : il ne
        // doit alors ni etre diffuse ni etre journalise, il contient un secret.
        bool HandleApiCommand(Player* owner, std::string const& arguments);

        bool HasCredential(ObjectGuid ownerGuid) const;
        void ClearCredential(ObjectGuid ownerGuid);

        // Poste une replique aupres du modele. Renvoie false si rien n a ete
        // envoye (pas de cle, delai anti-spam, file saturee).
        //
        // « owner » est l employeur : c est sa cle qui paie et son delai qui
        // compte. « speaker » est celui qui a ouvert la bouche - un compagnon de
        // groupe peut interpeller le mercenaire d un autre, mais la facture
        // reste chez l employeur.
        bool Talk(Player* owner, Player* bot, uint8 channel, std::string const& message, Player* speaker = nullptr);

        // Oublie l historique d un mercenaire congedie.
        void ForgetBot(ObjectGuid botGuid);

        void Update(uint32 diff);

        static char const* GetProviderName(uint8 provider);
        static uint8 ParseProvider(std::string const& name);

    private:
        MercenaryChatMgr();
        ~MercenaryChatMgr();

        void WorkerLoop();

        std::string BuildSystemPrompt(Player* owner, Player* bot) const;
        static std::string BuildPayload(MercenaryChatRequest const& request);
        static std::string BuildUrl(MercenaryChatRequest const& request);
        static bool Perform(MercenaryChatRequest const& request, std::string& answer, std::string& error);
        static std::string ExtractAnswer(uint8 provider, std::string const& body, std::string& error);

        // Identifiants par employeur.
        std::map<ObjectGuid, MercenaryCredential> m_credentials;
        mutable std::mutex m_credentialLock;

        // Historique de conversation par mercenaire.
        std::map<ObjectGuid, std::vector<std::pair<std::string, std::string> > > m_history;

        // Dernier envoi par employeur, pour l anti-spam.
        std::map<ObjectGuid, uint32> m_lastTalk;

        std::deque<MercenaryChatRequest> m_pending;
        std::mutex m_pendingLock;
        std::condition_variable m_pendingSignal;

        std::deque<MercenaryChatReply> m_replies;
        std::mutex m_replyLock;

        std::thread m_worker;
        std::atomic<bool> m_running;

        bool   m_enabled;
        uint32 m_cooldown;          // secondes entre deux repliques d un meme joueur
        uint32 m_timeout;           // secondes avant abandon de l appel
        uint32 m_maxTokens;
        uint32 m_historyDepth;      // nombre d echanges conserves
        uint32 m_maxPending;        // profondeur maximale de la file d envoi
};

#define sMercenaryChatMgr MercenaryChatMgr::instance()

#endif // __MERCENARYCHAT_H__
