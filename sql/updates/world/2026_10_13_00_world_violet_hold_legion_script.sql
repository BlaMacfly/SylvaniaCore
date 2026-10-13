-- DB/World: Fort Pourpre Legion (Assaut, carte 1544) tourne sans script d instance depuis l import.
-- Le script C++ instance_violet_hold_assault est bien enregistre (InstanceMapScript sur la map 1544,
-- appele dans brokenisles_script_loader.cpp) mais instance_template.script etait vide : aucune logique
-- de scenario/portes/boss ne s executait malgre les 9 creatures (8 boss) deja presentes en base.
UPDATE `instance_template` SET `script` = 'instance_violet_hold_assault' WHERE `map` = 1544;
