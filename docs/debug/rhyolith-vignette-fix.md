# Lord Rhyolith et les vignettes — le correctif

18/09/2026. L'analyse préalable, avec les preuves, est dans
[`rhyolith-root-cause.md`](rhyolith-root-cause.md) ; ce document ne redit que les conclusions.

---

# Root Cause

## Rhyolith — trois mécanismes de blocage indépendants, plus deux écarts de données

Le combat ne « bloquait pas à 25 % ». Il pouvait se figer à **n'importe quel** pourcentage,
par trois chemins distincts, et ce qui arrivait à 25 % était un quatrième problème.

### 1. `events.Reset()` à la première gorgée de magma *(le plus fréquent)*

```cpp
if (me->GetDistance2d(controller) <= 2.0f)
{
    me->CastSpell(me, SPELL_DRINK_MAGMA);
    events.Reset();                                   // <-- vide TOUTE la file
    events.ScheduleEvent(EVENT_CHECK_MOVE, 8000);
    return;
}
```

Dès que le colosse rattrapait son contrôleur de mouvement — c'est-à-dire dès que le raid
cessait de le diriger quelques secondes — la file d'événements était **entièrement vidée**.
Elle porte le rééquilibrage de la vie, les piétinements, les volcans, les fragments et,
dans `EventMap`, la **phase courante**. Seul `EVENT_CHECK_MOVE` était reprogrammé.

À partir de cet instant, plus rien ne faisait descendre la vie du colosse. Il restait
debout, invulnérable (le clamp `damage = GetHealth() - 1` tant que la forme finale n'est
pas prise), sans butin — quel que soit le pourcentage atteint.

### 2. Un pied tué gelait le combat, en silence

La référence Cataclysm interdit explicitement la mort d'un pied :

```cpp
if (damage >= me->GetHealth())
    damage = me->GetHealth() - 1;
```

**Nos deux IA de pied n'avaient pas ce clamp.** Et le rééquilibrage, quand un pied
manquait, faisait `break` — donc sortait du `switch` **avant** la ligne qui le
reprogramme. L'événement ne revenait jamais.

Un pied mort = même résultat qu'au point 1. C'est mot pour mot le rapport du joueur cité
par le commit `d13648e2`, jamais corrigé depuis.

### 3. `Creature::UpdateEntry` rendait toute sa vie au colosse *(défaut du core)*

```cpp
    if (updateLevel)
        SelectLevel();
    else
        UpdateLevelDependantStats();   // se termine par SetHealth(max)
```

L'amont TrinityCore, **au même endroit et au même commentaire près**, relève la vie avant
et la repose après. Notre fork avait perdu ces lignes. Or c'est tout le contrat de
`UpdateEntry(entry, data, updateLevel = false)` : « change le gabarit, garde l'état ».

Chacun des trois changements de carcasse remplissait donc la barre. En phase 1 le
rééquilibrage la redescendait en cinq secondes (d'où le clignotement observé) ; au
**troisième**, le rééquilibrage s'arrête — et la phase 2 démarrait barre pleine.

### 4. La forme finale était un autre boss *(données)*

| | 52558 / 54192 / 54199 | 53772 (forme finale) |
|---|---|---|
| `HealthModifier` | 152.517 | **234.624** — ×1,54 |
| `lootid` | 52558 → **23 lignes** | 53772 → **4 lignes** |

Vestiges de l'architecture précédente, où 53772 était **invoqué comme boss autonome**.
Combinés au point 3 : à 25 %, la barre repartait à 100 % d'une réserve une fois et demie
plus grosse que tout le combat précédent, et le boss lâchait un moignon de butin.
**C'est cela, le « blocage vers 25 % ».**

### 5. Le corps redevenait attaquable en pleine phase 1 *(données)*

52558 porte `UNIT_FLAG2_SELECTION_DISABLED` (`0x4000000`) : seuls les pieds sont
frappables. **54192 et 54199 l'avaient perdu.** Dès 75 %, les dégâts directs
court-circuitaient la mécanique des pieds et enchaînaient les transformations restantes —
d'où « il change d'apparence plusieurs fois ».

### 6. Les vitesses aussi étaient rechargées

`UpdateEntry` appelle `InitEntry`, qui réapplique `speed_walk`/`speed_run` du nouveau
gabarit. Les carcasses de phase 1 portent `speed_run = 1.14` contre le pas traînant
(`SetSpeed(MOVE_RUN, 0.3f)`) voulu par le script : dès 75 %, le colosse rattrapait son
contrôleur d'un bond et la direction au pied perdait tout sens — ce qui déclenchait le
point 1 en boucle.

## Vignettes — une seule cause, totale

```cpp
DEFINE_SERVER_OPCODE_HANDLER(SMSG_VIGNETTE_UPDATE, STATUS_UNHANDLED, CONNECTION_TYPE_INSTANCE);
```

```cpp
// WorldSession::SendPacket
if (!forced && handler->Status == STATUS_UNHANDLED)
{
    TC_LOG_ERROR("network.opcode", "Prevented sending disabled opcode %s to %s", ...);
    return;                                           // <-- le paquet meurt ici
}
```

**Tout paquet de vignette était refusé au dernier maillon.** Le gestionnaire tournait,
créait les entités, sérialisait — pour rien. Les opcodes serveur réellement implémentés de
ce core sont déclarés `STATUS_NEVER` ; `SMSG_VIGNETTE_UPDATE` était resté dans le lot des
237 encore marqués `STATUS_UNHANDLED`.

Le reste du portage du 17/09 était sain : `Vignette.db2` présent, `sVignetteStore` chargé,
714 gabarits porteurs, 213 spawns sur la carte 1220, contenu du paquet complet pour 7.3.5.

Deux défauts de cycle de vie se seraient révélés dès le déblocage :

- **un rare tué gardait son marqueur** : `CanSeeVignette()` refuse bien une unité morte,
  mais n'était consultée qu'à la *création* ; `OnWorldObjectDisappear` n'arrive qu'à la
  sortie du champ de vision, et une dépouille reste visible longtemps ;
- **les marqueurs survivaient à un changement de carte** : `Map::AddPlayerToMap` vide
  `m_clientGUIDs` d'un bloc sans prévenir le gestionnaire, et comme les retraits ne
  passent que par ce jeu de visibilité, toutes les vignettes de la carte précédente
  restaient orphelines — définitivement, jusqu'à la reconnexion.

---

# Why Previous Fixes Failed

| Commit | Ce qu'il a corrigé | Pourquoi ça ne suffisait pas |
|---|---|---|
| `4ccd43d2` — « les pieds n'existaient pas » | Vrai diagnostic : les pieds n'étaient jamais invoqués malgré `vehicle_template_accessory`. Le script les invoque désormais. | Les pieds existent — et **meurent**. Le correctif a rendu le combat jouable jusqu'au premier pied tué, puis l'a refigé par le même symptôme. |
| `d13648e2` — portage de la mécanique Cataclysm | La bonne architecture : vie qui descend du colosse vers les pieds, trois `UpdateEntry`, bascule de phase. Fidèle à la référence. | Le portage **suppose deux invariants que ni le core ni la base ne tenaient** : `UpdateEntry` conserve la vie (faux ici), et un pied ne meurt jamais (clamp non repris). Il a aussi laissé en place l'ancien système de santé partagée, qui écrasait son égalisation, et n'a pas touché `events.Reset()` ni les données de 53772. |
| `e6bc58a3` + `2a36ad02` — vignettes | Structure DB2, magasin, requête de hotfix, paquet, gestionnaire par joueur : tout est là et correct. | Le **dernier maillon** manquait : l'opcode restait déclaré désactivé, et `SendPacket` refuse par construction. Rien n'a jamais atteint le client. |

Le fil commun : chaque correctif traitait la couche qu'il regardait, alors que la
défaillance était **sous** elle — dans le core (`UpdateEntry`, `SendPacket`) et dans les
données (53772, 54192, 54199).

---

# Rhyolith State Machine

Les phases sont désormais portées par le mécanisme natif de `EventMap` (`SetPhase`,
`IsInPhase`, `ScheduleEvent(id, temps, groupe, phase)`) et non plus par un `uint8 phase`
maison. Un événement étiqueté phase 1 qui arrive à échéance en phase 2 est **écarté
d'office** : la bascule est atomique sans avoir à vider la file.

```
                    ┌──────────────┐
                    │ NOT_STARTED  │  entrée 52558, REACT_PASSIVE, vie pleine,
                    │              │  corps intargetable, pieds absents
                    └──────┬───────┘
                           │ EnterCombat
                           ▼
       ┌───────────────────────────────────────┐
       │ PHASE_ONE  (events.SetPhase(1))       │
       │  · pieds 52577/53087 invoqués,        │
       │    assis sur les sièges 0 et 1        │
       │  · contrôleur 52659 invoqué, suivi    │
       │  · toutes les 5 s : moyenne des pieds,│
       │    égalisation, DealDamage au colosse │
       └───┬───────────┬───────────┬───────────┘
           │ 75 %      │ 50 %      │ 25 %
           ▼           ▼           ▼
        54192       54199       53772 ─────► TRANSITION (atomique, StartPhaseTwo)
      (cosmétique, vie et pourcentage conservés)   │
                                                   ▼
                    ┌──────────────────────────────────────┐
                    │ PHASE_TWO  (events.SetPhase(2))      │
                    │  · pieds + contrôleur + invocations  │
                    │    disparus, cadres d'unité retirés  │
                    │  · corps ciblable et attaquable      │
                    │  · effondré 3 s, puis relevé, puis   │
                    │    agressif à 6,6 s                  │
                    │  · Immolation, Piétinement           │
                    └──────────────┬───────────────────────┘
                                   │ vie atteint 0
                                   ▼
                            ┌─────────────┐
                            │    DEAD     │ BossAI::JustDied → état DONE,
                            │             │ cadre retiré, butin de 52558
                            └─────────────┘
```

Pour chaque état :

| | NOT_STARTED | PHASE_ONE | TRANSITION | PHASE_TWO | DEAD |
|---|---|---|---|---|---|
| Ciblable | non (`SELECTION_DISABLED`) | non | devient oui | **oui** | dépouille |
| Attaquable | non | non | devient oui | **oui** | — |
| État de réaction | `PASSIVE` | `PASSIVE` | `PASSIVE` | `PASSIVE` → `AGGRESSIVE` à 6,6 s | — |
| Mouvement | aucun | `MoveFollow(contrôleur)`, pas traînant (0,3) | `MoveIdle` | `MoveChase`, course du gabarit 53772 | — |
| Vie | pleine | descend, alignée sur les pieds | **conservée** au passage | descend normalement | 0 |
| Peut mourir | non | non (`damage = GetHealth() - 1`) | non | **oui** | — |
| Pieds | absents | vivants, jamais tuables | disparaissent | absents | absents |
| Armure d'obsidienne | — | 80 charges sur chaque pied | part avec les pieds | absente | — |
| Butin | — | — | — | — | **table de 52558** |
| État de rencontre | `NOT_STARTED` | `IN_PROGRESS` | `IN_PROGRESS` | `IN_PROGRESS` | `DONE` |

**Sorties exceptionnelles**

| Événement | Traitement |
|---|---|
| `RESET` / `EVADE` / `WIPE` | `EnterEvadeMode` retire la barre de direction et l'armure en fusion, puis `BossAI::EnterEvadeMode` → `_Reset()` (invocations détruites, état `NOT_STARTED`) → `Reset()` : `SetPhase(PHASE_ONE)`, retour à l'entrée 52558 — donc aux drapeaux et vitesses du gabarit —, kit d'animation remis à zéro, vie pleine, `_transformationCount = 0`, GUID des pieds et du contrôleur effacés. |
| Pied manquant ou mort | Ne peut plus arriver par les dégâts. Si cela se produit malgré tout, le rééquilibrage part en `EnterEvadeMode(EVADE_REASON_OTHER)` au lieu de se taire. |
| `PLAYER_DEATH` | Aucun effet particulier : le combat continue tant que la liste de menace n'est pas vide. |
| `INSTANCE_RESET` | Aucun état statique global n'est conservé : tout l'état vit dans l'IA de la créature et dans `InstanceScript`. |

---

# Vignette Architecture

Ce que fait réellement le serveur en 7.3.5 :

1. **Les données** vivent dans `Vignette.db2` côté serveur **et côté client**. Le serveur
   n'envoie que l'identifiant ; le client y lit lui-même le nom, l'icône (l'atlas) et les
   drapeaux `onMinimap` / `onWorldMap`. Il n'y a donc rien à « pousser » de plus.
2. **Le rattachement** se fait par `creature_template.VignetteID` (714 gabarits peuplés).
3. **Un gestionnaire par joueur** (`Vignette::Manager`, membre de `Player`) tient le jeu de
   marqueurs de ce joueur. Il est alimenté par `OnWorldObjectAppear` /
   `OnWorldObjectDisappear`, appelés depuis `Player::UpdateVisibilityOf` : **le jeu de
   vignettes est le miroir du jeu de visibilité.**
4. **Chaque GUID de vignette** est fabriqué avec `HighGuid::Vignette` et un bas GUID tiré
   de la carte : `ObjectGuid::Create<HighGuid::Vignette>(map, vignetteID, lowGuid)`. Deux
   rares distincts ne peuvent donc pas partager un identifiant.
5. **L'envoi** est groupé : `Player::Update` appelle `Manager::Update()`, qui pousse en un
   seul `SMSG_VIGNETTE_UPDATE` les trois listes *ajoutés* / *mis à jour* / *retirés*. Côté
   client, cela déclenche `VIGNETTE_MINIMAP_UPDATED`, que lisent `C_VignetteInfo.GetVignetteInfo()`
   et, par-dessus, les add-ons du genre RareScanner. **Rien dans le correctif ne connaît
   RareScanner** : c'est le système générique qui est réparé.
6. **Le cycle de vie** est désormais réévalué à chaque tour : une vignette n'existe que
   tant que sa source est résoluble sur la carte du joueur *et* qu'elle satisfait
   `CanSeeVignette` (vivante, condition de joueur remplie). C'est ce même test qui purge
   les marqueurs d'un rare qu'on vient de tuer **et** ceux de la carte précédente après un
   changement de carte — le jeu de marqueurs ne peut plus diverger du monde.

Le correctif est donc générique par construction : tout nouveau rare marche dès que son
gabarit porte un `VignetteID`, sans une ligne de code de plus.

---

# Files Changed

| Fichier | Nature |
|---|---|
| `src/server/game/Entities/Creature/Creature.cpp` | core — `UpdateEntry` conserve la vie |
| `src/server/game/Server/Protocol/Opcodes.cpp` | core — `SMSG_VIGNETTE_UPDATE` cesse d'être refusé |
| `src/server/game/Vignette/VignetteMgr.cpp` | core — cycle de vie des marqueurs |
| `src/server/game/Vignette/VignetteMgr.h` | core — déclaration de `ForgetVignette` |
| `src/server/scripts/Kalimdor/Firelands/boss_lord_rhyolith.cpp` | script du combat |
| `sql/sylvania/rhyolith_carcasses.sql` (+ `_ROLLBACK`) | migration de données |
| `docs/debug/rhyolith-root-cause.md`, `docs/debug/rhyolith-vignette-fix.md` | documentation |

---

# SQL Changes

`sql/sylvania/rhyolith_carcasses.sql` — appliqué le 18/09/2026, sauvegarde préalable dans
`/home/ubuntu/db-backups/rhyolith-carcasses-*.sql`, annulation par `_ROLLBACK.sql`.

```sql
-- 1. Une seule réserve de vie pour les quatre carcasses
UPDATE creature_template SET HealthModifier = 152.517 WHERE entry = 53772;

-- 2. Un seul butin : celui de Rhyolith, quelle que soit la carcasse où il meurt
UPDATE creature_template SET lootid = 52558 WHERE entry IN (53772, 54192, 54199);

-- 3. Corps intargetable pendant TOUTE la phase 1 (UNIT_FLAG2_SELECTION_DISABLED)
UPDATE creature_template SET unit_flags2 = unit_flags2 | 0x4000000 WHERE entry IN (54192, 54199);
```

Aucune ligne n'est supprimée : les quatre entrées de `creature_loot_template` de 53772
deviennent simplement non référencées.

---

# C++ Changes

### `Creature::UpdateEntry` — le correctif générique

```diff
     if (updateLevel)
         SelectLevel();
-    else
-        UpdateLevelDependantStats(); // We still re-initialize level dependant stats on entry update
+    else
+    {
+        uint32 previousHealth = IsGuardian() ? 0 : GetHealth();
+        UpdateLevelDependantStats(); // We still re-initialize level dependant stats on entry update
+        if (previousHealth > 0)
+            SetHealth(previousHealth);
+    }
```

Aligné sur l'amont TrinityCore. **Dans tout le core, seuls deux appels passent
`updateLevel = false`** (les deux dans Rhyolith) : la portée du changement est donc nulle
ailleurs, tout en rétablissant le contrat correct pour l'avenir. Les gardiens sont laissés
de côté, leur vie dérivant de celle de leur maître.

### `Opcodes.cpp`

```diff
-DEFINE_SERVER_OPCODE_HANDLER(SMSG_VIGNETTE_UPDATE, STATUS_UNHANDLED, CONNECTION_TYPE_INSTANCE);
+DEFINE_SERVER_OPCODE_HANDLER(SMSG_VIGNETTE_UPDATE, STATUS_NEVER,     CONNECTION_TYPE_INSTANCE);
```

`STATUS_NEVER` est la déclaration des opcodes serveur implémentés de ce core
(`SMSG_ATTACK_START`, `SMSG_SPELL_GO`, `SMSG_CHAT`…).

### `VignetteMgr`

- `Manager::Update()` réévalue l'éligibilité de chaque marqueur au lieu de ne mettre à jour
  que sa position : la source doit être résoluble sur la carte du joueur **et** satisfaire
  `CanSeeVignette`. Couvre d'un seul test la mort du rare, sa disparition et le changement
  de carte. Les marqueurs de type `SourceScript` sont exclus : ils n'ont pas de source à
  suivre.
- `ForgetVignette(guid)`, mutualisée par les trois chemins de retrait : annule un ajout
  encore en attente au lieu d'envoyer au client le retrait d'un identifiant qu'il n'a
  jamais reçu.

Coût : le test remplace l'appel `ObjectAccessor::GetCreature` déjà fait à chaque tour pour
la position — l'ordre de grandeur est inchangé.

### `boss_lord_rhyolith.cpp`

| Correctif | Effet |
|---|---|
| Phases natives de `EventMap` (`PHASE_ONE` / `PHASE_TWO`), `uint8 phase` supprimé | La bascule devient atomique : un événement de phase 1 arrivé après la bascule est écarté d'office, y compris celui que la pile d'appel est en train d'exécuter. |
| `events.Reset()` → `events.Repeat(8000)` à la gorgée de magma | La file n'est plus vidée : la vie continue de descendre. |
| Clamp `damage = GetHealth() - 1` dans le `DamageTaken` des **deux** pieds | Un pied ne peut plus mourir. Le garde-fou `IsAlive()` reste **avant** : sur un pied déjà mort, la soustraction repasserait par le haut. |
| Ancien système `DATA_RHYOLITH_HEALTH_SHARED` retiré des pieds | Une seule source de vérité. L'égalisation portée depuis l'amont prend enfin effet — elle était écrasée le même tour par le `SetHealth` des pieds. |
| `break` → `EnterEvadeMode(EVADE_REASON_OTHER)` sur pied manquant | Plus de gel silencieux. |
| `events.Repeat()` sur les événements qui se reprogramment | Conserve leur étiquette de phase (`_lastEvent` la porte). |
| Vitesses reposées après les transformations de phase 1 | `InitEntry` les rechargeait depuis le gabarit ; la forme finale, elle, garde les siennes. |
| `SetAIAnimKitId(1498)` à la bascule, `0` au relèvement et au `Reset` | `EVENT_STAND_UP` ne relevait rien. |
| `RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_SELECTION_DISABLED)` | Le bon champ : c'est `FLAGS_2` qui porte l'intargetabilité, pas `FLAGS`. |
| `GetVehicleKit()` gardé dans `JustReachedHome` | Déréférencement non gardé. |
| `controllerGUID.Clear()`, `MoveIdle()` dans la bascule | Aucun reliquat de phase 1. |

Aucun `sleep`, aucune boucle d'attente, aucun timer destiné à masquer un symptôme, aucune
téléportation, aucun `SetHealth` de contournement (les deux `SetHealth` restants sont
l'égalisation des pieds, reprise telle quelle de l'amont, et la remise à plein au `Reset`),
aucun test sur un personnage ou un add-on particulier.

---

# Tests

## Ce qui a été vérifié

- **Compilation** : voir la section de vérification ci-dessous.
- **Migration SQL** : appliquée, valeurs relues (`HealthModifier` 152.517 partout,
  `lootid` 52558 sur les quatre entrées, `unit_flags2` 67110912 sur 54192 et 54199).
- **Analyse statique du chemin de code** : le trajet complet 100 % → 75 % → 50 % → 25 % →
  phase 2 → mort a été retracé à la main avec les valeurs réelles de la base.

## Ce qui reste à jouer en jeu

### Rhyolith

| Réf. | Procédure | Attendu |
|---|---|---|
| RHYO-01 | Entrer aux Terres de feu, engager Rhyolith, frapper le **pied gauche** | Le colosse pivote ; la barre de direction du joueur bouge ; le corps reste **non sélectionnable** |
| RHYO-02 | Frapper le **pied droit** | Pivotement inverse |
| RHYO-03 | Cesser de le diriger jusqu'à ce qu'il rejoigne son point d'arrêt et boive du magma | La vie **continue de descendre** après la gorgée (c'était le blocage n° 1) |
| RHYO-04 | Descendre à 75 %, puis 50 % | Changement d'apparence **sans rebond de la barre** ; le corps reste non sélectionnable ; le pas reste traînant |
| RHYO-05 | Concentrer tous les dégâts sur **un seul pied** | Le pied descend jusqu'à 1 point de vie mais **ne meurt pas** ; le combat continue |
| RHYO-06 | Atteindre 25 % | Les pieds disparaissent, l'armure éclate, le colosse s'effondre puis se relève ; **la barre reste à 25 %**, elle ne se remplit pas |
| RHYO-07 | Pendant la phase 2 | Le colosse est directement **ciblable et attaquable**, redevient agressif ~6,6 s après la bascule, et **se déplace** pour chasser |
| RHYO-08 | Le tuer | Il meurt, cadre d'unité retiré, rencontre en `DONE` |
| RHYO-09 | Ouvrir le butin | **Table de 52558** : jetons de palier (71775–71787), épiques (70912–71012), Essence du Vol draconique, Cendres embrasées, Élémentium vivant |
| RHYO-10 | Wipe en phase 1, puis ré-engager | Retour à l'entrée 52558, apparence et vitesse d'origine, vie pleine, corps non sélectionnable, pieds réinvoqués |
| RHYO-11 | Wipe **pendant** la bascule (entre 25 % et le relèvement) | Même remise à zéro ; aucun colosse assis, ciblable ou invulnérable ne subsiste |
| RHYO-12 | Wipe en phase 2 | Même remise à zéro. Penser à `.instance unbind all` avant de retester |
| RHYO-13 | Sortir de l'instance puis revenir | État cohérent ; aucune interaction ne « change » d'un passage à l'autre |

### Vignettes

| Réf. | Procédure | Attendu |
|---|---|---|
| VIG-01 | Aller sur les Îles Brisées (carte 1220, 213 spawns porteurs) — p. ex. **Karthax** (111731) vers -1641 / 6884 | — |
| VIG-02 | S'en approcher jusqu'à le voir | Un marqueur apparaît sur la minicarte ; `/dump C_VignetteInfo.GetVignettes()` renvoie une entrée |
| VIG-03 | Vérifier le nom et l'icône | Correspondent au rare (le client les lit dans son propre `Vignette.db2`) |
| VIG-04 | **Le tuer** | Le marqueur disparaît **sans attendre de s'éloigner** |
| VIG-05 | S'approcher de deux rares différents | Deux marqueurs distincts, identifiants distincts |
| VIG-06 | Prendre un portail vers une autre carte | Aucun marqueur fantôme de la carte précédente |
| VIG-07 | Se déconnecter / reconnecter près d'un rare | Le marqueur revient |
| VIG-08 | Activer **RareScanner** | L'add-on réagit sans aucune adaptation serveur |
| VIG-09 | `grep "Prevented sending disabled opcode SMSG_VIGNETTE_UPDATE" dc-world.log` | **Aucune ligne** |

### Non-régression

| Réf. | Procédure | Attendu |
|---|---|---|
| REG-01 | Vol à Silithus | Inchangé. Les correctifs de vol (`737d47e8`, `801b428c`) ne sont pas touchés : aucun fichier de transport, de véhicule-passager ni de taxi n'a été modifié. |
| REG-02 | Autres transformations en combat | Seuls deux appels dans tout le core passent `updateLevel = false`, tous deux dans Rhyolith. Les changements d'entrée qui passent par le défaut (`true`) appellent `SelectLevel()` et sont inchangés. |
| REG-03 | Volcans de Rhyolith | Ils utilisent `UpdateEntry` avec le `updateLevel` par défaut : comportement inchangé. |

---

# Remaining Limitations

**Rien de ce qui suit n'a été joué en jeu.** Le serveur compile, la migration est
appliquée, le chemin de code a été retracé sur les valeurs réelles — mais **aucun des
tests ci-dessus n'a été exécuté**. Tant que RHYO-01 à RHYO-13 et VIG-01 à VIG-09 n'ont pas
été passés, le correctif est *argumenté*, pas *vérifié*.

Points explicitement non traités, et pourquoi :

1. **La direction se fait au nombre de coups, pas aux dégâts.** La référence Cataclysm
   compte les **dégâts par seconde** encaissés par chaque pied (seuils 3 000 / 9 000) ;
   notre script compte les **coups** sur trois secondes glissantes. Le testeur rapporte que
   la direction fonctionne : je n'y ai pas touché. C'est néanmoins un écart au
   comportement officiel — un raid de mages fait tourner le colosse comme un raid de
   voleurs, alors que ce ne devrait pas être le cas.
2. **Les pieds commencent le combat à 100 %**, ce qui est correct, mais leur réserve
   (`HealthModifier` 79.063, soit 0,518 × celle du colosse) n'a pas été recoupée avec une
   source officielle. Elle n'a pas d'incidence sur la progression, qui se fait en
   pourcentage.
3. **`npc_lord_rhyolith_rhyolith`, le script attaché à 53772, est désormais inerte** : la
   transformation passe par `UpdateEntry(..., updateScript = false)`, donc l'IA du colosse
   ne change jamais. Je l'ai laissé en place — le modifier n'apportait rien et rien ne
   l'invoque — mais c'est un piège pour la prochaine lecture, et son `EnterEvadeMode` fait
   `DespawnOrUnsummon()`.
4. **Le mode héroïque n'a pas été examiné.** `EVENT_SUPERHEATED` s'y déclenche à 5 minutes
   au lieu de 6, et la référence y ajoute une mécanique (`UNLEASHED_FLAME`) que nous
   n'avons pas.
5. **Le haut fait « Pas un dresseur ambidextre »** (`bAchieve`) n'a pas été vérifié ; la
   référence passe par un état de monde (5931) que nous n'utilisons pas.
6. **Vignettes : pas de filtrage par quête de suivi.** `VignetteEntry` porte bien
   `VisibleTrackingQuestID`, mais le core n'a pas le support de bits de quête nécessaire :
   un trésor déjà ramassé peut donc réapparaître. Limitation déjà connue du portage.
7. **Vignettes : seules les créatures en portent.** `gameobject_template` n'a pas de
   colonne `VignetteID` — aucun marqueur sur les coffres.
8. **Le format binaire de `SMSG_VIGNETTE_UPDATE` n'a jamais pu être validé** en conditions
   réelles, puisque le paquet n'était jamais émis. Il vient du portage amont et paraît
   conforme à 7.3.5, mais VIG-02 est le **premier** test à passer : un paquet mal formé
   fait tomber le client. À tester sur un seul personnage avant d'ouvrir au royaume.
