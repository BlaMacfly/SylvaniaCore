-- hallow's end quest chain missing heirlooms

-- horde
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (54170, 54146, 54142, 54141)) AND `eventEntry`=12;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54170))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54146))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54142))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54141)));

DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (209094)) AND `eventEntry`=12;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES 
(12, (SELECT `guid` FROM `gameobject` WHERE `id` IN (209094)));

-- alliance
DELETE FROM `game_event_creature` WHERE `guid`IN (SELECT `guid` FROM `creature` WHERE `id` IN (53949, 53950, 54021, 54118)) AND `eventEntry`=12;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (53949))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (53950))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54021))),
(12, (SELECT `guid` FROM `creature` WHERE `id` IN (54118)));

DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (209072)) AND `eventEntry`=12;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES 
(12, (SELECT `guid` FROM `gameobject` WHERE `id` IN (209072)));

-- both factions
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (54114, 8395)) AND `eventEntry`=12;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(12, 20500911), -- entry 54114
(12, 20500896), -- entry 54114
(12, 20500912), -- entry 8395
(12, 20500897); -- entry 8395

-- areas near dead courier
DELETE FROM `areatrigger_involvedrelation` WHERE `id` IN (6911, 6920);
INSERT INTO `areatrigger_involvedrelation` (`id`, `quest`) VALUES 
(6911, 29392),
(6920, 29415);

-- missing secondary quest ending npcs
DELETE FROM `creature` WHERE `id`IN (54118, 54170);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(20500899, 54118, 0, 1519, 5150, '0', 0, 0, 0, -1, 0, 0, -8383.09, 590.661, 97.7792, 0.899663, 300, 0, 0, 4751, 0, 0, 0, 0, 0, 0, 0, '', 0),
(20500900, 54170, 1, 1637, 8621, '0', 0, 0, 0, -1, 0, 1, 1909.33, -4754.55, 38.9236, 1.68488, 300, 0, 0, 1929, 0, 0, 0, 0, 0, 0, 0, '', 0);

-- dead orc courier set as dead
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT guid FROM `creature` WHERE `id` IN (54142));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES 
((SELECT guid FROM `creature` WHERE `id` IN (54142)), 0, 0, 7, 0, 0, 0, 0, 0, NULL);

UPDATE `creature_template` SET `dynamicflags`='32', `type_flags`='128' WHERE  `entry`=54142;
UPDATE `creature_template` SET `type_flags`='128' WHERE  `entry`=53950;

-- alliance texts for quest chain missing heirlooms
DELETE FROM `quest_request_items` WHERE `ID` IN (29399, 29402, 29403, 29411);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES 
(29399, 1, 1, 0, 0, 'You look like you know something about these missing goods.', 0),
(29402, 1, 1, 0, 0, 'Did you get all the ingredients?', 0),
(29403, 1, 1, 0, 0, 'This seems to be the desired crate.', 0),
(29411, 1, 1, 0, 0, 'Have you brought the crate as we discussed?', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (29399, 29402, 29403, 29411);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(29399, 'deDE', 'Ihr seht aus, als wüsstet Ihr etwas über diese verschwundenen Waren.', 0),
(29399, 'esES', 'Pareces saber algo acerca de estos bienes robados.', 0),
(29399, 'frFR', 'Vous avez l’air de savoir quelque chose à propos de ces biens disparus.', 0),
(29399, 'itIT', 'Sembra che tu sappia qualcosa su questi beni mancanti.', 0),
(29399, 'ptBR', 'Você parece saber algo sobre as mercadorias roubadas.', 0),
(29399, 'ruRu', 'У тебя такой вид, как будто ты что-то знаешь об этих пропавших вещах.', 0),

(29402, 'deDE', 'Habt Ihr alle Ingredienzien erhalten?', 0),
(29402, 'esES', '¿Conseguiste todos los ingredientes?', 0),
(29402, 'frFR', 'Avez-vous tous les ingrédients ?', 0),
(29402, 'itIT', 'Hai preso tutti gli ingredienti?', 0),
(29402, 'ptBR', 'Você trouxe todos os ingredientes?', 0),
(29402, 'ruRu', 'Ты собрал все ингредиенты?', 0),

(29403, 'deDE', 'Dies scheint die gesuchte Kiste zu sein.', 0),
(29403, 'esES', 'Esta parece ser la caja deseada.', 0),
(29403, 'frFR', 'Cela semble être la caisse recherchée.', 0),
(29403, 'itIT', 'Questa sembra essere la cassa desiderata.', 0),
(29403, 'ptBR', 'Esta parece ser a caixa desejada.', 0),
(29403, 'ruRu', 'Это и есть тот самый ящик.', 0),

(29411, 'deDE', 'Habt Ihr die Kiste wie besprochen dabei?', 0),
(29411, 'esES', '¿Has traído el cajón, como acordamos?', 0),
(29411, 'frFR', 'M’avez-vous apporté la caisse comme convenu ?', 0),
(29411, 'itIT', 'Hai portato la cassa come abbiamo discusso?', 0),
(29411, 'ptBR', 'Você trouxe o caixote, como combinado?', 0),
(29411, 'ruRu', 'Ящик, о котором мы говорили, у тебя?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` IN (29392, 29398, 29399, 29402, 29403, 29411);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(29392, 0, 0, 0, 0, 0, 0, 0, 0, 'This courier won\'t be meeting with his employer anytime soon and the crate he was hired to transport seems to have disappeared.', 0),
(29398, 1, 1, 0, 0, 0, 0, 0, 0, 'Keep your voice down and don\'t let word of this get out OR I\'m finished as an auctioneer!', 0),
(29399, 1, 1, 0, 0, 0, 0, 0, 0, 'Finally, Cutler\'s given me something I can work with. Before I give up that information, I\'m going to want to know who you\'re working for.', 0),
(29402, 1, 1, 0, 0, 0, 0, 0, 0, 'Sometimes, I think I should\'ve followed my father into alchemy.$B$BThis concoction should protect us from the worst effects of carrying or handling the crate. Bottoms up!', 0),
(29403, 1, 1, 0, 0, 0, 0, 0, 0, 'Tendrils of dark power dance around the crate, but there\'s no trace of Sanath Lim-yo. You can now claim the crate and return it to your employer.', 0),
(29411, 1, 1, 0, 0, 0, 0, 0, 0, 'Ah, you did manage to get the crate before Archmage Xylem\'s man could get it out of the city. Excellent!', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (29392, 29398, 29399, 29402, 29403, 29411);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(29392, 'deDE', 'Dieser Kurier wird sich wohl in naher Zukunft nicht mit seinem Arbeitgeber treffen und die Kiste, die er transportieren sollte, scheint verschwunden zu sein.', 0),
(29392, 'esES', 'Este mensajero no va a reunirse por el momento con su patrón y el cajón que transportaba por encargo parece haber desaparecido.', 0),
(29392, 'frFR', 'Ce messager ne retrouvera plus jamais son employeur et la caisse qu’on l’avait chargé de transporter semble avoir disparu.', 0),
(29392, 'itIT', 'Questo corriere non incontrerà il suo datore di lavoro in qualsiasi momento e la cassa che è stata ingaggiata per il trasporto sembra essere scomparsa.', 0),
(29392, 'ptBR', 'Este entregador não irá se encontrar com quem o contratou tão cedo, e o caixote que ele deveria transportar desapareceu.', 0),
(29392, 'ruRU', 'Вряд ли теперь этот курьер сможет встретиться с тем, кто его нанял. Ящик, который он вез, очевидно, исчез.', 0),

(29398, 'deDE', 'Senkt Eure Stimme und lasst nichts hierüber verlauten oder meine Karriere als Auktionator ist vorüber!', 0),
(29398, 'esES', 'Mantén baja la voz y no digas nada de esto. ¡Largo de aquí o estaré acabado como subastador!', 0),
(29398, 'frFR', 'Parlez à voix basse et ne dites mot à personne de tout ça ou ma carrière de commissaire-priseur est finie !', 0),
(29398, 'itIT', 'Abbassa la voce e non lasciare che questa parola venga fuori o che io abbia finito come banditore!', 0),
(29398, 'ptBR', 'Fale baixo e não deixe que ninguém saiba disso, ou minha carreira como leiloeiro irá acabar!', 0),
(29398, 'ruRU', 'Тише! Не говори ничего об этом деле. Или конец моей карьере аукциониста!', 0),

(29399, 'deDE', 'Endlich hat mir Messerschmied mal etwas gegeben, womit ich arbeiten kann. Bevor ich diese Information herausrücke, will ich wissen, für wen Ihr arbeitet.', 0),
(29399, 'esES', 'Al final, Cubertería me ha dado algo con lo que puedo trabajar. Antes de dar esa información, me interesa saber para quién trabajas.', 0),
(29399, 'frFR', 'Enfin, Cutler m’a donné quelque chose qui peut m’être utile. Avant de céder cette information, j’ai besoin de savoir pour qui vous travaillez.', 0),
(29399, 'itIT', 'Alla fine, Cutler mi ha dato qualcosa con cui posso lavorare. Prima di rinunciare a quell\'informazione, voglio sapere per chi lavori.', 0),
(29399, 'ptBR', 'Finalmente, o Burlão me falou algo que eu posso usar. Antes que eu divulgue essa informação, preciso saber para quem você trabalha.', 0),
(29399, 'ruRU', 'Наконец-то я получил от Катлера какие-то сведения. Но сначала я хочу узнать, на кого ты работаешь.', 0),

(29402, 'deDE', 'Manchmal denke ich, dass ich meinem Vater in die Alchemie hätte folgen sollen.$B$BDieses Gebräu sollte uns vor den schlimmsten Auswirkungen, die das Tragen und die Handhabung der Kiste mit sich bringen, schützen. Wohl bekommt\'s!', 0),
(29402, 'esES', 'A veces, creo que me debería haber dedicado a la alquimia, como mi padre.$B$BEste brebaje nos debería proteger de los peores efectos derivados de transportar o manejar el cajón. ¡Del tirón!', 0),
(29402, 'frFR', 'Parfois, je pense que j’aurais dû suivre l’exemple de mon père et devenir alchimiste.$B$BCette décoction devrait nous protéger des pires effets du transport ou de la manipulation de la caisse. Cul sec !', 0),
(29402, 'itIT', 'A volte, penso che avrei dovuto seguire mio padre nell\'alchimia.$B$BQuesto intruglio dovrebbe proteggerci dagli effetti peggiori del trasporto o della manipolazione della cassa. Sottosopra!.', 0),
(29402, 'ptBR', 'Às vezes, acho que eu deveria ter seguido meu pai na profissão de alquimia.$B$BEste preparado deve nos proteger dos efeitos colaterais de carregar e manusear o caixote. Manda pra dentro!', 0),
(29402, 'ruRU', 'Иногда я думаю, что стоило мне пойти по стопам своего отца и стать алхимиком.$B$BЭто зелье защитит нас от всех негативных эффектов, которым может подвергнуться тот, кто переносит или хранит этот ящик. Давай выпьем его!', 0),

(29403, 'deDE', 'Ranken aus dunkler Macht tanzen um die Kiste, aber es gibt keine Spur von Sanath Lim-yo. Ihr könnt die Kiste jetzt an Euch nehmen und zu Eurem Auftraggeber zurückkehren.', 0),
(29403, 'esES', 'Alrededor del cajón bailan zarcillos de poder oscuro, pero no hay rastro de Sanath Lim-yo. Ahora puedes reclamar el cajón y devolverlo a quien te contrató.', 0),
(29403, 'frFR', 'Des vrilles d’un pouvoir sombre dansent autour de la caisse, mais il n’y a aucune trace de Sanath Lim-Yo. Vous pouvez maintenant récupérer la caisse et la rapporter à votre employeur.', 0),
(29403, 'itIT', 'Viticci di potere oscuro ballano attorno alla cassa, ma non c\'è traccia di Sanath Lim-yo. Ora puoi richiedere la cassa e restituirla al tuo datore di lavoro.', 0),
(29403, 'ptBR', 'Tentáculos de poder sombrio dançam ao redor do caixote, mas não há sinal de Sanath Lim-yo. Você pode pegar o caixote e devolvê-lo para seu empregador.', 0),
(29403, 'ruRU', 'От ящика исходит ощущение темной силы. Саната Лим-Йо поблизости нет. Вы можете взять ящик и отнести его своему нанимателю.', 0),

(29411, 'deDE', 'Ah, Ihr habt es also geschafft, die Kiste zu bekommen, bevor Erzmagier Xylems Mann sie aus der Stadt schaffen konnte. Exzellent!', 0),
(29411, 'esES', 'Ah, conseguiste el cajón antes de que el hombre del archimago Xylem pudiese sacarlo de la ciudad. ¡Excelente!', 0),
(29411, 'frFR', 'Ah, vous avez réussi à obtenir la caisse avant que l’homme de l’archimage Xylem ne puisse la sortir de la ville. Excellent !', 0),
(29411, 'itIT', 'Ah, sei riuscito a ottenere la cassa prima che l\'uomo di Archimage Xylem potesse portarlo fuori dalla città. Eccellente!', 0),
(29411, 'ptBR', 'Ah, você conseguiu trazer o caixote antes que os homens do arquimago Tauriel o tirassem da cidade. Excelente!', 0),
(29411, 'ruRU', 'Тебе все же удалось завладеть ящиком до того, как он достался Ксилему! Замечательно!', 0);

-- horde texts for quest chain missing heirlooms
DELETE FROM `quest_request_items` WHERE `ID` IN (29425, 29426, 29427, 29428);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES 
(29425, 1, 1, 0, 0, 'You look like you know something about these missing goods.', 0),
(29426, 1, 1, 0, 0, 'Did you get all the ingredients?', 0),
(29427, 1, 1, 0, 0, 'This seems to be the desired crate.', 0),
(29428, 1, 1, 0, 0, 'Have you brought the crate as we discussed?', 0);

DELETE FROM `quest_request_items_locale` WHERE `ID` IN (29425, 29426, 29427, 29428);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES 
(29425, 'deDE', 'Ihr seht aus, als wüsstet Ihr etwas über diese verschwundenen Waren.', 0),
(29425, 'esES', 'Pareces saber algo acerca de estos bienes robados.', 0),
(29425, 'frFR', 'Vous avez l’air de savoir quelque chose à propos de ces biens disparus.', 0),
(29425, 'itIT', 'Sembra che tu sappia qualcosa su questi beni mancanti.', 0),
(29425, 'ptBR', 'Você parece saber algo sobre as mercadorias roubadas.', 0),
(29425, 'ruRu', 'У тебя такой вид, как будто ты что-то знаешь об этих пропавших вещах.', 0),

(29426, 'deDE', 'Habt Ihr alle Ingredienzien erhalten?', 0),
(29426, 'esES', '¿Conseguiste todos los ingredientes?', 0),
(29426, 'frFR', 'Avez-vous tous les ingrédients ?', 0),
(29426, 'itIT', 'Hai preso tutti gli ingredienti?', 0),
(29426, 'ptBR', 'Você trouxe todos os ingredientes?', 0),
(29426, 'ruRu', 'Ты собрал все ингредиенты?', 0),

(29427, 'deDE', 'Dies scheint die gesuchte Kiste zu sein.', 0),
(29427, 'esES', 'Esta parece ser la caja deseada.', 0),
(29427, 'frFR', 'Cela semble être la caisse recherchée.', 0),
(29427, 'itIT', 'Questa sembra essere la cassa desiderata.', 0),
(29427, 'ptBR', 'Esta parece ser a caixa desejada.', 0),
(29427, 'ruRu', 'Это и есть тот самый ящик.', 0),

(29428, 'deDE', 'Habt Ihr die Kiste wie besprochen dabei?', 0),
(29428, 'esES', '¿Has traído el cajón, como acordamos?', 0),
(29428, 'frFR', 'M’avez-vous apporté la caisse comme convenu ?', 0),
(29428, 'itIT', 'Hai portato la cassa come abbiamo discusso?', 0),
(29428, 'ptBR', 'Você trouxe o caixote, como combinado?', 0),
(29428, 'ruRu', 'Ящик, о котором мы говорили, у тебя?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` IN (29415, 29416, 29425, 29426, 29427, 29428);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES 
(29415, 0, 0, 0, 0, 0, 0, 0, 0, 'This courier won\'t be meeting with his employer anytime soon and the crate he was hired to transport seems to have disappeared.', 0),
(29416, 1, 1, 0, 0, 0, 0, 0, 0, 'Keep your voice down and don\'t let word of this get out OR I\'m finished as an auctioneer!', 0),
(29425, 1, 1, 0, 0, 0, 0, 0, 0, 'Leave it to Droffers to have a buyer lined up already. We should combine our efforts to track down this thief and keep the crate\'s contents from falling into the wrong hands.', 0),
(29426, 1, 1, 0, 0, 0, 0, 0, 0, 'Let\'s see what I can remember from the alchemy lessons of my youth. If it explodes, I\'ve done something wrong.$B$BThis concoction should protect us from the worst effects of carrying or handling the crate.', 0),
(29427, 1, 1, 0, 0, 0, 0, 0, 0, 'Tendrils of dark power dance around the crate, but there\'s no trace of Sanath Lim-yo. You can now claim the crate and return it to your employer.', 0),
(29428, 1, 1, 0, 0, 0, 0, 0, 0, 'Ah, you did manage to get the crate before Archmage Xylem\'s man could get it out of the city. Excellent!', 0);

DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (29415, 29416, 29425, 29426, 29427, 29428);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES 
(29415, 'deDE', 'Dieser Kurier wird sich wohl in naher Zukunft nicht mit seinem Arbeitgeber treffen und die Kiste, die er transportieren sollte, scheint verschwunden zu sein.', 0),
(29415, 'esES', 'Este mensajero no va a reunirse por el momento con su patrón y el cajón que transportaba por encargo parece haber desaparecido.', 0),
(29415, 'frFR', 'Ce messager ne retrouvera plus jamais son employeur et la caisse qu’on l’avait chargé de transporter semble avoir disparu.', 0),
(29415, 'itIT', 'Questo corriere non incontrerà il suo datore di lavoro in qualsiasi momento e la cassa che è stata ingaggiata per il trasporto sembra essere scomparsa.', 0),
(29415, 'ptBR', 'Este entregador não irá se encontrar com quem o contratou tão cedo, e o caixote que ele deveria transportar desapareceu.', 0),
(29415, 'ruRU', 'Вряд ли теперь этот курьер сможет встретиться с тем, кто его нанял. Ящик, который он вез, очевидно, исчез.', 0),

(29416, 'deDE', 'Senkt Eure Stimme und lasst nichts hierüber verlauten oder meine Karriere als Auktionator ist vorüber!', 0),
(29416, 'esES', 'Mantén baja la voz y no digas nada de esto. ¡Largo de aquí o estaré acabado como subastador!', 0),
(29416, 'frFR', 'Parlez à voix basse et ne dites mot à personne de tout ça ou ma carrière de commissaire-priseur est finie !', 0),
(29416, 'itIT', 'Abbassa la voce e non lasciare che questa parola venga fuori o che io abbia finito come banditore!', 0),
(29416, 'ptBR', 'Fale baixo e não deixe que ninguém saiba disso, ou minha carreira como leiloeiro irá acabar!', 0),
(29416, 'ruRU', 'Тише! Не говори ничего об этом деле. Или конец моей карьере аукциониста!', 0),

(29425, 'deDE', 'Verlasst Euch auf Droffer, dass er direkt einen Käufer an der Hand hat. Wir sollten zusammen arbeiten, um diesen Dieb zu fassen und um zu verhindern, dass der Inhalt dieser Kiste in die falschen Hände fällt.', 0),
(29425, 'esES', 'ADeja que Droffers se encargue de buscar comprador. Tenemos que aunar esfuerzos para seguir a ese ladrón y evitar que el contenido del cajón caiga en manos equivocadas.', 0),
(29425, 'frFR', 'Faites confiance à Droffer pour avoir déjà un acheteur sur les rangs. Nous devrions combiner nos efforts pour pister ce voleur et empêcher le contenu de la caisse de tomber entre de mauvaises mains.', 0),
(29425, 'itIT', 'Lascia fare a Droffers per avere già un acquirente in fila. Dovremmo combinare i nostri sforzi per rintracciare questo ladro e impedire che il contenuto della cassa cada nelle mani sbagliate.', 0),
(29425, 'ptBR', 'O velho Droffers já tem um comprador em vista. Devíamos unir esforços para encontrar esse ladrão e impedir que o conteúdo do caixote caia nas mãos erradas.', 0),
(29425, 'ruRU', 'Ладно, давай уже оставим Дрофферса в покое, а то мы оставим его без покупателей. Нам же нужно объединить усилия для того, чтобы выследить вора и позаботиться о том, чтобы содержимое ящика не попало в дурные руки.', 0),

(29426, 'deDE', 'Dann wollen wir doch mal sehen, was aus den Alchemiestunden meiner Jugendzeit noch so hängengeblieben ist. Wenn es explodiert, habe ich etwas falsch gemacht.$B$BDieses Gebräu sollte uns vor den schlimmsten Auswirkungen, die das Tragen und die Handhabung der Kiste mit sich bringen, schützen.', 0),
(29426, 'esES', 'A ver lo que recuerdo de las lecciones de alquimia de mi juventud. Si explota, es que he hecho algo mal.$B$BEste brebaje nos debería proteger de los peores efectos derivados de transportar o manejar el cajón.', 0),
(29426, 'frFR', 'Voyons si j’arrive à me souvenir des leçons d’alchimie de ma jeunesse. Si ça explose, c’est que j’aurai fait une erreur.$B$BCette décoction devrait nous protéger des pires effets du transport ou de la manipulation de la caisse.', 0),
(29426, 'itIT', 'Vediamo cosa riesco a ricordare dalle lezioni di alchimia della mia giovinezza. Se esplode, ho fatto qualcosa di sbagliato.$B$BQuesto intruglio dovrebbe proteggerci dagli effetti peggiori del trasporto o della manipolazione della cassa.', 0),
(29426, 'ptBR', 'Vamos ver se me lembro das aulas de alquimia que fiz quando jovem. Se explodir, eu fiz alguma coisa errada.$B$BEste preparado deve nos proteger dos efeitos colaterais de carregar e manusear o caixote.', 0),
(29426, 'ruRU', 'Давайте посмотрим, что я могу вспомнить из уроков алхимии моей юности. Если он взорвется, я сделал что-то не так.$B$BЭта смесь должна защищать нас от наихудших последствий переноса или обработки ящика.', 0),

(29427, 'deDE', 'Ranken aus dunkler Macht tanzen um die Kiste, aber es gibt keine Spur von Sanath Lim-yo. Ihr könnt die Kiste jetzt an Euch nehmen und zu Eurem Auftraggeber zurückkehren.', 0),
(29427, 'esES', 'Alrededor del cajón bailan zarcillos de poder oscuro, pero no hay rastro de Sanath Lim-yo. Ahora puedes reclamar el cajón y devolverlo a quien te contrató.', 0),
(29427, 'frFR', 'Des vrilles d’un pouvoir sombre dansent autour de la caisse, mais il n’y a aucune trace de Sanath Lim-Yo. Vous pouvez maintenant récupérer la caisse et la rapporter à votre employeur.', 0),
(29427, 'itIT', 'Viticci di potere oscuro ballano attorno alla cassa, ma non c\'è traccia di Sanath Lim-yo. Ora puoi richiedere la cassa e restituirla al tuo datore di lavoro.', 0),
(29427, 'ptBR', 'Tentáculos de poder sombrio dançam ao redor do caixote, mas não há sinal de Sanath Lim-yo. Você pode pegar o caixote e devolvê-lo para seu empregador.', 0),
(29427, 'ruRU', 'От ящика исходит ощущение темной силы. Саната Лим-Йо поблизости нет. Вы можете взять ящик и отнести его своему нанимателю.', 0),

(29428, 'deDE', 'Ah, Ihr habt es also geschafft, die Kiste zu bekommen, bevor Erzmagier Xylems Mann sie aus der Stadt schaffen konnte. Exzellent!', 0),
(29428, 'esES', 'Ah, conseguiste el cajón antes de que el hombre del archimago Xylem pudiese sacarlo de la ciudad. ¡Excelente!', 0),
(29428, 'frFR', 'Ah, vous avez réussi à obtenir la caisse avant que l’homme de l’archimage Xylem ne puisse la sortir de la ville. Excellent !', 0),
(29428, 'itIT', 'Ah, sei riuscito a ottenere la cassa prima che l\'uomo di Archimage Xylem potesse portarlo fuori dalla città. Eccellente!', 0),
(29428, 'ptBR', 'Ah, você conseguiu trazer o caixote antes que os homens do arquimago Tauriel o tirassem da cidade. Excelente!', 0),
(29428, 'ruRU', 'Тебе все же удалось завладеть ящиком до того, как он достался Ксилему! Замечательно!', 0);