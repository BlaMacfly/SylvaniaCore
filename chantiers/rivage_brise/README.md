# Chantier — Assaut du Rivage brisé (carte 1666)

État au 31/08/2026. **Tout est appliqué et déployé.** Rien n'est vérifié
en jeu : c'est la seule chose qui manque.

## Le blocage d'origine

`instance_template` réclame pour la carte 1666 un script nommé
`scenario_7.2_broken_shore_intro` qui **n'existe nulle part dans notre code** —
script fantôme. La table `scenarios` n'a par ailleurs aucune ligne pour cette
carte. Conséquence : les quêtes `45102 Begin the Assault` et
`46734 Assault on Broken Shore` sont infranchissables.

## Ce qui a été rassemblé

Source : `dufernst/LegionCore-7.3.5` (même lignée uwow que notre fork).

| Élément | Volume | Emplacement |
|---|---|---|
| Script du scénario | 500 lignes | `reference/AssaultBrokenShore.cpp` |
| Script d'instance | 308 lignes | `reference/instance_AssaultBrokenShore.cpp` |
| Placements de créatures | **593 spawns**, 67 entrées | à extraire du dump |
| Placements d'objets | **59 spawns**, 52 entrées | à extraire du dump |

Le dump complet (`LegionCore_world_2020_04_25.zip`, 39 Mo compressés / 232 Mo)
n'est **pas** versionné : il se retélécharge depuis le dépôt de référence,
chemin `sql/base/`.

## Ce que notre base possède déjà

- Les **67 modèles de créatures** : présents, aucun manquant.
- Les **52 modèles d'objets** : présents, aucun manquant.
- Les répliques françaises de Vol'jin (90708) et Sylvanas (90709), y compris
  la blessure empoisonnée qui déclenche la retraite. Ces deux-là n'ont
  cependant **aucun spawn ni script**.

## Décisions de transposition, établies sur données

Les deux schémas divergent. Correspondances retenues :

| Référence | Nous | Décision |
|---|---|---|
| `spawnMask = 4096` | `spawnDifficulties` | **`'12'`** — 4096 = 2¹², et la difficulté 12 est « Normal Scenario » (type instance 5) d'après `Difficulty.db2` du build 7.3.5.26972 |
| `phaseMask = 1` | `phaseUseFlags`, `PhaseGroup` | valeurs neutres : aucun phasage réel à transposer |
| `PhaseId` | `PhaseId` | direct — vaut `''` sauf 3 créatures à `7043` |
| `guid` | `guid` | **renumérotés** au-dessus de nos maxima (créature 290000114, objet 210120986) |
| — | `terrainSwapMap` | `-1`, valeur employée par nos autres instances |
| `npcflag2`, `AiID`, `MovementID`, `MeleeID`, `isActive`, `skipClone`, `personal_size`, `isTeemingSpawn` | — | **abandonnées**, ces colonnes n'existent pas chez nous |

## Dépendances découvertes, à ne pas oublier

1. **180 créatures sur 593 ont `MovementType = 2`** : elles suivent des
   chemins. Sans extraction de `waypoint_data` pour leurs GUID, elles
   apparaîtront figées.
2. **12 créatures portent `AiID = 7424`**, une table d'IA propre au cœur de
   référence que nous n'avons pas. Ce comportement sera **perdu** et devra
   être refait autrement — probablement en SmartAI.
3. Le dump contient `scenario_data`, `scenario_poi`, `scenario_poi_points` et
   `scenario_step_spells` : la déclaration du scénario s'y trouve aussi.
4. Le script s'enregistre sous `instance_AssaultBrokenShore` alors que notre
   `instance_template` réclame `scenario_7.2_broken_shore_intro`. À raccorder.

## Piège rencontré, à retenir

Le premier extracteur écrit pour ce travail renvoyait **zéro ligne** pour la
carte 1666, ce qui aurait fait conclure à tort que la référence ne contenait
rien. Cause : dans ce dump, une instruction `insert into` s'étale sur
plusieurs lignes, et l'analyse ligne à ligne ne voyait que la première.

C'est un contrôle de cohérence — vérifier que le parseur trouvait bien des
lignes sur des cartes connues — qui a révélé le bug. **Toujours valider un
extracteur sur un cas positif connu avant de croire un résultat négatif.**

## Ce qui a été fait le 31/08

1. **593 créatures, 59 objets, 1495 points** appliqués sur la carte 1666.
   Le fichier était généré depuis le 27/08 et dormait sans être exécuté.
2. **808 lignes de C++ portées** dans
   `src/server/scripts/BrokenIsles/Scenario/scenario_assault_broken_shore.cpp`,
   enregistré sous `scenario_7.2_broken_shore_intro` — le nom que
   `instance_template` réclamait déjà, donc aucune modification de base.
   Ce nom contient un point : la classe est écrite à la main, la macro
   `RegisterInstanceScript` ne l'accepterait pas.
3. **Les 5 scripts rattachés** à leurs 11 entrées, toutes vérifiées
   exclusives à la carte 1666.
4. **87 points des 5 chemins scriptés** extraits et posés.
5. **Le donneur de la quête 45102** raccordé : Khadgar 116302.

## Le piège de l'extraction, deuxième épisode

Les cinq chemins scriptés (11322705 à 11322709) ne sont **pas** dans
`waypoint_data` mais dans **`waypoint_data_script`**, une table que notre
schéma n'a pas — notre `sWaypointMgr` ne lit que la première. L'extraction
du 27/08 ne regardait que celle-là et les a donc silencieusement manqués.

Conséquence si on ne l'avait pas vu : le corbeau arcanique n'aurait jamais
décollé, et comme c'est l'atteinte du point 20 de son vol qui déclenche
l'étape 0, **le scénario n'aurait jamais démarré** — sans la moindre
erreur dans le journal.

C'est la même leçon qu'en août, sous une autre forme : ce n'est pas
l'extracteur qui a menti, c'est la table qu'on n'a pas pensé à ouvrir.

## Ce qui reste

1. **Tout vérifier en jeu.** Rien n'a été joué. Prendre 45102 auprès de
   Khadgar 116302 en Îles brisées et dérouler le scénario.
2. **Les crédits 116253 et 116279** sont câblés sur la fermeture des deux
   premiers portails **par déduction** : la quête parle de « First » et
   « Second Legion Spire destroyed », et les portails sont les seuls
   objets destructibles de l'étape 3. À confirmer ou corriger.
3. **Les 12 créatures à `AiID = 7424`** (119422 ×9, 119425 ×2, 119412 ×1)
   gardent un comportement de mêlée ordinaire. Vérifié : le dump ne
   contient **aucune** table définissant les `AiID` — ce comportement
   n'est pas récupérable depuis cette source. Ne pas rouvrir ce point
   sans une autre référence.
4. **Khadgar 120215** n'est posé nulle part chez nous. La référence le
   place deux fois sur la carte 1220, en phases 7312 et 7313. Le crédit
   « Speak to Khadgar » est pour l'instant accordé par le script à la fin
   du scénario ; c'est un raccourci assumé, à arbitrer.
5. **Concordance rassurante** relevée au passage : 7 bombes arcaniques
   posées sur la carte, pour un critère qui en exige exactement 7.
