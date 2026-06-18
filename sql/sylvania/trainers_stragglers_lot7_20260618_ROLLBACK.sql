-- ROLLBACK Lot 7
SET NAMES utf8;
DELETE FROM gossip_menu_option WHERE OptionType=5 AND OptionNpcFlag=16 AND OptionText="Je voudrais m'entraîner." AND (MenuId,OptionIndex) IN ((12046,3),(79519,0));
