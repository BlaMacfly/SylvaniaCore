-- ============================================================================
-- Quête Mardum 38727 "Stop the Bombardment" — solution COMPLÈTE et VALIDÉE (3 bannières)
-- 2026-06-12. Soul Engine testé en jeu = SUCCÈS (visible + clic = crédit objectif).
-- ----------------------------------------------------------------------------
-- 2 problèmes corrigés :
--   1) Crédit : le script core go_mardum_illidari_banner dépend de
--      FindNearestCreature(devastator,50) -> échoue (phasing). Remplacé par SmartAI
--      (clic GOSSIP_HELLO=64 -> KILLEDMONSTER=33 sur invocateur=7) qui crédite
--      directement Devastator + bannière cachée. Lock (Data0) et goober.spell
--      191480 inexistant (Data10) retirés.
--   2) Visuel : displayId 26916 = modèle d'interaction INVISIBLE (d'où "?" sans
--      bannière). Remplacé par 31876 ("Legion Banner", bannière fel verte visible).
--
-- Paires (banner -> devastator + crédit caché) :
--   243965 Soul Engine        -> 93762 + 96692
--   243967 Forge of Corruption-> 96731 + 96733
--   243968 Doom Fortress      -> 96732 + 96734
--
-- IMPORTANT : un GO déjà spawné ne prend AIName/displayId qu'après recréation
--   (restart du world, ou .gobject delete + .gobject add). 243967/243968 ont déjà
--   leurs spawns d'origine bien placés -> actifs au prochain restart.
-- ============================================================================
UPDATE gameobject_template
   SET displayId=31876, AIName='SmartGameObjectAI', ScriptName='', Data0=0, Data10=0
 WHERE entry IN (243965,243967,243968);

DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid IN (243965,243967,243968);
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment)
VALUES
 (243965,1,0,0, 64,0,100,0, 0,0,0,0, 33,93762,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Soul Engine: credit Devastator 93762'),
 (243965,1,1,0, 64,0,100,0, 0,0,0,0, 33,96692,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Soul Engine: credit cache 96692'),
 (243967,1,0,0, 64,0,100,0, 0,0,0,0, 33,96731,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Forge of Corruption: credit Devastator 96731'),
 (243967,1,1,0, 64,0,100,0, 0,0,0,0, 33,96733,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Forge of Corruption: credit cache 96733'),
 (243968,1,0,0, 64,0,100,0, 0,0,0,0, 33,96732,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Doom Fortress: credit Devastator 96732'),
 (243968,1,1,0, 64,0,100,0, 0,0,0,0, 33,96734,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Banner Doom Fortress: credit cache 96734');
