#!/usr/bin/env python3
# Transforme les relevés wowuction archivés (prices*.tsv) en table `ahbot_price`.
# Colonnes des relevés : entry, statut, nom, horodatage archive, prix médian région (cuivre),
# écart type région, postés/jour région, vendus/jour région, prix médian royaume, vendus/jour royaume.
import glob, sys

MIN_SOLD_PER_DAY = 0.5          # en dessous : prix d'affichage, pas prix de vente
EXCLUDE = {82800}               # cage de mascotte : ne se crée pas sans données de mascotte

rows = {}
for fn in sorted(glob.glob('prices*.tsv')):
    for line in open(fn, encoding='utf-8'):
        p = line.rstrip('\n').split('\t')
        if len(p) < 8 or p[1] != 'OK':
            continue
        entry = int(p[0])
        try:
            price, dev, sold = int(p[4]), int(p[5]), float(p[7])
        except ValueError:
            continue
        if entry in EXCLUDE or price <= 0 or sold < MIN_SOLD_PER_DAY:
            continue
        rows[entry] = (price, dev, sold, p[2], p[3][:8])

def q(s):
    return "'" + s.replace('\\', '\\\\').replace("'", "\\'") + "'"

out = sys.stdout
out.write("""-- Table de prix du bot d'enchères (AuctionHouseBot.PriceTable.Enabled).
-- Source : fiches wowuction.com archivées par la Wayback Machine entre le 16/01/2018
-- (sortie de la 7.3.5) et le 13/08/2018 (fin de Legion). Prix = médiane sur 14 jours de
-- toute la région EU, ventes/jour = moyenne par royaume EU. Objets vendus moins de
-- %s fois par jour écartés (prix d'affichage, pas de vente).
CREATE TABLE IF NOT EXISTS `ahbot_price` (
  `entry` INT UNSIGNED NOT NULL,
  `price` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'prix de marché par unité, en cuivre',
  `deviation` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'écart type du prix, en cuivre',
  `soldPerDay` FLOAT NOT NULL DEFAULT 0 COMMENT 'ventes estimées par jour et par royaume',
  `name` VARCHAR(120) NOT NULL DEFAULT '',
  `source` VARCHAR(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Prix de marché du bot d enchères';

DELETE FROM `ahbot_price` WHERE `source` LIKE 'wowuction-eu-%%';
INSERT INTO `ahbot_price` (`entry`, `price`, `deviation`, `soldPerDay`, `name`, `source`) VALUES
""" % MIN_SOLD_PER_DAY)
vals = []
for entry in sorted(rows):
    price, dev, sold, name, day = rows[entry]
    vals.append("(%d, %d, %d, %.2f, %s, %s)" % (entry, price, dev, sold, q(name), q('wowuction-eu-' + day)))
out.write(",\n".join(vals) + ";\n")
sys.stderr.write("%d objets retenus\n" % len(rows))
