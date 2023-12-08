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
-- Table structure for table `invoice_archive`
--

DROP TABLE IF EXISTS `invoice_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_archive` (
  `invoice_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `invoice_date` date NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL,
  `credit_total` decimal(9,2) NOT NULL,
  `terms_id` int NOT NULL,
  `invoice_due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_archive`
--

LOCK TABLES `invoice_archive` WRITE;
/*!40000 ALTER TABLE `invoice_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_line_items`
--

DROP TABLE IF EXISTS `invoice_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_line_items` (
  `invoice_id` int NOT NULL,
  `invoice_sequence` int NOT NULL,
  `account_number` int NOT NULL,
  `line_item_amount` decimal(9,2) NOT NULL,
  `line_item_description` varchar(100) NOT NULL,
  PRIMARY KEY (`invoice_id`,`invoice_sequence`),
  KEY `line_items_fk_acounts` (`account_number`),
  CONSTRAINT `line_items_fk_acounts` FOREIGN KEY (`account_number`) REFERENCES `general_ledger_accounts` (`account_number`),
  CONSTRAINT `line_items_fk_invoices` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_line_items`
--

LOCK TABLES `invoice_line_items` WRITE;
/*!40000 ALTER TABLE `invoice_line_items` DISABLE KEYS */;
INSERT INTO `invoice_line_items` VALUES (1,1,553,3813.33,'Freight'),(2,1,553,40.20,'Freight'),(3,1,553,138.75,'Freight'),(4,1,553,144.70,'Int\'l shipment'),(5,1,553,15.50,'Freight'),(6,1,553,42.75,'Freight'),(7,1,553,172.50,'Freight'),(8,1,522,95.00,'Telephone service'),(9,1,403,601.95,'Cover design'),(10,1,553,42.67,'Freight'),(11,1,553,42.50,'Freight'),(12,1,580,50.00,'DiCicco\'s'),(12,2,570,75.60,'Kinko\'s'),(12,3,570,58.40,'Office Max'),(12,4,540,478.00,'Publishers Marketing'),(13,1,522,16.33,'Telephone (line 5)'),(14,1,553,6.00,'Freight out'),(15,1,574,856.92,'Property Taxes'),(16,1,572,9.95,'Monthly access fee'),(17,1,553,10.00,'Address correction'),(18,1,553,104.00,'Freight'),(19,1,160,116.54,'MVS Online Library'),(20,1,553,6.00,'Freight out'),(21,1,589,4901.26,'Office lease'),(22,1,553,108.25,'Freight'),(23,1,572,9.95,'Monthly access fee'),(24,1,520,1750.00,'Warehouse lease'),(25,1,553,129.00,'Freight'),(26,1,553,10.00,'Freight'),(27,1,540,207.78,'Prospect list'),(28,1,553,109.50,'Freight'),(29,1,523,450.00,'Back office additions'),(30,1,553,63.40,'Freight'),(31,1,589,7125.34,'Web site design'),(32,1,403,953.10,'Crash Course revision'),(33,1,591,220.00,'Form 571-L'),(34,1,553,127.75,'Freight'),(35,1,507,1600.00,'Income Tax'),(36,1,403,565.15,'Crash Course Ad'),(37,1,553,36.00,'Freight'),(38,1,553,61.50,'Freight'),(39,1,400,37966.19,'CICS Desk Reference'),(40,1,403,639.77,'Card deck'),(41,1,553,53.75,'Freight'),(42,1,553,400.00,'Freight'),(43,1,400,21842.00,'Book repro'),(44,1,522,19.67,'Telephone (Line 3)'),(45,1,553,2765.36,'Freight'),(46,1,510,224.00,'Health Insurance'),(47,1,572,1575.00,'Catalog ad'),(48,1,553,33.00,'Freight'),(49,1,522,16.33,'Telephone (line 6)'),(50,1,510,116.00,'Health Insurance'),(51,1,553,2184.11,'Freight'),(52,1,160,1083.58,'MSDN'),(53,1,522,46.21,'Telephone (Line 1)'),(54,1,403,313.55,'Card revision'),(55,1,553,40.75,'Freight'),(56,1,572,2433.00,'Card deck'),(57,1,589,1367.50,'401K Contributions'),(58,1,553,53.25,'Freight'),(59,1,553,13.75,'Freight'),(60,1,553,2312.20,'Freight'),(61,1,553,25.67,'Freight out'),(62,1,553,26.75,'Freight'),(63,1,553,2115.81,'Freight'),(64,1,553,23.50,'Freight'),(65,1,400,6940.25,'OS Utilities'),(66,1,553,31.95,'Freight'),(67,1,553,1927.54,'Freight'),(68,1,160,936.93,'Quarterly Maintenance'),(69,1,540,175.00,'Card deck advertising'),(70,1,553,6.00,'Freight'),(71,1,553,108.50,'Freight'),(72,1,553,10.00,'Address correction'),(73,1,552,290.00,'International pkg.'),(74,1,570,41.80,'Coffee'),(75,1,553,27.00,'Freight'),(76,1,553,241.00,'Int\'l shipment'),(77,1,403,904.14,'Cover design'),(78,1,403,1197.00,'Cover design'),(78,2,540,765.13,'Catalog design'),(79,1,540,2184.50,'PC card deck'),(80,1,553,2318.03,'Freight'),(81,1,553,26.25,'Freight'),(82,1,150,17.50,'Supplies'),(83,1,522,39.77,'Telephone (Line 2)'),(84,1,553,111.00,'Freight'),(85,1,553,158.00,'Int\'l shipment'),(86,1,553,739.20,'Freight'),(87,1,553,60.00,'Freight'),(88,1,553,147.25,'Freight'),(89,1,400,85.31,'Book copy'),(90,1,553,38.75,'Freight'),(91,1,522,32.70,'Telephone (line 4)'),(92,1,521,16.62,'Propane-forklift'),(93,1,553,162.75,'International shipment'),(94,1,553,52.25,'Freight'),(95,1,572,600.00,'Books for research'),(96,1,400,26881.40,'MVS JCL'),(97,1,170,356.48,'Network wiring'),(98,1,572,579.42,'Catalog ad'),(99,1,553,59.97,'Freight'),(100,1,553,67.92,'Freight'),(101,1,553,30.75,'Freight'),(102,1,400,20551.18,'CICS book printing'),(103,1,553,2051.59,'Freight'),(104,1,553,44.44,'Freight'),(105,1,582,503.20,'Bronco lease'),(106,1,400,23517.58,'DB2 book printing'),(107,1,553,3689.99,'Freight'),(108,1,553,67.00,'Freight'),(109,1,403,1000.46,'Crash Course covers'),(110,1,540,90.36,'Card deck advertising'),(111,1,553,22.57,'Freight'),(112,1,400,10976.06,'VSAM book printing'),(113,1,510,224.00,'Health Insurance'),(114,1,553,127.75,'Freight');
/*!40000 ALTER TABLE `invoice_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `vendor_id` int NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `invoice_date` date NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `credit_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `terms_id` int NOT NULL,
  `invoice_due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `invoices_fk_vendors` (`vendor_id`),
  KEY `invoices_fk_terms` (`terms_id`),
  KEY `invoices_invoice_date_ix` (`invoice_date` DESC),
  CONSTRAINT `invoices_fk_terms` FOREIGN KEY (`terms_id`) REFERENCES `terms` (`terms_id`),
  CONSTRAINT `invoices_fk_vendors` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,122,'989319-457','2014-04-08',3813.33,3813.33,0.00,3,'2014-05-08','2014-05-07'),(2,123,'263253241','2014-04-10',40.20,40.20,0.00,3,'2014-05-10','2014-05-14'),(3,123,'963253234','2014-04-13',138.75,138.75,0.00,3,'2014-05-13','2014-05-09'),(4,123,'2-000-2993','2014-04-16',144.70,144.70,0.00,3,'2014-05-16','2014-05-12'),(5,123,'963253251','2014-04-16',15.50,15.50,0.00,3,'2014-05-16','2014-05-11'),(6,123,'963253261','2014-04-16',42.75,42.75,0.00,3,'2014-05-16','2014-05-21'),(7,123,'963253237','2014-04-21',172.50,172.50,0.00,3,'2014-05-21','2014-05-22'),(8,89,'125520-1','2014-04-24',95.00,95.00,0.00,1,'2014-05-04','2014-05-01'),(9,121,'97/488','2014-04-24',601.95,601.95,0.00,3,'2014-05-24','2014-05-21'),(10,123,'263253250','2014-04-24',42.67,42.67,0.00,3,'2014-05-24','2014-05-22'),(11,123,'963253262','2014-04-25',42.50,42.50,0.00,3,'2014-05-25','2014-05-20'),(12,96,'I77271-O01','2014-04-26',662.00,662.00,0.00,2,'2014-05-16','2014-05-13'),(13,95,'111-92R-10096','2014-04-30',16.33,16.33,0.00,2,'2014-05-20','2014-05-23'),(14,115,'25022117','2014-05-01',6.00,6.00,0.00,4,'2014-06-10','2014-06-10'),(15,48,'P02-88D77S7','2014-05-03',856.92,856.92,0.00,3,'2014-06-02','2014-05-30'),(16,97,'21-4748363','2014-05-03',9.95,9.95,0.00,2,'2014-05-23','2014-05-22'),(17,123,'4-321-2596','2014-05-05',10.00,10.00,0.00,3,'2014-06-04','2014-06-05'),(18,123,'963253242','2014-05-06',104.00,104.00,0.00,3,'2014-06-05','2014-06-05'),(19,34,'QP58872','2014-05-07',116.54,116.54,0.00,1,'2014-05-17','2014-05-19'),(20,115,'24863706','2014-05-10',6.00,6.00,0.00,4,'2014-06-19','2014-06-15'),(21,119,'10843','2014-05-11',4901.26,4901.26,0.00,2,'2014-05-31','2014-05-29'),(22,123,'963253235','2014-05-11',108.25,108.25,0.00,3,'2014-06-10','2014-06-09'),(23,97,'21-4923721','2014-05-13',9.95,9.95,0.00,2,'2014-06-02','2014-05-28'),(24,113,'77290','2014-05-13',1750.00,1750.00,0.00,5,'2014-07-02','2014-07-05'),(25,123,'963253246','2014-05-13',129.00,129.00,0.00,3,'2014-06-12','2014-06-09'),(26,123,'4-342-8069','2014-05-14',10.00,10.00,0.00,3,'2014-06-13','2014-06-13'),(27,88,'972110','2014-05-15',207.78,207.78,0.00,1,'2014-05-25','2014-05-27'),(28,123,'963253263','2014-05-16',109.50,109.50,0.00,3,'2014-06-15','2014-06-10'),(29,108,'121897','2014-05-19',450.00,450.00,0.00,4,'2014-06-28','2014-07-03'),(30,123,'1-200-5164','2014-05-20',63.40,63.40,0.00,3,'2014-06-19','2014-06-24'),(31,104,'P02-3772','2014-05-21',7125.34,7125.34,0.00,3,'2014-06-20','2014-06-24'),(32,121,'97/486','2014-05-21',953.10,953.10,0.00,3,'2014-06-20','2014-06-22'),(33,105,'94007005','2014-05-23',220.00,220.00,0.00,3,'2014-06-22','2014-06-26'),(34,123,'963253232','2014-05-23',127.75,127.75,0.00,3,'2014-06-22','2014-06-18'),(35,107,'RTR-72-3662-X','2014-05-25',1600.00,1600.00,0.00,4,'2014-07-04','2014-07-09'),(36,121,'97/465','2014-05-25',565.15,565.15,0.00,3,'2014-06-24','2014-06-24'),(37,123,'963253260','2014-05-25',36.00,36.00,0.00,3,'2014-06-24','2014-06-26'),(38,123,'963253272','2014-05-26',61.50,61.50,0.00,3,'2014-06-25','2014-06-30'),(39,110,'0-2058','2014-05-28',37966.19,37966.19,0.00,3,'2014-06-27','2014-06-30'),(40,121,'97/503','2014-05-30',639.77,639.77,0.00,3,'2014-06-29','2014-06-25'),(41,123,'963253255','2014-05-31',53.75,53.75,0.00,3,'2014-06-30','2014-06-27'),(42,123,'94007069','2014-05-31',400.00,400.00,0.00,3,'2014-06-30','2014-07-01'),(43,72,'40318','2014-06-01',21842.00,21842.00,0.00,3,'2014-07-01','2014-06-29'),(44,95,'111-92R-10094','2014-06-01',19.67,19.67,0.00,2,'2014-06-21','2014-06-24'),(45,122,'989319-437','2014-06-01',2765.36,2765.36,0.00,3,'2014-07-01','2014-06-28'),(46,37,'547481328','2014-06-03',224.00,224.00,0.00,3,'2014-07-03','2014-07-04'),(47,83,'31359783','2014-06-03',1575.00,1575.00,0.00,2,'2014-06-23','2014-06-21'),(48,123,'1-202-2978','2014-06-03',33.00,33.00,0.00,3,'2014-07-03','2014-07-05'),(49,95,'111-92R-10097','2014-06-04',16.33,16.33,0.00,2,'2014-06-24','2014-06-26'),(50,37,'547479217','2014-06-07',116.00,116.00,0.00,3,'2014-07-07','2014-07-07'),(51,122,'989319-477','2014-06-08',2184.11,2184.11,0.00,3,'2014-07-08','2014-07-08'),(52,34,'Q545443','2014-06-09',1083.58,1083.58,0.00,1,'2014-06-19','2014-06-23'),(53,95,'111-92R-10092','2014-06-09',46.21,46.21,0.00,2,'2014-06-29','2014-07-02'),(54,121,'97/553B','2014-06-10',313.55,313.55,0.00,3,'2014-07-10','2014-07-09'),(55,123,'963253245','2014-06-10',40.75,40.75,0.00,3,'2014-07-10','2014-07-12'),(56,86,'367447','2014-06-11',2433.00,2433.00,0.00,1,'2014-06-21','2014-06-17'),(57,103,'75C-90227','2014-06-11',1367.50,1367.50,0.00,5,'2014-07-31','2014-07-31'),(58,123,'963253256','2014-06-11',53.25,53.25,0.00,3,'2014-07-11','2014-07-07'),(59,123,'4-314-3057','2014-06-11',13.75,13.75,0.00,3,'2014-07-11','2014-07-15'),(60,122,'989319-497','2014-06-12',2312.20,2312.20,0.00,3,'2014-07-12','2014-07-09'),(61,115,'24946731','2014-06-15',25.67,25.67,0.00,4,'2014-07-25','2014-07-26'),(62,123,'963253269','2014-06-15',26.75,26.75,0.00,3,'2014-07-15','2014-07-11'),(63,122,'989319-427','2014-06-16',2115.81,2115.81,0.00,3,'2014-07-16','2014-07-19'),(64,123,'963253267','2014-06-17',23.50,23.50,0.00,3,'2014-07-17','2014-07-19'),(65,99,'509786','2014-06-18',6940.25,6940.25,0.00,3,'2014-07-18','2014-07-15'),(66,123,'263253253','2014-06-18',31.95,31.95,0.00,3,'2014-07-18','2014-07-21'),(67,122,'989319-487','2014-06-20',1927.54,1927.54,0.00,3,'2014-07-20','2014-07-18'),(68,81,'MABO1489','2014-06-21',936.93,936.93,0.00,2,'2014-07-11','2014-07-10'),(69,80,'133560','2014-06-22',175.00,175.00,0.00,2,'2014-07-12','2014-07-16'),(70,115,'24780512','2014-06-22',6.00,6.00,0.00,4,'2014-08-01','2014-07-29'),(71,123,'963253254','2014-06-22',108.50,108.50,0.00,3,'2014-07-22','2014-07-20'),(72,123,'43966316','2014-06-22',10.00,10.00,0.00,3,'2014-07-22','2014-07-17'),(73,114,'CBM9920-M-T77109','2014-06-23',290.00,290.00,0.00,1,'2014-07-03','2014-06-29'),(74,102,'109596','2014-06-24',41.80,41.80,0.00,4,'2014-08-03','2014-08-04'),(75,123,'7548906-20','2014-06-24',27.00,27.00,0.00,3,'2014-07-24','2014-07-24'),(76,123,'963253248','2014-06-24',241.00,241.00,0.00,3,'2014-07-24','2014-07-25'),(77,121,'97/553','2014-06-25',904.14,904.14,0.00,3,'2014-07-25','2014-07-25'),(78,121,'97/522','2014-06-28',1962.13,1762.13,200.00,3,'2014-07-28','2014-07-30'),(79,100,'587056','2014-06-30',2184.50,2184.50,0.00,4,'2014-08-09','2014-08-07'),(80,122,'989319-467','2014-07-01',2318.03,2318.03,0.00,3,'2014-07-31','2014-07-29'),(81,123,'263253265','2014-07-02',26.25,26.25,0.00,3,'2014-08-01','2014-07-28'),(82,94,'203339-13','2014-07-05',17.50,17.50,0.00,2,'2014-07-25','2014-07-27'),(83,95,'111-92R-10093','2014-07-06',39.77,39.77,0.00,2,'2014-07-26','2014-07-22'),(84,123,'963253258','2014-07-06',111.00,111.00,0.00,3,'2014-08-05','2014-08-05'),(85,123,'963253271','2014-07-07',158.00,158.00,0.00,3,'2014-08-06','2014-08-11'),(86,123,'963253230','2014-07-07',739.20,739.20,0.00,3,'2014-08-06','2014-08-06'),(87,123,'963253244','2014-07-08',60.00,60.00,0.00,3,'2014-08-07','2014-08-09'),(88,123,'963253239','2014-07-08',147.25,147.25,0.00,3,'2014-08-07','2014-08-11'),(89,72,'39104','2014-07-10',85.31,0.00,0.00,3,'2014-08-09',NULL),(90,123,'963253252','2014-07-12',38.75,38.75,0.00,3,'2014-08-11','2014-08-11'),(91,95,'111-92R-10095','2014-07-15',32.70,32.70,0.00,2,'2014-08-04','2014-08-06'),(92,117,'111897','2014-07-15',16.62,16.62,0.00,3,'2014-08-14','2014-08-14'),(93,123,'4-327-7357','2014-07-16',162.75,162.75,0.00,3,'2014-08-15','2014-08-11'),(94,123,'963253264','2014-07-18',52.25,0.00,0.00,3,'2014-08-17',NULL),(95,82,'C73-24','2014-07-19',600.00,600.00,0.00,2,'2014-08-08','2014-08-13'),(96,110,'P-0259','2014-07-19',26881.40,26881.40,0.00,3,'2014-08-18','2014-08-20'),(97,90,'97-1024A','2014-07-20',356.48,356.48,0.00,2,'2014-08-09','2014-08-07'),(98,83,'31361833','2014-07-21',579.42,0.00,0.00,2,'2014-08-10',NULL),(99,123,'263253268','2014-07-21',59.97,0.00,0.00,3,'2014-08-20',NULL),(100,123,'263253270','2014-07-22',67.92,0.00,0.00,3,'2014-08-21',NULL),(101,123,'263253273','2014-07-22',30.75,0.00,0.00,3,'2014-08-21',NULL),(102,110,'P-0608','2014-07-23',20551.18,0.00,1200.00,3,'2014-08-22',NULL),(103,122,'989319-417','2014-07-23',2051.59,2051.59,0.00,3,'2014-08-22','2014-08-24'),(104,123,'263253243','2014-07-23',44.44,44.44,0.00,3,'2014-08-22','2014-08-24'),(105,106,'9982771','2014-07-24',503.20,0.00,0.00,3,'2014-08-23',NULL),(106,110,'0-2060','2014-07-24',23517.58,21221.63,2295.95,3,'2014-08-23','2014-08-27'),(107,122,'989319-447','2014-07-24',3689.99,3689.99,0.00,3,'2014-08-23','2014-08-19'),(108,123,'963253240','2014-07-24',67.00,67.00,0.00,3,'2014-08-23','2014-08-23'),(109,121,'97/222','2014-07-25',1000.46,1000.46,0.00,3,'2014-08-24','2014-08-22'),(110,80,'134116','2014-07-28',90.36,0.00,0.00,2,'2014-08-17',NULL),(111,123,'263253257','2014-07-30',22.57,22.57,0.00,3,'2014-08-29','2014-09-03'),(112,110,'0-2436','2014-07-31',10976.06,0.00,0.00,3,'2014-08-30',NULL),(113,37,'547480102','2014-08-01',224.00,0.00,0.00,3,'2014-08-31',NULL),(114,123,'963253249','2014-08-02',127.75,127.75,0.00,3,'2014-09-01','2014-09-04');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms`
--

DROP TABLE IF EXISTS `terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terms` (
  `terms_id` int NOT NULL AUTO_INCREMENT,
  `terms_description` varchar(50) NOT NULL,
  `terms_due_days` int NOT NULL,
  PRIMARY KEY (`terms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms`
--

LOCK TABLES `terms` WRITE;
/*!40000 ALTER TABLE `terms` DISABLE KEYS */;
INSERT INTO `terms` VALUES (1,'Net due 10 days',10),(2,'Net due 20 days',20),(3,'Net due 30 days',30),(4,'Net due 60 days',60),(5,'Net due 90 days',90);
/*!40000 ALTER TABLE `terms` ENABLE KEYS */;
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
INSERT INTO `userfavoritegames` VALUES (1,202301),(1,202302),(1,202303),(1,202304),(1,202305),(1,202306),(1,202307),(1,202308),(1,202309),(1,202310),(1,202311),(1,202312),(1,202313),(1,202314),(4,202314),(1,202315),(4,202315);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'11','scrypt:32768:8:1$oMeSmu490YGTSMPb$037a249d0fe43bbff2f9e6a8ceeb2518d52ba4487245cc64f6dfacc79cc0d424b7a44d3f8d9299770f859b05ee030c6945401ab4c5803d96114cc014985767ea',NULL),(2,'qq','scrypt:32768:8:1$pyNpzwxHYwNXH7md$df6eb011bdcbf8782bfe75e1c10ffb27ee847d38b06c11d1fe343787617139f5ac19b6d76c9f5f5b5aaad3deb6f11c82eb6dd3bd938b530b1c7424f7c7311e52',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_contacts`
--

DROP TABLE IF EXISTS `vendor_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_contacts` (
  `vendor_id` int NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_contacts`
--

LOCK TABLES `vendor_contacts` WRITE;
/*!40000 ALTER TABLE `vendor_contacts` DISABLE KEYS */;
INSERT INTO `vendor_contacts` VALUES (5,'Davison','Michelle'),(12,'Mayteh','Kendall'),(17,'Onandonga','Bruce'),(44,'Antavius','Anthony'),(76,'Bradlee','Danny'),(94,'Suscipe','Reynaldo'),(101,'O\'Sullivan','Geraldine'),(123,'Bucket','Charles');
/*!40000 ALTER TABLE `vendor_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendors` (
  `vendor_id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(50) NOT NULL,
  `vendor_address1` varchar(50) DEFAULT NULL,
  `vendor_address2` varchar(50) DEFAULT NULL,
  `vendor_city` varchar(50) NOT NULL,
  `vendor_state` char(2) NOT NULL,
  `vendor_zip_code` varchar(20) NOT NULL,
  `vendor_phone` varchar(50) DEFAULT NULL,
  `vendor_contact_last_name` varchar(50) DEFAULT NULL,
  `vendor_contact_first_name` varchar(50) DEFAULT NULL,
  `default_terms_id` int NOT NULL,
  `default_account_number` int NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `vendor_name` (`vendor_name`),
  KEY `vendors_fk_terms` (`default_terms_id`),
  KEY `vendors_fk_accounts` (`default_account_number`),
  CONSTRAINT `vendors_fk_accounts` FOREIGN KEY (`default_account_number`) REFERENCES `general_ledger_accounts` (`account_number`),
  CONSTRAINT `vendors_fk_terms` FOREIGN KEY (`default_terms_id`) REFERENCES `terms` (`terms_id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendors`
--

LOCK TABLES `vendors` WRITE;
/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
INSERT INTO `vendors` VALUES (1,'US Postal Service','Attn:  Supt. Window Services','PO Box 7005','Madison','WI','53707','(800) 555-1205','Alberto','Francesco',1,552),(2,'National Information Data Ctr','PO Box 96621',NULL,'Washington','DC','20120','(301) 555-8950','Irvin','Ania',3,540),(3,'Register of Copyrights','Library Of Congress',NULL,'Washington','DC','20559',NULL,'Liana','Lukas',3,403),(4,'Jobtrak','1990 Westwood Blvd Ste 260',NULL,'Los Angeles','CA','90025','(800) 555-8725','Quinn','Kenzie',3,572),(5,'Newbrige Book Clubs','3000 Cindel Drive',NULL,'Washington','NJ','07882','(800) 555-9980','Marks','Michelle',4,394),(6,'California Chamber Of Commerce','3255 Ramos Cir',NULL,'Sacramento','CA','95827','(916) 555-6670','Mauro','Anton',3,572),(7,'Towne Advertiser\'s Mailing Svcs','Kevin Minder','3441 W Macarthur Blvd','Santa Ana','CA','92704',NULL,'Maegen','Ted',3,540),(8,'BFI Industries','PO Box 9369',NULL,'Fresno','CA','93792','(559) 555-1551','Kaleigh','Erick',3,521),(9,'Pacific Gas & Electric','Box 52001',NULL,'San Francisco','CA','94152','(800) 555-6081','Anthoni','Kaitlyn',3,521),(10,'Robbins Mobile Lock And Key','4669 N Fresno',NULL,'Fresno','CA','93726','(559) 555-9375','Leigh','Bill',2,523),(11,'Bill Marvin Electric Inc','4583 E Home',NULL,'Fresno','CA','93703','(559) 555-5106','Hostlery','Kaitlin',2,523),(12,'City Of Fresno','PO Box 2069',NULL,'Fresno','CA','93718','(559) 555-9999','Mayte','Kendall',3,574),(13,'Golden Eagle Insurance Co','PO Box 85826',NULL,'San Diego','CA','92186',NULL,'Blanca','Korah',3,590),(14,'Expedata Inc','4420 N. First Street, Suite 108',NULL,'Fresno','CA','93726','(559) 555-9586','Quintin','Marvin',3,589),(15,'ASC Signs','1528 N Sierra Vista',NULL,'Fresno','CA','93703',NULL,'Darien','Elisabeth',1,546),(16,'Internal Revenue Service',NULL,NULL,'Fresno','CA','93888',NULL,'Aileen','Joan',1,235),(17,'Blanchard & Johnson Associates','27371 Valderas',NULL,'Mission Viejo','CA','92691','(214) 555-3647','Keeton','Gonzalo',3,540),(18,'Fresno Photoengraving Company','1952 \"H\" Street','P.O. Box 1952','Fresno','CA','93718','(559) 555-3005','Chaddick','Derek',3,403),(19,'Crown Printing','1730 \"H\" St',NULL,'Fresno','CA','93721','(559) 555-7473','Randrup','Leann',2,400),(20,'Diversified Printing & Pub','2632 Saturn St',NULL,'Brea','CA','92621','(714) 555-4541','Lane','Vanesa',3,400),(21,'The Library Ltd','7700 Forsyth',NULL,'St Louis','MO','63105','(314) 555-8834','Marques','Malia',3,540),(22,'Micro Center','1555 W Lane Ave',NULL,'Columbus','OH','43221','(614) 555-4435','Evan','Emily',2,160),(23,'Yale Industrial Trucks-Fresno','3711 W Franklin',NULL,'Fresno','CA','93706','(559) 555-2993','Alexis','Alexandro',3,532),(24,'Zee Medical Service Co','4221 W Sierra Madre #104',NULL,'Washington','IA','52353',NULL,'Hallie','Juliana',3,570),(25,'California Data Marketing','2818 E Hamilton',NULL,'Fresno','CA','93721','(559) 555-3801','Jonessen','Moises',4,540),(26,'Small Press','121 E Front St - 4th Floor',NULL,'Traverse City','MI','49684',NULL,'Colette','Dusty',3,540),(27,'Rich Advertising','12 Daniel Road',NULL,'Fairfield','NJ','07004','(201) 555-9742','Neil','Ingrid',3,540),(29,'Vision Envelope & Printing','PO Box 3100',NULL,'Gardena','CA','90247','(310) 555-7062','Raven','Jamari',3,551),(30,'Costco','Fresno Warehouse','4500 W Shaw','Fresno','CA','93711',NULL,'Jaquan','Aaron',3,570),(31,'Enterprise Communications Inc','1483 Chain Bridge Rd, Ste 202',NULL,'Mclean','VA','22101','(770) 555-9558','Lawrence','Eileen',2,536),(32,'RR Bowker','PO Box 31',NULL,'East Brunswick','NJ','08810','(800) 555-8110','Essence','Marjorie',3,532),(33,'Nielson','Ohio Valley Litho Division','Location #0470','Cincinnati','OH','45264',NULL,'Brooklynn','Keely',2,541),(34,'IBM','PO Box 61000',NULL,'San Francisco','CA','94161','(800) 555-4426','Camron','Trentin',1,160),(35,'Cal State Termite','PO Box 956',NULL,'Selma','CA','93662','(559) 555-1534','Hunter','Demetrius',2,523),(36,'Graylift','PO Box 2808',NULL,'Fresno','CA','93745','(559) 555-6621','Sydney','Deangelo',3,532),(37,'Blue Cross','PO Box 9061',NULL,'Oxnard','CA','93031','(800) 555-0912','Eliana','Nikolas',3,510),(38,'Venture Communications Int\'l','60 Madison Ave',NULL,'New York','NY','10010','(212) 555-4800','Neftaly','Thalia',3,540),(39,'Custom Printing Company','PO Box 7028',NULL,'St Louis','MO','63177','(301) 555-1494','Myles','Harley',3,540),(40,'Nat Assoc of College Stores','500 East Lorain Street',NULL,'Oberlin','OH','44074',NULL,'Bernard','Lucy',3,572),(41,'Shields Design','415 E Olive Ave',NULL,'Fresno','CA','93728','(559) 555-8060','Kerry','Rowan',2,403),(42,'Opamp Technical Books','1033 N Sycamore Ave.',NULL,'Los Angeles','CA','90038','(213) 555-4322','Paris','Gideon',3,572),(43,'Capital Resource Credit','PO Box 39046',NULL,'Minneapolis','MN','55439','(612) 555-0057','Maxwell','Jayda',3,589),(44,'Courier Companies, Inc','PO Box 5317',NULL,'Boston','MA','02206','(508) 555-6351','Antavius','Troy',4,400),(45,'Naylor Publications Inc','PO Box 40513',NULL,'Jacksonville','FL','32231','(800) 555-6041','Gerald','Kristofer',3,572),(46,'Open Horizons Publishing','Book Marketing Update','PO Box 205','Fairfield','IA','52556','(515) 555-6130','Damien','Deborah',2,540),(47,'Baker & Taylor Books','Five Lakepointe Plaza, Ste 500','2709 Water Ridge Parkway','Charlotte','NC','28217','(704) 555-3500','Bernardo','Brittnee',3,572),(48,'Fresno County Tax Collector','PO Box 1192',NULL,'Fresno','CA','93715','(559) 555-3482','Brenton','Kila',3,574),(49,'Mcgraw Hill Companies','PO Box 87373',NULL,'Chicago','IL','60680','(614) 555-3663','Holbrooke','Rashad',3,572),(50,'Publishers Weekly','Box 1979',NULL,'Marion','OH','43305','(800) 555-1669','Carrollton','Priscilla',3,572),(51,'Blue Shield of California','PO Box 7021',NULL,'Anaheim','CA','92850','(415) 555-5103','Smith','Kylie',3,510),(52,'Aztek Label','Accounts Payable','1150 N Tustin Ave','Anaheim','CA','92807','(714) 555-9000','Griffin','Brian',3,551),(53,'Gary McKeighan Insurance','3649 W Beechwood Ave #101',NULL,'Fresno','CA','93711','(559) 555-2420','Jair','Caitlin',3,590),(54,'Ph Photographic Services','2384 E Gettysburg',NULL,'Fresno','CA','93726','(559) 555-0765','Cheyenne','Kaylea',3,540),(55,'Quality Education Data','PO Box 95857',NULL,'Chicago','IL','60694','(800) 555-5811','Misael','Kayle',2,540),(56,'Springhouse Corp','PO Box 7247-7051',NULL,'Philadelphia','PA','19170','(215) 555-8700','Maeve','Clarence',3,523),(57,'The Windows Deck','117 W Micheltorena Top Floor',NULL,'Santa Barbara','CA','93101','(800) 555-3353','Wood','Liam',3,536),(58,'Fresno Rack & Shelving Inc','4718 N Bendel Ave',NULL,'Fresno','CA','93722',NULL,'Baylee','Dakota',2,523),(59,'Publishers Marketing Assoc','627 Aviation Way',NULL,'Manhatttan Beach','CA','90266','(310) 555-2732','Walker','Jovon',3,572),(60,'The Mailers Guide Co','PO Box 1550',NULL,'New Rochelle','NY','10802',NULL,'Lacy','Karina',3,540),(61,'American Booksellers Assoc','828 S Broadway',NULL,'Tarrytown','NY','10591','(800) 555-0037','Angelica','Nashalie',3,574),(62,'Cmg Information Services','PO Box 2283',NULL,'Boston','MA','02107','(508) 555-7000','Randall','Yash',3,540),(63,'Lou Gentile\'s Flower Basket','722 E Olive Ave',NULL,'Fresno','CA','93728','(559) 555-6643','Anum','Trisha',1,570),(64,'Texaco','PO Box 6070',NULL,'Inglewood','CA','90312',NULL,'Oren','Grace',3,582),(65,'The Drawing Board','PO Box 4758',NULL,'Carol Stream','IL','60197',NULL,'Mckayla','Jeffery',2,551),(66,'Ascom Hasler Mailing Systems','PO Box 895',NULL,'Shelton','CT','06484',NULL,'Lewis','Darnell',3,532),(67,'Bill Jones','Secretary Of State','PO Box 944230','Sacramento','CA','94244',NULL,'Deasia','Tristin',3,589),(68,'Computer Library','3502 W Greenway #7',NULL,'Phoenix','AZ','85023','(602) 547-0331','Aryn','Leroy',3,540),(69,'Frank E Wilber Co','2437 N Sunnyside',NULL,'Fresno','CA','93727','(559) 555-1881','Millerton','Johnathon',3,532),(70,'Fresno Credit Bureau','PO Box 942',NULL,'Fresno','CA','93714','(559) 555-7900','Braydon','Anne',2,555),(71,'The Fresno Bee','1626 E Street',NULL,'Fresno','CA','93786','(559) 555-4442','Colton','Leah',2,572),(72,'Data Reproductions Corp','4545 Glenmeade Lane',NULL,'Auburn Hills','MI','48326','(810) 555-3700','Arodondo','Cesar',3,400),(73,'Executive Office Products','353 E Shaw Ave',NULL,'Fresno','CA','93710','(559) 555-1704','Danielson','Rachael',2,570),(74,'Leslie Company','PO Box 610',NULL,'Olathe','KS','66061','(800) 255-6210','Alondra','Zev',3,570),(75,'Retirement Plan Consultants','6435 North Palm Ave, Ste 101',NULL,'Fresno','CA','93704','(559) 555-7070','Edgardo','Salina',3,589),(76,'Simon Direct Inc','4 Cornwall Dr Ste 102',NULL,'East Brunswick','NJ','08816','(908) 555-7222','Bradlee','Daniel',2,540),(77,'State Board Of Equalization','PO Box 942808',NULL,'Sacramento','CA','94208','(916) 555-4911','Dean','Julissa',1,631),(78,'The Presort Center','1627 \"E\" Street',NULL,'Fresno','CA','93706','(559) 555-6151','Marissa','Kyle',3,540),(79,'Valprint','PO Box 12332',NULL,'Fresno','CA','93777','(559) 555-3112','Warren','Quentin',3,551),(80,'Cardinal Business Media, Inc.','P O Box 7247-7844',NULL,'Philadelphia','PA','19170','(215) 555-1500','Eulalia','Kelsey',2,540),(81,'Wang Laboratories, Inc.','P.O. Box 21209',NULL,'Pasadena','CA','91185','(800) 555-0344','Kapil','Robert',2,160),(82,'Reiter\'s Scientific & Pro Books','2021 K Street Nw',NULL,'Washington','DC','20006','(202) 555-5561','Rodolfo','Carlee',2,572),(83,'Ingram','PO Box 845361',NULL,'Dallas','TX','75284',NULL,'Yobani','Trey',2,541),(84,'Boucher Communications Inc','1300 Virginia Dr. Ste 400',NULL,'Fort Washington','PA','19034','(215) 555-8000','Carson','Julian',3,540),(85,'Champion Printing Company','3250 Spring Grove Ave',NULL,'Cincinnati','OH','45225','(800) 555-1957','Clifford','Jillian',3,540),(86,'Computerworld','Department #1872','PO Box 61000','San Francisco','CA','94161','(617) 555-0700','Lloyd','Angel',1,572),(87,'DMV Renewal','PO Box 942894',NULL,'Sacramento','CA','94294',NULL,'Josey','Lorena',4,568),(88,'Edward Data Services','4775 E Miami River Rd',NULL,'Cleves','OH','45002','(513) 555-3043','Helena','Jeanette',1,540),(89,'Evans Executone Inc','4918 Taylor Ct',NULL,'Turlock','CA','95380',NULL,'Royce','Hannah',1,522),(90,'Wakefield Co','295 W Cromwell Ave Ste 106',NULL,'Fresno','CA','93711','(559) 555-4744','Rothman','Nathanael',2,170),(91,'McKesson Water Products','P O Box 7126',NULL,'Pasadena','CA','91109','(800) 555-7009','Destin','Luciano',2,570),(92,'Zip Print & Copy Center','PO Box 12332',NULL,'Fresno','CA','93777','(233) 555-6400','Javen','Justin',2,540),(93,'AT&T','PO Box 78225',NULL,'Phoenix','AZ','85062',NULL,'Wesley','Alisha',3,522),(94,'Abbey Office Furnishings','4150 W Shaw Ave',NULL,'Fresno','CA','93722','(559) 555-8300','Francis','Kyra',2,150),(95,'Pacific Bell',NULL,NULL,'Sacramento','CA','95887','(209) 555-7500','Nickalus','Kurt',2,522),(96,'Wells Fargo Bank','Business Mastercard','P.O. Box 29479','Phoenix','AZ','85038','(947) 555-3900','Damion','Mikayla',2,160),(97,'Compuserve','Dept L-742',NULL,'Columbus','OH','43260','(614) 555-8600','Armando','Jan',2,572),(98,'American Express','Box 0001',NULL,'Los Angeles','CA','90096','(800) 555-3344','Story','Kirsten',2,160),(99,'Bertelsmann Industry Svcs. Inc','28210 N Avenue Stanford',NULL,'Valencia','CA','91355','(805) 555-0584','Potter','Lance',3,400),(100,'Cahners Publishing Company','Citibank Lock Box 4026','8725 W Sahara Zone 1127','The Lake','NV','89163','(301) 555-2162','Jacobsen','Samuel',4,540),(101,'California Business Machines','Gallery Plz','5091 N Fresno','Fresno','CA','93710','(559) 555-5570','Rohansen','Anders',2,170),(102,'Coffee Break Service','PO Box 1091',NULL,'Fresno','CA','93714','(559) 555-8700','Smitzen','Jeffrey',4,570),(103,'Dean Witter Reynolds','9 River Pk Pl E 400',NULL,'Boston','MA','02134','(508) 555-8737','Johnson','Vance',5,589),(104,'Digital Dreamworks','5070 N Sixth Ste. 71',NULL,'Fresno','CA','93711',NULL,'Elmert','Ron',3,589),(105,'Dristas Groom & McCormick','7112 N Fresno St Ste 200',NULL,'Fresno','CA','93720','(559) 555-8484','Aaronsen','Thom',3,591),(106,'Ford Motor Credit Company','Dept 0419',NULL,'Los Angeles','CA','90084','(800) 555-7000','Snyder','Karen',3,582),(107,'Franchise Tax Board','PO Box 942857',NULL,'Sacramento','CA','94257',NULL,'Prado','Anita',4,507),(108,'Gostanian General Building','427 W Bedford #102',NULL,'Fresno','CA','93711','(559) 555-5100','Bragg','Walter',4,523),(109,'Kent H Landsberg Co','File No 72686','PO Box 61000','San Francisco','CA','94160','(916) 555-8100','Stevens','Wendy',3,540),(110,'Malloy Lithographing Inc','5411 Jackson Road','PO Box 1124','Ann Arbor','MI','48106','(313) 555-6113','Regging','Abe',3,400),(111,'Net Asset, Llc','1315 Van Ness Ave Ste. 103',NULL,'Fresno','CA','93721',NULL,'Kraggin','Laura',1,572),(112,'Office Depot','File No 81901',NULL,'Los Angeles','CA','90074','(800) 555-1711','Pinsippi','Val',3,570),(113,'Pollstar','4697 W Jacquelyn Ave',NULL,'Fresno','CA','93722','(559) 555-2631','Aranovitch','Robert',5,520),(114,'Postmaster','Postage Due Technician','1900 E Street','Fresno','CA','93706','(559) 555-7785','Finklestein','Fyodor',1,552),(115,'Roadway Package System, Inc','Dept La 21095',NULL,'Pasadena','CA','91185',NULL,'Smith','Sam',4,553),(116,'State of California','Employment Development Dept','PO Box 826276','Sacramento','CA','94230','(209) 555-5132','Articunia','Mercedez',1,631),(117,'Suburban Propane','2874 S Cherry Ave',NULL,'Fresno','CA','93706','(559) 555-2770','Spivak','Harold',3,521),(118,'Unocal','P.O. Box 860070',NULL,'Pasadena','CA','91186','(415) 555-7600','Bluzinski','Rachael',3,582),(119,'Yesmed, Inc','PO Box 2061',NULL,'Fresno','CA','93718','(559) 555-0600','Hernandez','Reba',2,589),(120,'Dataforms/West','1617 W. Shaw Avenue','Suite F','Fresno','CA','93711',NULL,'Church','Charlie',3,551),(121,'Zylka Design','3467 W Shaw Ave #103',NULL,'Fresno','CA','93711','(559) 555-8625','Ronaldsen','Jaime',3,403),(122,'United Parcel Service','P.O. Box 505820',NULL,'Reno','NV','88905','(800) 555-0855','Beauregard','Violet',3,553),(123,'Federal Express Corporation','P.O. Box 1140','Dept A','Memphis','TN','38101','(800) 555-4091','Bucket','Charlie',3,553);
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;
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

-- Dump completed on 2023-12-07 23:34:41
