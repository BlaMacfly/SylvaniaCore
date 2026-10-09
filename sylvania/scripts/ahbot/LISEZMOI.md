# Table de prix du bot d'enchères

Source : fiches d'objets wowuction.com archivées par la Wayback Machine pendant la 7.3.5
(16/01/2018 au 13/08/2018). Chaque fiche donne le prix médian sur 14 jours de toute la
région EU et les ventes estimées par jour.

1. `items_urls.json` : liste des fiches archivées (requêtes CDX par royaume EU).
2. `python3 fetch2.py K 4` pour K = 0..3 (en parallèle) : récupère les fiches dans `prices_K.tsv`.
3. `python3 gen_sql.py > ../../../sql/sylvania/ahbot_price.sql` : écarte les objets vendus
   moins de 0,5 fois par jour (prix d'affichage) et produit la table `ahbot_price` (base world).

Activation : `AuctionHouseBot.PriceTable.Enabled = 1` dans worldserver.conf.
