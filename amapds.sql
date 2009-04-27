-- phpMyAdmin SQL Dump
-- version 3.1.3.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 22, 2009 at 03:57 PM
-- Server version: 5.0.45
-- PHP Version: 5.2.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: 'radioecology_6'
--

-- --------------------------------------------------------

--
-- Table structure for table 'code'
--

CREATE TABLE IF NOT EXISTS `code` (
  id char(4) collate utf8_unicode_ci NOT NULL,
  `type` char(4) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  category int(11) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'code_log'
--

CREATE TABLE IF NOT EXISTS code_log (
  logid int(11) NOT NULL auto_increment,
  id char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  `type` char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  category int(11) default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'code_lt'
--
CREATE TABLE IF NOT EXISTS `code_lt` (
`id` char(4)
,`type` char(4)
,`name` varchar(60)
,`username` varchar(30)
,`addtime` timestamp
,`category` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table 'code_mu'
--

CREATE TABLE IF NOT EXISTS code_mu (
  id char(4) collate utf8_bin default NULL,
  `name` varchar(60) collate utf8_bin default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'code_rn'
--
CREATE TABLE IF NOT EXISTS `code_rn` (
`id` char(4)
,`name` varchar(60)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'code_st'
--
CREATE TABLE IF NOT EXISTS `code_st` (
`id` char(4)
,`type` char(4)
,`name` varchar(60)
,`username` varchar(30)
,`addtime` timestamp
,`category` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'code_sy'
--
CREATE TABLE IF NOT EXISTS `code_sy` (
`id` char(4)
,`name` varchar(60)
);
-- --------------------------------------------------------

--
-- Table structure for table 'contact'
--

CREATE TABLE IF NOT EXISTS contact (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  address1 varchar(60) collate utf8_unicode_ci default NULL,
  address2 varchar(60) collate utf8_unicode_ci default NULL,
  zipcode varchar(60) collate utf8_unicode_ci default NULL,
  postname varchar(60) collate utf8_unicode_ci default NULL,
  country varchar(60) collate utf8_unicode_ci default NULL,
  phone varchar(15) collate utf8_unicode_ci default NULL,
  fax varchar(15) collate utf8_unicode_ci default NULL,
  email varchar(60) collate utf8_unicode_ci default NULL,
  info text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'contact_log'
--

CREATE TABLE IF NOT EXISTS contact_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  address1 varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  address2 varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  zipcode varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  postname varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  country varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  phone varchar(15) character set utf8 collate utf8_unicode_ci default NULL,
  fax varchar(15) character set utf8 collate utf8_unicode_ci default NULL,
  email varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  info text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'content'
--

CREATE TABLE IF NOT EXISTS content (
  id int(11) NOT NULL auto_increment,
  sourceid char(8) collate utf8_unicode_ci NOT NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  nuclideid char(4) collate utf8_unicode_ci default NULL,
  literatureid char(8) collate utf8_unicode_ci default NULL,
  valid tinyint(1) NOT NULL default '1',
  amount double NOT NULL,
  unit char(4) collate utf8_unicode_ci NOT NULL,
  chemform char(4) collate utf8_unicode_ci NOT NULL,
  released tinyint(1) NOT NULL,
  `year` int(11) default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2031 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'content_e'
--
CREATE TABLE IF NOT EXISTS `content_e` (
`id` int(11)
,`sourceid` varchar(60)
,`contactid` varchar(60)
,`nuclideid` varchar(60)
,`literatureid` text
,`valid` tinyint(1)
,`amount` double
,`unit` char(4)
,`chemform` char(4)
,`released` tinyint(1)
,`year` int(11)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'content_log'
--

CREATE TABLE IF NOT EXISTS content_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL,
  sourceid char(8) collate utf8_unicode_ci NOT NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  nuclideid char(4) collate utf8_unicode_ci default NULL,
  literatureid char(8) collate utf8_unicode_ci default NULL,
  valid tinyint(1) NOT NULL default '1',
  amount double NOT NULL,
  unit char(4) collate utf8_unicode_ci NOT NULL,
  chemform char(4) collate utf8_unicode_ci NOT NULL,
  released tinyint(1) NOT NULL,
  `year` int(11) default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'content_name'
--
CREATE TABLE IF NOT EXISTS `content_name` (
`name` varbinary(93)
,`id` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table 'country'
--

CREATE TABLE IF NOT EXISTS country (
  id char(2) collate utf8_unicode_ci NOT NULL,
  `name` varchar(25) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'country_log'
--

CREATE TABLE IF NOT EXISTS country_log (
  logid int(11) NOT NULL auto_increment,
  id char(2) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(25) character set utf8 collate utf8_unicode_ci NOT NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'grouping'
--

CREATE TABLE IF NOT EXISTS grouping (
  id int(11) NOT NULL auto_increment,
  grp varchar(60) collate utf8_unicode_ci default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='__admin__' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'laboratory'
--

CREATE TABLE IF NOT EXISTS laboratory (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  `comment` text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'laboratory_e'
--
CREATE TABLE IF NOT EXISTS `laboratory_e` (
`id` char(8)
,`name` varchar(60)
,`contactid` varchar(60)
,`comment` text
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'laboratory_log'
--

CREATE TABLE IF NOT EXISTS laboratory_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  contactid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  `comment` text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'literature'
--

CREATE TABLE IF NOT EXISTS literature (
  id char(8) collate utf8_unicode_ci NOT NULL,
  author varchar(255) collate utf8_unicode_ci NOT NULL,
  `name` text collate utf8_unicode_ci,
  company varchar(60) collate utf8_unicode_ci default NULL,
  town varchar(60) collate utf8_unicode_ci default NULL,
  journal varchar(60) collate utf8_unicode_ci default NULL,
  `year` smallint(6) default NULL,
  number smallint(6) default NULL,
  volume smallint(6) default NULL,
  pages varchar(60) collate utf8_unicode_ci default NULL,
  `comment` text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  isbn varchar(30) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'literature_log'
--

CREATE TABLE IF NOT EXISTS literature_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) collate utf8_unicode_ci NOT NULL,
  author varchar(255) collate utf8_unicode_ci NOT NULL,
  title text collate utf8_unicode_ci,
  editor varchar(60) collate utf8_unicode_ci default NULL,
  company varchar(60) collate utf8_unicode_ci default NULL,
  town varchar(60) collate utf8_unicode_ci default NULL,
  journal varchar(60) collate utf8_unicode_ci default NULL,
  `year` smallint(6) default NULL,
  number smallint(6) default NULL,
  volume smallint(6) default NULL,
  pages varchar(60) collate utf8_unicode_ci default NULL,
  `comment` text collate utf8_unicode_ci,
  updatetype char(1) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (logid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'measpol'
--

CREATE TABLE IF NOT EXISTS measpol (
  measureid int(11) NOT NULL,
  policyid int(11) NOT NULL,
  PRIMARY KEY  (measureid,policyid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'measpol_log'
--

CREATE TABLE IF NOT EXISTS measpol_log (
  logid int(11) NOT NULL auto_increment,
  measureid int(11) NOT NULL,
  policyid int(11) NOT NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'measure'
--

CREATE TABLE IF NOT EXISTS measure (
  id int(11) NOT NULL auto_increment,
  sampleid int(11) NOT NULL,
  methodid char(8) collate utf8_unicode_ci NOT NULL,
  laboratoryid char(8) collate utf8_unicode_ci NOT NULL,
  nuclideid char(4) collate utf8_unicode_ci NOT NULL,
  `value` double default NULL,
  unit char(4) collate utf8_unicode_ci default NULL,
  prec double default NULL,
  measuredate timestamp NULL default NULL,
  refdate timestamp NULL default NULL,
  quality char(1) collate utf8_unicode_ci default NULL,
  detlimit double default NULL,
  underdetlimit tinyint(1) default '0',
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=67860 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'measure_e'
--
CREATE TABLE IF NOT EXISTS `measure_e` (
`id` int(11)
,`sampleid` int(11)
,`methodid` char(8)
,`laboratoryid` char(8)
,`nuclideid` char(4)
,`value` double
,`unit` char(4)
,`prec` double
,`measuredate` timestamp
,`refdate` timestamp
,`quality` char(1)
,`detlimit` double
,`underdetlimit` tinyint(1)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'measure_log'
--

CREATE TABLE IF NOT EXISTS measure_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) default NULL,
  sampleid int(11) NOT NULL,
  methodid char(8) collate utf8_unicode_ci NOT NULL,
  laboratoryid char(8) collate utf8_unicode_ci NOT NULL,
  nuclideid char(4) collate utf8_unicode_ci NOT NULL,
  `value` double default NULL,
  unit char(4) collate utf8_unicode_ci default NULL,
  prec double default NULL,
  measuredate timestamp NULL default NULL,
  refdate timestamp NULL default NULL,
  quality char(1) collate utf8_unicode_ci default NULL,
  detlimit double default NULL,
  underdetlimit tinyint(1) default '0',
  measuretype char(4) collate utf8_unicode_ci default 'SAMP',
  policyid int(11) default NULL,
  updatetype char(1) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (logid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'method'
--

CREATE TABLE IF NOT EXISTS method (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  detlimit double default NULL,
  unit char(4) collate utf8_unicode_ci default NULL,
  description text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'method_log'
--

CREATE TABLE IF NOT EXISTS method_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  detlimit double default NULL,
  unit char(4) character set utf8 collate utf8_unicode_ci default NULL,
  description text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'monitoringprogramme'
--

CREATE TABLE IF NOT EXISTS monitoringprogramme (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  `type` char(4) collate utf8_unicode_ci default NULL,
  compartment char(4) collate utf8_unicode_ci default NULL,
  laboratoryid char(8) collate utf8_unicode_ci default NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'monitoringprogramme_e'
--
CREATE TABLE IF NOT EXISTS `monitoringprogramme_e` (
`id` char(8)
,`name` varchar(60)
,`type` char(4)
,`compartment` char(4)
,`laboratoryid` varchar(60)
,`contactid` varchar(60)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'monitoringprogramme_log'
--

CREATE TABLE IF NOT EXISTS monitoringprogramme_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  `type` char(4) character set utf8 collate utf8_unicode_ci default NULL,
  compartment char(4) character set utf8 collate utf8_unicode_ci default NULL,
  laboratoryid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  contactid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'monitoringstation'
--

CREATE TABLE IF NOT EXISTS monitoringstation (
  id int(11) NOT NULL auto_increment,
  stationid char(8) collate utf8_unicode_ci NOT NULL,
  monitoringprogrammeid char(8) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2748 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'monitoringstations'
--
CREATE TABLE IF NOT EXISTS `monitoringstations` (
`programme` varchar(60)
,`station` varchar(60)
,`lat` double
,`lon` double
,`country` varchar(60)
,`sampletype` char(4)
,`compartment` char(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'monitoringstation_e'
--
CREATE TABLE IF NOT EXISTS `monitoringstation_e` (
`id` int(11)
,`stationid` varchar(60)
,`monitoringprogrammeid` varchar(60)
);
-- --------------------------------------------------------

--
-- Table structure for table 'monitoringstation_log'
--

CREATE TABLE IF NOT EXISTS monitoringstation_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  stationid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  monitoringprogrammeid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'monitoringstation_name'
--
CREATE TABLE IF NOT EXISTS `monitoringstation_name` (
`id` int(11)
,`name` varchar(123)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'npps'
--
CREATE TABLE IF NOT EXISTS `npps` (
`lat` double
,`lon` double
,`country` varchar(60)
,`name` varchar(60)
,`n_reactors` bigint(21)
,`effect` decimal(32,0)
,`status` char(4)
);
-- --------------------------------------------------------

--
-- Table structure for table 'nuclide'
--

CREATE TABLE IF NOT EXISTS nuclide (
  id char(4) collate utf8_unicode_ci NOT NULL,
  thalfyear double default NULL,
  daughter char(4) collate utf8_unicode_ci default NULL,
  dosefactor double default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  `name` varchar(60) collate utf8_unicode_ci default NULL,
  `no` int(11) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'nuclide_log'
--

CREATE TABLE IF NOT EXISTS nuclide_log (
  logid int(11) NOT NULL auto_increment,
  id char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  thalfyear double default NULL,
  daughter char(4) character set utf8 collate utf8_unicode_ci default NULL,
  dosefactor double default NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  `no` int(11) default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'nuctest'
--

CREATE TABLE IF NOT EXISTS nuctest (
  id int(11) NOT NULL auto_increment,
  sourceid char(8) collate utf8_unicode_ci NOT NULL,
  yield char(60) collate utf8_unicode_ci default NULL,
  surfwavemagn double default NULL,
  bodywavemagn double default NULL,
  purpose char(60) collate utf8_unicode_ci default NULL,
  devicetype char(60) collate utf8_unicode_ci default NULL,
  `type` char(60) collate utf8_unicode_ci default NULL,
  rocktype char(60) collate utf8_unicode_ci default NULL,
  testingparty char(60) collate utf8_unicode_ci default NULL,
  referencesource text collate utf8_unicode_ci,
  testsite char(8) collate utf8_unicode_ci NOT NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Nuclear tests' AUTO_INCREMENT=161 ;

-- --------------------------------------------------------

--
-- Table structure for table 'nuctest_log'
--

CREATE TABLE IF NOT EXISTS nuctest_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  sourceid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  yield char(60) character set utf8 collate utf8_unicode_ci default NULL,
  surfwavemagn double default NULL,
  bodywavemagn double default NULL,
  purpose char(60) character set utf8 collate utf8_unicode_ci default NULL,
  devicetype char(60) character set utf8 collate utf8_unicode_ci default NULL,
  `type` char(60) character set utf8 collate utf8_unicode_ci default NULL,
  rocktype char(60) character set utf8 collate utf8_unicode_ci default NULL,
  testingparty char(60) character set utf8 collate utf8_unicode_ci default NULL,
  referencesource text character set utf8 collate utf8_unicode_ci,
  testsite char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'parameter'
--

CREATE TABLE IF NOT EXISTS parameter (
  id int(11) NOT NULL auto_increment,
  sampleid int(11) NOT NULL,
  laboratoryid char(8) collate utf8_unicode_ci default NULL,
  parameter char(4) collate utf8_unicode_ci NOT NULL,
  `value` double default NULL,
  prec double default NULL,
  unit char(4) collate utf8_unicode_ci default NULL,
  underdetlimit tinyint(1) default '0',
  description varchar(255) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=32693 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'parameter_e'
--
CREATE TABLE IF NOT EXISTS `parameter_e` (
`id` int(11)
,`sampleid` int(11)
,`laboratoryid` char(8)
,`parameter` char(4)
,`value` double
,`prec` double
,`unit` char(4)
,`underdetlimit` tinyint(1)
,`description` varchar(255)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'parameter_log'
--

CREATE TABLE IF NOT EXISTS parameter_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  sampleid int(11) NOT NULL,
  laboratoryid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  parameter char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  `value` double default NULL,
  prec double default NULL,
  unit char(4) character set utf8 collate utf8_unicode_ci default NULL,
  underdetlimit tinyint(1) default '0',
  description varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'policy'
--

CREATE TABLE IF NOT EXISTS policy (
  id int(11) NOT NULL auto_increment,
  rawfree timestamp NULL default NULL,
  aggregatefree timestamp NULL default NULL,
  catalogfree timestamp NULL default NULL,
  publicdomain tinyint(1) default '0',
  `comment` text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table 'policy_log'
--

CREATE TABLE IF NOT EXISTS policy_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  rawfree timestamp NULL default NULL,
  aggregatefree timestamp NULL default NULL,
  catalogfree timestamp NULL default NULL,
  publicdomain tinyint(1) default '0',
  `comment` text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'project'
--

CREATE TABLE IF NOT EXISTS project (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  org varchar(60) collate utf8_unicode_ci default NULL,
  spathmos tinyint(1) default '0',
  spterr tinyint(1) default '0',
  spfresh tinyint(1) default '0',
  spmarine tinyint(1) default '0',
  sphealth tinyint(1) default '0',
  `comment` text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'projectdata'
--
CREATE TABLE IF NOT EXISTS `projectdata` (
`date` varbinary(20)
,`value` double
,`nuclideid` char(4)
,`unit` char(4)
,`type` char(4)
,`compartment` char(4)
,`projectid` char(8)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'project_e'
--
CREATE TABLE IF NOT EXISTS `project_e` (
`id` char(8)
,`name` varchar(60)
,`contactid` varchar(60)
,`org` varchar(60)
,`spathmos` tinyint(1)
,`spterr` tinyint(1)
,`spfresh` tinyint(1)
,`spmarine` tinyint(1)
,`sphealth` tinyint(1)
,`comment` text
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'project_log'
--

CREATE TABLE IF NOT EXISTS project_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  contactid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  org varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  spathmos tinyint(1) default '0',
  spterr tinyint(1) default '0',
  spfresh tinyint(1) default '0',
  spmarine tinyint(1) default '0',
  sphealth tinyint(1) default '0',
  `comment` text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'qaqc'
--

CREATE TABLE IF NOT EXISTS qaqc (
  id int(11) NOT NULL auto_increment,
  methodid char(8) collate utf8_unicode_ci NOT NULL,
  laboratoryid char(8) collate utf8_unicode_ci NOT NULL,
  compstat char(4) collate utf8_unicode_ci default NULL,
  compinst varchar(60) collate utf8_unicode_ci default NULL,
  compyear smallint(6) default NULL,
  compresult text collate utf8_unicode_ci,
  docq tinyint(1) NOT NULL,
  spec text collate utf8_unicode_ci,
  isosertified tinyint(1) NOT NULL,
  qualityrank char(1) collate utf8_unicode_ci default NULL,
  validfrom timestamp NULL default NULL,
  `comment` text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

-- --------------------------------------------------------

--
-- Table structure for table 'qaqc_log'
--

CREATE TABLE IF NOT EXISTS qaqc_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  methodid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  laboratoryid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  compstat char(4) character set utf8 collate utf8_unicode_ci default NULL,
  compinst varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  compyear smallint(6) default NULL,
  compresult text character set utf8 collate utf8_unicode_ci,
  docq tinyint(1) NOT NULL,
  spec text character set utf8 collate utf8_unicode_ci,
  isosertified tinyint(1) NOT NULL,
  qualityrank char(1) character set utf8 collate utf8_unicode_ci default NULL,
  validfrom timestamp NULL default NULL,
  `comment` text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'reactor'
--

CREATE TABLE IF NOT EXISTS reactor (
  id int(11) NOT NULL auto_increment,
  sourceid char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(30) collate utf8_unicode_ci NOT NULL,
  `type` varchar(30) collate utf8_unicode_ci NOT NULL,
  `status` char(4) collate utf8_unicode_ci NOT NULL,
  startup varchar(30) collate utf8_unicode_ci default NULL,
  history text collate utf8_unicode_ci,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  mw_net int(11) default NULL,
  mw_el int(11) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Nuclear Power Reactors' AUTO_INCREMENT=406 ;

-- --------------------------------------------------------

--
-- Table structure for table 'reactor_log'
--

CREATE TABLE IF NOT EXISTS reactor_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  sourceid char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(30) character set utf8 collate utf8_unicode_ci NOT NULL,
  `type` varchar(30) character set utf8 collate utf8_unicode_ci NOT NULL,
  `status` char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  startup varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  history text character set utf8 collate utf8_unicode_ci,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  mw_net int(11) default NULL,
  mw_el int(11) default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'releasedata'
--
CREATE TABLE IF NOT EXISTS `releasedata` (
`year` int(11)
,`amount` double
,`unit` char(4)
,`nuclideid` char(4)
,`sourceid` char(8)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'releases'
--
CREATE TABLE IF NOT EXISTS `releases` (
`date` varbinary(17)
,`amount` double
,`unit` char(4)
,`nuclideid` char(4)
,`sourceid` char(8)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'rpps'
--
CREATE TABLE IF NOT EXISTS `rpps` (
`lat` double
,`lon` double
,`name` varchar(60)
,`country` varchar(60)
);
-- --------------------------------------------------------

--
-- Table structure for table 'sample'
--

CREATE TABLE IF NOT EXISTS sample (
  id int(11) NOT NULL,
  main int(11) NOT NULL,
  sub smallint(6) NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci default NULL,
  stationid char(8) collate utf8_unicode_ci NOT NULL,
  projectid char(8) collate utf8_unicode_ci default NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  `type` char(4) collate utf8_unicode_ci NOT NULL,
  noofsamples int(11) default '1',
  `year` smallint(6) default NULL,
  `month` smallint(6) default NULL,
  `day` smallint(6) default NULL,
  compartment char(4) collate utf8_unicode_ci default NULL,
  weight double default NULL,
  weightunit char(4) collate utf8_unicode_ci default NULL,
  profdepthfrom double default NULL,
  profdepthto double default NULL,
  profunit char(4) collate utf8_unicode_ci default NULL,
  literatureid char(8) collate utf8_unicode_ci default NULL,
  dataowner char(8) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Samples';

-- --------------------------------------------------------

--
-- Stand-in structure for view 'sample_data'
--
CREATE TABLE IF NOT EXISTS `sample_data` (
`date` decimal(11,4)
,`value` double
,`prec` double
,`underdetlimit` tinyint(1)
,`type` char(4)
,`compartment` char(4)
,`nuclide` varchar(60)
,`nuclideno` int(11)
,`unit` char(4)
,`projectid` char(8)
,`location` varchar(60)
,`lat` double
,`lon` double
,`country` varchar(60)
,`stationid` char(8)
,`year` smallint(6)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'sample_data_old'
--
CREATE TABLE IF NOT EXISTS `sample_data_old` (
`date` decimal(11,4)
,`value` double
,`prec` double
,`underdetlimit` tinyint(1)
,`type` char(4)
,`compartment` char(4)
,`nuclide` varchar(60)
,`nuclideno` int(11)
,`unit` char(4)
,`projectid` char(8)
,`location` varchar(60)
,`lat` double
,`lon` double
,`country` varchar(60)
,`stationid` char(8)
,`year` smallint(6)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'sample_e'
--
CREATE TABLE IF NOT EXISTS `sample_e` (
`id` int(11)
,`main` int(11)
,`sub` smallint(6)
,`stationid` varchar(60)
,`projectid` varchar(60)
,`contactid` varchar(60)
,`type` varchar(60)
,`noofsamples` int(11)
,`year` smallint(6)
,`month` smallint(6)
,`day` smallint(6)
,`compartment` char(4)
,`weight` double
,`weightunit` char(4)
,`profdepthfrom` double
,`profdepthto` double
,`profunit` char(4)
,`literatureid` text
,`dataowner` char(8)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'sample_log'
--

CREATE TABLE IF NOT EXISTS sample_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) default NULL,
  main int(11) NOT NULL,
  sub smallint(6) NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci default NULL,
  stationid char(8) collate utf8_unicode_ci NOT NULL,
  projectid char(8) collate utf8_unicode_ci default NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  `type` char(4) collate utf8_unicode_ci NOT NULL,
  methodid char(8) collate utf8_unicode_ci default NULL,
  noofsamples int(11) default '1',
  `year` smallint(6) default NULL,
  `month` smallint(6) default NULL,
  `day` smallint(6) default NULL,
  compartment char(4) collate utf8_unicode_ci default NULL,
  weight double default NULL,
  weightunit char(4) collate utf8_unicode_ci default NULL,
  profdepthfrom double default NULL,
  profdepthto double default NULL,
  profunit char(4) collate utf8_unicode_ci default NULL,
  literatureid char(8) collate utf8_unicode_ci default NULL,
  dataowner char(8) collate utf8_unicode_ci default NULL,
  updatetype char(1) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby char(20) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (logid),
  KEY alterby (alterby)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'sessionlist'
--

CREATE TABLE IF NOT EXISTS sessionlist (
  id char(32) collate utf8_unicode_ci NOT NULL,
  userid int(11) NOT NULL,
  `grants` int(11) NOT NULL,
  ip char(15) collate utf8_unicode_ci NOT NULL,
  timeout timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='__system__';

-- --------------------------------------------------------

--
-- Table structure for table 'source'
--

CREATE TABLE IF NOT EXISTS `source` (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  stationid char(8) collate utf8_unicode_ci default NULL,
  contactid char(8) collate utf8_unicode_ci default NULL,
  `type` char(4) collate utf8_unicode_ci NOT NULL,
  descr text collate utf8_unicode_ci,
  event datetime default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id),
  KEY FK_source_station (stationid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'sources'
--
CREATE TABLE IF NOT EXISTS `sources` (
`name` varchar(60)
,`lat` double
,`lon` double
,`type` varchar(60)
,`code` char(4)
,`country` varchar(60)
,`id` char(8)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'sources_cat'
--
CREATE TABLE IF NOT EXISTS `sources_cat` (
`lat` double
,`lon` double
,`category` int(11)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'sourcetype'
--
CREATE TABLE IF NOT EXISTS `sourcetype` (
`id` char(4)
,`name` varchar(60)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'source_e'
--
CREATE TABLE IF NOT EXISTS `source_e` (
`id` char(8)
,`name` varchar(60)
,`stationid` varchar(60)
,`contactid` varchar(60)
,`type` varchar(60)
,`descr` text
,`event` datetime
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'source_log'
--

CREATE TABLE IF NOT EXISTS source_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) character set utf8 collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci NOT NULL,
  stationid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  contactid char(8) character set utf8 collate utf8_unicode_ci default NULL,
  `type` char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  descr text character set utf8 collate utf8_unicode_ci,
  event datetime default NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Table structure for table 'station'
--

CREATE TABLE IF NOT EXISTS station (
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  lat double NOT NULL,
  lon double NOT NULL,
  height double default NULL,
  county varchar(60) collate utf8_unicode_ci default NULL,
  country varchar(60) collate utf8_unicode_ci default NULL,
  `comment` text collate utf8_unicode_ci,
  `type` char(4) collate utf8_unicode_ci default 'PNTL',
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'station_log'
--

CREATE TABLE IF NOT EXISTS station_log (
  logid int(11) NOT NULL auto_increment,
  id char(8) collate utf8_unicode_ci NOT NULL,
  `name` varchar(60) collate utf8_unicode_ci NOT NULL,
  lat double NOT NULL,
  lon double NOT NULL,
  height double default NULL,
  county varchar(60) collate utf8_unicode_ci default NULL,
  country varchar(60) collate utf8_unicode_ci default NULL,
  `comment` text collate utf8_unicode_ci,
  `type` char(4) collate utf8_unicode_ci default 'PNTL',
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  loguser varchar(30) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (logid),
  KEY loguser (loguser)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

-- --------------------------------------------------------

--
-- Table structure for table 'textparameter'
--

CREATE TABLE IF NOT EXISTS textparameter (
  id int(11) default NULL,
  sampleid int(11) default NULL,
  laboratoryid char(4) collate utf8_unicode_ci default NULL,
  parameter char(4) collate utf8_unicode_ci default NULL,
  description varchar(255) collate utf8_unicode_ci default NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'textparameter_e'
--
CREATE TABLE IF NOT EXISTS `textparameter_e` (
`id` int(11)
,`sampleid` int(11)
,`laboratoryid` char(4)
,`parameter` char(4)
,`description` varchar(255)
,`username` varchar(30)
,`addtime` timestamp
);
-- --------------------------------------------------------

--
-- Table structure for table 'textparameter_log'
--

CREATE TABLE IF NOT EXISTS textparameter_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) default NULL,
  sampleid int(11) default NULL,
  laboratoryid char(4) character set utf8 collate utf8_unicode_ci default NULL,
  parameter char(4) character set utf8 collate utf8_unicode_ci default NULL,
  description varchar(255) character set utf8 collate utf8_unicode_ci default NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view 'type'
--
CREATE TABLE IF NOT EXISTS `type` (
`id` char(4)
,`name` varchar(60)
,`addtime` timestamp
,`username` varchar(30)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'typelist'
--
CREATE TABLE IF NOT EXISTS `typelist` (
`name` varchar(60)
,`id` char(4)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view 'typesinuse'
--
CREATE TABLE IF NOT EXISTS `typesinuse` (
`name` varchar(60)
,`id` char(4)
);
-- --------------------------------------------------------

--
-- Table structure for table 'unit'
--

CREATE TABLE IF NOT EXISTS unit (
  id int(11) NOT NULL auto_increment,
  unit char(4) collate utf8_unicode_ci NOT NULL,
  relunit char(4) collate utf8_unicode_ci default NULL,
  factor double NOT NULL,
  username varchar(30) collate utf8_unicode_ci default NULL,
  addtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  `name` varchar(60) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- Table structure for table 'unit_log'
--

CREATE TABLE IF NOT EXISTS unit_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL default '0',
  unit char(4) character set utf8 collate utf8_unicode_ci NOT NULL,
  relunit char(4) character set utf8 collate utf8_unicode_ci default NULL,
  factor double NOT NULL,
  username varchar(30) character set utf8 collate utf8_unicode_ci default NULL,
  addtime timestamp NULL default NULL,
  `name` varchar(60) character set utf8 collate utf8_unicode_ci default NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'user'
--

CREATE TABLE IF NOT EXISTS `user` (
  id bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(200) default NULL,
  email varchar(256) default NULL,
  institute varchar(256) default NULL,
  country varchar(50) default NULL,
  username char(10) NOT NULL default '',
  usertype smallint(5) unsigned NOT NULL default '1',
  homepage varchar(255) default NULL,
  tel varchar(25) default NULL,
  `password` char(32) default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='__system__' AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Table structure for table 'usertype'
--

CREATE TABLE IF NOT EXISTS usertype (
  id int(11) NOT NULL,
  `name` varchar(128) collate utf8_unicode_ci NOT NULL,
  shortname varchar(10) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (id),
  UNIQUE KEY `name` (`name`,shortname)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'usertype_log'
--

CREATE TABLE IF NOT EXISTS usertype_log (
  logid int(11) NOT NULL auto_increment,
  id int(11) NOT NULL,
  `name` varchar(128) character set utf8 collate utf8_unicode_ci NOT NULL,
  shortname varchar(10) character set utf8 collate utf8_unicode_ci NOT NULL,
  logtime timestamp NOT NULL default CURRENT_TIMESTAMP,
  alterby varchar(64) NOT NULL,
  PRIMARY KEY  (logid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table 'user_log'
--

CREATE TABLE IF NOT EXISTS user_log (
  id bigint(20) unsigned default NULL,
  `name` varchar(200) collate utf8_unicode_ci default NULL,
  email varchar(256) collate utf8_unicode_ci default NULL,
  institute varchar(256) collate utf8_unicode_ci default NULL,
  country varchar(50) collate utf8_unicode_ci default NULL,
  username char(10) collate utf8_unicode_ci NOT NULL default '',
  usertype smallint(5) unsigned NOT NULL default '1',
  `password` char(32) collate utf8_unicode_ci default NULL,
  ip char(15) collate utf8_unicode_ci default NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  logid bigint(20) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (logid)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Structure for view 'code_lt'
--
DROP TABLE IF EXISTS `code_lt`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW code_lt AS select `code`.id AS id,`code`.`type` AS `type`,`code`.`name` AS `name`,`code`.username AS username,`code`.addtime AS addtime,`code`.category AS category from `code` where (`code`.`type` = _utf8'LT');

-- --------------------------------------------------------

--
-- Structure for view 'code_rn'
--
DROP TABLE IF EXISTS `code_rn`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW code_rn AS select `code`.id AS id,`code`.`name` AS `name` from `code` where (`code`.`type` = _utf8'RN');

-- --------------------------------------------------------

--
-- Structure for view 'code_st'
--
DROP TABLE IF EXISTS `code_st`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW code_st AS select `code`.id AS id,`code`.`type` AS `type`,`code`.`name` AS `name`,`code`.username AS username,`code`.addtime AS addtime,`code`.category AS category from `code` where (`code`.`type` = _utf8'st');

-- --------------------------------------------------------

--
-- Structure for view 'code_sy'
--
DROP TABLE IF EXISTS `code_sy`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW code_sy AS select `code`.id AS id,`code`.`name` AS `name` from `code` where (`code`.`type` = _utf8'SY');

-- --------------------------------------------------------

--
-- Structure for view 'content_e'
--
DROP TABLE IF EXISTS `content_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW content_e AS select c.id AS id,`source`.`name` AS sourceid,contact.`name` AS contactid,nuclide.`name` AS nuclideid,literature.`name` AS literatureid,c.valid AS valid,c.amount AS amount,c.unit AS unit,c.chemform AS chemform,c.released AS released,c.`year` AS `year`,c.username AS username,c.addtime AS addtime from ((((content c left join `source` on((c.sourceid = `source`.id))) join (content c1 left join contact on((c1.contactid = contact.id)))) join (content c2 left join nuclide on((c2.nuclideid = nuclide.id)))) join (content c3 left join literature on((c3.literatureid = literature.id)))) where ((c.id = c1.id) and (c.id = c2.id) and (c.id = c3.id));

-- --------------------------------------------------------

--
-- Structure for view 'content_name'
--
DROP TABLE IF EXISTS `content_name`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW content_name AS select concat(s.`name`,_utf8' ',c.amount,_utf8' ',c.unit,_utf8' ',c.nuclideid) AS `name`,c.id AS id from (content c join `source` s) where (s.id = c.sourceid);

-- --------------------------------------------------------

--
-- Structure for view 'laboratory_e'
--
DROP TABLE IF EXISTS `laboratory_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW laboratory_e AS select l.id AS id,l.`name` AS `name`,c.`name` AS contactid,l.`comment` AS `comment`,l.username AS username,l.addtime AS addtime from (laboratory l left join contact c on((c.id = l.contactid)));

-- --------------------------------------------------------

--
-- Structure for view 'measure_e'
--
DROP TABLE IF EXISTS `measure_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW measure_e AS select measure.id AS id,measure.sampleid AS sampleid,measure.methodid AS methodid,measure.laboratoryid AS laboratoryid,measure.nuclideid AS nuclideid,measure.`value` AS `value`,measure.unit AS unit,measure.prec AS prec,measure.measuredate AS measuredate,measure.refdate AS refdate,measure.quality AS quality,measure.detlimit AS detlimit,measure.underdetlimit AS underdetlimit,measure.username AS username,measure.addtime AS addtime from measure;

-- --------------------------------------------------------

--
-- Structure for view 'monitoringprogramme_e'
--
DROP TABLE IF EXISTS `monitoringprogramme_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW monitoringprogramme_e AS select m.id AS id,m.`name` AS `name`,m.`type` AS `type`,m.compartment AS compartment,l.`name` AS laboratoryid,c.`name` AS contactid,m.username AS username,m.addtime AS addtime from ((monitoringprogramme m left join laboratory l on((m.laboratoryid = l.id))) join (monitoringprogramme m1 left join contact c on((m1.contactid = c.id)))) where (m1.id = m.id);

-- --------------------------------------------------------

--
-- Structure for view 'monitoringstations'
--
DROP TABLE IF EXISTS `monitoringstations`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW monitoringstations AS select monitoringprogramme.`name` AS programme,station.`name` AS station,station.lat AS lat,station.lon AS lon,station.country AS country,monitoringprogramme.`type` AS sampletype,monitoringprogramme.compartment AS compartment from ((station join monitoringstation) join monitoringprogramme) where ((station.id = monitoringstation.stationid) and (monitoringstation.monitoringprogrammeid = monitoringprogramme.id));

-- --------------------------------------------------------

--
-- Structure for view 'monitoringstation_e'
--
DROP TABLE IF EXISTS `monitoringstation_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW monitoringstation_e AS select m.id AS id,s.`name` AS stationid,mp.`name` AS monitoringprogrammeid from ((monitoringstation m join station s) join monitoringprogramme mp) where ((s.id = m.stationid) and (mp.id = m.monitoringprogrammeid));

-- --------------------------------------------------------

--
-- Structure for view 'monitoringstation_name'
--
DROP TABLE IF EXISTS `monitoringstation_name`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW monitoringstation_name AS select ms.id AS id,concat(st.`name`,_utf8' - ',mp.`name`) AS `name` from ((monitoringstation ms join station st) join monitoringprogramme mp) where ((st.id = ms.stationid) and (mp.id = ms.monitoringprogrammeid));

-- --------------------------------------------------------

--
-- Structure for view 'npps'
--
DROP TABLE IF EXISTS `npps`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW npps AS select station.lat AS lat,station.lon AS lon,station.country AS country,`source`.`name` AS `name`,count(reactor.id) AS n_reactors,sum(reactor.mw_el) AS effect,reactor.`status` AS `status` from ((station join `source`) join reactor) where ((station.id = `source`.stationid) and (`source`.id = reactor.sourceid)) group by station.lat,station.lon,station.country,`source`.`name`,reactor.`status` order by station.country,reactor.`status`,`source`.`name`;

-- --------------------------------------------------------

--
-- Structure for view 'parameter_e'
--
DROP TABLE IF EXISTS `parameter_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW parameter_e AS select parameter.id AS id,parameter.sampleid AS sampleid,parameter.laboratoryid AS laboratoryid,parameter.parameter AS parameter,parameter.`value` AS `value`,parameter.prec AS prec,parameter.unit AS unit,parameter.underdetlimit AS underdetlimit,parameter.description AS description,parameter.username AS username,parameter.addtime AS addtime from parameter;

-- --------------------------------------------------------

--
-- Structure for view 'projectdata'
--
DROP TABLE IF EXISTS `projectdata`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW projectdata AS select concat(sample.`day`,_utf8'.',sample.`month`,_utf8'.',sample.`year`) AS `date`,measure.`value` AS `value`,measure.nuclideid AS nuclideid,measure.unit AS unit,sample.`type` AS `type`,sample.compartment AS compartment,sample.projectid AS projectid from (sample join measure) where (sample.id = measure.sampleid);

-- --------------------------------------------------------

--
-- Structure for view 'project_e'
--
DROP TABLE IF EXISTS `project_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW project_e AS select p.id AS id,p.`name` AS `name`,c.`name` AS contactid,p.org AS org,p.spathmos AS spathmos,p.spterr AS spterr,p.spfresh AS spfresh,p.spmarine AS spmarine,p.sphealth AS sphealth,p.`comment` AS `comment`,p.username AS username,p.addtime AS addtime from (project p left join contact c on((p.contactid = c.id)));

-- --------------------------------------------------------

--
-- Structure for view 'releasedata'
--
DROP TABLE IF EXISTS `releasedata`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW releasedata AS select content.`year` AS `year`,content.amount AS amount,content.unit AS unit,content.nuclideid AS nuclideid,content.sourceid AS sourceid from content where (content.released = 1);

-- --------------------------------------------------------

--
-- Structure for view 'releases'
--
DROP TABLE IF EXISTS `releases`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW releases AS select concat(_utf8'01.07.',content.`year`) AS `date`,content.amount AS amount,content.unit AS unit,content.nuclideid AS nuclideid,content.sourceid AS sourceid from content where (content.released = 1);

-- --------------------------------------------------------

--
-- Structure for view 'rpps'
--
DROP TABLE IF EXISTS `rpps`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW rpps AS select station.lat AS lat,station.lon AS lon,`source`.`name` AS `name`,station.country AS country from (station join `source`) where ((station.id = `source`.stationid) and (`source`.`type` = _utf8'RPP'));

-- --------------------------------------------------------

--
-- Structure for view 'sample_data'
--
DROP TABLE IF EXISTS `sample_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sample_data AS select (((sample.`day` / 365) + (sample.`month` / 12)) + sample.`year`) AS `date`,measure.`value` AS `value`,measure.prec AS prec,measure.underdetlimit AS underdetlimit,sample.`type` AS `type`,sample.compartment AS compartment,nuclide.`name` AS nuclide,nuclide.`no` AS nuclideno,measure.unit AS unit,sample.projectid AS projectid,station.`name` AS location,station.lat AS lat,station.lon AS lon,station.country AS country,sample.stationid AS stationid,sample.`year` AS `year` from (((sample join measure) join nuclide) join station) where ((station.id = sample.stationid) and (sample.id = measure.sampleid) and (nuclide.id = measure.nuclideid) and ((sample.profdepthfrom < 10) or isnull(sample.profdepthfrom)));

-- --------------------------------------------------------

--
-- Structure for view 'sample_data_old'
--
DROP TABLE IF EXISTS `sample_data_old`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sample_data_old AS select (((sample.`day` / 365) + (sample.`month` / 12)) + sample.`year`) AS `date`,measure.`value` AS `value`,measure.prec AS prec,measure.underdetlimit AS underdetlimit,sample.`type` AS `type`,sample.compartment AS compartment,nuclide.`name` AS nuclide,nuclide.`no` AS nuclideno,measure.unit AS unit,sample.projectid AS projectid,station.`name` AS location,station.lat AS lat,station.lon AS lon,station.country AS country,sample.stationid AS stationid,sample.`year` AS `year` from (((sample join measure) join nuclide) join station) where ((station.id = sample.stationid) and (sample.id = measure.sampleid) and (nuclide.id = measure.nuclideid) and ((sample.profdepthfrom < 10) or isnull(sample.profdepthfrom)));

-- --------------------------------------------------------

--
-- Structure for view 'sample_e'
--
DROP TABLE IF EXISTS `sample_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sample_e AS select s.id AS id,s.main AS main,s.sub AS sub,st.`name` AS stationid,p.`name` AS projectid,c.`name` AS contactid,`code`.`name` AS `type`,s.noofsamples AS noofsamples,s.`year` AS `year`,s.`month` AS `month`,s.`day` AS `day`,s.compartment AS compartment,s.weight AS weight,s.weightunit AS weightunit,s.profdepthfrom AS profdepthfrom,s.profdepthto AS profdepthto,s.profunit AS profunit,literature.`name` AS literatureid,s.dataowner AS dataowner,s.username AS username,s.addtime AS addtime from (((((sample s left join contact c on((s.contactid = c.id))) join station st) join project p) join `code`) join (sample s1 left join literature on((s1.literatureid = literature.id)))) where ((s.stationid = st.id) and (s.projectid = p.id) and (s.id = s1.id) and (`code`.id = s.`type`));

-- --------------------------------------------------------

--
-- Structure for view 'sources'
--
DROP TABLE IF EXISTS `sources`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sources AS select `source`.`name` AS `name`,station.lat AS lat,station.lon AS lon,`code`.`name` AS `type`,`source`.`type` AS `code`,station.country AS country,`source`.id AS id from ((station join `source`) join `code`) where ((station.id = `source`.stationid) and (`source`.`type` = `code`.id));

-- --------------------------------------------------------

--
-- Structure for view 'sources_cat'
--
DROP TABLE IF EXISTS `sources_cat`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sources_cat AS select station.lat AS lat,station.lon AS lon,`code`.category AS category from ((station join `source`) join `code`) where ((`code`.id = `source`.`type`) and (station.id = `source`.stationid));

-- --------------------------------------------------------

--
-- Structure for view 'sourcetype'
--
DROP TABLE IF EXISTS `sourcetype`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW sourcetype AS select `code`.id AS id,`code`.`name` AS `name` from `code` where (`code`.`type` = _utf8'ST');

-- --------------------------------------------------------

--
-- Structure for view 'source_e'
--
DROP TABLE IF EXISTS `source_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW source_e AS select s.id AS id,s.`name` AS `name`,st.`name` AS stationid,c.`name` AS contactid,co.`name` AS `type`,s.descr AS descr,s.event AS event,s.username AS username,s.addtime AS addtime from (((`source` s left join contact c on((s.contactid = c.id))) join station st) join `code` co) where ((st.id = s.stationid) and (co.id = s.`type`) and (co.`type` = _utf8'ST'));

-- --------------------------------------------------------

--
-- Structure for view 'textparameter_e'
--
DROP TABLE IF EXISTS `textparameter_e`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW textparameter_e AS select textparameter.id AS id,textparameter.sampleid AS sampleid,textparameter.laboratoryid AS laboratoryid,textparameter.parameter AS parameter,textparameter.description AS description,textparameter.username AS username,textparameter.addtime AS addtime from textparameter;

-- --------------------------------------------------------

--
-- Structure for view 'type'
--
DROP TABLE IF EXISTS `type`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW `type` AS select `code`.id AS id,`code`.`name` AS `name`,`code`.addtime AS addtime,`code`.username AS username from `code` where (`code`.`type` = _utf8'SA');

-- --------------------------------------------------------

--
-- Structure for view 'typelist'
--
DROP TABLE IF EXISTS `typelist`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW typelist AS select `code`.`name` AS `name`,`code`.id AS id from `code` where ((`code`.`type` = _utf8'SA') and `code`.id in (select distinct sample.`type` AS `type` from sample));

-- --------------------------------------------------------

--
-- Structure for view 'typesinuse'
--
DROP TABLE IF EXISTS `typesinuse`;

CREATE ALGORITHM=UNDEFINED DEFINER=apache@`%` SQL SECURITY DEFINER VIEW typesinuse AS select `code`.`name` AS `name`,`code`.id AS id from `code` where ((`code`.`type` = _utf8'SA') and `code`.id in (select distinct sample.`type` AS `type` from sample));
