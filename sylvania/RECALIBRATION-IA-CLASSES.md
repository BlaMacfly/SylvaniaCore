# Recalibration Legion des IA de classe des PlayerBots

**Serveur :** Sylvania Legion (DestinyCore 7.3.5) · **Relevé :** 16/08/2026

## 1. Le constat

Les IA de `src/server/game/AI/PlayerAI/BotClassAI/` résolvent leurs sorts par
`FindMaxRankSpellByExist(id)`. Quand le bot ne connaît pas l'identifiant, la
constante vaut 0 et toutes les branches qui en dépendent sont sautées
silencieusement. Mesure sur les bots niveau 110 du serveur :

| Classe | Sorts réclamés | Réellement connus | Taux |
|---|---|---|---|
| Chaman | 43 | 3 | **7 %** |
| Mage | 46 | 4 | **9 %** |
| Chasseur | 41 | 6 | 15 % |
| Démoniste | 44 | 7 | 16 % |
| Prêtre | 39 | 7 | 18 % |
| Druide | 56 | 11 | 20 % |
| Paladin | 42 | 9 | 21 % |
| Guerrier | 45 | 10 | 22 % |
| Voleur | 31 | 8 | 26 % |

**80 à 93 % du répertoire de chaque IA est du code mort.** Les identifiants
datent d'une version bien antérieure du jeu.

## 2. Méthode

La source de vérité est **la base du serveur**, pas une documentation externe :
une requête sur `character_spell` dit exactement ce qu'un bot d'une classe et
d'un niveau donnés possède. Wowhead et Icy Veins servent à décider *l'ordre* des
sorts dans la rotation ; la base valide qu'ils sont castables.

```sql
SELECT DISTINCT s.spell FROM character_spell s JOIN characters c ON c.guid=s.guid
WHERE c.class = <classe> AND c.level >= 100 AND s.spell IN (<candidats>);
```

## 3. Kits Legion vérifiés présents chez les bots

Spécialisation entre parenthèses = celle que portent les bots du siège.

### Guerrier (Armes 71, Protection 73)
`12294` Frappe mortelle · `1464` Salve · `163201` Exécution · `167105` Broyeur
de colosse · `1680` Tourbillon · `34428` Fureur sanguinaire · `1719` Cri de
guerre · `118038` Mourir l'arme à la main · `7384` Waylay
Protection : `23922` Coup de bouclier · `6572` Vengeance · `6343` Coup de
tonnerre · `2565` Blocage · `190456` Ignorer la douleur · `1160` Cri
démoralisant · `23920` Renvoi de sort

### Paladin (Vindicte 70)
`184575` Lame de justice · `85256` Verdict du templier · `53385` Tempête divine
· `26573` Consécration · `31884` Colère vengeresse · `184662` Bouclier de
vengeance · `210191` Verbe de gloire · `19750` Éclair de lumière · `853` Marteau
de la justice · `96231` Réprimande

### Chasseur (Maîtrise des bêtes 253)
`193455` Tir de cobra · `34026` Commandement de tuer · `120679` Bête sauvage ·
`19574` Furie bestiale · `193530` Aspect du sauvage · `120360` Barrage · `2643`
Tir multiple · `5116` Tir de diversion · `781` Repli

### Voleur (Assassinat 259)
`1329` Mutilation · `32645` Envenimer · `1943` Rupture · `703` Garrot · `79140`
Vendetta · `51723` Éventail de couteaux · `1784` Camouflage · `1856` Disparition
· `5277` Évasion

### Prêtre (Ombre 258)
`8092` Attaque mentale · `15407` Flagellation mentale · `589` Mot de l'ombre :
douleur · `34914` Toucher vampirique · `228260` Éruption du Vide · `32379` Mot
de l'ombre : mort · `47585` Dispersion · `232698` Forme d'ombre · `17` Mot de
pouvoir : bouclier · `15487` Silence · `2061` Soins rapides

### Chaman (Restauration 264)
`77472` Vague de soins · `8004` Salve de soins · `1064` Chaîne de soins ·
`61295` Vague de rappel · `73920` Pluie de soins · `98008` Totem de lien
spirituel · `108280` Totem de marée de soins · `77130` Purification de l'esprit
· `403` Éclair · `188389` Salve de flammes · `51505` Explosion de lave

### Démoniste (Affliction 265)
`980` Agonie · `172` Corruption · `30108` Affliction instable · `198590` Drain
d'âme · `27243` Semence de corruption · `48181` Traque · `1454` Connexion

### Druide (Équilibre 102, Gardien 104)
Équilibre : `190984` Courroux solaire · `194153` Frappe lunaire · `93402` Feu
solaire · `78674` Poussée d'étoiles · `191034` Pluie d'étoiles · `194223`
Alignement céleste
Gardien : `33917` Mutilation · `192081` Fourrure de fer · `22842` Régénération
frénétique · `61336` Instincts de survie

## 4. Avancement

| Classe | État |
|---|---|
| Mage | ✅ 7 constantes recalibrées (rotation Givre, zone, défensif) |
| Guerrier, Paladin, Chasseur, Voleur, Prêtre, Chaman, Démoniste, Druide | kit vérifié, recalibration à faire |

## 5. Trous restants

Des sorts pourtant fondamentaux manquent aux bots : Charge (`100`) et Provocation
(`355`) chez le guerrier, Jugement (`20271`) et Frappe du croisé (`35395`) chez
le paladin, Nova de givre (`122`) et Contresort (`2139`) chez le mage. L'octroi
des sorts reste donc incomplet malgré `LearnDefaultSkills` et
`LearnSpecializationSpells` — à creuser séparément, probablement du côté des
sorts de rang de spécialisation octroyés par niveau.
