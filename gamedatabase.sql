CREATE DATABASE  IF NOT EXISTS `gamedatabase` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gamedatabase`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: gamedatabase
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `game_id` int NOT NULL,
  `game_title` varchar(255) NOT NULL,
  `release_date` date DEFAULT NULL,
  `publisher_id` int DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  `image_id` int DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `publisher_id` (`publisher_id`),
  KEY `genre_id` (`genre_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `game_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (202301,'Destiny 2','2010-01-19',11001,1,1),(202302,'Cyberpunk 2077','2012-09-20',11002,2,2),(202303,'Call of Duty','2022-10-28',11003,3,3),(202304,'Hogwarts Legacy','0002-10-23',11004,4,4),(202305,'Lost Ark','0002-11-23',11005,5,5),(202306,'DOTA 2','0009-07-13',11006,6,6),(202307,'Born of Bread','2012-05-23',11007,7,7),(202308,'Civilization VI','2016-12-21',11008,8,8),(202309,'Sims 4','0009-02-14',11009,3,9),(202310,'Backpack Hero','2023-11-14',11010,5,10),(202311,'Plant vs. Zombie','0005-05-09',11011,4,11),(202312,'Grand Theft Auto V','2015-04-14',11012,6,12),(202313,'Dave the Diver','2023-06-28',11013,7,13),(202314,'It Takes Two','2021-05-26',11014,8,14),(202315,'BattleBlock Theater','2014-05-15',11015,3,15);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameimage`
--

DROP TABLE IF EXISTS `gameimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameimage` (
  `game_id` int NOT NULL,
  `image_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`image_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `gameimage_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `images` (`image_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameimage`
--

LOCK TABLES `gameimage` WRITE;
/*!40000 ALTER TABLE `gameimage` DISABLE KEYS */;
INSERT INTO `gameimage` VALUES (202301,1),(202302,2),(202303,3),(202304,4),(202305,5),(202306,6),(202307,7),(202308,8),(202309,9),(202310,10),(202311,11),(202312,12),(202313,13),(202314,14),(202315,15);
/*!40000 ALTER TABLE `gameimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gamelanguage`
--

DROP TABLE IF EXISTS `gamelanguage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gamelanguage` (
  `game_id` int NOT NULL,
  `language_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `gamelanguage_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gamelanguage_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamelanguage`
--

LOCK TABLES `gamelanguage` WRITE;
/*!40000 ALTER TABLE `gamelanguage` DISABLE KEYS */;
INSERT INTO `gamelanguage` VALUES (202301,1),(202303,1),(202308,1),(202312,1),(202314,1),(202302,2),(202304,2),(202307,2),(202309,2),(202305,3),(202306,4),(202310,6),(202311,7),(202313,8),(202315,9);
/*!40000 ALTER TABLE `gamelanguage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gamemedia`
--

DROP TABLE IF EXISTS `gamemedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gamemedia` (
  `game_id` int NOT NULL,
  `media_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `gamemedia_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`),
  CONSTRAINT `gamemedia_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gamemedia`
--

LOCK TABLES `gamemedia` WRITE;
/*!40000 ALTER TABLE `gamemedia` DISABLE KEYS */;
INSERT INTO `gamemedia` VALUES (202304,44001),(202304,44002);
/*!40000 ALTER TABLE `gamemedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gameplatform`
--

DROP TABLE IF EXISTS `gameplatform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameplatform` (
  `game_id` int NOT NULL,
  `platform_id` int NOT NULL,
  PRIMARY KEY (`game_id`,`platform_id`),
  KEY `platform_id` (`platform_id`),
  CONSTRAINT `gameplatform_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gameplatform_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `platform` (`platform_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gameplatform`
--

LOCK TABLES `gameplatform` WRITE;
/*!40000 ALTER TABLE `gameplatform` DISABLE KEYS */;
INSERT INTO `gameplatform` VALUES (202301,1),(202302,1),(202303,1),(202305,1),(202306,1),(202307,1),(202308,1),(202310,1),(202312,1),(202313,1),(202314,1),(202315,1),(202304,2),(202309,2),(202311,2);
/*!40000 ALTER TABLE `gameplatform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_ledger_account`
--

DROP TABLE IF EXISTS `general_ledger_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `general_ledger_account` (
  `account_number` int NOT NULL AUTO_INCREMENT,
  `account_description` varchar(50) NOT NULL,
  PRIMARY KEY (`account_number`),
  UNIQUE KEY `account_description` (`account_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_ledger_account`
--

LOCK TABLES `general_ledger_account` WRITE;
/*!40000 ALTER TABLE `general_ledger_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `general_ledger_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `general_ledger_accounts`
--

DROP TABLE IF EXISTS `general_ledger_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `general_ledger_accounts` (
  `account_number` int NOT NULL,
  `account_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`account_number`),
  UNIQUE KEY `account_description` (`account_description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `general_ledger_accounts`
--

LOCK TABLES `general_ledger_accounts` WRITE;
/*!40000 ALTER TABLE `general_ledger_accounts` DISABLE KEYS */;
INSERT INTO `general_ledger_accounts` VALUES (221,'401K Employee Contributions'),(591,'Accounting'),(200,'Accounts Payable'),(110,'Accounts Receivable'),(569,'Auto Expense'),(568,'Auto License Fee'),(565,'Bank Fees'),(394,'Book Club Royalties'),(181,'Book Development'),(120,'Book Inventory'),(400,'Book Printing Costs'),(403,'Book Production Costs'),(572,'Books, Dues, and Subscriptions'),(520,'Building Lease'),(523,'Building Maintenance'),(551,'Business Forms'),(590,'Business Insurance'),(574,'Business Licenses and Taxes'),(280,'Capital Stock'),(162,'Capitalized Lease'),(536,'Card Deck Advertising'),(100,'Cash'),(610,'Charitable Contributions'),(555,'Collection Agency Fees'),(301,'College Sales'),(310,'Compositing Revenue'),(160,'Computer Equipment'),(527,'Computer Equipment Maintenance'),(306,'Consignment Sales'),(556,'Credit Card Handling'),(540,'Direct Mail Advertising'),(238,'Employee FICA Taxes Payable'),(242,'Employee SDI Taxes Payable'),(239,'Employer FICA Taxes Payable'),(241,'Employer FUTA Taxes Payable'),(243,'Employer UCI Taxes Payable'),(532,'Equipment Rental'),(546,'Exhibits and Shows'),(630,'Federal Corporation Income Taxes'),(505,'FICA'),(553,'Freight'),(150,'Furniture'),(506,'FUTA'),(510,'Group Insurance'),(251,'IBM Credit Corporation Payable'),(528,'IBM Lease'),(235,'Income Taxes Payable'),(620,'Interest Paid to Banks'),(580,'Meals'),(508,'Medicare'),(234,'Medicare Taxes Payable'),(570,'Office Supplies'),(170,'Other Equipment'),(621,'Other Interest'),(589,'Outside Services'),(550,'Packaging Materials'),(576,'PC Software'),(552,'Postage'),(611,'Profit Sharing Contributions'),(300,'Retail Sales'),(290,'Retained Earnings'),(205,'Royalties Payable'),(500,'Salaries and Wages'),(632,'Sales Tax'),(230,'Sales Taxes Payable'),(167,'Software'),(541,'Space Advertising'),(631,'State Corporation Income Taxes'),(237,'State Payroll Taxes Payable'),(522,'Telephone'),(302,'Trade Sales'),(582,'Travel and Accomodations'),(507,'UCI'),(521,'Utilities'),(548,'Web Site Production and Fees');
/*!40000 ALTER TABLE `general_ledger_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(255) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Action'),(2,'Adventure'),(3,'RPG'),(4,'Strategy'),(5,'Simulation'),(6,'Racing'),(7,'Management'),(8,'Puzzle');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image_address` varchar(255) NOT NULL,
  `image_description` text,
  `game_id` int DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  KEY `game_id` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'https://storage.googleapis.com/gameimagesss/destiny2.png','\"Destiny 2\"',202301),(2,'https://storage.googleapis.com/gameimagesss/cyberpunk2077.png','\"Cyberpunk 2077\"',202302),(3,'https://storage.googleapis.com/gameimagesss/callofduty.png','\"Call of Duty\"',202303),(4,'https://storage.googleapis.com/gameimagesss/hogwartslegacy.png','\"Hogwarts Legacy\"',202304),(5,'https://storage.googleapis.com/gameimagesss/lostark.png','\"Lost Ark\"',202305),(6,'https://storage.googleapis.com/gameimagesss/dota2.png','\"DOTA 2\"',202306),(7,'https://storage.googleapis.com/gameimagesss/bornofbread.png','\"Born of Bread\"',202307),(8,'https://storage.googleapis.com/gameimagesss/civilizationvi.png','\"Civilization VI\"',202308),(9,'https://storage.googleapis.com/gameimagesss/sims4.png','\"Sims 4\"',202309),(10,'https://storage.googleapis.com/gameimagesss/backpackhero.png','\"Backpack Hero\"',202310),(11,'https://storage.googleapis.com/gameimagesss/plantvszombie.png','\"Plant vs. Zombie\"',202311),(12,'https://storage.googleapis.com/gameimagesss/grandtheftautov.png','\"Grand Theft Auto V\"',202312),(13,'https://storage.googleapis.com/gameimagesss/davethediver.png','\"Dave the Diver\"',202313),(14,'https://storage.googleapis.com/gameimagesss/ittakestwo.png','\"It Takes Two\"',202314),(15,'https://storage.googleapis.com/gameimagesss/battleblocktheater.png','\"BattleBlock Theater\"',202315);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `language_id` int NOT NULL AUTO_INCREMENT,
  `language_name` varchar(100) NOT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English'),(2,'English,Bulgarian'),(3,'English,French,German'),(4,'English,French,Italian'),(5,'English,French,Spanish'),(6,'English,German,Czech'),(7,'English,Italian,German'),(8,'English,Korean,Japanese'),(9,'English,Spanish');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `media_id` int NOT NULL,
  `media_type` varchar(100) DEFAULT NULL,
  `media_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (44001,'movie','Harry Potter'),(44002,'book','Harry Potter');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_system`
--

DROP TABLE IF EXISTS `operating_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operating_system` (
  `os_id` int NOT NULL AUTO_INCREMENT,
  `os_name` varchar(100) NOT NULL,
  PRIMARY KEY (`os_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operating_system`
--

LOCK TABLES `operating_system` WRITE;
/*!40000 ALTER TABLE `operating_system` DISABLE KEYS */;
INSERT INTO `operating_system` VALUES (1,'Windows'),(2,'Windows, MacOS'),(3,'Windows, MacOS,Linux');
/*!40000 ALTER TABLE `operating_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platform`
--

DROP TABLE IF EXISTS `platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platform` (
  `platform_id` int NOT NULL AUTO_INCREMENT,
  `platform_name` varchar(255) NOT NULL,
  PRIMARY KEY (`platform_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platform`
--

LOCK TABLES `platform` WRITE;
/*!40000 ALTER TABLE `platform` DISABLE KEYS */;
INSERT INTO `platform` VALUES (1,'Steam'),(2,'Steam,Origin'),(3,'Steam,Uplay');
/*!40000 ALTER TABLE `platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platformoperatingsystem`
--

DROP TABLE IF EXISTS `platformoperatingsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platformoperatingsystem` (
  `platform_id` int NOT NULL,
  `os_id` int NOT NULL,
  PRIMARY KEY (`platform_id`,`os_id`),
  KEY `os_id` (`os_id`),
  CONSTRAINT `platformoperatingsystem_ibfk_1` FOREIGN KEY (`platform_id`) REFERENCES `platform` (`platform_id`),
  CONSTRAINT `platformoperatingsystem_ibfk_2` FOREIGN KEY (`os_id`) REFERENCES `operating_system` (`os_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platformoperatingsystem`
--

LOCK TABLES `platformoperatingsystem` WRITE;
/*!40000 ALTER TABLE `platformoperatingsystem` DISABLE KEYS */;
/*!40000 ALTER TABLE `platformoperatingsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL,
  `publisher_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (11001,'Bungie'),(11002,'CD projekt red'),(11003,'Activision'),(11004,'Warner Bros. Games'),(11005,'Amazon Games'),(11006,'Valve'),(11007,'Dear Villagers'),(11008,'Aspyr'),(11009,'Electronic Arts'),(11010,'Different Tales'),(11011,'PopCap Games, Inc.'),(11012,'RockStar Games'),(11013,'Mintrocket'),(11014,'Electronic Arts'),(11015,'The Behemoth');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisherlanguage`
--

DROP TABLE IF EXISTS `publisherlanguage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisherlanguage` (
  `publisher_id` int NOT NULL,
  `language_id` int NOT NULL,
  PRIMARY KEY (`publisher_id`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `publisherlanguage_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publisherlanguage_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisherlanguage`
--

LOCK TABLES `publisherlanguage` WRITE;
/*!40000 ALTER TABLE `publisherlanguage` DISABLE KEYS */;
INSERT INTO `publisherlanguage` VALUES (11002,1),(11007,1),(11014,1),(11001,2),(11010,2),(11012,2),(11015,2),(11003,3),(11013,3),(11005,4),(11004,5),(11006,6),(11011,7),(11008,8),(11009,9);
/*!40000 ALTER TABLE `publisherlanguage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `rating_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rating_id`),
  KEY `game_id` (`game_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rating_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (1,202311,1,4,'2023-12-08 02:11:45'),(2,202311,1,4,'2023-12-08 02:11:45'),(3,202314,5,5,'2023-12-08 02:35:03'),(4,202314,5,5,'2023-12-08 02:35:03'),(5,202314,6,5,'2023-12-08 02:39:30'),(6,202314,6,5,'2023-12-08 02:39:30'),(7,202312,1,5,'2023-12-08 18:30:41'),(8,202312,1,5,'2023-12-08 18:30:41');
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `game_id` int NOT NULL,
  `user_id` int NOT NULL,
  `review_text` text,
  `review_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `game_id` (`game_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,202311,1,'This game is so FUN!','2023-12-08 02:11:15'),(2,202314,5,'Good Game!!','2023-12-08 02:35:21'),(3,202314,6,'Nice game!','2023-12-08 02:39:38');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userfavoritegames`
--

DROP TABLE IF EXISTS `userfavoritegames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userfavoritegames` (
  `user_id` int NOT NULL,
  `game_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`game_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `userfavoritegames_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userfavoritegames_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfavoritegames`
--

LOCK TABLES `userfavoritegames` WRITE;
/*!40000 ALTER TABLE `userfavoritegames` DISABLE KEYS */;
INSERT INTO `userfavoritegames` VALUES (5,202308),(1,202311),(1,202312),(1,202314),(4,202314),(5,202314),(6,202314),(4,202315);
/*!40000 ALTER TABLE `userfavoritegames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `game_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'11','scrypt:32768:8:1$oMeSmu490YGTSMPb$037a249d0fe43bbff2f9e6a8ceeb2518d52ba4487245cc64f6dfacc79cc0d424b7a44d3f8d9299770f859b05ee030c6945401ab4c5803d96114cc014985767ea',NULL),(2,'qq','scrypt:32768:8:1$pyNpzwxHYwNXH7md$df6eb011bdcbf8782bfe75e1c10ffb27ee847d38b06c11d1fe343787617139f5ac19b6d76c9f5f5b5aaad3deb6f11c82eb6dd3bd938b530b1c7424f7c7311e52',NULL),(3,'newuser','scrypt:32768:8:1$ihpz7etKtfvAsFkc$d2aac3d18cc50e1ef045b6be2069ac9a281065c16cbaee711fcc2b6d7dcda5878142752de952d77c7dc0f22c69c5ab6f319cdb03826098f368f5474da48693b5',NULL),(4,'111','scrypt:32768:8:1$d7zHcKiyUJgzlueb$bc6e7693ad2878f8f95ab41ea489e8910535648b8d0994fe79f9fc0720512772211044a811f3bc79a29caf4739d0165fbe1d645a12c85e970d28b77ebe3e15ba',NULL),(5,'1111','scrypt:32768:8:1$x4cy9tmKFdbqrey7$454bec432e9051109f9aba9d6141dc119a8f3c7286b201964d07d2744fab85fb89169b72bd8209b34820928d456eb2a642a93f488e8bb73ffad718d1fb98a59b',NULL),(6,'4444','scrypt:32768:8:1$7QWuWOQZxZtkMtxj$2ebefa6eb5489dd305bdd92a64bcc7852ac05fe69237f1e1c6906ea808992ceddf6a2206e747e0b0b5be0aadad921ed5a9ad635502f8f78610ffac4d9b9fb2e8',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'gamedatabase'
--

--
-- Dumping routines for database 'gamedatabase'
--
/*!50003 DROP FUNCTION IF EXISTS `GetAverageRatingForGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetAverageRatingForGame`(gameTitle VARCHAR(255)) RETURNS decimal(5,2)
    DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(5, 2);
    
    SELECT AVG(r.rating) INTO avgRating
    FROM game g
    LEFT JOIN review r ON g.game_id = r.game_id
    WHERE g.game_title = gameTitle;
    
    RETURN avgRating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddNewGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewGame`(IN title VARCHAR(255), IN releaseDate DATE, IN developer VARCHAR(255), IN publisherId INT, IN genreId INT, IN categoryId INT)
BEGIN
    INSERT INTO game (game_title, release_date, developer_name, publisher_id, genre_id, category_id) 
    VALUES (title, releaseDate, developer, publisherId, genreId, categoryId);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddReviewAndRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddReviewAndRating`(IN userId INT, IN gameId INT, IN rating INT, IN reviewText TEXT)
BEGIN
    INSERT INTO review (game_id, user_id, rating, review_text)
    VALUES (gameId, userId, rating, reviewText);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteGameFromCollection` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGameFromCollection`(IN userId INT, IN gameId INT)
BEGIN
    DELETE FROM user_game_collection 
    WHERE user_id = userId AND game_id = gameId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteReviewAndRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteReviewAndRating`(IN reviewId INT)
BEGIN
    DELETE FROM review 
    WHERE review_id = reviewId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetGamesByGenre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetGamesByGenre`(IN genreName VARCHAR(255))
BEGIN
    SELECT g.game_title
    FROM game g
    JOIN genre ge ON g.genre_id = ge.genre_id
    WHERE ge.genre_name = genreName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateGameInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGameInfo`(IN gameId INT, IN newTitle VARCHAR(255), IN newReleaseDate DATE, IN newDeveloper VARCHAR(255))
BEGIN
    UPDATE game 
    SET game_title = newTitle, release_date = newReleaseDate, developer_name = newDeveloper 
    WHERE game_id = gameId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateReviewAndRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateReviewAndRating`(IN reviewId INT, IN newRating INT, IN newReviewText TEXT)
BEGIN
    UPDATE review 
    SET rating = newRating, review_text = newReviewText 
    WHERE review_id = reviewId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 20:37:28
