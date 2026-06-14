-- ============================================================================
-- Activation de 2 donjons Legion dont les scripts C++ existaient mais n'étaient
-- pas assignés en base (instance_template.script vide). 2026-06-12.
-- Les classes InstanceMapScript existent dans le core :
--   - instance_neltharions_lair        (src/.../BrokenIsles/NeltharionsLair)
--   - instance_vault_of_the_wardens     (src/.../BrokenIsles/VaultOfTheWardens, donjon 5)
-- Effet au prochain redémarrage du worldserver (liaison script<->map au boot).
-- Revert : remettre script='' sur ces 2 maps.
-- ============================================================================
UPDATE instance_template SET script='instance_neltharions_lair'     WHERE map=1458;
UPDATE instance_template SET script='instance_vault_of_the_wardens' WHERE map=1493;
