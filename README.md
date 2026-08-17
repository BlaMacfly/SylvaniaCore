<div align="center">

<img src=".github/assets/sylvaniacore-logo.png" alt="SylvaniaCore" width="360">

# SylvaniaCore

**Le core C++ du royaume [La Légion de Sylvania](https://legendesylvania.com)**
Émulateur de serveur *World of Warcraft®* — Legion 7.3.5

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

## 🛠️ Prérequis

- **CMake 3.31+**
- **Boost 1.84.0**
- **MySQL 8.0**
- **OpenSSL 3.x**
- **GCC / Clang / MSVC** (Visual Studio 2022 recommandé)

Plateformes supportées : **Linux, Windows, macOS**.

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

3. Créer les bases (`auth`, `characters`, `world`, `hotfixes`) et importer les structures SQL
   fournies dans `sql/base`.

4. Lancer les serveurs :
   ```bash
   ./bin/worldserver
   ./bin/bnetserver
   ```

> ℹ️ Le code source conserve volontairement les noms internes hérités de l'amont
> (`DestinyCore`, cibles CMake, chemins de configuration) afin de rester compatible avec les
> mises à jour amont et de ne pas casser les scripts de déploiement existants.

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
3. Ouvrez une pull request

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
