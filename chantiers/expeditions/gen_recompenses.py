#!/usr/bin/env python3
# Recompenses des expeditions sans aucune option (world_quest_reward), tirees de LegionCore world_quest_template.
# Une option = un id ; une option peut cumuler plusieurs lignes (ex. objet + eclats du Neant pour les assauts).
import subprocess, sys
sys.path.insert(0, '/home/ubuntu/tmp')
import wdc1

def q(sql):
    out = subprocess.run(['sudo', 'mysql', '-N', '-e', sql], capture_output=True, text=True, check=True).stdout
    return [l.split('\t') for l in out.rstrip('\n').split('\n') if l]

items_client = {rid for rid, _ in wdc1.WDC1('/home/ubuntu/server/data/dbc/enUS/Item.db2').rows()}
TYPES = {116: 0, 117: 0, 121: 0, 122: 0, 123: 0, 126: 0, 136: 7334, 139: 0, 142: 0}   # zone LC de reference
deja = {r[0] for r in q("SELECT DISTINCT questType FROM dc_world.world_quest_reward")}
nid = int(q("SELECT MAX(id) FROM dc_world.world_quest_reward")[0][0]) + 1
premier = nid
rows, absents = [], []
for qi, zone in TYPES.items():
    assert str(qi) not in deja, qi
    t = q(f"""SELECT CurrencyID, CurrencyMin, CurrencyMax, GoldMin, GoldMax, ItemCAList, ItemResourceList, Currency, CurrencyCount
              FROM lc_world_ref.world_quest_template WHERE QuestInfoID={qi} AND ZoneID={zone}""")[0]
    cur, cmin, cmax, gmin, gmax, ap, res, bonus, bonusN = t
    extra = [('CURRENCY', bonus, bonusN)] if bonus != '0' else []   # eclats du Neant des assauts, avec chaque option
    options = []
    for it in ap.split():
        options.append([('ITEM', it, '1')])
    r = res.split()
    for i in range(0, len(r) - 3, 4):
        it, mn, mx = r[i], int(r[i + 1]), int(r[i + 2])
        options.append([('ITEM', it, str((mn + mx) // 2))])
    if cur != '0':
        options += [[('CURRENCY', cur, cmin)], [('CURRENCY', cur, cmax)]]
    if gmax != '0':
        options += [[('GOLD', '0', gmin)], [('GOLD', '0', gmax)]]
    for opt in options:
        if any(k == 'ITEM' and int(v) not in items_client for k, v, _ in opt):
            absents += [v for k, v, _ in opt if k == 'ITEM']
            continue
        for k, v, n in opt + extra:
            rows.append(f"({nid}, {qi}, '{k}', {v}, {n}, 0)")
        nid += 1
    print(qi, len(options), 'options')

L = ["-- Recompenses des expeditions des categories qui n'en avaient aucune (136 rares elites, 139/142 assauts,",
     "-- 116/117/121/122/123/126 commandes de metiers), reprises de LegionCore world_quest_template (zone de reference",
     "-- Azsuna pour 136). Une option est tiree a l'activation de la quete. Les pieces d'armure ne sont pas reprises.",
     f"-- Objets absents du client ecartes : {sorted(set(absents)) or 'aucun'}. Rollback : DELETE des id {premier} a {nid-1}.",
     "", "INSERT INTO world_quest_reward (id, questType, rewardType, rewardId, rewardCount, rewardContext) VALUES",
     ',\n'.join(rows) + ';']
O = '/home/ubuntu/DestinyCore/sql/sylvania/2026_10_08_expeditions_recompenses'
open(O + '.sql', 'w').write('\n'.join(L) + '\n')
open(O + '_rollback.sql', 'w').write(f"-- Annule 2026_10_08_expeditions_recompenses.sql\nDELETE FROM world_quest_reward WHERE id BETWEEN {premier} AND {nid-1};\n")
print('options', premier, '->', nid - 1, 'lignes', len(rows), 'absents', sorted(set(absents)))
