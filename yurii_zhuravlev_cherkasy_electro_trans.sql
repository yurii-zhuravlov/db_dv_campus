-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: yurii_zhuravlev_cherkasy_electro_trans
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employe`
--

DROP TABLE IF EXISTS `employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `gender` smallint(5) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `license` smallint(5) unsigned NOT NULL DEFAULT '0',
  `position_id` int(10) unsigned DEFAULT NULL,
  `monthly_salary` decimal(20,4) unsigned NOT NULL,
  `hired` date NOT NULL,
  `fired` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EMPLOYE_POSITION_ID_POSITION_ID_idx` (`position_id`),
  CONSTRAINT `EMPLOYE_POSITION_ID_POSITION_ID` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employe`
--

LOCK TABLES `employe` WRITE;
/*!40000 ALTER TABLE `employe` DISABLE KEYS */;
INSERT INTO `employe` VALUES (1,'Kelvin','Sullivan','1985-03-12',1,'k.sullivan@gmail.com ',1,1,28439.0000,'2013-05-28',NULL),(3,'Joyce','Craig','1993-05-28',2,'j.craig@gmail.com	',1,11,21805.0000,'2018-12-05',NULL),(4,'Melissa','Edwards','1978-12-05',2,'m.edwards@gmail.com',1,3,29252.0000,'2019-07-13',NULL),(5,'Rebecca','Lloyd','1999-07-13',2,'r.lloyd@gmail.com	',0,8,15299.0000,'2019-02-02',NULL),(6,'Kellan','Sullivan','1969-02-02',1,'k.sullivan@gmail.com	',1,4,48662.0000,'2011-07-22',NULL),(7,'Vincent','Stevens','2001-07-22',1,'v.stevens@gmail.com	',1,1,28662.0000,'2018-10-12',NULL),(8,'Alina','Cameron','1998-10-12',2,'a.cameron@gmail.com',1,2,20822.0000,'2012-01-25',NULL),(9,'Sarah','Harrison','1982-01-25',2,'s.harrison@gmail.com	',0,6,18477.0000,'2013-08-01',NULL),(10,'Lucas','Holmes','1993-08-01',1,'l.holmes@gmail.com	',1,5,26749.0000,'2013-05-09',NULL),(11,'Vincent','Murray','1973-05-09',1,'v.murray@gmail.com	',0,12,11516.0000,'2014-05-30',NULL),(12,'Alfred','Baker','1984-05-30',1,'a.baker@gmail.com	',1,7,26547.0000,'2017-11-04',NULL),(13,'Tiana','Chapman','1977-11-04',2,'t.chapman@gmail.com	',1,9,20732.0000,'2019-04-28',NULL),(14,'Jared','Holmes','1969-04-28',1,'j.holmes@gmail.com	',1,1,24324.0000,'2012-03-19',NULL),(15,'Lucas','Gray','1972-03-19',1,'l.gray@gmail.com	',1,1,24617.0000,'2016-12-02',NULL),(16,'Catherine','Craig','1996-12-02',2,'c.craig@gmail.com	',1,10,22232.0000,'2018-01-13',NULL),(17,'Alina','Morrison','1998-01-13',2,'a.morrison@gmail.com	',1,10,22683.0000,'2015-03-12',NULL);
/*!40000 ALTER TABLE `employe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,'Driver'),(2,'Dispatcher'),(3,'Accountant'),(4,'Director'),(5,'Mechanic'),(6,'Doctor'),(7,'Lawyer'),(8,'Cleaner'),(9,'Controller'),(10,'Conductor'),(11,'Secretary'),(12,'Storekeeper');
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race`
--

DROP TABLE IF EXISTS `race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `race` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employe_id` int(10) unsigned DEFAULT NULL,
  `transport_id` int(10) unsigned DEFAULT NULL,
  `route_id` int(10) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `tickets_sold` int(10) NOT NULL,
  `free_ride` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `RACE_EMPLOYE_ID_EMPLOYE_ID_idx` (`employe_id`),
  KEY `RACE_TRANSPORT_ID_TRANSPORT_ID_idx` (`transport_id`),
  KEY `RACE_ROUTE_ID_ROUTE_ID_idx` (`route_id`),
  CONSTRAINT `RACE_EMPLOYE_ID_EMPLOYE_ID` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`) ON DELETE SET NULL,
  CONSTRAINT `RACE_ROUTE_ID_ROUTE_ID` FOREIGN KEY (`route_id`) REFERENCES `route` (`id`) ON DELETE SET NULL,
  CONSTRAINT `RACE_TRANSPORT_ID_TRANSPORT_ID` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race`
--

LOCK TABLES `race` WRITE;
/*!40000 ALTER TABLE `race` DISABLE KEYS */;
INSERT INTO `race` VALUES (1,1,3,1,'2019-09-01',289,513),(2,7,7,7,'2019-09-01',374,649),(3,14,4,4,'2019-09-01',275,537),(4,15,5,7,'2019-09-01',315,583),(5,1,3,1,'2019-09-02',342,452),(6,7,7,7,'2019-09-02',414,565),(7,14,4,4,'2019-09-02',325,501),(8,15,5,7,'2019-09-02',367,502),(9,1,3,1,'2019-09-03',323,530),(10,7,7,7,'2019-09-03',377,672),(11,14,4,4,'2019-09-03',309,579),(12,15,5,7,'2019-09-03',301,542),(13,1,3,1,'2019-09-04',301,501),(14,7,7,7,'2019-09-04',332,602),(15,14,4,4,'2019-09-04',245,521),(16,15,5,7,'2019-09-04',263,456),(17,1,3,1,'2019-09-05',255,472),(18,7,7,7,'2019-09-05',310,531),(19,14,4,4,'2019-09-05',202,508),(20,15,5,7,'2019-09-05',213,403),(21,1,3,1,'2019-09-06',320,390),(22,7,7,7,'2019-09-06',346,462),(23,14,4,4,'2019-09-06',258,421),(24,15,5,7,'2019-09-06',290,370),(25,1,3,1,'2019-09-07',390,532),(26,7,7,7,'2019-09-07',474,680),(27,14,4,4,'2019-09-07',315,509),(28,15,5,7,'2019-09-07',337,409),(29,1,1,1,'2019-09-08',334,637),(30,7,7,7,'2019-09-08',404,632),(31,15,4,4,'2019-09-08',364,553),(32,15,6,7,'2019-09-08',334,490),(33,1,3,1,'2019-09-09',420,510),(34,7,7,7,'2019-09-09',456,734),(35,15,4,4,'2019-09-09',390,523),(36,15,6,7,'2019-09-09',384,590),(37,7,1,1,'2019-09-10',373,710),(38,7,7,7,'2019-09-10',362,584),(39,15,4,4,'2019-09-10',320,621),(40,15,5,7,'2019-09-10',410,494),(41,7,3,1,'2019-09-11',289,475),(42,7,7,7,'2019-09-11',271,467),(43,15,4,4,'2019-09-11',298,483),(44,15,6,7,'2019-09-11',310,421);
/*!40000 ALTER TABLE `race` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `price` decimal(20,4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,'ЧЛФЗ \"Аврора\" - санаторій \"Україна\"','1',3.0000),(2,'вул. Пацаєва - санаторій \"Україна\"','1A',3.0000),(3,'вул. Пацаєва - ЧШК','2',3.0000),(4,'санаторій \"Україна\" - Залізничний вокзал\n','3',3.0000),(5,'вул. Луначарського - Троллейбусний парк\n','4',3.0000),(6,'вул. Луначарського - Залізничний вокзал\n','4A',3.0000),(7,'вул. Можайського - Троллейбусний парк\n','7',3.0000),(8,'санаторій \"Україна\" - Тролейбусний парк\n','7A',3.0000),(9,'ЧЛФЗ \"Аврора\" - вул. Руставі\n','8',3.0000),(10,'ЧЛФЗ \"Аврора\" - Аеропорт\n','8P',3.0000),(11,'Річковий вокзал - вул. Конєва\n','10',3.0000),(12,'вул. Пацаєва - вул. Руставі\n','11',3.0000),(13,'вул. Онопрієнка - Аеропорт\n','14',3.0000),(14,'Вантажний порт - Аеропорт\n','50',3.0000);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paid_at` datetime NOT NULL,
  `amount` decimal(20,4) NOT NULL,
  `employe_id` int(10) unsigned DEFAULT NULL,
  `position_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `SALARY_EMPLOYE_ID_EMPLOYE_ID_idx` (`employe_id`),
  KEY `SALARY_POSITION_ID_POSITION_ID_idx` (`position_id`),
  CONSTRAINT `SALARY_EMPLOYE_ID_EMPLOYE_ID` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`) ON DELETE SET NULL,
  CONSTRAINT `SALARY_POSITION_ID_POSITION_ID` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (1,'2019-09-03 00:00:00',24332.0000,1,1),(2,'2019-09-03 00:00:00',21805.0000,3,11),(3,'2019-09-03 00:00:00',29252.0000,4,3),(4,'2019-09-03 00:00:00',15299.0000,5,8),(5,'2019-09-03 00:00:00',48662.0000,6,4),(6,'2019-09-03 00:00:00',28662.0000,7,1),(7,'2019-09-03 00:00:00',20822.0000,8,2),(8,'2019-09-03 00:00:00',18477.0000,9,6),(9,'2019-09-03 00:00:00',26749.0000,10,5),(10,'2019-09-03 00:00:00',11516.0000,11,12),(11,'2019-09-03 00:00:00',26547.0000,12,7),(12,'2019-09-03 00:00:00',20732.0000,13,9),(13,'2019-09-03 00:00:00',24324.0000,14,1),(14,'2019-09-03 00:00:00',24617.0000,15,1),(15,'2019-09-03 00:00:00',22232.0000,16,10),(16,'2019-10-02 00:00:00',22683.0000,17,10),(17,'2019-10-02 00:00:00',27425.0000,1,1),(18,'2019-10-02 00:00:00',21805.0000,3,11),(19,'2019-10-02 00:00:00',29252.0000,4,3),(20,'2019-10-02 00:00:00',15299.0000,5,8),(21,'2019-10-02 00:00:00',48662.0000,6,4),(22,'2019-10-02 00:00:00',28662.0000,7,1),(23,'2019-10-02 00:00:00',20822.0000,8,2),(24,'2019-10-02 00:00:00',18477.0000,9,6),(25,'2019-10-02 00:00:00',26749.0000,10,5),(26,'2019-10-02 00:00:00',11516.0000,11,12),(27,'2019-10-02 00:00:00',26547.0000,12,7),(28,'2019-10-02 00:00:00',20732.0000,13,9),(29,'2019-10-02 00:00:00',24324.0000,14,1),(30,'2019-10-02 00:00:00',24617.0000,15,1),(31,'2019-10-02 00:00:00',22232.0000,16,10),(32,'2019-10-02 00:00:00',22683.0000,17,10),(33,'2019-11-04 00:00:00',28439.0000,1,1),(34,'2019-11-04 00:00:00',21805.0000,3,11),(35,'2019-11-04 00:00:00',29252.0000,4,3),(36,'2019-11-04 00:00:00',15299.0000,5,8),(37,'2019-11-04 00:00:00',48662.0000,6,4),(38,'2019-11-04 00:00:00',28662.0000,7,1),(39,'2019-11-04 00:00:00',20822.0000,8,2),(40,'2019-11-04 00:00:00',18477.0000,9,6),(41,'2019-11-04 00:00:00',26749.0000,10,5),(42,'2019-11-04 00:00:00',11516.0000,11,12),(43,'2019-11-04 00:00:00',26547.0000,12,6),(44,'2019-11-04 00:00:00',20732.0000,13,9),(45,'2019-11-04 00:00:00',24324.0000,14,1),(46,'2019-11-04 00:00:00',24617.0000,15,1),(47,'2019-11-04 00:00:00',22232.0000,16,10),(48,'2019-11-04 00:00:00',22683.0000,17,10);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport`
--

DROP TABLE IF EXISTS `transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport`
--

LOCK TABLES `transport` WRITE;
/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
INSERT INTO `transport` VALUES (1,'LiAZ-5280','AE5634MC'),(2,'AKSM-321','BI7122EE'),(3,'ElectroLAZ-12','AA5624KC'),(4,'Bogdan Т701.10','AE5632MC'),(5,'Solaris Trollino 15','BM3856CA'),(6,'Irisbus Cristalis','BB2270EE'),(7,'TrolZa-5265','AB0268EO'),(8,'BTZ-52763','AE5222AX'),(9,'VMZ-62151','BK5606AH'),(10,'PKTS-6281','CA4417CK');
/*!40000 ALTER TABLE `transport` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-16 18:22:20
