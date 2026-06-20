-- ============================================================
-- Fix Salles Brisées (map 540) : Grand Warlock Nethekurse jamais tuable
-- Boss non-attaquable tant que ses 4 peons (Fel Orc Convert 17083) ne notifient
-- pas leur mort (SETDATA_PEON_DEATH). Leur SmartAI n avait AUCUN handler de mort
-- => seul le fallback 90s rendait le boss attaquable => joueurs partent, porte de
-- sortie (DOOR_TYPE PASSAGE, ouvre quand boss DONE) jamais ouverte.
-- Fix : a la mort, chaque Fel Orc Convert notifie le Nethekurse le plus proche.
-- (boss SetData attend field=1 SETDATA_DATA, value=2 SETDATA_PEON_DEATH ; 4 morts => attaquable)
-- Hot-reloadable : .reload smart_scripts. Rollback : DELETE ... id=1.
-- 2026-06-20
-- ============================================================
DELETE FROM smart_scripts WHERE source_type=0 AND entryorguid=17083 AND id=1;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,event_param5,event_param_string,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment)
VALUES
 (17083,0,1,0, 6,0,100,0, 0,0,0,0,0,"",
  45,1,2,0,0,0,0,
  19,16807,80,0, 0,0,0,0, "Fel Orc Convert: a la mort notifie Nethekurse (peon death -> boss attaquable)");
