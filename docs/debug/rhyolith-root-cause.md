# Lord Rhyolith et les vignettes — analyse de cause racine

Audit du 18/09/2026, avant toute modification.
Core : SylvaniaCore (fork de `slash-design/DestinyCore`), branche `sylvaniacore`, client Legion 7.3.5.

---

## 1. Architecture constatée

### 1.1 Le core

| Élément | Constat |
|---|---|
| Core parent | `slash-design/DestinyCore` (remote `upstream`), lui-même dérivé de TrinityCore |
| Branche | `sylvaniacore`, HEAD `2a36ad02` |
| Système de scripts | `ScriptMgr` classique TrinityCore : `CreatureScript` + `CreatureAI`, `BossAI`/`InstanceScript` |
| Scripts Firelands | `src/server/scripts/Kalimdor/Firelands/` — un fichier par boss, `instance_firelands.cpp`, `firelands.h` |
| `EventMap` | `src/common/Utilities/EventMap.h` — **supporte les phases** (`SetPhase`, `IsInPhase`, `ScheduleEvent(id, time, group, phase)`) |
| Véhicules | `Vehicle`/`VehicleKit`, accessoires via `vehicle_template_accessory` |
| Vignettes | `src/server/game/Vignette/` (Vignette, VignetteMgr) + `VignettePackets` + `sVignetteStore` |

### 1.2 Le combat, tel qu'il est écrit aujourd'hui

`boss_lord_rhyolith.cpp` (1557 lignes) contient sept scripts : le colosse, une seconde IA pour l'entrée 53772, les deux pieds, le volcan, le cratère, les adds.

Créatures et données :

| Entrée | Nom | `HealthModifier` | `unit_flags2` | `lootid` | `ScriptName` |
|---|---|---|---|---|---|
| 52558 | Lord Rhyolith | **152.517** | `0x4000000 \| 0x1000000 \| 0x800` | 52558 (**23 lignes**) | `boss_lord_rhyolith` |
| 54192 | Lord Rhyolith (abîmé 1) | 152.517 | `0x800` | 0 | *(vide)* |
| 54199 | Lord Rhyolith (abîmé 2) | 152.517 | `0x800` | 0 | *(vide)* |
| 53772 | Lord Rhyolith (phase 2) | **234.624** | `0x1000000 \| 0x800` | 53772 (**4 lignes**) | `npc_lord_rhyolith_rhyolith` |
| 52577 | Left Foot | 79.063 | `0x8000` | 0 | `npc_lord_rhyolith_left_foot` |
| 53087 | Right Foot | 79.063 | `0x8000` | 0 | `npc_lord_rhyolith_right_foot` |

`0x4000000` = `UNIT_FLAG2_SELECTION_DISABLED` (« Cant select, even in GM mode »).
Un seul spawn en base : le guid 1338763 (entrée 52558, carte 720). Les pieds ne sont spawnés nulle part ; ils sont déclarés accessoires du véhicule 1606 (sièges 0 et 1) et, depuis le commit `4ccd43d2`, invoqués par le script si l'installation du véhicule ne les produit pas.

---

## 2. Comportement attendu (référence)

Sources croisées :

1. **`The-Cataclysm-Preservation-Project/TrinityCore`**, `src/server/scripts/Kalimdor/Firelands/boss_lord_rhyolith.cpp` (branche `master`, 1360 lignes) — seul dépôt open source qui tienne réellement ce combat. C'est déjà la référence citée par le commit `d13648e2`.
2. **`TrinityCore/TrinityCore`** master pour le comportement générique du core.
3. Wowhead / warcraft.wiki.gg pour la mécanique observable.

Mécanique officielle :

- **Phase 1** : le corps du colosse est **intargetable**. Tous les dégâts passent par les deux pieds. La différence de dégâts entre pied gauche et pied droit fait tourner le colosse ; on le dirige sur les volcans.
- La vie affichée est **celle du colosse**, tirée vers le bas par la vie des pieds.
- Trois changements de carcasse purement cosmétiques à **75 %, 50 % et 25 %** (54192, 54199, puis 53772), par `UpdateEntry` sur la même créature.
- **Phase 2** à 25 % : l'armure d'obsidienne éclate, les pieds disparaissent, le colosse s'effondre puis se relève, devient directement attaquable et se bat normalement jusqu'à la mort. **La barre continue depuis 25 %, elle ne se remplit pas.**
- Les pieds **ne meurent jamais**.

---

## 3. Écarts constatés, avec les preuves

### R1 — `Creature::UpdateEntry` rend toute sa vie à la créature (défaut du core, générique)

`src/server/game/Entities/Creature/Creature.cpp` :

```cpp
    if (updateLevel)
        SelectLevel();
    else
        UpdateLevelDependantStats(); // We still re-initialize level dependant stats on entry update
```

et `UpdateLevelDependantStats()` se termine par `SetCreateHealth(health); SetMaxHealth(health); SetHealth(health);` — **vie pleine**.

L'amont TrinityCore, au même endroit, au commentaire près :

```cpp
    if (updateLevel)
        SelectLevel();
    else if (!IsGuardian())
    {
        uint32 previousHealth = GetHealth();
        UpdateLevelDependantStats(); // We still re-initialize level dependant stats on entry update
        if (previousHealth > 0)
            SetHealth(previousHealth);
    }
```

Le commentaire identique prouve qu'il s'agit du même code et que **notre fork a perdu la conservation de la vie**. Ce n'est pas propre à Rhyolith : c'est le contrat de `UpdateEntry(entry, data, updateLevel = false)` — « change le gabarit, garde l'état » — et tout le script de référence repose dessus.

Conséquence ici : chacun des trois changements de carcasse **remplit la barre**. En phase 1 l'événement d'équilibrage la redescend en moins de cinq secondes (d'où le clignotement observé), mais au **troisième** changement l'équilibrage s'arrête — et la phase 2 démarre barre pleine.

> Risque de régression : dans tout le core, **seuls deux appels** passent `updateLevel = false`, tous les deux dans Rhyolith. Le correctif ne peut donc rien casser ailleurs, tout en rétablissant le contrat correct pour l'avenir.

### R2 — Les pieds sont tuables, et un pied mort gèle définitivement le combat

Référence, `npc_rhyolith_foot::DamageTaken` :

```cpp
    if (damage >= me->GetHealth())
        damage = me->GetHealth() - 1;   // un pied ne meurt jamais
```

**Nos deux IA de pied n'ont pas ce clamp.** Rien ne borne les dégâts qu'ils encaissent.

Et notre événement d'équilibrage, quand un pied manque :

```cpp
    if (!footLeft || !footRight || !footLeft->IsAlive() || !footRight->IsAlive())
        break;      // <-- sort SANS se reprogrammer
```

`break` quitte le `switch` sans le `events.ScheduleEvent(..., 5000)` qui suit — **l'événement ne revient jamais**. La référence, elle, part en `EnterEvadeMode(EVADE_REASON_OTHER)`.

Donc : un pied meurt → la vie du colosse ne bouge plus jamais → il reste debout, inerte, invulnérable (le clamp `damage = GetHealth() - 1` tant que `_transformationCount < 3`), sans butin. **C'est mot pour mot le rapport du joueur cité dans le commit `d13648e2`** — et ce n'est toujours pas corrigé.

### R3 — L'entrée de phase 2 a une réserve de vie 1,54 × celle de la phase 1

`53772.HealthModifier = 234.624` contre `152.517` pour 52558 / 54192 / 54199. Le rapport vaut **1,5383**.

Cette valeur est un vestige de l'architecture précédente, où 53772 était **invoqué comme un boss autonome** (c'est ce que le commit `d13648e2` a supprimé). Une fois devenue une simple transformation, elle n'a plus de sens : les quatre carcasses doivent partager une seule réserve.

Combiné à **R1**, voilà le « blocage vers 25 % » : au moment précis où la phase 2 commence, la barre repart à 100 % d'une réserve une fois et demie plus grosse que tout le combat qui précède. Rien n'est « bloqué » au sens strict — le boss est devenu une éponge impossible à entamer.

### R4 — Le butin de la forme finale est un moignon

- `52558.lootid = 52558` → **23 lignes** : jetons de palier (71775–71787), épiques (70912–71012), Essence du Vol draconique, Cendres embrasées, Élémentium vivant.
- `53772.lootid = 53772` → **4 lignes**, dont deux en `QuestRequired = 1`, plus l'objet 56001.

Le boss meurt sous l'entrée 53772 : il lâche donc le moignon. Même une phase 2 gagnée ne rendrait pas le bon butin.

### R5 — Les carcasses intermédiaires redeviennent sélectionnables en pleine phase 1

52558 porte `UNIT_FLAG2_SELECTION_DISABLED` (`0x4000000`) : le corps est intargetable, conforme. 53772 ne le porte pas : conforme aussi, la phase 2 doit être attaquable.

Mais **54192 et 54199 ne le portent pas non plus** (`unit_flags2 = 0x800`). Donc dès 75 %, le corps devient sélectionnable et attaquable alors qu'on est encore en phase 1. Les dégâts directs court-circuitent toute la mécanique des pieds et enchaînent les transformations restantes — d'où « il change d'apparence plusieurs fois » et l'arrivée prématurée en phase 2.

Preuve que la référence attend bien ce drapeau sur les formes de phase 1 : son script le **retire explicitement** au moment de la bascule (`me->RemoveFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_UNTARGETABLE_BY_CLIENT)` — bit 26, le même). On ne retire que ce qui est présent.

### R6 — Deux modèles de santé concurrents tournent en même temps

L'ancien système est resté en place sous le portage :

- pied, `DamageTaken` : `pInstance->SetData(DATA_RHYOLITH_HEALTH_SHARED, me->GetHealth() - damage)`
- pied, `UpdateAI`, **à chaque tick** : `me->SetHealth(pInstance->GetData(DATA_RHYOLITH_HEALTH_SHARED))`

Or le portage fait faire l'égalisation au colosse :

```cpp
    footLeft->SetHealth(CalculatePct(footLeft->GetMaxHealth(), targetHealthPct));
    footRight->SetHealth(CalculatePct(footRight->GetMaxHealth(), targetHealthPct));
```

…immédiatement écrasé le même tick par le `SetHealth` des pieds. **L'égalisation portée n'a jamais pris effet.**

Second effet : la valeur partagée est amorcée à `bossMaxHealth / 2` dans `Reset()` **et** dans `EnterCombat()`, alors que la vie maximale d'un pied vaut `79.063 / 152.517 = 0,5184` fois celle du colosse. Les pieds commencent donc le combat à **96,5 %** et non à 100 %.

### R7 — La bascule en phase 2 n'est pas atomique vis-à-vis de la file d'événements

`StartPhaseTwo()` est appelée depuis `DamageTaken`, donc depuis `Unit::DealDamage`, donc **depuis l'intérieur du `case EVENT_BALANCE_FEET_HEALTH`** de la boucle `events.ExecuteEvent()`. Ce `case` se termine par `events.ScheduleEvent(EVENT_BALANCE_FEET_HEALTH, 5000)` — exécuté **après** le `events.Reset()` de `StartPhaseTwo`. Un événement de phase 1 survit donc à la bascule.

La référence n'a pas ce problème : elle étiquette ses événements par phase et `events.SetPhase(PHASE_TWO)` annule d'office tout ce qui appartient à la phase 1. **Notre `EventMap` sait faire exactement cela** et le script ne s'en sert pas : il utilise un `uint8 phase` maison.

### R8 — Le relèvement ne relève rien, et un déréférencement non gardé

- `case EVENT_STAND_UP:` ne fait que programmer `EVENT_TURN_AGGRESSIVE`. La référence y remet le kit d'animation à zéro (`me->SetAIAnimKitId(0)`) après l'avoir posé sur « assis » à la bascule. Notre portage n'a repris ni l'un ni l'autre : rien ne pilote la posture, et si quoi que ce soit assied le colosse, aucun chemin ne le relève. `Unit::SetAIAnimKitId` existe pourtant dans notre core.
- `JustReachedHome()` fait `me->GetVehicleKit()->InstallAllAccessories(false)` **sans vérifier le pointeur**.

---

## 4. Vignettes — cause racine

### V1 — Le paquet est jeté juste avant la socket (bloquant, générique)

`src/server/game/Server/Protocol/Opcodes.cpp` :

```cpp
    DEFINE_SERVER_OPCODE_HANDLER(SMSG_VIGNETTE_UPDATE, STATUS_UNHANDLED, CONNECTION_TYPE_INSTANCE);
```

`WorldSession::SendPacket` :

```cpp
    if (!forced)
    {
        if (handler->Status == STATUS_UNHANDLED)
        {
            TC_LOG_ERROR("network.opcode", "Prevented sending disabled opcode %s to %s", ...);
            return;
        }
    }
```

**Tout paquet de vignette est refusé.** Le gestionnaire tourne, crée les entités, remplit `_addedVignette`, sérialise — et le dernier maillon jette le résultat. Les opcodes serveur réellement implémentés de ce core sont déclarés `STATUS_NEVER` (`SMSG_ATTACK_START`, `SMSG_SPELL_GO`, `SMSG_CHAT`…) ; 237 opcodes sont encore sur `STATUS_UNHANDLED`, et `SMSG_VIGNETTE_UPDATE` est resté dans ce lot.

Le reste du portage est sain : `Vignette.db2` est bien présent (`/home/ubuntu/server/data/dbc/enUS/Vignette.db2`, 70 Ko), `sVignetteStore` est déclaré et chargé (`DB2Stores.cpp:304` et `:828`), 714 gabarits portent un `VignetteID`, et 213 spawns porteurs de vignette existent sur la carte 1220. Le contenu du paquet (GUID source, position, `VignetteID`, `ZoneID`) est complet pour 7.3.5 : le client va chercher lui-même nom, icône et drapeaux `onMinimap`/`onWorldMap` dans son propre `Vignette.db2` à partir du `VignetteID`.

### V2 — Un rare tué garde son marqueur

`CanSeeVignette()` refuse bien une unité morte — mais n'est consultée qu'à la **création**, dans `OnWorldObjectAppear`. `Manager::Update()` ne réévalue jamais rien. Or `OnWorldObjectDisappear` n'est appelée que depuis `Player::UpdateVisibilityOf`, c'est-à-dire quand l'objet **sort du champ de vision** — pas quand il meurt : une dépouille reste visible longtemps. Le marqueur survit donc au rare, jusqu'à ce que le joueur s'éloigne.

### V3 — Les marqueurs survivent à un changement de carte

`Map::AddPlayerToMap` (`src/server/game/Maps/Map.cpp:630`) :

```cpp
    if (initPlayer)
        player->m_clientGUIDs.clear();
```

Le jeu de visibilité est vidé d'un bloc, **sans prévenir le gestionnaire de vignettes**. Et comme `OnWorldObjectDisappear` ne se déclenche que pour les objets encore présents dans `m_clientGUIDs`, toutes les vignettes de la carte précédente deviennent orphelines dans `_vignettes` — définitivement. Le client conserve des marqueurs fantômes, figés sur des coordonnées et un `ZoneID` périmés, que `Manager::Update` ne peut même plus résoudre.

Seule la reconnexion nettoie (le gestionnaire meurt avec l'objet `Player`). C'est l'explication générique des marqueurs « qui ne correspondent pas au rare ».

### V4 — Un retrait peut désigner une vignette jamais envoyée

Une vignette créée puis détruite dans le même tour de `Player::Update` laisse son GUID dans `_removedVignette` alors que le client ne l'a jamais reçue (la boucle `_addedVignette` ne la retrouve plus dans `_vignettes` et passe son tour). Bénin aujourd'hui, mais les correctifs V2/V3 rendent le cas fréquent.

---

## 5. Cause racine retenue

**Réponse à la question D du cahier des charges : H — mélange.** Précisément, et par ordre d'importance :

**Rhyolith** — la machine d'états est correcte dans sa forme mais repose sur deux invariants que ni le core ni la base ne tiennent :

1. *(core, C++)* `UpdateEntry(…, updateLevel = false)` doit **conserver la vie** ; notre fork la remet à plein. → **R1**
2. *(scripts, C++)* **un pied ne doit jamais mourir**, et si l'un manque le combat doit s'évader, pas se figer en silence. → **R2**
3. *(base)* les quatre carcasses doivent **partager une seule réserve de vie** et **un seul butin** ; 53772 a sa propre réserve (×1,54) et un butin moignon. → **R3, R4**
4. *(base)* le corps doit rester **intargetable pendant toute la phase 1** ; 54192 et 54199 ont perdu le drapeau. → **R5**

Les points R6 à R8 sont des séquelles du portage (système de santé doublé, bascule non atomique, relèvement vide) : ils ne suffisent pas à bloquer le combat mais entretiennent les états intermédiaires incohérents observés.

**Vignettes** — une cause unique et bloquante : **`SMSG_VIGNETTE_UPDATE` est déclaré `STATUS_UNHANDLED`, et `WorldSession::SendPacket` refuse par construction tout opcode dans cet état** (V1). Deux défauts de cycle de vie (V2, V3) se révéleront dès que les paquets circuleront.

## 6. Causes alternatives écartées

| Hypothèse | Pourquoi écartée |
|---|---|
| « 25 % est un seuil mal codé » | Le seuil est correct et identique à la référence. C'est ce qui se passe **après** (R1 + R3) qui casse. |
| « `UpdateEntry` remplace l'IA et on perd `BossAI` » | Non : `AIM_Initialize()` n'est appelé que si `updateScript = true`, ce qui n'est jamais le cas ici. L'IA `boss_lord_rhyolithAI` survit aux transformations. Le script `npc_lord_rhyolith_rhyolith` attaché à 53772 est donc inerte. |
| « Le corps est attaquable dès le départ » | Non : 52558 porte `UNIT_FLAG2_SELECTION_DISABLED`. Le problème n'apparaît qu'à partir de 54192 (R5). |
| « Le format du paquet de vignette est faux » | Le paquet n'est jamais émis (V1) : on ne peut rien conclure sur son format tant que le blocage n'est pas levé. À revérifier en jeu après correctif. |
| « `Vignette.db2` manque ou le magasin ne charge pas » | Le fichier est là, le magasin est déclaré et chargé, 714 gabarits et 213 spawns sont peuplés. |
| « RareScanner est en cause » | L'add-on ne fait qu'écouter `VIGNETTE_MINIMAP_UPDATED` / `C_VignetteInfo`. Sans paquet, il n'a rien à écouter. Aucun correctif spécifique à l'add-on n'est justifié. |
