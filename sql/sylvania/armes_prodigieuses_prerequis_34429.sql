-- Premiere quete de l arme prodigieuse de 10 classes : PrevQuestID = 34429 « Kill Your Hundred »,
-- une quete de l INTRODUCTION DE DRAENOR (Tanaan). Heritage de la base DestinyCore d origine.
-- Tout personnage qui n est pas passe par l intro de WoD ne pouvait pas obtenir son arme :
-- 4 personnages sur 180 de niveau >= 98 l avaient faite (29/09/2026). Tres probablement le
-- blocage « arme prodigieuse du DK » signale au debut du chantier.
-- Prerequis retire (on ne reprend pas ceux de LegionCore : le sien pour le chasseur, 41415,
-- aurait bloque un joueur qui a obtenu son arme chez nous sans passer par la). Quete reservee
-- a sa classe : AllowableClasses etait a 0 (un guerrier pouvait prendre celle du chasseur).
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=2    WHERE ID=40408 AND PrevQuestID=34429; -- paladin
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=1    WHERE ID=40579 AND PrevQuestID=34429; -- guerrier
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=4    WHERE ID=40618 AND PrevQuestID=34429; -- chasseur
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=512  WHERE ID=40636 AND PrevQuestID=34429; -- moine
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=256  WHERE ID=40684 AND PrevQuestID=34429; -- demoniste
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=32   WHERE ID=40715 AND PrevQuestID=34429; -- chevalier de la mort
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=2048 WHERE ID=40816 AND PrevQuestID=34429; -- chasseur de demons
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=8    WHERE ID=40839 AND PrevQuestID=34429; -- voleur
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=128  WHERE ID=41085 AND PrevQuestID=34429; -- mage
UPDATE quest_template_addon SET PrevQuestID=0, AllowableClasses=64   WHERE ID=41335 AND PrevQuestID=34429; -- chaman
