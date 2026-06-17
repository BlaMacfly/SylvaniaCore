# SylvaniaCore

Fork de **DestinyCore** (WoW Legion 7.3.5.26972) pour le serveur "La Legende de Sylvania".

- Base upstream : DestinyCore master @2d631f4e (remote `upstream`).
- Customs conserves : Klauss (taux XP perso x1-7, gossip FR), Solocraft, Solo LFG (natifs DestinyCore + config).
- PlayerBots : DESACTIVES (pbotall=0 + gardes code) - serveur blizzlike sans bots.

## Correctifs SylvaniaCore (commits dedies)
1. Compat build MariaDB (CR_INVALID_CONN_HANDLE).
2. Desactivation PlayerBots + fix crash issue #56 (file BG/arene).
3. Fix cadavre orphelin (blocage esprit guerisseur apres reset d instance).
4. Klauss (entry 1000000) - voir sql/sylvania/klauss_npc_*.sql pour le spawn.

## Config worldserver requise
pbot = 0 ; pbotall = 0 ; Solocraft.Enable = 1 ; SoloLFG.Enable = 1 ; SoloLFG.Announce = 1

## Donnees client
maps/vmaps/mmaps/dbc extraits du client 7.3.5.26972 (compatibles, pas de re-extraction).

## scripts/
- reconcile_schema.sh : synchro additive de schema (golden -> cible) pour migrer auth/characters.
- ROLLBACK.sh.example : modele de rollback blue-green (adapter les chemins).
