# La bataille du Rivage brisé — déroulé de référence (carte 1460, scénario 786)

Ce document croise trois sources, et dit toujours laquelle parle :

- **la vidéo** fournie par l'exploitant (40 min, écran partagé Alliance/Horde),
  qui donne l'ordre réel des événements, le minutage et les compteurs affichés ;
- **les DB2 du build 7.3.5.26972** (`ScenarioStep`, `CriteriaTree`, `Criteria`),
  qui donnent les critères chiffrés ;
- **[Warcraft Wiki](https://warcraft.wiki.gg/wiki/The_Battle_for_Broken_Shore_(quest))**,
  qui donne les intitulés et les répliques.

Ce que **notre base** contient est indiqué en regard, avec l'écart quand il y en a.

---

## Les neuf étapes

| # | Alliance | Horde | Critère officiel |
|---|---|---|---|
| 1 | The Broken Shore | idem | arbre 42768 — asset 44060 ×1 |
| 2 | Storm The Beach | idem | 44095 ×**33**, 52643 ×**3**, 44077 ×**3** |
| 3 | Defeat the Commander — **Arganoth** | Defeat the Commander — **Azgalor** | arbre 43554 — asset 45131 ×1 |
| 4 | **Find Varian** | **Find The Others** (Sylvanas *et* Baine) | arbre 43589 — asset 45228 ×1 |
| 5 | Destroy the Portal — **4 ancres blindées** | idem | arbre 43415 — asset 45288 ×**4** |
| 6 | Raze the Black City — barre 0→100 % | idem | arbre 42770 — 44384 ×1, 53062 ×2, 53063 ×5, 53064 ×10 |
| 7 | The Highlord — atteindre Tirion | idem | arbre 42772 |
| 8 | Krosus | idem | arbre 43765 |
| 9 | **Stop Gul'dan** | **Hold the Ridge** | arbre 47225 |

---

## Trois erreurs que ce croisement a révélées

**L'étape 5 comptait la mauvaise créature.** Notre script invoquait deux
« ancres dimensionnelles » (90637) de sa fabrication. Le jeu demande la
destruction de **quatre ancres blindées** (`101667`), dont la carte porte déjà
quinze exemplaires autour de `(1107, 2061)`. Corrigé.

**L'étape 3 n'a pas le même adversaire selon la faction.** Alliance : *Dread
Commander Arganoth*. Horde : *Fel Commander Azgalor*. Notre script ne connaît
qu'Arganoth et l'invoque pour les deux camps. **Non corrigé.**

**L'étape 4 non plus.** Alliance : trouver Varian. Horde : trouver **Sylvanas
et Baine**, deux personnages, pas Vol'jin. Notre script cherche Vol'jin côté
Horde. **Non corrigé.**

Et l'étape 9 diverge aussi : l'Alliance arrête Gul'dan, la Horde tient la
crête pendant ce temps.

---

## Nos dialogues sont inventés

Toutes les répliques de `creature_text` pour ce scénario ont un
`BroadcastTextId` à **zéro** : elles ont été écrites à la main, elles ne
viennent pas du jeu. Elles sont plausibles mais fausses, et l'une d'elles a
directement produit un bug.

| Entrée | Notre texte | Le jeu |
|---|---|---|
| 90714 Jaina | « Détruisez les ancres **dimensionnelles** » | *Those crystals appear to be anchoring the structures to our dimension. Take them out!* |
| 90713 Varian | « Soldats de l'Alliance ! La Légion s'abat… » | *Genn, Jaina, it's good to see you safe.* |
| 90717 Genn | — | *Just in time. We haven't been able to break their line. Now we may have a chance.* |
| 90708 Vol'jin | « Fils et filles de la Horde ! … » | *Dere's only one way offa dis beach, and it be t'rough alla dose demons ahead of us.* |
| 90413 Gul'dan | « Vous arrivez trop tard ! … » | *I have seen the end of your pitiful world, Wrynn. … The legion is ENDLESS.* |

C'est la réplique de Jaina qui a fabriqué l'erreur de l'étape 5 : le script a
été écrit d'après elle. **La donnée fausse produit du code faux.**

---

## Déroulé relevé sur la vidéo

Minutage de la vidéo, pas du scénario — les premières minutes sont à Dalaran.

| Temps | Événement |
|---|---|
| 06:02 | Jaina : « Attention, des infernaux ! » — début du combat de plage |
| 06:04 | Le commandant de l'effroi Arganoth parle |
| 06:54 | Genn Grisetête : « Celui-là est à moi ! » |
| 07:00 | Jaina : « Est-ce que tout le monde va bien ? » |
| 07:26 | Genn : « Les troupes de Varian ont dû arriver de l'autre côté de… » |
| 07:48 | Jaina : « Je n'avais jamais vu des démons progresser… » |
| 08:18 | Genn : « Quelque chose a changé. La Légion n'est… » |
| 08:38 | Jaina : « Oh, non… » |
| 08:46 | Varian : « Tenez bon, soldats de l'Alliance ! » |
| 09:12 | Varian : « Genn, Jaina, je suis heureux de voir que vous allez bien. » |
| 09:18 | Varian : « En formation, protecteurs de l'Alliance ! Repoussons-les ! » |
| 17:28 | Varian : « Vous avez une autre occasion de l'abattre, Sylvanas » |
| 17:32 | Sylvanas : « C'est comme si c'était fait, Wrynn. » |
| 17:54 | Varian : « Tout le monde, de l'autre côté du gouffre ! » |
| 18:08 | Sylvanas : « Nous allons prendre la crête et couvrir votre… » |
| 18:44 | Gul'dan : « M'échapper ? C'est plutôt vous qui n'échapperez pas à mon… » |
| ~08:20 vidéo | phase 5 : compteur **0/4 → 2/4 → 3/4 Ancres blindées détruites** |
| ~09:00 vidéo | phase 6 : barre **0 % → 2 % → 13 % → 37 % → 63 %** |

Le texte ci-dessus vient de la reconnaissance optique sur une vidéo 720p en
écran partagé : **les fins de phrase sont tronquées** par la largeur de la
fenêtre de discussion, et certains caractères sont incertains. Il donne
l'ordre et l'orateur de façon fiable ; il ne fait pas autorité sur la
formulation exacte. Pour celle-ci, se référer au wiki.

---

## Ce qui reste à faire

1. **Le commandant Horde** : invoquer Azgalor et non Arganoth.
2. **L'étape 4 Horde** : deux cibles, Sylvanas et Baine.
3. **L'étape 9 Horde** : tenir la crête, pas arrêter Gul'dan.
4. **Les étapes 6 à 9** avancent encore par forçage, sans leurs critères. La
   barre de 300 points de l'étape 6 est alimentée par quatre événements de
   poids différents (1, 2, 5, 10) dont le sens reste à établir.
5. **Remplacer les dialogues inventés** par les vrais. Ils n'existent qu'en
   anglais dans nos sources : traduire, ou assumer l'anglais.
