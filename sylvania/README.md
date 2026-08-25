# `sylvania/` — notes internes du fork

Notes d'exploitation du fork et scripts qui ne sont pas du code de serveur.
La présentation du projet et la procédure d'installation sont dans le
[README à la racine](../README.md).

## État du fork

- **Base amont** : DestinyCore `master @2d631f4e` (remote `upstream`), plus de 200 commits de divergence
  (`git rev-list --count 2d631f4e..HEAD` pour le compte exact).
- **Client** : Legion 7.3.5.26972. `maps` / `vmaps` / `mmaps` / `dbc` extraits une fois pour
  toutes, aucune ré-extraction nécessaire.
- **Moteur** : MariaDB 11.4. Bases `dc_auth`, `dc_characters`, `dc_world`, `dc_hotfixes`, `dc_shop`.

## PlayerBots : ce qui tourne réellement

Le peuplement automatique hérité de l'amont est **coupé**, mais le système de bots, lui,
**tourne** : trois modules du royaume le pilotent à la demande. `World.cpp` initialise le
gestionnaire de bots dès que `pbotbg` **ou** `pbotall` vaut 1 — c'est ce qui permet aux modules
maison de fonctionner avec le peuplement amont désactivé.

| Clé | Valeur | Effet |
| --- | --- | --- |
| `pbot` | `0` | Aucun bot ami ni bot de groupe connecté automatiquement à l'arrivée d'un joueur (amont ; la valeur par défaut dans le code est 1, la couper est donc un choix). |
| `pbotall` | `0` | Aucun peuplement automatique du monde ni de la file LFG (amont). |
| `pbotbg` | `1` | **Module BG BotFill** : remplissage des champs de bataille quand de vrais joueurs sont en file (WS / AB / EY / AV / IC). Explicitement indépendant de `pbotall`. |
| `pbotmerc` | `1` | **Module Mercenaires** : le Portail d'Invocation (créature `1000010`, 60 spawns) loue des bots au joueur solo, 100 po, contrat rompu au moindre départ du groupe. |
| `siege_enable` | `0` | **Module Siège des Capitales** : écrit et livré, mais **pas encore activé** en production. |
| `pbotasl` | `88` | Plafond de bots connectés simultanément. |
| `pbottitle` | `600` | Titre « Mercenaire » imposé à tout bot, pour qu'un joueur ne puisse jamais le confondre avec un vrai joueur. Entrée `char_titles` custom de la base hotfix (MaskID 380). |

## Autres customs conservés de l'amont

- **Solocraft** (`Solocraft.Enable = 1`) : mise à l'échelle des donjons en solo.
- **Solo LFG** (`SoloLFG.Enable = 1`, `SoloLFG.Announce = 1`).
- **Klauss** (créature `1000000`, 13 spawns) : PNJ de réglage du taux d'XP personnel (x1 à x7),
  dialogues FR. Spawns dans `sql/sylvania/klauss_npc_*.sql`.

## `sql/sylvania/`

108 fichiers : la trace versionnée des correctifs data appliqués à la main à la base de
production. **Le dossier n'a pas une base cible unique** — la plupart visent `dc_world`, mais
`capital_siege.sql` crée deux tables dans `characters`. Chaque fichier annonce sa base dans son
en-tête : la lire avant de rejouer quoi que ce soit. Les `*_ROLLBACK.sql` annulent le patch de
même nom.

Ces fichiers ne passent **pas** par le mécanisme de mise à jour automatique du core. Un patch qui
doit valoir pour toute installation neuve a sa place dans `sql/updates/`, pas ici.

## `scripts/`

- **`db-release-github.sh`** — publie les bases de contenu (`dc_world` + `dc_hotfixes`) en assets
  de Release GitHub, seul canal viable : 79 Mo et 35 Mo une fois gzippés, là où GitHub refuse tout
  fichier de plus de 100 Mo dans l'historique. Réécrit au passage les collations MariaDB 11.4
  (`utf8mb4_uca1400_*`) que MySQL 8 ne connaît pas, exclut les tables de travail `bak_*` / `tmp_*`,
  et dépose une release **brouillon** : la publication reste manuelle. `--dry-run` produit les
  archives sans rien envoyer. Demande un PAT *fine-grained* dans `~/.config/sylvania-github-token`.
- **`reconcile_schema.sh`** — synchro additive de schéma (golden → cible) pour migrer
  `auth` / `characters`.
- **`ROLLBACK.sh.example`** — modèle de rollback blue-green (adapter les chemins).
