-- Rollback Lot 8 Secourisme (2026-06-19)
DELETE FROM trainer_spell WHERE TrainerId=160 AND SpellId=3273;
DELETE FROM gossip_menu_option_trainer WHERE MenuId IN (657,4761,5855,8802,22169,10826) AND OptionIndex=0 AND TrainerId=160;
