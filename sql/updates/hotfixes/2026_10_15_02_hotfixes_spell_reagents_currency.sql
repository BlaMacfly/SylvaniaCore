-- Table hotfix de SpellReagentsCurrency.db2 (cout en monnaie des sorts, ex. ressources du domaine pour recruter des troupes) : vide, le fichier du client est lu tel quel.
CREATE TABLE IF NOT EXISTS `spell_reagents_currency` (
  `ID` int(10) unsigned NOT NULL DEFAULT 0,
  `SpellID` int(11) NOT NULL DEFAULT 0,
  `CurrencyTypesID` smallint(5) unsigned NOT NULL DEFAULT 0,
  `CurrencyCount` smallint(5) unsigned NOT NULL DEFAULT 0,
  `VerifiedBuild` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
