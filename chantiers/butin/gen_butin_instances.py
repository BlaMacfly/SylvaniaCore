#!/usr/bin/env python3
# Butin des monstres d'instances Legion absent chez nous : repris de LegionCore (creature_loot_template).
# Regle : PNJ pose chez nous sur la carte, sans butin chez nous (lootid nul ou table vide), avec butin chez LC,
# et qui n'est pas un boss du Guide d'aventure (creature_template_journal) ni un boss (rang 3 ou type_flags BOSS) : ceux-la sont listes a part.
import subprocess, sys
MAPS = (1712, 1648, 1651, 1677, 1516, 1493, 1676, 1530, 1520, 1456, 1458, 1477, 1492, 1571)
def q(sql):
    out = subprocess.run(['mysql', '-N', '-B', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.splitlines() if l]
maps = ','.join(map(str, MAPS))
cands = q(f"""SELECT DISTINCT d.entry, d.name, IF(d.type_flags & 4, 3, d.`rank`), lt.lootid, d.lootid,
  (SELECT MIN(map) FROM dc_world.creature c2 WHERE c2.id=d.entry AND c2.map IN ({maps}))
  FROM dc_world.creature c JOIN dc_world.creature_template d ON d.entry=c.id
  JOIN lc_world_ref.creature_template lt ON lt.entry=d.entry
  WHERE c.map IN ({maps}) AND lt.lootid<>0
  AND EXISTS (SELECT 1 FROM lc_world_ref.creature_loot_template l WHERE l.entry=lt.lootid)
  AND (d.lootid=0 OR NOT EXISTS (SELECT 1 FROM dc_world.creature_loot_template l2 WHERE l2.Entry=d.lootid))
  AND d.entry NOT IN (SELECT entry FROM dc_world.creature_template_journal)""")
rows, set_loot, skipped, bymap = [], [], [], {}
for entry, name, rank, lclid, dclid, mp in cands:
    if rank == '3':
        skipped.append((entry, name, mp)); continue
    exist = q(f"SELECT COUNT(*) FROM dc_world.creature_loot_template WHERE Entry={entry}")[0][0]
    if exist != '0':
        set_loot.append(entry); bymap[mp] = bymap.get(mp, 0) + 1; continue
    n = 0
    for item, ch, lm, gid, mc, mx in q(f"SELECT item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount FROM lc_world_ref.creature_loot_template WHERE entry={lclid}"):
        item, ch, lm, gid, mc, mx = int(item), float(ch), int(lm), int(gid), int(mc), int(mx)
        if mc < 0 or item <= 0 or ch == 0:   # references, devises, lignes a 0 % (butin personnel de LC)
            continue
        quest = 1 if ch < 0 else 0
        if lm == 0 or not (lm & 1):
            lm = 1
        rows.append(f"({entry},{item},0,{abs(ch):g},{quest},{lm},{gid},{mc},{mx},'{name.replace(chr(39), chr(39)*2)} (LC)')")
        n += 1
    if n:
        set_loot.append(entry); bymap[mp] = bymap.get(mp, 0) + 1
print("-- Butin des monstres d'instances Legion : repris de LegionCore.")
print("-- Les portages de cartes (port_carte.py) et nos donnees d'origine n'avaient ni lootid ni table pour ces PNJ :")
print("-- aucun monstre d'Antorus ne laissait de butin. Ecartes : boss du Guide d'aventure (butin par le journal),")
print("-- references, devises et lignes a 0 % de LC (butin personnel). LootMode 0 de LC -> 1 (sinon jamais tire).")
print("-- PNJ par carte : " + ', '.join(f'{k}={v}' for k, v in sorted(bymap.items())))
for e, n, m in skipped:
    print(f"-- boss ecarte (hors journal) : {e} {n} carte {m}")
print()
ids = ','.join(sorted(set(set_loot), key=int))
print(f"DELETE FROM `creature_loot_template` WHERE `Entry` IN ({ids}) AND `Comment` LIKE '%(LC)';")
print("INSERT INTO `creature_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES")
print(',\n'.join(rows) + ';')
print(f"UPDATE `creature_template` SET `lootid`=`entry` WHERE `entry` IN ({ids}) AND `lootid`=0;")
print(f"-- {len(set_loot)} PNJ, {len(rows)} lignes", file=sys.stderr)
