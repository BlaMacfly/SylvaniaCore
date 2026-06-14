-- ============================================================================
-- Fix FIABLE - banniere "Illidari Banner" 243965 (Soul Engine) / quete 38727
-- ----------------------------------------------------------------------------
-- Probleme : meme banniere posee, le clic ne creditait pas la quete.
--   Le script core `go_mardum_illidari_banner` fait
--   player->FindNearestCreature(93762, 50.0f) puis crediter ; si le Devastator
--   n'est pas trouve (phasing zone DH / introuvable dans la phase du joueur),
--   rien ne se passe. Script aussi marque //TODO cote core.
--
-- Solution : basculer la banniere sur SmartGameObjectAI. Au clic (GOSSIP_HELLO=64)
--   -> SMART_ACTION_CALL_KILLEDMONSTER (33) sur l'invocateur (TARGET 7) pour
--   crediter les 2 objectifs : Devastator 93762 + banniere cachee 96692.
--   Independant du Devastator et du phasing. Lock (Data0) + ScriptName retires.
--
-- Application : sur le VPS la modif DB est faite ; en jeu (GM) :
--   .reload gameobject_template
--   .reload smart_scripts
--   .gobject delete <guid_ancienne_banniere>   (puis la re-poser)
--   .gobject add 243965 7200
-- ============================================================================
UPDATE gameobject_template
   SET AIName='SmartGameObjectAI', ScriptName='', Data0=0
 WHERE entry=243965;

DELETE FROM smart_scripts WHERE source_type=1 AND entryorguid=243965;
INSERT INTO smart_scripts
 (entryorguid,source_type,id,link,event_type,event_phase_mask,event_chance,event_flags,
  event_param1,event_param2,event_param3,event_param4,
  action_type,action_param1,action_param2,action_param3,action_param4,action_param5,action_param6,
  target_type,target_param1,target_param2,target_param3,target_x,target_y,target_z,target_o,comment)
VALUES
 (243965,1,0,0, 64,0,100,0, 0,0,0,0, 33,93762,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Illidari Banner Soul Engine: credit Devastator 93762 au clic'),
 (243965,1,1,0, 64,0,100,0, 0,0,0,0, 33,96692,0,0,0,0,0, 7,0,0,0, 0,0,0,0, 'Illidari Banner Soul Engine: credit banniere cachee 96692 au clic');
