#!/usr/bin/env python3
"""Phasage d'une zone exterieure depuis LegionCore (lc_world_ref) vers dc_world.

Usage : port_phasage_zone.py <zoneId> [<map>] [--exclure id,id,...] [--sans-phases id,id,...]
--sans-phases : phases LC non portees (invasions 7.2 sans donneur chez nous...) ; les definitions LC qui les
contiennent sont des releves pris pendant ce contenu et sont ignorees pour toutes leurs phases, et les spawns qui
les portent ne sont ni ajoutes ni rephases.
--exclure : PNJ/objets dont on ne touche pas les spawns (donnees LC incompletes, voir verif_phasage.py)
Produit phasage_<zone>.sql et phasage_<zone>.log dans le repertoire courant.

LegionCore : phase_definitions (zone, entry, liste de phases) + conditions de type 23 ; toutes les
definitions dont les conditions sont remplies s'ajoutent. Chez nous : phase_area (aire, phase) +
conditions de type 26, ElseGroup = OU. Une phase recoit donc, en OU, les groupes de conditions de
toutes les definitions LC qui la contiennent.

Les spawns phases de LC sont rapproches des notres (meme id, < 5 m) ; nos spawns sans phase prennent
la phase LC. Un ensemble de phases sans groupe client recoit un groupe maison dans
dc_hotfixes.phase_x_phase_group (la visibilite des PNJ ne se decide que cote serveur).
Les spawns phases de LC absents chez nous sont ajoutes avec des GUID neufs.
"""
import collections, csv, math, re, subprocess, sys

LC, DC, HF = "lc_world_ref", "dc_world", "dc_hotfixes"
ZONE = int(sys.argv[1])
MAP = int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2].isdigit() else 1220
EXCLURE = {int(x) for x in sys.argv[sys.argv.index("--exclure") + 1].split(",")} if "--exclure" in sys.argv else set()
SANS_PHASES = {int(x) for x in sys.argv[sys.argv.index("--sans-phases") + 1].split(",")} if "--sans-phases" in sys.argv else set()
KEEP_PHASES = {4741}          # phases faites a la main chez nous : jamais retouchees
SAME_TYPES = set(range(1, 19)) | {20, 22, 23, 25, 27, 28, 29, 30, 33, 34, 35, 36, 37, 38}

def unesc(v):
    if v == "NULL":
        return None
    return v.replace("\\t", "\t").replace("\\n", "\n").replace("\\0", "\0").replace("\\\\", "\\")

def q(db, sql):
    out = subprocess.run(["mysql", db, "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit("SQL %s : %s\n%s" % (db, out.stderr, sql))
    lines = out.stdout.split("\n")
    if not lines or not lines[0]:
        return []
    cols = lines[0].split("\t")
    return [dict(zip(cols, map(unesc, l.split("\t")))) for l in lines[1:] if l != ""]

def ids(xs):
    xs = sorted(set(int(x) for x in xs))
    return ",".join(map(str, xs)) if xs else "NULL"

def lit(v):
    if v is None:
        return "NULL"
    if isinstance(v, (int, float)):
        return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"

def ins(table, row):
    return "INSERT INTO `%s` (%s) VALUES (%s);" % (
        table, ",".join("`%s`" % k for k in row), ",".join(lit(v) for v in row.values()))

sql, log = [], []
def L(*a):
    log.append(" ".join(str(x) for x in a))

# ---------------------------------------------------------------- donnees client
# seules les phases cosmetiques (0x10) sont portees : chez nous (TC), un joueur qui porte une phase non
# cosmetique ne voit plus les objets sans phase, alors que chez LC il les voit toujours
phases_ok = {int(r["ID"]) for r in csv.DictReader(open("/home/ubuntu/tmp/Phase.csv")) if int(r["Flags"]) & 0x10}
groups = collections.defaultdict(set)
for r in csv.DictReader(open("/home/ubuntu/tmp/PhaseXPhaseGroup.csv")):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
for r in q(HF, "SELECT PhaseID,PhaseGroupID FROM phase_x_phase_group"):
    groups[int(r["PhaseGroupID"])].add(int(r["PhaseID"]))
group_of = {frozenset(v): k for k, v in groups.items()}
next_group = max(10001, max(groups) + 1)
next_pxg_id = max(200000, int(q(HF, "SELECT COALESCE(MAX(ID),0) m FROM phase_x_phase_group")[0]["m"]) + 1)
new_groups = {}

sql.append("-- Phasage de la zone %d (carte %d) depuis LegionCore" % (ZONE, MAP))

# ---------------------------------------------------------------- 1. phases et conditions
defs = q(LC, "SELECT entry,phaseId,comment FROM phase_definitions WHERE zoneId=%d ORDER BY entry" % ZONE)
for d in [d for d in defs if {int(x) for x in d["phaseId"].split()} & SANS_PHASES]:
    L("DEF %s (%s) ignoree : contient une phase non portee" % (d["entry"], d["comment"]))
defs = [d for d in defs if not {int(x) for x in d["phaseId"].split()} & SANS_PHASES]
lc_cond = collections.defaultdict(list)
for c in q(LC, "SELECT * FROM conditions WHERE SourceTypeOrReferenceId=23 AND SourceGroup=%d" % ZONE):
    lc_cond[int(c["SourceEntry"])].append(c)
objectives = {(int(r["QuestID"]), int(r["ObjectID"])): r for r in q(DC, "SELECT ID,QuestID,ObjectID,Amount FROM quest_objectives")}

def translate(d):
    """Groupes (ElseGroup -> conditions traduites) d'une definition ; None = toujours vraie ; False = intraduisible."""
    cs = lc_cond.get(int(d["entry"]))
    if not cs:
        return None
    out = collections.defaultdict(list)
    for c in cs:
        t, v1, v2, v3 = (int(c[k]) for k in ("ConditionTypeOrReference", "ConditionValue1", "ConditionValue2", "ConditionValue3"))
        if t == 41:  # LC : (quete, ObjectID) avance -> chez nous 48 (ID d'objectif accompli)
            o = objectives.get((v1, v2))
            if not o:
                L("DEF %s : objectif %d/%d introuvable" % (d["entry"], v1, v2))
                return False
            if int(o["Amount"]) > max(v3, 1):
                L("DEF %s : objectif %s (%d/%d) seuil LC %d < %s, approxime par 'accompli'" % (d["entry"], o["ID"], v1, v2, v3, o["Amount"]))
            t, v1, v2, v3 = 48, int(o["ID"]), 0, 0
        elif t not in SAME_TYPES:
            L("DEF %s : condition LC de type %d non traduite" % (d["entry"], t))
            return False
        out[int(c["ElseGroup"])].append({"ConditionTypeOrReference": t, "ConditionTarget": int(c["ConditionTarget"]),
            "ConditionValue1": v1, "ConditionValue2": v2, "ConditionValue3": v3, "NegativeCondition": int(c["NegativeCondition"])})
    return [out[k] for k in sorted(out)]

by_phase = collections.defaultdict(list)   # phase -> [definition]
for d in defs:
    for p in d["phaseId"].split():
        p = int(p)
        if p not in phases_ok:
            L("PHASE %d (def %s) absente de Phase.db2 ou non cosmetique, ignoree" % (p, d["entry"]))
            continue
        by_phase[p].append(d)

# LC a des definitions sans condition (modeles jamais remplis, ex. « Highmountain - if has 39733 ») : leurs phases
# sont donnees a tout le monde. Chez LC un spawn est visible des qu'UNE de ses phases est active, donc les spawns
# releves avec ces phases de base en plus de leur phase propre (invasions 7.2 de Haut-Mont) y sont visibles en
# permanence. On retire ces phases de base des spawns qui en ont une autre, et elles ne levent pas les conditions
# de nos phases existantes.
base_ph = {p for p, ds in by_phase.items() if any(not lc_cond.get(int(d["entry"])) for d in ds)}
if base_ph:
    L("PHASES DE BASE (definition LC sans condition) : %s" % " ".join(map(str, sorted(base_ph))))

exist = {int(r["PhaseId"]): r["Comment"] or "" for r in q(DC, "SELECT PhaseId,Comment FROM phase_area WHERE AreaId=%d" % ZONE)}
exist_cond = collections.defaultdict(list)
for c in q(DC, "SELECT * FROM conditions WHERE SourceTypeOrReferenceId=26 AND SourceEntry=%d" % ZONE):
    exist_cond[int(c["SourceGroup"])].append(c)

active = set()   # phases que la zone peut donner apres portage
n_new = n_ext = 0
sql.append("\n-- 1. Phases de la zone")
for p, ds in sorted(by_phase.items()):
    if p in KEEP_PHASES:
        L("PHASE %d gardee telle quelle (faite a la main)" % p)
        active.add(p)
        continue
    if p in exist:
        if not exist_cond[p]:
            active.add(p)
            continue  # deja toujours active
        covered = {int(m) for c in exist_cond[p] for m in re.findall(r"LC (\d+) :", c["Comment"] or "")}
        # les portages precedents (campagnes, assauts) ne prenaient que les definitions a phase unique
        todo = [d for d in ds if int(d["entry"]) not in covered and len(d["phaseId"].split()) > 1 and lc_cond.get(int(d["entry"]))]
        eg = 1 + max(int(c["ElseGroup"]) for c in exist_cond[p])
    else:
        todo, eg = ds, 0
    rows, always = [], False
    for d in todo:
        g = translate(d)
        if g is False:
            continue
        if g is None:
            always = True
            break
        for grp in g:
            for c in grp:
                rows.append(dict({"SourceTypeOrReferenceId": 26, "SourceGroup": p, "SourceEntry": ZONE, "SourceId": 0, "ElseGroup": eg},
                                 **c, ErrorType=0, ErrorTextId=0, ScriptName="",
                                 Comment="LC %s : %s" % (d["entry"], (d["comment"] or "")[:60])))
            eg += 1
    if p not in exist:
        if not always and not rows:
            L("PHASE %d : aucune definition traduisible, non portee" % p)
            continue
        sql.append(ins("phase_area", {"AreaId": ZONE, "PhaseId": p,
                   "Comment": ("LC: " + " / ".join(sorted({(d["comment"] or "").strip() for d in ds if d["comment"]})))[:250]}))
        n_new += 1
        if always:
            rows = []
    elif always:
        sql.append("DELETE FROM `conditions` WHERE SourceTypeOrReferenceId=26 AND SourceGroup=%d AND SourceEntry=%d; -- definition LC sans condition" % (p, ZONE))
        rows = []
        n_ext += 1
    elif rows:
        n_ext += 1
    active.add(p)
    for c in rows:
        sql.append(ins("conditions", c))
L("PHASES : %d nouvelles, %d completees, %d actives au total" % (n_new, n_ext, len(active)))

# ---------------------------------------------------------------- 2. spawns
def phase_fields(phs, what):
    if phs & SANS_PHASES:
        return 0, 0
    phs = {p for p in phs if p in phases_ok}
    if phs - base_ph:
        phs -= base_ph
    if not phs:
        return 0, 0
    if len(phs) == 1:
        return next(iter(phs)), 0
    fs = frozenset(phs)
    g = group_of.get(fs)
    if g is None:
        global next_group
        g = group_of[fs] = new_groups[fs] = next_group
        next_group += 1
    return 0, g

def difficulties(mask):
    mask = int(mask)
    return ",".join(str(i) for i in range(64) if mask >> i & 1) or "0"

nextguid = {t: int(q(DC, "SELECT MAX(guid) m FROM %s" % t)[0]["m"]) + 1000 for t in ("creature", "gameobject")}
templates = {"creature": {int(r["entry"]) for r in q(DC, "SELECT entry FROM creature_template")},
             "gameobject": {int(r["entry"]) for r in q(DC, "SELECT entry FROM gameobject_template")}}
new_creatures = {}
for table in ("creature", "gameobject"):
    lc_rows = q(LC, "SELECT * FROM `%s` WHERE map=%d AND zoneId=%d" % (table, MAP, ZONE))
    ours = collections.defaultdict(list)
    for r in q(DC, "SELECT guid,id,PhaseId,PhaseGroup,position_x,position_y,position_z FROM `%s` WHERE map=%d AND zoneId=%d" % (table, MAP, ZONE)):
        ours[int(r["id"])].append(r)
    lc_by_id = collections.defaultdict(list)
    for r in lc_rows:
        r["ph"] = {int(x) for x in r["PhaseId"].split()}
        r["pos"] = (float(r["position_x"]), float(r["position_y"]), float(r["position_z"]))
        lc_by_id[int(r["id"])].append(r)
    sql.append("\n-- 2. Spawns %s" % table)
    rephased = added = orphans = 0
    used = set()
    for i, mine in ours.items():
        cands = lc_by_id.get(i, [])
        if not cands or i in EXCLURE:
            continue
        pending = []
        for o in mine:
            pos = (float(o["position_x"]), float(o["position_y"]), float(o["position_z"]))
            best = min(cands, key=lambda r: math.dist(r["pos"], pos))
            if math.dist(best["pos"], pos) < 5:
                used.add(best["guid"])
                if best["ph"] and not int(o["PhaseId"]) and not int(o["PhaseGroup"]):
                    pid, pg = phase_fields(best["ph"], table)
                    if pid or pg:
                        sql.append("UPDATE `%s` SET PhaseId=%d, PhaseGroup=%d WHERE guid=%s; -- id %d (LC %s)" % (table, pid, pg, o["guid"], i, best["guid"]))
                        rephased += 1
            elif not int(o["PhaseId"]) and not int(o["PhaseGroup"]):
                pending.append((o, pos))
        # nos spawns sans equivalent proche : si LC ne pose ce PNJ QUE phase, c'est un doublon visible de tous
        # (il offrirait ses quetes hors de l'ordre) : il prend la phase du spawn LC le plus proche, qui n'est
        # alors pas ajoute
        if pending and all(r["ph"] for r in cands):
            for o, pos in pending:
                free = [r for r in cands if r["guid"] not in used] or cands
                best = min(free, key=lambda r: math.dist(r["pos"], pos))
                used.add(best["guid"])
                pid, pg = phase_fields(best["ph"], table)
                if pid or pg:
                    sql.append("UPDATE `%s` SET PhaseId=%d, PhaseGroup=%d WHERE guid=%s; -- id %d orphelin, phase de LC %s a %.0f m" % (table, pid, pg, o["guid"], i, best["guid"], math.dist(best["pos"], pos)))
                    orphans += 1
                    if math.dist(best["pos"], pos) > 30:
                        L("SPAWN %s guid %s id %d : orphelin a %.0f m du spawn LC %s, phase reprise" % (table, o["guid"], i, math.dist(best["pos"], pos), best["guid"]))
        elif pending:
            for o, pos in pending:
                best = min(cands, key=lambda r: math.dist(r["pos"], pos))
                if best["ph"] and math.dist(best["pos"], pos) < 30:
                    L("SPAWN %s guid %s id %d : sans phase, LC le pose aussi sans phase ailleurs ; plus proche LC %s phase a %.0f m, laisse visible" % (table, o["guid"], i, best["guid"], math.dist(best["pos"], pos)))
    for r in lc_rows:
        if not r["ph"] or r["guid"] in used:
            continue
        i = int(r["id"])
        if i in EXCLURE:
            continue
        if i >= 400000 or i not in templates[table]:
            L("SPAWN %s LC %s id %d : modele absent chez nous" % (table, r["guid"], i))
            continue
        if r["ph"] & SANS_PHASES:
            L("SPAWN %s LC %s id %d : phase non portee %s" % (table, r["guid"], i, sorted(r["ph"] & SANS_PHASES)))
            continue
        if not (r["ph"] & phases_ok):
            L("SPAWN %s LC %s id %d : phases %s absentes de Phase.db2 ou non cosmetiques" % (table, r["guid"], i, sorted(r["ph"])))
            continue
        near = [o for o in ours.get(i, []) if math.dist(r["pos"], (float(o["position_x"]), float(o["position_y"]), float(o["position_z"]))) < 30]
        if near:  # LC pose ce PNJ aussi sans phase et le notre est deja la : pas de doublon
            L("SPAWN %s LC %s id %d : non ajoute, notre guid %s est a %.0f m" % (table, r["guid"], i, near[0]["guid"],
              math.dist(r["pos"], (float(near[0]["position_x"]), float(near[0]["position_y"]), float(near[0]["position_z"])))))
            continue
        pid, pg = phase_fields(r["ph"], table)
        g = nextguid[table]; nextguid[table] += 1
        base = {"guid": g, "id": i, "map": MAP, "zoneId": ZONE, "areaId": int(r["areaId"]),
                "spawnDifficulties": difficulties(r["spawnMask"]), "phaseUseFlags": 0, "PhaseId": pid, "PhaseGroup": pg,
                "terrainSwapMap": -1, "position_x": r["pos"][0], "position_y": r["pos"][1], "position_z": r["pos"][2],
                "orientation": float(r["orientation"]), "spawntimesecs": int(r["spawntimesecs"])}
        if table == "creature":
            mt = int(r["MovementType"])
            if mt == 2:
                mt = 0
                L("SPAWN creature %d (id %d, LC %s) : chemin LC non porte, immobile" % (g, i, r["guid"]))
            base.update({"modelid": int(r["modelid"]), "equipment_id": int(r["equipment_id"]), "spawndist": float(r["spawndist"]) if mt == 1 else 0,
                         "currentwaypoint": 0, "curhealth": int(r["curhealth"]), "curmana": int(r["curmana"]), "MovementType": mt,
                         "npcflag": int(r["npcflag"]), "unit_flags": int(r["unit_flags"]), "unit_flags2": 0, "unit_flags3": int(r["unit_flags3"]),
                         "dynamicflags": int(r["dynamicflags"]), "ScriptName": "", "movementmode": 0, "VerifiedBuild": 0})
            new_creatures[int(r["guid"])] = g
        else:
            base.update({"rotation0": float(r["rotation0"]), "rotation1": float(r["rotation1"]), "rotation2": float(r["rotation2"]),
                         "rotation3": float(r["rotation3"]), "animprogress": int(r["animprogress"]), "state": int(r["state"]),
                         "isActive": int(r["isActive"]), "ScriptName": "", "VerifiedBuild": 0})
        sql.append(ins(table, base) + " -- LC %s phases %s" % (r["guid"], " ".join(map(str, sorted(r["ph"])))))
        added += 1
    L("SPAWNS %s : %d rephases, %d orphelins rephases, %d ajoutes" % (table, rephased, orphans, added))

if new_creatures:
    sql.append("\n-- creature_addon des spawns ajoutes")
    for r in q(LC, "SELECT * FROM creature_addon WHERE guid IN (%s)" % ids(new_creatures)):
        sql.append(ins("creature_addon", {"guid": new_creatures[int(r["guid"])], "path_id": 0, "mount": int(r["mount"]), "bytes1": int(r["bytes1"]),
                   "bytes2": int(r["bytes2"]), "emote": int(r["emote"]), "aiAnimKit": 0, "movementAnimKit": 0, "meleeAnimKit": 0,
                   "visibilityDistanceType": 0, "auras": r["auras"] or ""}))

# ---------------------------------------------------------------- 3. groupes de phases maison (base hotfixes)
hf = ["-- Groupes de phases maison pour le phasage de la zone %d (ensembles LC sans groupe client)" % ZONE]
for fs, g in sorted(new_groups.items(), key=lambda x: x[1]):
    for p in sorted(fs):
        hf.append("INSERT INTO `phase_x_phase_group` (`ID`,`PhaseID`,`PhaseGroupID`,`VerifiedBuild`) VALUES (%d,%d,%d,0);" % (next_pxg_id, p, g))
        next_pxg_id += 1
L("GROUPES maison : %d (%s)" % (len(new_groups), ", ".join("%d=%s" % (g, "/".join(map(str, sorted(fs)))) for fs, g in sorted(new_groups.items(), key=lambda x: x[1]))))

open("phasage_%d.sql" % ZONE, "w").write("\n".join(sql) + "\n")
open("phasage_%d_hotfixes.sql" % ZONE, "w").write("\n".join(hf) + "\n")
open("phasage_%d.log" % ZONE, "w").write("\n".join(log) + "\n")
print("phasage_%d.sql : %d lignes ; hotfixes : %d ; log : %d remarques" % (ZONE, len(sql), len(hf) - 1, len(log)))
