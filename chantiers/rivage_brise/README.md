# Chantier — Assaut du Rivage brisé (carte 1666)

État au 27/08/2026. **Rien n'est appliqué au serveur à ce stade.**

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

## Reste à faire

1. Extraire et transposer les 593 + 59 placements.
2. Extraire les chemins des 180 créatures mobiles.
3. Transposer la déclaration du scénario.
4. Porter les 808 lignes de C++ et les adapter à notre API, qui a divergé
   (`MoveJump`, `SetFacingTo`, `GetEffect` diffèrent déjà — constaté ailleurs).
5. Raccorder le nom de script.
6. Refaire autrement le comportement des 12 créatures à `AiID`.
