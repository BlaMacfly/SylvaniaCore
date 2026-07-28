# Patches SQL Sylvania (dc_world)

Copie de sauvegarde des patchs data appliques a la base `dc_world` (source : `~/dc-patches/` sur le VPS).

IMPORTANT : `dc_world` n est PAS incluse dans le backup automatique quotidien
(qui ne couvre que `auth` et `characters`, cf. ~/scripts/db-backup.sh) car un dump
compresse pese ~78 Mo. Ces fichiers sont donc la trace versionnee des changements
data faits a la main. Un backup hebdomadaire complet de dc_world existe par ailleurs
en local sur le VPS (~/Backups-World/).

Contenu notable :
- artifact_runner.sql + artifact_batch1..10.sql : framework et 24 configs de scenarios d artefact
- artifact_choices.sql / artifact_gate.sql : choix d artefact 13 classes + porte du Gardien
- monk_campaign_intro.sql : campagne moine + scenario Serenity s End
- broken_shore_intro.sql : intro Iles Brisees (2 factions)
- ring_of_peace.sql : binding areatrigger_template (RoP 3983 + Chi-Ji 10191)
- trainers_*, quete_*, fix_* : historique des correctifs data
Les fichiers *_ROLLBACK.sql annulent le patch correspondant.
