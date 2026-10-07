#!/usr/bin/env python3
# Assauts de la Legion : genere le SQL versionne d'une zone depuis LegionCore (lecture seule des bases).
# Usage : gen_assaut.py <zone> <nom_fichier>   ex. gen_assaut.py 7334 azsuna
import subprocess, sys, collections

ZONE, NOM = int(sys.argv[1]), sys.argv[2]
OUT = '/home/ubuntu/DestinyCore/sql/sylvania/2026_10_07_assaut_%s' % NOM

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.strip().split('\n') if l]

# ---- 1. calques de LegionCore pour la zone, rattaches a une quete d assaut (139/142) par une condition simple
assault = {r[0]: r for r in q(f"SELECT ID, QuestInfoID, IFNULL(LogTitle,'') FROM dc_world.quest_template WHERE QuestInfoID IN (139,142) AND QuestSortID={ZONE}")}
defs = q(f"SELECT entry, phaseId FROM lc_world_ref.phase_definitions WHERE zoneId={ZONE}")
conds = collections.defaultdict(list)
for se, ct, v1, neg, eg in q(f"""SELECT SourceEntry, ConditionTypeOrReference, ConditionValue1, NegativeCondition, ElseGroup
                                  FROM lc_world_ref.conditions WHERE SourceTypeOrReferenceId=23 AND SourceGroup={ZONE}"""):
    conds[se].append((ct, v1, neg, eg))

phases = {}   # phaseId -> liste de (type, quete, negation, elsegroup)
for entry, ph in defs:
    if ' ' in ph.strip():
        continue                                  # calques multiples = decor de base de la zone, deja chez nous
    c = conds.get(entry, [])
    if not c or not all(v1 in assault and ct in ('9', '14') for ct, v1, neg, eg in c):
        continue                                  # seulement les calques pilotes par une quete d assaut
    phases[ph.strip()] = c

# calques multiples pilotes par une quete d assaut : LegionCore y range les demons de certaines quetes
# (son moteur accepte plusieurs calques par creature, pas le notre). On prend leurs cibles absentes chez nous
# et on les met dans un calque libre de la zone, allume par la meme condition.
borrowed = {}   # calque emprunte -> chaine de calques LegionCore
used_here = {r[0] for r in q(f"SELECT PhaseId FROM dc_world.phase_area WHERE AreaId={ZONE}")} | \
            {r[0] for r in q(f"SELECT DISTINCT PhaseId FROM dc_world.creature WHERE zoneId={ZONE}")}
pool = [p for p in ['6209', '6210', '6212', '6214', '6216', '6159', '6160', '6161', '6162', '6163', '7502', '7503', '7504', '7505']
        if p not in phases and p not in used_here]
for entry, ph in defs:
    c = conds.get(entry, [])
    if ' ' not in ph.strip() or not c or not all(v1 in assault and ct == '9' for ct, v1, neg, eg in c):
        continue
    if not pool:
        print('plus de calque libre pour', ph); continue
    p = pool.pop(0)
    phases[p] = c
    borrowed[p] = ph.strip()

PH = ','.join('"%s"' % p for p in phases)
# ---- 2. apparitions LegionCore dans ces calques
start_c = int(q("SELECT MAX(guid)+1 FROM dc_world.creature")[0][0])
cre = q(f"""SELECT c.id, c.map, c.zoneId, c.areaId, c.PhaseId, c.position_x, c.position_y, c.position_z, c.orientation,
                   c.spawntimesecs, c.spawndist, IF(c.MovementType=2,0,c.MovementType),
                   IF(c.equipment_id>0 AND EXISTS(SELECT 1 FROM dc_world.creature_equip_template e WHERE e.CreatureID=c.id AND e.ID=c.equipment_id), c.equipment_id, 0),
                   t.name
            FROM lc_world_ref.creature c JOIN dc_world.creature_template t ON t.entry=c.id
            WHERE c.map=1220 AND c.zoneId IN ({ZONE},0) AND c.PhaseId IN ({PH}) ORDER BY c.PhaseId, c.id, c.guid""")
# demons des calques multiples : seulement les cibles des quetes concernees, absentes de notre monde
deja = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.creature")}
for p, ph in borrowed.items():
    quests = ','.join(sorted({v1 for ct, v1, neg, eg in phases[p]}))
    rows = q(f"""SELECT c.id, c.map, c.zoneId, c.areaId, '{p}', c.position_x, c.position_y, c.position_z, c.orientation,
                   c.spawntimesecs, c.spawndist, IF(c.MovementType=2,0,c.MovementType),
                   IF(c.equipment_id>0 AND EXISTS(SELECT 1 FROM dc_world.creature_equip_template e WHERE e.CreatureID=c.id AND e.ID=c.equipment_id), c.equipment_id, 0),
                   t.name
            FROM lc_world_ref.creature c JOIN dc_world.creature_template t ON t.entry=c.id
            WHERE c.map=1220 AND c.PhaseId='{ph}'
              AND c.id IN (SELECT ObjectID FROM dc_world.quest_objectives WHERE Type=0 AND QuestID IN ({quests}))
            ORDER BY c.id, c.guid""")
    rows = [r for r in rows if r[0] not in deja]
    print('calque emprunte', p, 'pour', quests, ':', len(rows), 'creatures')
    cre += rows
start_g = int(q("SELECT MAX(guid)+1 FROM dc_world.gameobject")[0][0])
gob = q(f"""SELECT g.id, g.map, g.zoneId, g.areaId, g.PhaseId, g.position_x, g.position_y, g.position_z, g.orientation,
                   g.rotation0, g.rotation1, g.rotation2, g.rotation3, g.spawntimesecs, g.animprogress, g.state
            FROM lc_world_ref.gameobject g JOIN dc_world.gameobject_template t ON t.entry=g.id
            WHERE g.map=1220 AND g.zoneId IN ({ZONE},0) AND g.PhaseId IN ({PH}) ORDER BY g.PhaseId, g.id, g.guid""")

# ---- 3. quetes jouables : toutes leurs cibles (monstres / objets) existent, dans le monde ou dans ces calques
spawned = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.creature")} | {r[0] for r in cre}
credit = set()
for e, k1, k2 in q("SELECT entry, KillCredit1, KillCredit2 FROM dc_world.creature_template WHERE KillCredit1<>0 OR KillCredit2<>0"):
    if e in spawned: credit |= {k1, k2}
gos = {r[0] for r in q("SELECT DISTINCT id FROM dc_world.gameobject")} | {r[0] for r in gob}
objs = collections.defaultdict(list)
for qid, t, oid, fl in q(f"SELECT QuestID, Type, ObjectID, Flags FROM dc_world.quest_objectives WHERE QuestID IN ({','.join(assault)})"):
    objs[qid].append((t, oid, int(fl)))
upd = {}
for qid, timer, var, val, vb in q(f"SELECT QuestID, Timer, VariableID, Value, VerifiedBuild FROM lc_world_ref.world_quest_update WHERE QuestID IN ({','.join(assault)}) AND EventID=0"):
    if qid not in upd or int(vb) > int(upd[qid][3]): upd[qid] = (timer, var, val, vb)
jouables, refus = [], []
for qid in sorted(assault, key=int):
    o = objs.get(qid, [])
    def dispo(t, oid):
        return (t == '0' and (oid in spawned or oid in credit)) or (t == '2' and oid in gos) or t not in ('0', '2')
    # requis : ni optionnel (0x04) ni contribution a la barre de progression (0x40)
    requis = [(t, oid) for t, oid, fl in o if t != '15' and not fl & 0x44]
    barre = [(t, oid) for t, oid, fl in o if fl & 0x40]
    ok = bool(o) and qid in upd and all(dispo(t, oid) for t, oid in requis) \
         and (not any(t == '15' for t, _, _ in o) or any(dispo(t, oid) for t, oid in barre))
    (jouables if ok else refus).append(qid)

# second passage : on ne pose que les calques dont au moins une quete pilote est jouable
garde = {p: c for p, c in phases.items() if any(v1 in jouables for ct, v1, neg, eg in c)}
if len(garde) != len(phases):
    phases = garde
    PH = ','.join('"%s"' % p for p in phases)
    cre = [r for r in cre if r[4] in phases]
    gob = [r for r in gob if r[4] in phases]

# ---- 4. calques deja presents dans la zone chez nous (portages precedents)
exist = {r[0] for r in q(f"SELECT PhaseId FROM dc_world.phase_area WHERE AreaId={ZONE}")}
ourcond = collections.defaultdict(set)
for sg, ct, v1 in q(f"SELECT SourceGroup, ConditionTypeOrReference, ConditionValue1 FROM dc_world.conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry={ZONE}"):
    ourcond[sg].add((ct, v1))
ourcre = {r[0] for r in q(f"SELECT DISTINCT PhaseId FROM dc_world.creature WHERE zoneId={ZONE}")}
skip_insert = set()
pool = [x for x in pool if x not in phases]
for p in list(phases):
    if p not in exist:
        continue
    if all((ct, v1) in ourcond[p] for ct, v1, neg, eg in phases[p]):
        skip_insert.add(p)                         # deja relie a la meme quete : on ne double rien
        if p in ourcre:
            cre = [r for r in cre if r[4] != p]
            gob = [r for r in gob if r[4] != p]
        print('calque', p, 'deja en place, reutilise')
    else:
        n = pool.pop(0)                            # calque occupe par autre chose : on en prend un libre
        cre = [r[:4] + [n] + r[5:] if r[4] == p else r for r in cre]
        gob = [r[:4] + [n] + r[5:] if r[4] == p else r for r in gob]
        phases[n] = phases.pop(p)
        print('calque', p, 'occupe, remplace par', n)

L = [f"-- Assaut de la Legion, zone {ZONE} ({NOM}) : contenu repris de LegionCore (lc_world_ref).",
     f"-- {len(phases)} calques pilotes par les quetes d assaut ; {len(cre)} creatures et {len(gob)} objets ;",
     f"-- {len(jouables)} quetes d assaut jouables inscrites au registre (activees seulement pendant l assaut, voir WorldQuestMgr).",
     f"-- Non inscrites (cibles absentes) : {', '.join(assault[x][2] for x in refus) or 'aucune'}.",
     f"-- Rollback : 2026_10_07_assaut_{NOM}_rollback.sql", ""]
L.append("INSERT INTO creature (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap, modelid, equipment_id,")
L.append("  position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag,")
L.append("  unit_flags, unit_flags2, unit_flags3, dynamicflags, ScriptName, movementmode, VerifiedBuild) VALUES")
for i, r in enumerate(cre):
    cid, m, z, a, ph, x, y, zz, o, rs, dist, mt, eq, name = r
    L.append(f"({start_c+i}, {cid}, {m}, {ZONE}, {a}, '0', 0, {ph}, 0, -1, 0, {eq}, {x}, {y}, {zz}, {o}, {rs}, {dist}, 0, 1, 0, {mt}, 0, 0, 0, 0, 0, '', 0, 0)"
             + (',' if i < len(cre) - 1 else ';') + f" -- {name}")
if gob:
    L += ["", "INSERT INTO gameobject (guid, id, map, zoneId, areaId, spawnDifficulties, phaseUseFlags, PhaseId, PhaseGroup, terrainSwapMap,",
          "  position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state, isActive, ScriptName, VerifiedBuild) VALUES"]
    for i, r in enumerate(gob):
        gid, m, z, a, ph, x, y, zz, o, r0, r1, r2, r3, rs, ap, st = r
        L.append(f"({start_g+i}, {gid}, {m}, {ZONE}, {a}, '0', 0, {ph}, 0, -1, {x}, {y}, {zz}, {o}, {r0}, {r1}, {r2}, {r3}, {rs}, {ap}, {st}, 0, '', 0)"
                 + (',' if i < len(gob) - 1 else ';'))
nouv = [p for p in phases if p not in skip_insert]
if nouv:
    L += ["", "INSERT INTO phase_area (AreaId, PhaseId, Comment) VALUES"]
    L.append(',\n'.join(f"({ZONE}, {p}, 'Assaut de la Legion - quete(s) {'/'.join(sorted({c[1] for c in phases[p]}))}')" for p in nouv) + ';')
    L += ["", "INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget,",
          "  ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, Comment) VALUES"]
    crow = [f"(26, {p}, {ZONE}, 0, {eg}, {ct}, 0, {v1}, 0, 0, {neg}, 0, 0, '', 'Assaut {NOM} : calque {p}')" for p in nouv for ct, v1, neg, eg in phases[p]]
    L.append(',\n'.join(crow) + ';')
L += ["", "-- contours de quete (sans eux le joueur ne recoit pas l expedition en entrant dans la zone)",
      f"INSERT IGNORE INTO quest_poi SELECT * FROM lc_world_ref.quest_poi WHERE QuestID IN ({','.join(jouables)});",
      f"INSERT IGNORE INTO quest_poi_points SELECT * FROM lc_world_ref.quest_poi_points WHERE QuestID IN ({','.join(jouables)});",
      "", "INSERT INTO world_quest (id, duration, variable, value) VALUES"]
L.append(',\n'.join(f"({x}, {upd[x][0]}, {upd[x][1]}, {upd[x][2]})" for x in jouables) + ';')
open(OUT + '.sql', 'w').write('\n'.join(L) + '\n')

# contours deja presents avant ce fichier : le rollback ne doit pas les supprimer
J = ','.join(jouables)
poi_new = sorted(set(jouables) - {r[0] for r in q(f"SELECT DISTINCT QuestID FROM dc_world.quest_poi WHERE QuestID IN ({J})")}, key=int)
pts_new = sorted(set(jouables) - {r[0] for r in q(f"SELECT DISTINCT QuestID FROM dc_world.quest_poi_points WHERE QuestID IN ({J})")}, key=int)
deja_reg = {r[0] for r in q(f"SELECT id FROM dc_world.world_quest WHERE id IN ({J})")}
assert not deja_reg, ('deja au registre', deja_reg)
R = [f"-- Annule 2026_10_07_assaut_{NOM}.sql",
     f"DELETE FROM creature WHERE guid BETWEEN {start_c} AND {start_c+len(cre)-1};",
     f"DELETE FROM gameobject WHERE guid BETWEEN {start_g} AND {start_g+len(gob)-1};" if gob else "",
     f"DELETE FROM phase_area WHERE AreaId={ZONE} AND Comment LIKE 'Assaut de la Legion%';",
     f"DELETE FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry={ZONE} AND Comment LIKE 'Assaut {NOM} :%';",
     (f"DELETE FROM quest_poi WHERE QuestID IN ({','.join(poi_new)});" if poi_new else ""),
     (f"DELETE FROM quest_poi_points WHERE QuestID IN ({','.join(pts_new)});" if pts_new else ""),
     f"DELETE FROM world_quest WHERE id IN ({','.join(jouables)});"]
open(OUT + '_rollback.sql', 'w').write('\n'.join(x for x in R if x) + '\n')
print('calques', sorted(phases), '\ncreatures', len(cre), 'objets', len(gob))
print('jouables', [(x, assault[x][1], assault[x][2]) for x in jouables])
print('refusees', [(x, assault[x][2]) for x in refus])
