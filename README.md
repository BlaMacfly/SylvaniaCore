<div align="center">

<img src=".github/assets/sylvaniacore-logo.png" alt="SylvaniaCore" width="360">

# SylvaniaCore

**Le core C++ du royaume [La Légion de Sylvania](https://legendesylvania.com)**
Émulateur de serveur *World of Warcraft®* — Legion 7.3.5

[![Wiki](https://img.shields.io/badge/Wiki-documentation-0b7285?style=flat&logo=github)](https://github.com/BlaMacfly/SylvaniaCore/wiki)
[![Discord contributeurs](https://img.shields.io/badge/Discord-Espace%20contributeurs-5865F2?style=flat&logo=discord&logoColor=white)](https://discord.gg/qmQBXbuXkx)
[![License: GPL v2](https://img.shields.io/badge/License-GPLv2-blue.svg)](./LICENSE)
[![Stars](https://img.shields.io/github/stars/BlaMacfly/SylvaniaCore.svg?style=flat&logo=github)](https://github.com/BlaMacfly/SylvaniaCore/stargazers)
[![Forks](https://img.shields.io/github/forks/BlaMacfly/SylvaniaCore.svg?style=flat&logo=github)](https://github.com/BlaMacfly/SylvaniaCore/network/members)
[![Fork de DestinyCore](https://img.shields.io/badge/fork%20de-DestinyCore-2ea44f?logo=github)](https://github.com/slash-design/DestinyCore)

</div>

---

## 📖 Présentation

**SylvaniaCore** est le core qui fait tourner **La Légion de Sylvania**, un royaume francophone
*World of Warcraft®* en version **Legion 7.3.5**. C'est un fork de
[DestinyCore](https://github.com/slash-design/DestinyCore) (lui-même issu de la lignée TrinityCore),
maintenu et développé en continu pour les besoins du royaume.

Le dépôt sert à la fois de **base de code vivante** et de **sauvegarde** du serveur en production.

### Philosophie : « blizz adaptatif »

Ce n'est pas un serveur *fun* ni un serveur *rates x∞*. Les valeurs authentiques de Blizzard
(dégâts, tuning, économie) sont **préservées** ; le travail de fond consiste à **corriger les écarts
au blizzlike** plutôt qu'à adoucir le jeu. Chaque bug rencontré en jeu est corrigé à la source —
côté données ou côté core — jamais contourné à coups de commandes MJ.

---

## ✨ Ce que SylvaniaCore ajoute

Au-delà du core amont, le royaume apporte ses propres systèmes :

| Module | Description |
| --- | --- |
| 🤖 **PlayerBots** | Bots joueurs pilotables (`src/server/game/PlayerBot`) : ordres de groupe, rôles tank/heal, gestion d'équipement, remplissage automatique des champs de bataille |
| ⚔️ **Siège des Capitales** | Invasion quotidienne des capitales par des raids de bots, avec meneur désigné et joueurs flaggés PvP (`src/server/game/CapitalSiege`) |
| 💰 **Mercenaires** | PNJ de louage : un joueur solo recrute des compagnons contre pièces d'or, sous contrat (`src/server/game/Mercenary`) |
| 🇫🇷 **Localisation frFR** | Restitution des textes officiels français extraits du client 7.3.5 (quêtes, dialogues, broadcast texts) et traduction des contenus scriptés manquants |
| 🐛 **Correctifs de contenu** | Campagnes, donjons et quêtes remis en état zone par zone (Mardum, Île Vagabonde, Cime du Vortex…) |

---

## 📚 Documentation

Ce README suffit pour **installer et lancer** un serveur. Tout le reste vit dans le
**[wiki du projet](https://github.com/BlaMacfly/SylvaniaCore/wiki)** :

| | |
| --- | --- |
| 🔧 **[Corriger le contenu](https://github.com/BlaMacfly/SylvaniaCore/wiki/Corriger-le-contenu)** | Les classes de bugs récurrentes de ce core — scripts C++ non rattachés, hooks morts, quêtes sans objectif, butin, phases résiduelles — et comment les trouver. **Le meilleur point d'entrée pour une première contribution.** |
| ⚙️ **[Configuration](https://github.com/BlaMacfly/SylvaniaCore/wiki/Configuration)** | Référence de toutes les clés de configuration propres au royaume |
| 🧩 **[Architecture du core](https://github.com/BlaMacfly/SylvaniaCore/wiki/Architecture-du-core)** | Arborescence, lignée amont, pièges d'architecture |
| 🤖 **Modules** | [PlayerBots](https://github.com/BlaMacfly/SylvaniaCore/wiki/Module-PlayerBots) · [Mercenaires](https://github.com/BlaMacfly/SylvaniaCore/wiki/Module-Mercenaires) · [Siège des Capitales](https://github.com/BlaMacfly/SylvaniaCore/wiki/Module-Siege-des-Capitales) · [Autres customs](https://github.com/BlaMacfly/SylvaniaCore/wiki/Autres-customs) |
| 💥 **[Diagnostic des crashs](https://github.com/BlaMacfly/SylvaniaCore/wiki/Diagnostic-des-crashs)** | Core dumps, redzone jemalloc, faux crashs d'arrêt |
| 🩺 **[FAQ Dépannage](https://github.com/BlaMacfly/SylvaniaCore/wiki/FAQ-Depannage)** | Écran de chargement, PNJ disparus, personnage bloqué, boss infaisable… |
| 🚧 **[Chantiers en cours](https://github.com/BlaMacfly/SylvaniaCore/wiki/Chantiers-en-cours)** | Ce qui est ouvert, ce qui est clos, et les **impasses connues** |

---

## 🛠️ Prérequis

- **CMake 3.31+**
- **Boost 1.84.0**
- **MySQL 8.0** ou **MariaDB 10.6+** (le royaume tourne sur MariaDB 11.4)
- **OpenSSL 3.x**
- **GCC / Clang / MSVC** (Visual Studio 2022 recommandé)

Plateformes supportées : **Linux, Windows, macOS**.

> 📖 Paquets à installer, extraction des données client et compilation sur une machine modeste :
> **[Installation](https://github.com/BlaMacfly/SylvaniaCore/wiki/Installation)** sur le wiki.

---

## 📦 Compilation

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/BlaMacfly/SylvaniaCore.git
   cd SylvaniaCore
   ```

2. Configurer et compiler :
   ```bash
   cmake -S . -B build -DTOOLS=ON
   cmake --build build -j$(nproc)
   ```

3. Installer les bases de données — voir la section
   [Installation de la base de données](#-installation-de-la-base-de-données) ci-dessous.

4. Lancer les serveurs :
   ```bash
   ./bin/worldserver
   ./bin/bnetserver
   ```

> ℹ️ Le code source conserve volontairement les noms internes hérités de l'amont
> (`DestinyCore`, cibles CMake, chemins de configuration) afin de rester compatible avec les
> mises à jour amont et de ne pas casser les scripts de déploiement existants.

---

## 💾 Installation de la base de données

Le dépôt ne contient **que les schémas** `auth`, `characters` et `shop`. Les bases `world` et
`hotfixes` sont trop volumineuses pour être versionnées : elles se téléchargent dans les
**releases du dépôt amont DestinyCore**.

> ⚠️ **N'importez jamais les fichiers de `sql/base/dev/`.** Ce sont des structures **vides**
> (tables sans aucune donnée) destinées aux développeurs de l'amont. Les importer donne une base
> `world` creuse : le worldserver démarre, mais le client reste bloqué sur l'écran de chargement.

### 1. Télécharger la base amont

Récupérez la dernière release DB sur
[slash-design/DestinyCore/releases](https://github.com/slash-design/DestinyCore/releases)
(à ce jour `DB735.02.rar`, ~84 Mo). L'archive contient deux dumps :

| Fichier | Base | Taille décompressée |
| --- | --- | --- |
| `DB_world_735.02.sql` | `world` | ~375 Mo |
| `DB_hotfixes_735.02.sql` | `hotfixes` | ~127 Mo |

Ces deux dumps effectuent eux-mêmes leur `CREATE DATABASE` puis leur `USE` sur les noms `world` et
`hotfixes` ; pour utiliser d'autres noms de bases, éditez ces deux lignes en tête de fichier.

### 2. Créer les bases et importer

```bash
# Bases auth / characters / world / hotfixes
mysql -u root -p < sql/create/create_mysql.sql

# La base shop n'est pas couverte par le script amont
mysql -u root -p -e "CREATE DATABASE shop DEFAULT CHARACTER SET utf8;"

# Schémas fournis par le dépôt
mysql -u trinity -p auth       < sql/base/auth_database.sql
mysql -u trinity -p characters < sql/base/characters_database.sql
mysql -u trinity -p shop       < sql/base/shop_database.sql

# Bases complètes issues de la release amont
mysql -u trinity -p < DB_world_735.02.sql
mysql -u trinity -p < DB_hotfixes_735.02.sql
```

### 3. Laisser le core appliquer les mises à jour

N'importez **rien** à la main depuis `sql/updates/`. Dans `worldserver.conf` :

```ini
Updates.EnableDatabases = 31   # auth + characters + world + hotfixes + shop
Updates.AutoSetup       = 1
```

Au premier démarrage, le worldserver applique lui-même les quelque 330 fichiers de
`sql/updates/world`, ainsi que ceux de `characters` et `hotfixes`. La table `updates` des dumps
amont est livrée vide : c'est normal, tout l'historique est rejoué. Comptez plusieurs minutes.

### 4. Correctifs de contenu du royaume (optionnel)

`sql/sylvania/` est la trace versionnée des correctifs data appliqués à la base du royaume
(artefacts, campagnes, donjons, modules Mercenaires et Siège des Capitales…). Ils sont indépendants
du mécanisme de mise à jour automatique et s'importent à la main, dans l'ordre chronologique, une
fois les étapes précédentes terminées. **Chaque fichier annonce sa base cible dans son en-tête :
le dossier n'en a pas une seule.** Détail et conventions : **[Bases de données](https://github.com/BlaMacfly/SylvaniaCore/wiki/Bases-de-donnees)**.

### 🩺 Bloqué sur l'écran de chargement ?

Ces deux messages apparaissent à chaque connexion sur **tous** les serveurs de cette lignée et ne
sont **pas** des erreurs :

```text
Client tried to call not implemented method ResourceService.GetContentHandle
Received not handled opcode [CMSG_GET_ACCOUNT_CHARACTER_LIST ...]
```

`ResourceService` est un service Battle.net resté à l'état d'ébauche en amont, et
`CMSG_GET_ACCOUNT_CHARACTER_LIST` (liste des personnages inter-royaumes) est délibérément déclaré
`STATUS_UNHANDLED` dans `src/server/game/Server/Protocol/Opcodes.cpp`.

La cause est presque toujours une base `world` ou `hotfixes` mal importée — relisez l'avertissement
sur `sql/base/dev/` ci-dessus. Les autres pistes (cache client, données extraites, lecture de
`DBErrors.log`) sont détaillées dans la **[FAQ Dépannage](https://github.com/BlaMacfly/SylvaniaCore/wiki/FAQ-Depannage)**, avec les autres
symptômes fréquents.

---

## 🌍 Rejoindre le royaume

Le serveur de jeu est ouvert et le site officiel explique comment s'y connecter :
**[legendesylvania.com](https://legendesylvania.com)**

---

## 🤝 Contribuer

Les contributions sont les bienvenues — correction de bug, amélioration de la documentation
ou nouvelle fonctionnalité :

1. Forkez le dépôt
2. Créez une branche dédiée
3. Ouvrez une pull request contre `sylvaniacore`

> 📖 Conventions du dépôt, style de commit, règles pour le SQL et doctrine de correction :
> **[Contribuer](https://github.com/BlaMacfly/SylvaniaCore/wiki/Contribuer)** sur le wiki.

Un Discord est ouvert **aux contributeurs et aux personnes qui souhaitent participer au
développement du core** : c'est l'endroit où discuter d'un correctif avant de se lancer, poser
des questions sur l'architecture ou faire relire une PR. (Ce n'est pas le Discord des joueurs
du royaume.)

<a href="https://discord.gg/qmQBXbuXkx"><img src="https://img.shields.io/badge/Discord-Espace%20contributeurs-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Rejoindre le Discord des contributeurs"></a>

---

## 🐛 Signaler un problème

Ouvrez un ticket sur le [suivi d'issues](https://github.com/BlaMacfly/SylvaniaCore/issues).
Vérifiez au préalable qu'un rapport identique n'existe pas déjà.

---

## 🙏 Remerciements

SylvaniaCore n'existerait pas sans le travail des projets dont il descend :

- [DestinyCore](https://github.com/slash-design/DestinyCore) — le core amont dont ce dépôt est un fork
- [TrinityCore](https://github.com/TrinityCore/TrinityCore) — la lignée d'origine
- [**ArgusCore**](https://github.com/Trion-Control-Panel/ArgusCore), le projet de
  [FlyingPhoenix](https://github.com/fIyingPhoenix) — une référence majeure pour SylvaniaCore.
  Un travail considérable y a été mené sur le moteur, la couche réseau et les mécaniques de
  classes en 7.3.5 ; nous nous en inspirons régulièrement pour remettre en état des pans entiers
  du core. Merci pour tout ce qui est partagé ouvertement.
- [mod-playerbots](https://github.com/liyunfan1223/mod-playerbots) — référence sur la logique des bots joueurs

État de la CI du dépôt amont :
[![Windows x64](https://github.com/slash-design/DestinyCore/actions/workflows/win-x64-build.yml/badge.svg)](https://github.com/slash-design/DestinyCore/actions/workflows/win-x64-build.yml)
[![GCC](https://github.com/slash-design/DestinyCore/actions/workflows/gcc-build.yml/badge.svg)](https://github.com/slash-design/DestinyCore/actions/workflows/gcc-build.yml)
[![Clang](https://github.com/slash-design/DestinyCore/actions/workflows/clang-build.yml/badge.svg)](https://github.com/slash-design/DestinyCore/actions/workflows/clang-build.yml)

---

## 📜 Licence

Distribué sous **GPL v2.0**. Voir le fichier [LICENSE](./LICENSE).

*World of Warcraft® et Blizzard Entertainment® sont des marques déposées de Blizzard Entertainment, Inc.
Ce projet n'est ni affilié à Blizzard Entertainment, ni approuvé par elle.*

---

<div align="center">

<img src=".github/assets/sylvaniacore-logo.png" alt="SylvaniaCore" width="90">

⭐ Si SylvaniaCore vous plaît, laissez une étoile au projet !

</div>
