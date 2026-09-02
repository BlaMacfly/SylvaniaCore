# Legion — référence de travail

Ce document n'est pas une fiche encyclopédique. C'est un **croisement** : ce que
le jeu officiel contient d'un côté, ce que notre base contient de l'autre. Un
fait non vérifié contre nos données ne sert à rien pour réparer.

Chaque section suit la même règle : la source officielle est citée, puis la
requête qui l'a confrontée à `dc_world`, puis l'écart s'il y en a un.

---

## L'ossature de l'extension

| Correctif | Contenu | Ce qui nous concerne |
|---|---|---|
| **7.0** Legion | Invasion, les quatre zones, les Sanctums de classe, l'arme prodigieuse | Scénario d'introduction du Rivage brisé |
| **7.1** Retour à Karazhan | Suramar, Karazhan | — |
| **7.2** Tombe de Sargeras | **Campagne du Front-de-Légion**, le Rivage brisé jouable, montures de classe | Notre chantier actuel |
| **7.3** Ombres d'Argus | Argus, l'Insurgé | — |

---

## Le piège du Rivage brisé : DEUX scénarios

C'est l'erreur qui m'a coûté le plus de temps, et elle est facile à refaire.

| | Introduction | Assaut |
|---|---|---|
| Correctif | 7.0 | 7.2 |
| Carte | **1460** | **1666** |
| Scénario | 786 | 1280 |
| Récit | La bataille perdue. Varian, Vol'jin, Tirion, Krosus, Gul'dan qui ouvre la Tombe | Le retour offensif depuis Dalaran |
| Entrées de créatures | 90xxx | 116xxx–122xxx |
| Script | `scenario_broken_shore_intro` | `scenario_7.2_broken_shore_intro` |
| Quêtes liées | 42740 (Alliance) / 44543 (Horde) | **45102**, **46734** |

Les deux portent le même nom en jeu. Quand une quête du Rivage brisé ne se
débloque pas, **la première question est : laquelle des deux cartes ?**

Les objectifs de 45102 parlent de « flèches de la Légion » (*Legion Spires*) et
de Lord Kalgorath — tous en 116xxx, donc 7.2, donc carte 1666. Rien de tout
cela n'est atteignable sur la 1460.

---

## Campagne du Front-de-Légion (7.2)

Source : [Breaching the Tomb](https://warcraft.wiki.gg/wiki/Breaching_the_Tomb),
qui liste les quinze quêtes de l'exploit du même nom. En jeu officiel elles
étaient **échelonnées par semaines**, du 28 mars au 6 juin 2017 — d'où le
sentiment de campagne décousue.

### État chez nous, au 01/09/2026

Les quinze quêtes existent, **toutes avec donneur et receveur**. La campagne
n'était donc pas cassée : seuls ses deux points d'entrée l'étaient.

| ID | Quête | Donneur | Objectifs |
|---|---|---|---|
| 46730 | Armies of Legionfall | Khadgar **86563** (Dalaran) | 1 |
| 46734 | Assault on Broken Shore | Khadgar 86563 + **116302** | 2 |
| 45102 | Begin the Assault | Khadgar **116302** | 3 |
| 46245 | Begin Construction | Commander Chambers 120183 | 1 |
| 46845 | Vengeance Point | Heidirk the Scalekeeper 120118 | 3 |
| 47137 | Champions of Legionfall | Maiev Shadowsong 116576 | 1 |
| 47139 | Mark of the Sentinax | Illidan Stormrage 117873 | 1 |
| 46252 | Intolerable Infestation | Maiev 116576 | 1 |
| 46250 | Take Out the Head... | Maiev 116576 | 1 |
| 46246 | Strike Them Down | Maiev 116576 | 1 |
| 46832 | Aalgen Point | Commander Chambers 120183 | **0** ⚠ |
| 46247 | Defending Broken Isles | Maiev 116576 | 1 |
| 46251 | Shard Times | Khadgar 116302 | 1 |
| 46248 | Self-Fulfilling Prophecy | Prophet Velen 120372 | 1 |
| 46769 | Relieved of Their Valuables | Khadgar 116302 | 1 |
| 46249 | Championing Our Cause | Khadgar 116302 | 1 |

**Les deux Khadgar.** Ne pas les confondre, ils portent le même nom :

- **86563** — Anneau de Krasus, Dalaran, carte 1220 en `(-841, 4258, 746)`.
  L'altitude 746 est celle de la cité flottante. C'est lui qui ouvre la
  campagne et qui lance le scénario d'assaut.
- **116302** — Pointe de la Délivrance, sur le Rivage brisé, carte 1220 en
  `(-1628, 3194, 130)`. Il donne le reste.
- **120215** — un troisième, posé nulle part chez nous. La référence le place
  à l'Anneau de Krasus en phases 7312/7313. C'est la cible du crédit
  « Speak to Khadgar » de la quête 46734.

### Deux anomalies relevées

**46832 « Aalgen Point » n'a aucun objectif.** Elle a pourtant donneur et
receveur, et aucune ligne dans `quest_template_addon` — donc pas de
`SpecialFlags = 2` qui justifierait une validation par script. À examiner.

**48641 porte aussi le titre « Armies of Legionfall »**, sans aucun donneur,
avec `QuestSortID 7543` (la zone du Rivage brisé) là où 46730 porte `-428`.
Probablement une variante de suivi. Ne pas la confondre avec la vraie.

---

## Entrer dans le scénario d'assaut

Le déroulement officiel, décrit par les joueurs
([Warcraft Wiki](https://warcraft.wiki.gg/wiki/Assault_on_Broken_Shore_(quest)),
[Icy Veins](https://www.icy-veins.com/forums/topic/28263-patch-72-assault-on-the-broken-shore-scenario/)) :

> On prend la quête auprès de l'archimage à l'Anneau de Krasus, on choisit
> « I am ready to launch the assault », une cinématique se joue, puis
> *you will be flown* jusqu'au scénario.

Trois conséquences pour nous :

1. L'entrée est une **option de dialogue**, pas un portail. Elle n'existait ni
   dans notre base ni dans le dump de référence — donnée de capture jamais
   importée. Recréée dans `npc_archmage_khadgar_86563`.
2. Le sort **240603** porte la destination officielle dans
   `spell_target_position` : carte 1666, `(-1111.6, 2969.71, 186.02)`.
3. « Emporté par la voie des airs », c'est le **corbeau arcanique 118517**,
   invoqué par le sort **243303** (effet 28 SUMMON, valeur 118517 — vérifié
   dans `SpellEffect.db2` du build 7.3.5.26972). Son chemin de vol 11322708
   part de l'altitude de Dalaran (751) et descend au niveau de la mer (4).

---

## Les huit étapes du scénario 1280

Relevées dans `ScenarioStep`, `CriteriaTree` et `Criteria` du build
7.3.5.26972 — pas recopiées d'un autre cœur.

| Ordre | Arbre | Type | Asset | Montant | Étape |
|---|---|---|---|---|---|
| 0 | 56811 | 92 | 56460 | 1 | Into the Fray |
| 1 | 56872 | 92 | 56697 | 3 | Vanguard of the Assault |
| 2 | 56874 | 92 | 56500 | 1 | Might of the Legion (Kalgorath) |
| 3 | 57180 | 92 | 56779 | barre de 200 | Rifts of Chaos |
| 3 | 57185 | **73** | 56778 | 3 | ... les trois portails |
| 4 | 57183 | 92 | 56780 | 1 | The Doomguard's Command (Arganoth) |
| 5 | 57293 | **68** | 267955 | 1 | Gateway to Ruin |
| 6 | 58303 | 92 | 57574 | 7 | Pillar of Fire (7 bombes) |
| 7 | 59170 | 92 | 57579 | 1 | Mephistroth |

Types : **92** `SEND_EVENT_SCENARIO` (alimenté par `DoSendEventScenario`),
**73** `SEND_EVENT`, **68** `USE_GAMEOBJECT` (les deux par `UpdateCriteria`).

Concordance rassurante : la carte porte exactement **7 bombes arcaniques**
(120743) pour un critère qui en exige 7, et 7 portails (118558) dont 3 à
fermer.

---

## Comment étendre ce document

La méthode, pas le contenu, est ce qui compte :

1. Partir d'une source officielle — les wikis Warcraft sont fiables sur les
   chaînes de quêtes ; Wowhead ment quand on le lit par `curl`, ses tables
   sont en JavaScript.
2. Pour tout ce qui est chiffré — critères, sorts, scénarios — passer par
   `wago.tools`, qui sert les DB2 du build **7.3.5.26972**, le nôtre.
   Format : `/db2/<Table>/csv?build=7.3.5.26972&filter[Colonne]=valeur`.
   Sans le filtre, les grosses tables font expirer la requête.
3. **Toujours confronter à `dc_world`** avant d'écrire quoi que ce soit ici.
   Une ligne qui n'a pas été vérifiée contre notre base n'a pas sa place.
4. Noter les écarts, pas les conformités. Ce qui marche n'a pas besoin d'être
   documenté.
