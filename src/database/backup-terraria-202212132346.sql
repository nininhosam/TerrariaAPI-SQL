-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: terraria
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craftings`
--

DROP TABLE IF EXISTS `craftings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craftings` (
  `result` int NOT NULL,
  `material` int NOT NULL,
  `amount` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`result`,`material`),
  KEY `material` (`material`),
  CONSTRAINT `craftings_ibfk_1` FOREIGN KEY (`material`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craftings_ibfk_2` FOREIGN KEY (`result`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftings`
--

LOCK TABLES `craftings` WRITE;
/*!40000 ALTER TABLE `craftings` DISABLE KEYS */;
INSERT INTO `craftings` VALUES (1,2,1),(1,3,1),(1,4,1),(2,5,1),(2,6,1),(2,7,1),(7,8,1),(7,9,1),(7,10,1),(7,11,1),(8,12,1),(8,13,1),(8,14,1),(8,15,1),(9,16,1),(9,17,1),(9,18,1),(10,19,1),(10,20,1),(10,21,1),(11,22,1),(11,23,1),(11,24,1),(14,44,10),(14,49,1),(15,42,10),(15,49,1),(27,25,1),(27,26,1),(30,28,1),(30,29,1),(42,41,4),(44,43,4),(47,46,3),(48,45,3),(49,47,1),(49,48,1),(52,30,1),(52,50,1),(52,51,1),(58,53,1),(58,54,1),(58,55,1),(58,56,1),(58,57,1),(62,58,1),(62,59,1),(63,58,1),(63,60,1),(63,61,1),(65,63,1),(65,64,1),(66,52,1),(66,65,1);
/*!40000 ALTER TABLE `craftings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `obtained` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Shellphone','Obtained by crafting'),(2,'Cell Phone','Obtained by crafting'),(3,'Demon Conch','Obtained by fishing in lava'),(4,'Magic Conch','Found on Sanstone Chests, Oasis crates and Mirage Crates'),(5,'Magic Mirror','Found in gold chests in the Underground and Cavern layers'),(6,'Ice Mirror','Found in frozen chests in the Ice biome'),(7,'PDA','Obtained by crafting'),(8,'GPS','Obtained by crafting'),(9,'R.E.K. 3000','Obtained by crafting'),(10,'Goblin Tech','Obtained by crafting'),(11,'Fish Finder','Obtained by crafting'),(12,'Depth Meter','Dropped by Cave Bats, Giant Bats, Jungle Bats, Spore Bats, and Ice Bats'),(13,'Compass','Dropped by Salamanders, Giant Shellys, and Crawdads, Piranhas, Mother Slimes, Snow Flinxes, Undead Vikings, and Armored Vikings'),(14,'Gold Watch','Obtained by crafting'),(15,'Platinum Watch','Obtained by crafting'),(16,'Lifeform Analyzer','Purchased from the Traveling Merchant'),(17,'Tally Counter','Dropped from Angry Bones, Cursed Skulls, and Dark Casters'),(18,'Radar','Found in chests on/near the surface, Wooden Crates and Pearlwood creates. Also sold by the Skeleton Merchant'),(19,'Metal Detector','Dropped by the Nymph'),(20,'Stopwatch','Purchased from the Traveling Merchant'),(21,'DPS Meter','Purchased from the Traveling Merchant'),(22,'Sextant','Possible reward from completing the Angler\'s Fishing quests'),(23,'Weather Radio','Possible reward from completing the Angler\'s Fishing quests'),(24,'Fishermans Pocket Guide','Possible reward from completing the Angler\'s Fishing quests'),(25,'Shoe Spikes','Found in Gold Chests underground and Rich Mahogany Chests in the underground jungle.'),(26,'Climbing Claws','Found in surface chests, Wooden Crates and Pearlwood Crates.'),(27,'Tiger Climbing Gear','Obtained by crafting'),(28,'Obsidian Skull','Obtained by crafting'),(29,'Lava Charm','Found in chests in the lower portion of the Caverns, Hellstone Crates and Obsidian Crates'),(30,'Molten Charm','Obtained by crafting'),(40,'Obsidian','Ore produced when water and lava collide'),(41,'Platinum ore','Ore found in underground and cavern layers'),(42,'Platinum Bar','Obtained by crafting'),(43,'Gold Ore','Ore found in underground and cavern layers'),(44,'Gold Bar','Obtained by crafting'),(45,'Iron ore','Ore found on the surface, Underground and Cavern layers'),(46,'Lead ore','Ore found on the surface, Underground and Cavern layers'),(47,'Lead Bar','Obtained by crafting'),(48,'Iron Bar','Obtained by crafting'),(49,'Chain','Obtained by crafting'),(50,'Water Walking Boots','Found in Water Chests, Ocean crates and Seaside Crates'),(51,'Obsidian Rose','Dropped by Fire Imps'),(52,'Lava Waders','Obtained by crafting'),(53,'Rocket Boots','Purchased from the Goblin Tinkerer'),(54,'Hermes Boots','Found in Chests in the Underground and Cavern layers'),(55,'Flurry Boots','Found in Frozen Chests in the underground Snow Biome, Frozen Crates and Boreal Crates'),(56,'Sailfish Boots','Found in Wooden Crates and Iron Crates'),(57,'Dunerider Boots','Found in Sanstone Chests in the Underground Desert, Oasis Crates and Mirage Crates'),(58,'Spectre Boots','Obtained by crafting'),(59,'Flower Boots','Found in Ivy Chests, Jungle Crates and Bramble Crates'),(60,'Anklet of the Wind','Found in Ivy Chests, Jungle Crates and Bramble Crates'),(61,'Aglet','Found in surface Chests, Wooden Crates and Pearlwood Crates. Also sold by the Skeleton Merchant'),(62,'Fairy Boots','Obtained by crafting'),(63,'Lightning Boots','Obtained by crafting'),(64,'Ice Skates','Found in Frozen Chests in the Ice Biome, Frozen Crates and Boreal Crates.'),(65,'Frostspark Boots','Obtained by crafting'),(66,'Terraspark Boots','Obtained by crafting');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'terraria'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-13 23:46:10
