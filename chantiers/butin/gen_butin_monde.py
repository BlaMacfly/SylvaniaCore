#!/usr/bin/env python3
"""Butin, vol a la tire, depecage et or des PNJ poses chez nous qui n'ont rien, alors que LegionCore en a.

Usage (dans ~/tmp/butin) : gen_butin_monde.py > sortie.sql
Entrees : loot_ids.txt, pp_ids.txt, skin_ids.txt (PNJ poses, table vide chez nous, pleine chez LC) et les
extraits TDB 7.3.5 (tdb_<colonne>.txt : entree -> table TDB ; tdb_<table>.tsv : lignes TDB).
Source : la TDB 7.3.5 quand elle a des lignes pour le PNJ, sinon LegionCore.
Regles LegionCore :
- `lootmode` y est un masque de DIFFICULTE (bit 0 = normal, 0 = toutes) ; notre core tire toujours en mode 1 :
  on ne garde que les lignes valables en normal, mises en mode 1 ;
- references (tables LC absentes chez nous), devises (item < 0) et lignes a 0 % (butin personnel LC) ecartees ;
- chance negative = objet de quete ;
- boss ecartes (Guide d'aventure, rang 3, drapeau BOSS) : leur butin passe par le journal.
"""
import collections
import subprocess
import sys


def q(sql):
    out = subprocess.run(["mysql", "-N", "-B", "-e", sql], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit(out.stderr + sql)
    return [l.split("\t") for l in out.stdout.splitlines() if l]


def esc(s):
    return s.replace("\\", "\\\\").replace("'", "\\'")


def tdb_rows(path):
    try:
        rows = [l.rstrip("\n").split("\t") for l in open(path, encoding="utf-8", errors="replace")]
    except FileNotFoundError:
        return {}
    cols = rows[0]
    out = collections.defaultdict(list)
    for v in rows[1:]:
        d = dict(zip(cols, v))
        out[d["Entry"]].append(d)
    return out


KINDS = (("lootid", "creature_loot_template", "loot_ids.txt"),
         ("pickpocketloot", "pickpocketing_loot_template", "pp_ids.txt"),
         ("skinloot", "skinning_loot_template", "skin_ids.txt"))
journal = {r[0] for r in q("SELECT entry FROM dc_world.creature_template_journal")}
sql, stats = [], collections.Counter()
print("-- Butin, vol a la tire, depecage et or des PNJ poses qui n'avaient rien chez nous (gen_butin_monde.py).")
print("-- Source : TDB 7.3.5 si elle a des lignes, sinon LegionCore (lignes valables en difficulte normale ;")
print("-- references, devises et lignes a 0 % ecartees ; boss du Guide d'aventure ecartes).")
for col, table, idfile in KINDS:
    ids = open(idfile).read().split()
    tdb_of = dict(l.split() for l in open("tdb_%s.txt" % col) if l.strip())
    tdb = tdb_rows("tdb_%s.tsv" % table)
    info = {r[0]: r for r in q("SELECT d.entry, d.name, d.`rank`, d.type_flags, lt.%s, d.%s FROM dc_world.creature_template d "
                                "JOIN lc_world_ref.creature_template lt ON lt.entry=d.entry WHERE d.entry IN (%s)" % (col, col, ",".join(ids)))}
    used = {r[0] for r in q("SELECT DISTINCT Entry FROM dc_world.%s WHERE Entry IN (%s)" % (table, ",".join(ids)))}
    lc = collections.defaultdict(list)
    for r in q("SELECT entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount FROM lc_world_ref.%s "
               "WHERE entry IN (%s)" % (table, ",".join(sorted({info[e][4] for e in ids if e in info}, key=int)))):
        lc[r[0]].append(r)
    done, rows = [], []
    for e in ids:
        if e not in info:
            continue
        _, name, rank, tflags, lcid, ourid = info[e]
        if col == "lootid" and (e in journal or rank == "3" or int(tflags) & 4):
            stats["%s : boss ecarte" % table] += 1
            continue
        if e in used:
            stats["%s : entree deja occupee chez nous" % table] += 1
            continue
        items = {}
        src = "TDB"
        for d in tdb.get(tdb_of.get(e, "-"), []):
            if d["Reference"] not in ("0", "") or int(d["Item"]) <= 0:
                continue
            items[int(d["Item"])] = (float(d["Chance"]), int(d["QuestRequired"]), int(d["LootMode"]) or 1, int(d["GroupId"]),
                                     int(d["MinCount"]), int(d["MaxCount"]))
        if not items:
            src = "LC"
            for _, item, ch, lm, gid, mc, mx in lc.get(lcid, []):
                item, ch, lm, mc = int(item), float(ch), int(lm), int(mc)
                if mc < 0 or item <= 0 or ch == 0 or (lm and not lm & 1):
                    continue
                old = items.get(item)
                if old and old[0] >= abs(ch):
                    continue
                items[item] = (abs(ch), 1 if ch < 0 else 0, 1, int(gid), max(mc, 1), max(int(mx), mc, 1))
        if not items:
            stats["%s : rien de gardable" % table] += 1
            continue
        for item, (ch, qr, lm, gid, mc, mx) in sorted(items.items()):
            rows.append("(%s,%d,0,%g,%d,%d,%d,%d,%d,'%s (%s)')" % (e, item, ch, qr, lm, gid, mc, mx, esc(name), src))
        done.append(e)
        stats["%s : PNJ %s" % (table, src)] += 1
    if not done:
        continue
    print("\n-- %s : %d PNJ, %d lignes" % (table, len(done), len(rows)))
    print("INSERT INTO `%s` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES" % table)
    print(",\n".join(rows) + ";")
    print("UPDATE `creature_template` SET `%s`=`entry` WHERE `entry` IN (%s);" % (col, ",".join(done)))

# or : PNJ poses sans or chez nous, avec or chez LC
gold = q("SELECT d.entry, lt.mingold, lt.maxgold FROM dc_world.creature_template d JOIN lc_world_ref.creature_template lt ON lt.entry=d.entry "
         "WHERE d.mingold=0 AND d.maxgold=0 AND lt.maxgold>0 AND EXISTS (SELECT 1 FROM dc_world.creature c WHERE c.id=d.entry)")
print("\n-- Or : %d PNJ sans or chez nous, avec or chez LegionCore" % len(gold))
for e, mn, mx in gold:
    print("UPDATE `creature_template` SET `mingold`=%s, `maxgold`=%s WHERE `entry`=%s AND `mingold`=0 AND `maxgold`=0;" % (mn, mx, e))
stats["or"] = len(gold)
for k, v in sorted(stats.items()):
    print("%s : %d" % (k, v), file=sys.stderr)
