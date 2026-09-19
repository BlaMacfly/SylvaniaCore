-- Silithus : rendre leur position exacte aux PNJ documentes par un pin unique.
--
-- Le decalage anti-quadrillage servait a dissoudre le reseau regulier des pins
-- Wowhead. Un PNJ qui n a qu un seul pin n a jamais fait partie d un reseau : le
-- decaler ne faisait que degrader une position exacte.
--
-- Sans consequence pour la plupart -- quelques centimetres -- mais Rhonormu est
-- pose sur une pente raide : 1,9 m de decalage horizontal lui avaient fait gravir
-- 4,69 m. Il surplombait l endroit documente. Sa position porte pourtant le
-- marqueur uiMapPhaseId 9491, qui atteste qu elle est bien celle de La Plaie ;
-- aucun amont ne le spawne, Wowhead est la seule source.
--
-- Annulation : db-backups/silithus-uniques-*.sql

UPDATE `creature` SET `position_x`=-6468.2950,`position_y`=-214.6340,`position_z`=5.0325 WHERE `guid`=290202167;
UPDATE `creature` SET `position_x`=-6349.2200,`position_y`=166.8490,`position_z`=7.7180 WHERE `guid`=290202168;
UPDATE `creature` SET `position_x`=-6387.1070,`position_y`=183.0820,`position_z`=7.6788 WHERE `guid`=290202169;
UPDATE `creature` SET `position_x`=-7404.6570,`position_y`=288.5990,`position_z`=-2.5581 WHERE `guid`=290202170;
UPDATE `creature` SET `position_x`=-7069.0820,`position_y`=1270.7150,`position_z`=-92.9048 WHERE `guid`=290202171;
UPDATE `creature` SET `position_x`=-6392.5200,`position_y`=-312.0340,`position_z`=-0.9756 WHERE `guid`=290202176;
UPDATE `creature` SET `position_x`=-6365.4570,`position_y`=191.1990,`position_z`=7.6072 WHERE `guid`=290202658;
UPDATE `creature` SET `position_x`=-6349.2200,`position_y`=166.8490,`position_z`=7.7180 WHERE `guid`=290202723;
UPDATE `creature` SET `position_x`=-7253.1070,`position_y`=329.1820,`position_z`=23.6767 WHERE `guid`=290202845;
UPDATE `creature` SET `position_x`=-7355.9450,`position_y`=312.9490,`position_z`=-1.9580 WHERE `guid`=290202855;
UPDATE `creature` SET `position_x`=-6392.5200,`position_y`=166.8490,`position_z`=7.6412 WHERE `guid`=290202875;
UPDATE `creature` SET `position_x`=-6387.1070,`position_y`=166.8490,`position_z`=7.6081 WHERE `guid`=290203065;
UPDATE `creature` SET `position_x`=-6419.5820,`position_y`=183.0820,`position_z`=8.9616 WHERE `guid`=290203071;
UPDATE `creature` SET `position_x`=-7534.5570,`position_y`=1782.0640,`position_z`=7.0062 WHERE `guid`=290203108;
UPDATE `creature` SET `position_x`=-7539.9700,`position_y`=1782.0640,`position_z`=8.5431 WHERE `guid`=290203114;
UPDATE `creature` SET `position_x`=-7539.9700,`position_y`=1782.0640,`position_z`=8.5431 WHERE `guid`=290203120;
UPDATE `creature` SET `position_x`=-7539.9700,`position_y`=1782.0640,`position_z`=8.5431 WHERE `guid`=290203126;
UPDATE `creature` SET `position_x`=-7539.9700,`position_y`=1782.0640,`position_z`=8.5431 WHERE `guid`=290203127;
UPDATE `creature` SET `position_x`=-7539.9700,`position_y`=1782.0640,`position_z`=8.5431 WHERE `guid`=290203128;
UPDATE `creature` SET `position_x`=-7480.4320,`position_y`=1822.6480,`position_z`=-27.7169 WHERE `guid`=290203140;
UPDATE `creature` SET `position_x`=-8059.5700,`position_y`=1635.9640,`position_z`=5.4439 WHERE `guid`=290203141;
UPDATE `creature` SET `position_x`=-7545.3820,`position_y`=1790.1810,`position_z`=10.6610 WHERE `guid`=290203150;
