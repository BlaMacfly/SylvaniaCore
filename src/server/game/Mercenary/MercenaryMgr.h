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

// SylvaniaCore - Module "Mercenaires"
//
// Le Portail d Invocation de Mercenaire vend au joueur la compagnie temporaire
// d un playerbot. Le contrat est volontairement fragile : il ne survit ni au
// depart du groupe, ni au renvoi du mercenaire, ni a la deconnexion du client.
// A chaque rupture, le bot se deconnecte et l invocation suivante se repaye.

#ifndef __MERCENARYMGR_H__
#define __MERCENARYMGR_H__

#include "Common.h"
#include "ObjectGuid.h"
#include "Position.h"
#include <vector>

class Creature;
class Group;
class Player;

// Un groupe de World of Warcraft compte cinq places, le maitre inclus : il ne
// peut donc jamais y avoir plus de quatre mercenaires sans convertir le groupe
// en raid, ce qui interdirait les donjons.
#define MERCENARY_GROUP_SIZE          5
#define MERCENARY_HARD_CAP            (MERCENARY_GROUP_SIZE - 1)
#define MERCENARY_SUMMON_TIMEOUT      60      // secondes avant abandon + remboursement
#define MERCENARY_COPPER_PER_GOLD     10000

enum MercenaryStage
{
    MERC_STAGE_SUMMONING = 0,   // connexion et mise a niveau en cours
    MERC_STAGE_ACTIVE    = 1    // dans le groupe, sous contrat
};

enum MercenaryResult
{
    MERC_OK = 0,
    MERC_ERR_DISABLED,
    MERC_ERR_BAD_PLACE,
    MERC_ERR_IN_COMBAT,
    MERC_ERR_LEVEL,
    MERC_ERR_NOT_LEADER,
    MERC_ERR_GROUP_FULL,
    MERC_ERR_MAX_REACHED,
    MERC_ERR_NO_MONEY,
    MERC_ERR_NO_BOT,
    MERC_ERR_PENDING
};

struct MercenaryContract
{
    MercenaryContract() : accountId(0), role(0), stage(MERC_STAGE_SUMMONING), waitSeconds(0),
        pendingRelease(false), summonPending(false), hasPortal(false), portalMap(0) { }

    uint32     accountId;       // compte bot reserve
    ObjectGuid ownerGuid;       // joueur qui a paye
    ObjectGuid botGuid;         // renseigne une fois le mercenaire en jeu
    uint8      role;            // ROLE_TANK, ROLE_HEALER ou ROLE_DAMAGE
    uint8      stage;
    uint32     waitSeconds;

    // Contrat rompu par un hook de groupe du core, mais dont la liberation est
    // differee au prochain Update() : voir MercenaryMgr::OnPlayerLeftGroup().
    bool       pendingRelease;

    // Le mercenaire est entre dans le groupe mais n a pas encore ete rappele
    // aupres de son employeur : l ordre part au tick suivant, quand l IA de
    // groupe aura reconnu son maitre.
    bool       summonPending;

    // Le portail d ou part l invocation : le mercenaire doit en sortir, pas
    // se materialiser aux pieds de son employeur reste en retrait.
    bool       hasPortal;
    uint32     portalMap;
    Position   portalPos;
};

class TC_GAME_API MercenaryMgr
{
    public:
        static MercenaryMgr* instance();

        void LoadConfig();

        bool   IsEnabled() const     { return m_enabled; }
        uint32 GetCost() const       { return m_cost; }                            // en cuivre
        uint32 GetCostGold() const   { return m_cost / MERCENARY_COPPER_PER_GOLD; }
        uint32 GetMaxPerPlayer() const { return m_maxPerPlayer; }
        uint32 GetMinLevel() const   { return m_minLevel; }

        // Nombre de contrats en cours pour ce joueur, invocations comprises.
        uint32 CountContracts(ObjectGuid ownerGuid) const;

        // Verifie, encaisse et lance l invocation. Le prelevement n a lieu que
        // si un mercenaire du role demande a effectivement ete reserve.
        // "portal" est la structure invoquante : le mercenaire en sortira.
        // « freeOfCharge » saute la verification et le prelevement : il sert
        // aux recrutements que le jeu offre, comme l escorte fournie a
        // l entree d un scenario. Le contrat reste identique par ailleurs,
        // rupture au premier depart du groupe comprise.
        MercenaryResult Summon(Player* owner, uint8 role, Creature* portal = nullptr,
                               bool freeOfCharge = false);

        void Update(uint32 diff);

        bool IsMercenary(ObjectGuid botGuid) const;
        bool IsAccountHired(uint32 accountId) const;

        // Ce mercenaire sert-il precisement cet employeur ?
        bool IsMercenaryOf(ObjectGuid botGuid, ObjectGuid ownerGuid) const;

        // Choisit le mercenaire qui repondra a une replique adressee au groupe
        // ou lancee a voix haute : celui dont le nom est cite, a defaut le
        // premier sous contrat. Un seul repond - chaque replique est facturee
        // au joueur par son fournisseur.
        Player* PickMercenaryFor(Player* owner, std::string const& message) const;

        // Variante pour le canal de groupe : n importe quel compagnon peut
        // interpeller un mercenaire de la troupe, quel qu en soit l employeur.
        // Renvoie le mercenaire et, par « outOwner », celui dont la cle paiera.
        Player* PickMercenaryInGroup(Player* speaker, std::string const& message, Player*& outOwner) const;

        // Rupture du contrat. Le mercenaire quitte le groupe et se deconnecte ;
        // aucune de ces routes ne rembourse, c est la regle du systeme.
        void DismissOne(ObjectGuid botGuid);
        void DismissAll(ObjectGuid ownerGuid);

        // Hooks du module (GroupScript / PlayerScript).
        void OnPlayerLeftGroup(ObjectGuid guid);
        void OnGroupDisband(Group* group);
        void OnPlayerLogout(Player* player);

        static char const* GetRoleName(uint8 role);
        static char const* GetErrorText(MercenaryResult result);

    private:
        MercenaryMgr();

        bool FindCandidate(Player* owner, uint8 role, uint32& accountId, uint64& charGuid, bool& alreadyOnline) const;
        void ReleaseBot(MercenaryContract const& contract);
        void Refund(ObjectGuid ownerGuid, char const* reason);

        static bool  IsMercenaryCapableClass(uint8 playerClass);
        static int32 FindSpecIndexForRole(uint8 playerClass, uint8 role);

        std::vector<MercenaryContract> m_contracts;

        bool   m_enabled;
        uint32 m_cost;
        uint32 m_maxPerPlayer;
        uint32 m_minLevel;
        uint32 m_updateTimer;

        // Garde-fou de reentrance : congedier un mercenaire le retire du groupe,
        // ce qui rappelle nos propres hooks GroupScript.
        bool   m_releasing;
};

#define sMercenaryMgr MercenaryMgr::instance()

#endif // __MERCENARYMGR_H__
