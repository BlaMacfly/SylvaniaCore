-- Tables de commandement des domaines de classe (Carte de reconnaissance, Carte de commandement, Oeil d Odyn...).
-- Sans drapeau GOSSIP, le client envoie CMSG_OPEN_MISSION_NPC avec le type de sujet 1 (fief) et ouvre de
-- lui-meme la fenetre des missions de DRAENOR, quelle que soit la reponse du serveur (trace du 30/09 19:25 :
-- « Blez clique le PNJ 102669, type de sujet demande 1 »). Comme chez LegionCore : drapeau GOSSIP + menu 18747,
-- dont l option ouvre la carte du domaine (GOSSIP_OPTION_ADVENTURE_MAP = 29 -> SMSG_SHOW_ADVENTURE_MAP).
UPDATE gossip_menu_option SET OptionType=29, OptionNpcFlag=1, OptionText="Show me what missions you have prepared." WHERE MenuId=18747 AND OptionIndex=0;
UPDATE creature_template SET npcflag = npcflag | 1, gossip_menu_id = 18747 WHERE entry IN (93787,97379,97389,98000,98093,98613,98695,99041,99428,101979,102589,102669,102957,103221,122719,127476) AND gossip_menu_id IN (0,18747) AND ScriptName="";
UPDATE creature_template SET npcflag = npcflag | 137438953472 WHERE entry IN (101979,103221);
UPDATE gossip_menu_option SET OptionBroadcastTextId=95541 WHERE MenuId=18747 AND OptionIndex=0;
