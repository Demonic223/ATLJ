-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: aika_db4
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_validate`
--

DROP TABLE IF EXISTS `account_validate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_validate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `code` varchar(40) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `referrer` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_validate`
--

LOCK TABLES `account_validate` WRITE;
/*!40000 ALTER TABLE `account_validate` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_validate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int(10) unsigned NOT NULL,
  `username` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mail` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `last_token` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `last_token_creation_time` int(10) unsigned DEFAULT NULL,
  `nation` int(10) unsigned DEFAULT NULL,
  `isactive` int(10) unsigned DEFAULT '0',
  `account_status` int(10) unsigned DEFAULT '0',
  `account_type` int(10) unsigned DEFAULT '0',
  `storage_gold` int(10) unsigned DEFAULT '0',
  `cash` int(11) DEFAULT '0',
  `ip_created` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `time_created` int(10) unsigned DEFAULT NULL,
  `premium_time` bigint(20) unsigned NOT NULL DEFAULT '1',
  `ban_days` int(10) unsigned DEFAULT NULL,
  `playtime` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_id` (`forum_id`),
  UNIQUE KEY `username` (`username`,`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=2179 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'admin','21232f297a57a5a743894a0e4a801fc3','admin@gmail.com','8c2429e7fe8c3f5319049de2417a7a2a',7,0,0,0,0,0,0,'127.0.0.1',1673047794,1642714066,0,NULL);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `AuctionId` int(11) NOT NULL AUTO_INCREMENT,
  `Active` int(11) NOT NULL DEFAULT '1',
  `CharacterId` int(11) NOT NULL,
  `ItemType` int(11) NOT NULL,
  `ItemLevel` int(11) NOT NULL,
  `ReinforceLevel` int(11) NOT NULL,
  `RegisterDate` datetime NOT NULL,
  `RegisterTime` int(11) NOT NULL,
  `SellingPrice` int(11) NOT NULL,
  `auction_itemsId` int(11) NOT NULL,
  PRIMARY KEY (`AuctionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction_items`
--

DROP TABLE IF EXISTS `auction_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `item_id` int(10) unsigned NOT NULL,
  `app` int(10) unsigned NOT NULL,
  `identific` int(10) unsigned NOT NULL,
  `effect1_index` int(10) unsigned NOT NULL,
  `effect1_value` int(10) unsigned NOT NULL,
  `effect2_index` int(10) unsigned NOT NULL,
  `effect2_value` int(10) unsigned NOT NULL,
  `effect3_index` int(10) unsigned NOT NULL,
  `effect3_value` int(10) unsigned NOT NULL,
  `min` int(10) unsigned NOT NULL,
  `max` int(10) unsigned NOT NULL,
  `refine` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction_items`
--

LOCK TABLES `auction_items` WRITE;
/*!40000 ALTER TABLE `auction_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buffs`
--

DROP TABLE IF EXISTS `buffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buffs` (
  `buff_index` int(11) NOT NULL,
  `buff_time` bigint(20) NOT NULL,
  `owner_charid` int(11) NOT NULL,
  PRIMARY KEY (`owner_charid`,`buff_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buffs`
--

LOCK TABLES `buffs` WRITE;
/*!40000 ALTER TABLE `buffs` DISABLE KEYS */;
/*!40000 ALTER TABLE `buffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `characters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner_accid` int(10) unsigned NOT NULL,
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `slot` int(10) unsigned NOT NULL,
  `numeric_token` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `numeric_errors` int(10) unsigned DEFAULT NULL,
  `deleted` tinyint(3) unsigned DEFAULT '0',
  `speedmove` int(10) unsigned DEFAULT NULL,
  `rotation` int(10) unsigned DEFAULT NULL,
  `lastlogin` bigint(20) unsigned DEFAULT '1',
  `loggedtime` int(10) unsigned DEFAULT NULL,
  `playerkill` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `classinfo` int(10) unsigned NOT NULL,
  `firstlogin` int(10) unsigned DEFAULT NULL,
  `strength` int(10) unsigned NOT NULL,
  `agility` int(10) unsigned NOT NULL,
  `intelligence` int(10) unsigned NOT NULL,
  `constitution` int(10) unsigned NOT NULL,
  `luck` int(10) unsigned NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `altura` int(10) unsigned NOT NULL,
  `tronco` int(10) unsigned NOT NULL,
  `perna` int(10) unsigned NOT NULL,
  `corpo` int(10) unsigned NOT NULL,
  `curhp` int(10) unsigned DEFAULT NULL,
  `curmp` int(10) unsigned DEFAULT NULL,
  `honor` int(10) unsigned DEFAULT NULL,
  `killpoint` int(10) unsigned DEFAULT NULL,
  `infamia` int(10) unsigned DEFAULT NULL,
  `skillpoint` int(10) unsigned DEFAULT NULL,
  `experience` bigint(20) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `guildindex` int(10) unsigned DEFAULT NULL,
  `gold` int(10) unsigned DEFAULT NULL,
  `posx` int(10) unsigned NOT NULL,
  `posy` int(10) unsigned NOT NULL,
  `creationtime` int(10) unsigned NOT NULL,
  `delete_time` bigint(20) DEFAULT '1',
  `logintime` int(10) unsigned DEFAULT NULL,
  `active_title` int(10) unsigned DEFAULT '0',
  `active_action` int(10) unsigned DEFAULT NULL,
  `tp_positions` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `pranevcnt` int(10) unsigned DEFAULT NULL,
  `saved_posx` int(10) unsigned DEFAULT NULL,
  `saved_posy` int(10) unsigned DEFAULT NULL,
  `last_diary_event` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devires`
--

DROP TABLE IF EXISTS `devires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devires` (
  `devir_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nation_id` int(10) unsigned NOT NULL,
  `slot1_itemid` int(10) unsigned DEFAULT NULL,
  `slot2_itemid` int(10) unsigned DEFAULT NULL,
  `slot3_itemid` int(10) unsigned DEFAULT NULL,
  `slot4_itemid` int(10) unsigned DEFAULT NULL,
  `slot5_itemid` int(10) unsigned DEFAULT NULL,
  `slot1_name` varchar(32) DEFAULT NULL,
  `slot2_name` varchar(32) DEFAULT NULL,
  `slot3_name` varchar(32) DEFAULT NULL,
  `slot4_name` varchar(32) DEFAULT NULL,
  `slot5_name` varchar(32) DEFAULT NULL,
  `slot1_timecap` bigint(20) NOT NULL DEFAULT '1',
  `slot2_timecap` bigint(20) NOT NULL DEFAULT '1',
  `slot3_timecap` bigint(20) NOT NULL DEFAULT '1',
  `slot4_timecap` bigint(20) NOT NULL DEFAULT '1',
  `slot5_timecap` bigint(20) NOT NULL DEFAULT '1',
  `slot1_able` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot2_able` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot3_able` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot4_able` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot5_able` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`devir_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devires`
--

LOCK TABLES `devires` WRITE;
/*!40000 ALTER TABLE `devires` DISABLE KEYS */;
INSERT INTO `devires` VALUES (1,1,0,0,0,0,0,'','','','','',1674381131,1674381753,1674382620,1674383412,1674395283,1,1,1,1,1),(2,1,0,0,0,0,0,'','','','','',1674396131,1674396133,1674396139,-2209161600,-2209161600,1,1,1,0,0),(3,1,0,0,0,0,0,'','','','','',1674384134,1674353421,-2209161600,-2209161600,-2209161600,1,1,0,0,0),(4,1,0,0,0,0,0,'','','','','',1674382964,-2209161600,-2209161600,-2209161600,-2209161600,1,0,0,0,0),(5,1,0,0,0,0,0,'','','','','',-2209161600,-2209161600,-2209161600,-2209161600,-2209161600,0,0,0,0,0),(6,2,0,0,0,0,0,'','','','','',1674381837,1674382596,1674382597,-2209161600,-2209161600,1,1,1,1,1),(7,2,0,0,0,0,0,'','','','','',1674379171,1674379667,-2209161600,-2209161600,-2209161600,1,1,1,0,0),(8,2,0,0,0,0,0,'','','','','',1674380631,-2209161600,-2209161600,-2209161600,-2209161600,1,1,0,0,0),(9,2,0,0,0,0,0,'','','','','',1674363527,-2209161600,-2209161600,-2209161600,-2209161600,1,0,0,0,0),(10,2,0,0,0,0,0,'','','','','',-2209161600,-2209161600,-2209161600,-2209161600,-2209161600,0,0,0,0,0),(11,3,0,0,0,0,0,'','','','','',1674395736,1674395738,1674395851,1674395853,1674395854,1,1,1,1,1),(12,3,0,0,0,0,0,'','','','','',1674395437,1674395439,1674395439,-2209161600,-2209161600,1,1,1,0,0),(13,3,0,0,0,0,0,'','','','','',1674353310,1674359618,-2209161600,-2209161600,-2209161600,1,1,0,0,0),(14,3,0,0,0,0,0,'','','','','',1674349186,-2209161600,-2209161600,-2209161600,-2209161600,1,0,0,0,0),(15,3,0,0,0,0,0,'','','','','',-2209161600,-2209161600,-2209161600,-2209161600,-2209161600,0,0,0,0,0);
/*!40000 ALTER TABLE `devires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donate_users`
--

DROP TABLE IF EXISTS `donate_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donate_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `asaas_id` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`,`asaas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donate_users`
--

LOCK TABLES `donate_users` WRITE;
/*!40000 ALTER TABLE `donate_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `donate_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donates`
--

DROP TABLE IF EXISTS `donates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `asaas_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `icoins` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `refunded` tinyint(1) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donates`
--

LOCK TABLES `donates` WRITE;
/*!40000 ALTER TABLE `donates` DISABLE KEYS */;
/*!40000 ALTER TABLE `donates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `founders`
--

DROP TABLE IF EXISTS `founders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `founders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idtransaction` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dateofcomprovant` date NOT NULL,
  `valueofcomprovant` double NOT NULL,
  `validated` int(11) NOT NULL DEFAULT '0',
  `validated_gmid` int(11) NOT NULL DEFAULT '0',
  `coupom` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `founders`
--

LOCK TABLES `founders` WRITE;
/*!40000 ALTER TABLE `founders` DISABLE KEYS */;
/*!40000 ALTER TABLE `founders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_list`
--

DROP TABLE IF EXISTS `friend_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `owner_characterId` int(10) unsigned NOT NULL,
  `friend_characterId` int(10) unsigned NOT NULL,
  `registerDate` datetime NOT NULL,
  `lastUpdateDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_list`
--

LOCK TABLES `friend_list` WRITE;
/*!40000 ALTER TABLE `friend_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gm_accounts`
--

DROP TABLE IF EXISTS `gm_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gm_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `password_errors` int(11) DEFAULT NULL,
  `account_status` int(11) NOT NULL,
  `master_priv` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gm_accounts`
--

LOCK TABLES `gm_accounts` WRITE;
/*!40000 ALTER TABLE `gm_accounts` DISABLE KEYS */;
INSERT INTO `gm_accounts` VALUES (1,'admin','@admin@1234@',0,1,5);
/*!40000 ALTER TABLE `gm_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gm_commands`
--

DROP TABLE IF EXISTS `gm_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gm_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_gmid` int(11) NOT NULL,
  `command_type` int(11) NOT NULL,
  `runned` int(11) NOT NULL DEFAULT '0',
  `command` text NOT NULL,
  `created_at` datetime NOT NULL,
  `runned_at` datetime NOT NULL,
  `runned_by` varchar(16) NOT NULL,
  `target_name` varchar(45) NOT NULL DEFAULT '',
  `target_itemid` int(11) NOT NULL DEFAULT '0',
  `target_itemcnt` int(11) NOT NULL DEFAULT '1',
  `refused` int(11) NOT NULL DEFAULT '0',
  `refused_at` datetime NOT NULL,
  `reason_run` varchar(255) NOT NULL DEFAULT '',
  `reason_refuse` varchar(255) NOT NULL DEFAULT '',
  `reason_create` varchar(255) NOT NULL DEFAULT '',
  `coupom` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gm_commands`
--

LOCK TABLES `gm_commands` WRITE;
/*!40000 ALTER TABLE `gm_commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `gm_commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guilds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slot` int(10) unsigned NOT NULL,
  `name` varchar(19) NOT NULL,
  `nation` int(10) unsigned NOT NULL,
  `experience` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `totalmembers` int(10) unsigned NOT NULL,
  `bravurepoints` int(10) unsigned NOT NULL,
  `skillpoints` int(10) unsigned NOT NULL,
  `promote` int(10) unsigned NOT NULL,
  `notice1` varchar(34) NOT NULL,
  `notice2` varchar(34) NOT NULL,
  `notice3` varchar(34) NOT NULL,
  `site` varchar(38) NOT NULL,
  `rank1` int(10) unsigned NOT NULL,
  `rank2` int(10) unsigned NOT NULL,
  `rank3` int(10) unsigned NOT NULL,
  `rank4` int(10) unsigned NOT NULL,
  `rank5` int(10) unsigned NOT NULL,
  `ally_leader` int(10) unsigned NOT NULL,
  `guild_ally1_index` int(10) unsigned NOT NULL,
  `guild_ally1_name` varchar(18) NOT NULL,
  `guild_ally2_index` int(10) unsigned NOT NULL,
  `guild_ally2_name` varchar(18) NOT NULL,
  `guild_ally3_index` int(10) unsigned NOT NULL,
  `guild_ally3_name` varchar(18) NOT NULL,
  `guild_ally4_index` int(10) unsigned NOT NULL,
  `guild_ally4_name` varchar(18) NOT NULL,
  `storage_gold` int(10) unsigned NOT NULL,
  `leader_char_index` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilds`
--

LOCK TABLES `guilds` WRITE;
/*!40000 ALTER TABLE `guilds` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilds_players`
--

DROP TABLE IF EXISTS `guilds_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guilds_players` (
  `guild_index` int(10) unsigned NOT NULL,
  `char_index` int(10) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `player_rank` int(10) unsigned NOT NULL,
  `classinfo` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `logged` int(10) unsigned NOT NULL,
  `last_login` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilds_players`
--

LOCK TABLES `guilds_players` WRITE;
/*!40000 ALTER TABLE `guilds_players` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilds_players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itembars`
--

DROP TABLE IF EXISTS `itembars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itembars` (
  `owner_charid` int(10) unsigned NOT NULL,
  `slot` int(10) unsigned NOT NULL,
  `item` int(10) unsigned NOT NULL,
  PRIMARY KEY (`owner_charid`,`slot`,`item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itembars`
--

LOCK TABLES `itembars` WRITE;
/*!40000 ALTER TABLE `itembars` DISABLE KEYS */;
/*!40000 ALTER TABLE `itembars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `slot_type` int(11) NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `slot` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL DEFAULT '0',
  `app` int(10) unsigned DEFAULT NULL,
  `identific` int(10) unsigned DEFAULT NULL,
  `effect1_index` int(10) unsigned DEFAULT NULL,
  `effect1_value` int(10) unsigned DEFAULT NULL,
  `effect2_index` int(10) unsigned DEFAULT NULL,
  `effect2_value` int(10) unsigned DEFAULT NULL,
  `effect3_index` int(10) unsigned DEFAULT NULL,
  `effect3_value` int(10) unsigned DEFAULT NULL,
  `min` int(10) unsigned DEFAULT NULL,
  `max` int(10) unsigned DEFAULT NULL,
  `refine` int(10) unsigned DEFAULT '1',
  `time` int(10) unsigned DEFAULT NULL,
  `owner_mail_slot` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`slot_type`,`owner_id`,`slot`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mails`
--

DROP TABLE IF EXISTS `mails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `characterId` int(10) unsigned NOT NULL,
  `sentCharacterId` int(10) unsigned NOT NULL,
  `sentCharacterName` varchar(16) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `textBody` varchar(512) DEFAULT NULL,
  `slot` int(10) unsigned NOT NULL,
  `sentGold` int(10) unsigned NOT NULL,
  `gold` int(11) DEFAULT NULL,
  `returnDate` datetime(1) DEFAULT NULL,
  `sentDate` datetime(1) DEFAULT NULL,
  `checked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `canReturn` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `hasItems` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `isFromAuction` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mailReturned` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mails`
--

LOCK TABLES `mails` WRITE;
/*!40000 ALTER TABLE `mails` DISABLE KEYS */;
/*!40000 ALTER TABLE `mails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mails_items`
--

DROP TABLE IF EXISTS `mails_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mails_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `mail_id` int(10) unsigned NOT NULL,
  `slot` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `app` int(10) unsigned NOT NULL,
  `identific` int(10) unsigned NOT NULL,
  `effect1_index` int(10) unsigned NOT NULL,
  `effect1_value` int(10) unsigned NOT NULL,
  `effect2_index` int(10) unsigned NOT NULL,
  `effect2_value` int(10) unsigned NOT NULL,
  `effect3_index` int(10) unsigned NOT NULL,
  `effect3_value` int(10) unsigned NOT NULL,
  `min` int(10) unsigned NOT NULL,
  `max` int(10) unsigned NOT NULL,
  `refine` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mails_items`
--

LOCK TABLES `mails_items` WRITE;
/*!40000 ALTER TABLE `mails_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `mails_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nations`
--

DROP TABLE IF EXISTS `nations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nations` (
  `nation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nation_name` varchar(32) NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `nation_rank` int(10) unsigned NOT NULL,
  `guild_id_marshal` int(10) unsigned NOT NULL,
  `guild_id_tactician` int(10) unsigned NOT NULL,
  `guild_id_judge` int(10) unsigned NOT NULL,
  `guild_id_treasurer` int(10) unsigned NOT NULL,
  `citizen_tax` int(10) unsigned NOT NULL,
  `visitor_tax` int(10) unsigned NOT NULL,
  `settlement` int(10) unsigned NOT NULL,
  `nation_ally` int(10) unsigned NOT NULL,
  `marechal_ally` varchar(32) DEFAULT NULL,
  `ally_date` int(10) unsigned NOT NULL,
  `nation_gold` bigint(20) unsigned NOT NULL,
  `cerco_guildid_attack_A1` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_A2` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_A3` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_A4` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_B1` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_B2` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_B3` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_B4` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_C1` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_C2` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_C3` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_C4` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_D1` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_D2` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_D3` int(10) unsigned NOT NULL,
  `cerco_guildid_attack_D4` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nations`
--

LOCK TABLES `nations` WRITE;
/*!40000 ALTER TABLE `nations` DISABLE KEYS */;
INSERT INTO `nations` VALUES (1,'Astur-PvP',0,1,0,0,0,0,5,20,10000,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(2,'Exodia-PvP',1,2,0,0,0,0,5,20,10000,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),(3,'Leonides-PvP',2,3,0,0,0,0,5,20,10000,0,'',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `nations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prans`
--

DROP TABLE IF EXISTS `prans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acc_id` int(10) unsigned NOT NULL,
  `char_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(20) DEFAULT '',
  `food` int(11) NOT NULL,
  `devotion` int(11) NOT NULL,
  `p_cute` int(10) unsigned NOT NULL,
  `p_smart` int(10) unsigned NOT NULL,
  `p_sexy` int(10) unsigned NOT NULL,
  `p_energetic` int(10) unsigned NOT NULL,
  `p_tough` int(10) unsigned NOT NULL,
  `p_corrupt` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `class` int(10) unsigned NOT NULL,
  `hp` int(10) unsigned NOT NULL,
  `max_hp` int(10) unsigned NOT NULL,
  `mp` int(10) unsigned NOT NULL,
  `max_mp` int(10) unsigned NOT NULL,
  `xp` int(10) unsigned NOT NULL,
  `def_p` int(10) unsigned NOT NULL,
  `def_m` int(10) unsigned NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `chest` int(10) unsigned NOT NULL,
  `leg` int(10) unsigned NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prans`
--

LOCK TABLES `prans` WRITE;
/*!40000 ALTER TABLE `prans` DISABLE KEYS */;
/*!40000 ALTER TABLE `prans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quests`
--

DROP TABLE IF EXISTS `quests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quests` (
  `charid` int(10) unsigned NOT NULL,
  `questid` int(10) unsigned NOT NULL,
  `req1` int(10) unsigned NOT NULL DEFAULT '0',
  `req2` int(10) unsigned NOT NULL DEFAULT '0',
  `req3` int(10) unsigned NOT NULL DEFAULT '0',
  `req4` int(10) unsigned NOT NULL DEFAULT '0',
  `req5` int(10) unsigned NOT NULL DEFAULT '0',
  `isdone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `updated_at` bigint(20) DEFAULT '0',
  `created_at` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`,`questid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quests`
--

LOCK TABLES `quests` WRITE;
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recover_password`
--

DROP TABLE IF EXISTS `recover_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recover_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `code` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recover_password`
--

LOCK TABLES `recover_password` WRITE;
/*!40000 ALTER TABLE `recover_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `recover_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referrers`
--

DROP TABLE IF EXISTS `referrers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referrer` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  `total_refs` int(11) NOT NULL DEFAULT '0',
  `completed_first_donation` int(11) NOT NULL DEFAULT '0' COMMENT 'Referências que completaram a primeira doação com esse código de referência.',
  `total_cash_raised` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `referrer` (`referrer`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referrers`
--

LOCK TABLES `referrers` WRITE;
/*!40000 ALTER TABLE `referrers` DISABLE KEYS */;
/*!40000 ALTER TABLE `referrers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server` (
  `nation_id` int(11) NOT NULL AUTO_INCREMENT,
  `nation_name` varchar(64) NOT NULL,
  `nation_player_on` int(11) NOT NULL,
  PRIMARY KEY (`nation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_info`
--

DROP TABLE IF EXISTS `server_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) NOT NULL,
  `players_active` int(11) NOT NULL,
  `mail_count` bigint(20) NOT NULL,
  `character_count` bigint(20) NOT NULL,
  `guild_count` int(11) NOT NULL,
  `pran_count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_info`
--

LOCK TABLES `server_info` WRITE;
/*!40000 ALTER TABLE `server_info` DISABLE KEYS */;
INSERT INTO `server_info` VALUES (1,1,0,0,0,0,10240);
/*!40000 ALTER TABLE `server_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `owner_charid` int(10) unsigned NOT NULL,
  `slot` int(10) unsigned NOT NULL,
  `item` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`owner_charid`,`slot`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `titles` (
  `owner_charid` int(10) unsigned NOT NULL,
  `title_index` int(10) unsigned NOT NULL,
  `title_level` int(10) unsigned NOT NULL DEFAULT '0',
  `title_progress` int(10) unsigned NOT NULL,
  PRIMARY KEY (`owner_charid`,`title_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titles`
--

LOCK TABLES `titles` WRITE;
/*!40000 ALTER TABLE `titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `titles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-29 11:26:26
