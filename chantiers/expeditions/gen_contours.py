#!/usr/bin/env python3
# Contours de quete (quest_poi + quest_poi_points) repris de TDB 735.00 (TrinityCore, base officielle 7.3.5)
# pour les expeditions du registre qui n ont aucun point de contour. Lecture seule des bases.
import subprocess
def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.strip().split('\n') if l]
ids = [r[0] for r in q("""SELECT w.id FROM dc_world.world_quest w JOIN dc_world.quest_template q ON q.ID=w.id
    WHERE q.QuestType=3 AND NOT EXISTS (SELECT 1 FROM dc_world.quest_poi_points p WHERE p.QuestID=w.id)
      AND EXISTS (SELECT 1 FROM tdb735_ref.quest_poi_points p WHERE p.QuestID=w.id) ORDER BY w.id""")]
I = ','.join(ids)
cols = "QuestID, BlobIndex, Idx1, ObjectiveIndex, QuestObjectiveID, QuestObjectID, MapID, WorldMapAreaId, Floor, Priority, Flags, WorldEffectID, PlayerConditionID, WoDUnk1, AlwaysAllowMergingBlobs, VerifiedBuild"
poi = q(f"SELECT {cols} FROM tdb735_ref.quest_poi WHERE QuestID IN ({I}) ORDER BY QuestID, Idx1")
pts = q(f"SELECT QuestID, Idx1, Idx2, X, Y, VerifiedBuild FROM tdb735_ref.quest_poi_points WHERE QuestID IN ({I}) ORDER BY QuestID, Idx1, Idx2")
old = q(f"SELECT {cols} FROM dc_world.quest_poi WHERE QuestID IN ({I}) ORDER BY QuestID, Idx1")
O = '/home/ubuntu/DestinyCore/sql/sylvania/2026_10_07_expeditions_contours'
L = ["-- Contours des expeditions sans aucun point : le serveur ne pouvait pas donner la quete au joueur",
     "-- qui entre dans sa zone (Player::UpdateBonusQuests via ObjectMgr::BonusQuestsRects).",
     f"-- {len(ids)} quetes (dont les 14 quetes d assaut d Azsuna), contour + points repris ensemble de TDB 735.00",
     "-- (TrinityCore, base officielle 7.3.5) pour rester coherents (Idx1). Rollback : ..._contours_rollback.sql", "",
     f"DELETE FROM quest_poi WHERE QuestID IN ({I});",
     f"DELETE FROM quest_poi_points WHERE QuestID IN ({I});", "",
     f"INSERT INTO quest_poi ({cols}) VALUES", ',\n'.join('(' + ', '.join(r) + ')' for r in poi) + ';', "",
     "INSERT INTO quest_poi_points (QuestID, Idx1, Idx2, X, Y, VerifiedBuild) VALUES", ',\n'.join('(' + ', '.join(r) + ')' for r in pts) + ';']
open(O + '.sql', 'w').write('\n'.join(L) + '\n')
R = ["-- Annule 2026_10_07_expeditions_contours.sql : remet les contours d avant (sans points)",
     f"DELETE FROM quest_poi WHERE QuestID IN ({I});", f"DELETE FROM quest_poi_points WHERE QuestID IN ({I});"]
if old:
    R += [f"INSERT INTO quest_poi ({cols}) VALUES", ',\n'.join('(' + ', '.join(r) + ')' for r in old) + ';']
open(O + '_rollback.sql', 'w').write('\n'.join(R) + '\n')
print(len(ids), 'quetes', len(poi), 'contours', len(pts), 'points', len(old), 'anciens contours sauvegardes')
