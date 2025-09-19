-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: camera_db
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `accessories`
--

DROP TABLE IF EXISTS `accessories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accessories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accessories_name_en_unique` (`name_en`),
  UNIQUE KEY `accessories_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessories`
--

LOCK TABLES `accessories` WRITE;
/*!40000 ALTER TABLE `accessories` DISABLE KEYS */;
INSERT INTO `accessories` VALUES (1,'Battery','バッテリー',NULL,NULL),(2,'Battery charger','バッテリーチャージャー',NULL,NULL),(3,'Power cord','電源コード',NULL,NULL),(4,'Strap','ストラップ',NULL,NULL),(5,'Body cap','ボディキャップ',NULL,NULL),(6,'Hot shoe cover','ホットシューカバー',NULL,NULL),(7,'USB cable','USBケーブル',NULL,NULL),(8,'Cable protector','ケーブルプロテクター',NULL,NULL),(9,'Eyepiece cup','アイピースカップ',NULL,NULL);
/*!40000 ALTER TABLE `accessories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_accessory`
--

DROP TABLE IF EXISTS `camera_accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_accessory` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `accessory_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_accessory_camera_id_accessory_id_unique` (`camera_id`,`accessory_id`),
  KEY `camera_accessory_accessory_id_foreign` (`accessory_id`),
  CONSTRAINT `camera_accessory_accessory_id_foreign` FOREIGN KEY (`accessory_id`) REFERENCES `accessories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_accessory_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_accessory`
--

LOCK TABLES `camera_accessory` WRITE;
/*!40000 ALTER TABLE `camera_accessory` DISABLE KEYS */;
INSERT INTO `camera_accessory` VALUES (2,1,1),(3,1,2),(1,1,4),(5,1,5),(4,1,6),(10,2,1),(11,2,2),(9,2,4),(13,2,5),(12,2,6),(6,2,7),(8,2,8),(7,2,9),(17,3,1),(18,3,2),(16,3,4),(20,3,5),(19,3,6),(14,3,7),(15,3,8),(22,4,1),(21,4,4),(23,4,5),(26,5,1),(25,5,4),(27,5,5),(24,5,7),(30,6,1),(31,6,2),(29,6,4),(33,6,5),(32,6,6),(28,6,7),(36,7,1),(37,7,2),(35,7,4),(39,7,5),(38,7,6),(34,7,7),(42,8,1),(41,8,4),(43,8,5),(40,8,7),(46,9,1),(45,9,4),(47,9,5),(44,9,7),(50,10,1),(49,10,4),(52,10,5),(51,10,6),(48,10,7),(55,11,1),(54,11,4),(57,11,5),(56,11,6),(53,11,7),(59,12,1),(58,12,4),(61,12,5),(60,12,6),(65,13,1),(66,13,2),(64,13,4),(68,13,5),(67,13,6),(63,13,8),(62,13,9),(72,15,1),(73,15,2),(76,15,3),(71,15,4),(75,15,5),(74,15,6),(70,15,8),(69,15,9);
/*!40000 ALTER TABLE `camera_accessory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_color_option`
--

DROP TABLE IF EXISTS `camera_color_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_color_option` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `color_option_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_color_option_camera_id_color_option_id_unique` (`camera_id`,`color_option_id`),
  KEY `camera_color_option_color_option_id_foreign` (`color_option_id`),
  CONSTRAINT `camera_color_option_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_color_option_color_option_id_foreign` FOREIGN KEY (`color_option_id`) REFERENCES `color_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_color_option`
--

LOCK TABLES `camera_color_option` WRITE;
/*!40000 ALTER TABLE `camera_color_option` DISABLE KEYS */;
INSERT INTO `camera_color_option` VALUES (1,1,1),(2,2,1),(3,3,1),(5,4,1),(4,4,2),(6,5,17),(7,6,1),(8,7,1),(9,8,1),(10,9,1),(11,10,15),(12,11,1),(14,12,1),(13,12,2),(15,13,1),(16,14,1),(17,15,1);
/*!40000 ALTER TABLE `camera_color_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_display_language`
--

DROP TABLE IF EXISTS `camera_display_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_display_language` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `display_language_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_display_language_camera_id_display_language_id_unique` (`camera_id`,`display_language_id`),
  KEY `camera_display_language_display_language_id_foreign` (`display_language_id`),
  CONSTRAINT `camera_display_language_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_display_language_display_language_id_foreign` FOREIGN KEY (`display_language_id`) REFERENCES `display_languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_display_language`
--

LOCK TABLES `camera_display_language` WRITE;
/*!40000 ALTER TABLE `camera_display_language` DISABLE KEYS */;
INSERT INTO `camera_display_language` VALUES (2,1,1),(1,1,8),(4,2,1),(3,2,8),(6,3,1),(5,3,8),(9,4,1),(7,4,8),(8,4,10),(14,5,1),(10,5,2),(11,5,3),(12,5,8),(13,5,10),(24,7,1),(17,7,2),(18,7,3),(15,7,4),(16,7,5),(19,7,6),(20,7,7),(21,7,8),(23,7,9),(22,7,10),(25,7,11),(35,8,1),(28,8,2),(29,8,3),(26,8,4),(27,8,5),(30,8,6),(31,8,7),(32,8,8),(34,8,9),(33,8,10),(36,8,11),(46,9,1),(39,9,2),(40,9,3),(37,9,4),(38,9,5),(41,9,6),(42,9,7),(43,9,8),(45,9,9),(44,9,10),(47,9,11),(57,10,1),(50,10,2),(51,10,3),(48,10,4),(49,10,5),(52,10,6),(53,10,7),(54,10,8),(56,10,9),(55,10,10),(58,10,11),(59,12,8),(65,13,1),(61,13,3),(60,13,5),(62,13,6),(64,13,9),(63,13,10),(66,13,11),(67,15,8);
/*!40000 ALTER TABLE `camera_display_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_feature`
--

DROP TABLE IF EXISTS `camera_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_feature` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `feature_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_feature_camera_id_feature_id_unique` (`camera_id`,`feature_id`),
  KEY `camera_feature_feature_id_foreign` (`feature_id`),
  CONSTRAINT `camera_feature_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_feature_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_feature`
--

LOCK TABLES `camera_feature` WRITE;
/*!40000 ALTER TABLE `camera_feature` DISABLE KEYS */;
INSERT INTO `camera_feature` VALUES (12,1,1),(10,1,2),(1,1,3),(11,1,4),(6,1,5),(4,1,6),(5,1,8),(9,1,9),(2,1,12),(7,1,13),(3,1,14),(8,1,16),(25,2,1),(23,2,2),(13,2,3),(24,2,4),(19,2,5),(18,2,6),(22,2,9),(14,2,10),(16,2,11),(15,2,12),(20,2,13),(17,2,14),(21,2,16),(38,3,1),(36,3,2),(26,3,3),(37,3,4),(32,3,5),(31,3,6),(35,3,9),(27,3,10),(29,3,11),(28,3,12),(33,3,13),(30,3,14),(34,3,16),(46,4,4),(43,4,5),(42,4,6),(45,4,9),(40,4,11),(39,4,12),(44,4,13),(41,4,14),(47,5,3),(50,5,9),(49,5,11),(48,5,12),(55,6,2),(51,6,3),(53,6,5),(54,6,9),(52,6,11),(60,7,5),(62,7,9),(56,7,10),(58,7,11),(57,7,12),(59,7,14),(61,7,16),(63,8,3),(68,8,5),(70,8,9),(64,8,10),(66,8,11),(65,8,12),(67,8,14),(69,8,16),(71,9,3),(75,9,5),(76,9,9),(72,9,10),(74,9,11),(73,9,12),(81,10,5),(83,10,9),(77,10,10),(79,10,11),(78,10,12),(80,10,14),(82,10,16),(84,11,10),(86,11,11),(85,11,12),(87,11,14),(99,12,1),(97,12,2),(88,12,3),(98,12,4),(94,12,5),(93,12,6),(96,12,9),(89,12,10),(91,12,11),(90,12,12),(92,12,14),(95,12,16),(112,13,1),(100,13,3),(111,13,4),(107,13,5),(105,13,6),(106,13,8),(110,13,9),(101,13,10),(103,13,11),(102,13,12),(108,13,13),(104,13,14),(109,13,16),(124,14,1),(123,14,2),(113,14,3),(119,14,5),(118,14,6),(122,14,9),(116,14,11),(115,14,12),(120,14,13),(117,14,14),(114,14,15),(121,14,16),(137,15,1),(135,15,2),(125,15,3),(136,15,4),(131,15,5),(129,15,6),(130,15,8),(134,15,9),(127,15,11),(126,15,12),(132,15,13),(128,15,14),(133,15,16);
/*!40000 ALTER TABLE `camera_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_interface_model`
--

DROP TABLE IF EXISTS `camera_interface_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_interface_model` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `interface_model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_interface_model_camera_id_interface_model_id_unique` (`camera_id`,`interface_model_id`),
  KEY `camera_interface_model_interface_model_id_foreign` (`interface_model_id`),
  CONSTRAINT `camera_interface_model_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_interface_model_interface_model_id_foreign` FOREIGN KEY (`interface_model_id`) REFERENCES `interface_models` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_interface_model`
--

LOCK TABLES `camera_interface_model` WRITE;
/*!40000 ALTER TABLE `camera_interface_model` DISABLE KEYS */;
INSERT INTO `camera_interface_model` VALUES (6,1,2),(5,1,3),(7,1,4),(2,1,5),(1,1,7),(3,1,8),(4,1,9),(12,2,2),(13,2,4),(9,2,5),(8,2,6),(10,2,8),(11,2,9),(14,2,11),(19,3,2),(20,3,4),(16,3,5),(15,3,7),(17,3,8),(18,3,9),(21,3,11),(26,4,2),(23,4,5),(22,4,7),(24,4,8),(25,4,9),(29,5,2),(28,5,3),(27,5,5),(31,6,2),(30,6,5),(33,7,2),(32,7,5),(39,8,2),(38,8,3),(35,8,5),(34,8,6),(36,8,8),(37,8,9),(40,8,11),(46,9,2),(45,9,3),(42,9,5),(41,9,6),(43,9,8),(44,9,9),(47,9,11),(49,10,2),(48,10,5),(51,11,2),(50,11,5),(56,12,2),(53,12,5),(52,12,7),(54,12,8),(55,12,9),(63,13,2),(62,13,3),(59,13,5),(57,13,6),(60,13,8),(61,13,9),(58,13,10),(64,13,11),(71,14,2),(70,14,3),(67,14,5),(65,14,6),(68,14,8),(69,14,9),(66,14,10),(78,15,2),(77,15,3),(74,15,5),(72,15,6),(75,15,8),(76,15,9),(73,15,10);
/*!40000 ALTER TABLE `camera_interface_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_photo_format`
--

DROP TABLE IF EXISTS `camera_photo_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_photo_format` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `photo_format_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_photo_format_camera_id_photo_format_id_unique` (`camera_id`,`photo_format_id`),
  KEY `camera_photo_format_photo_format_id_foreign` (`photo_format_id`),
  CONSTRAINT `camera_photo_format_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_photo_format_photo_format_id_foreign` FOREIGN KEY (`photo_format_id`) REFERENCES `photo_formats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_photo_format`
--

LOCK TABLES `camera_photo_format` WRITE;
/*!40000 ALTER TABLE `camera_photo_format` DISABLE KEYS */;
INSERT INTO `camera_photo_format` VALUES (4,1,1),(3,1,2),(5,1,3),(2,1,4),(1,1,5),(8,2,1),(7,2,2),(9,2,3),(6,2,5),(12,3,1),(11,3,2),(13,3,3),(10,3,5),(15,4,1),(14,4,2),(16,4,3),(17,4,9),(20,5,1),(19,5,2),(18,5,6),(22,6,1),(21,6,6),(24,7,1),(23,7,7),(26,8,1),(25,8,7),(28,9,1),(27,9,7),(30,10,1),(29,10,7),(32,11,1),(31,11,7),(34,12,1),(33,12,2),(35,12,3),(37,13,1),(36,13,2),(38,13,3),(40,14,1),(39,14,2),(41,14,3),(43,15,1),(42,15,2),(44,15,3);
/*!40000 ALTER TABLE `camera_photo_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_prices`
--

DROP TABLE IF EXISTS `camera_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `price` int unsigned NOT NULL,
  `recorded_at` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `camera_prices_camera_id_foreign` (`camera_id`),
  CONSTRAINT `camera_prices_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_prices`
--

LOCK TABLES `camera_prices` WRITE;
/*!40000 ALTER TABLE `camera_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `camera_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_recording_media`
--

DROP TABLE IF EXISTS `camera_recording_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_recording_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `recording_media_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_recording_media_camera_id_recording_media_id_unique` (`camera_id`,`recording_media_id`),
  KEY `camera_recording_media_recording_media_id_foreign` (`recording_media_id`),
  CONSTRAINT `camera_recording_media_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_recording_media_recording_media_id_foreign` FOREIGN KEY (`recording_media_id`) REFERENCES `recording_medias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_recording_media`
--

LOCK TABLES `camera_recording_media` WRITE;
/*!40000 ALTER TABLE `camera_recording_media` DISABLE KEYS */;
INSERT INTO `camera_recording_media` VALUES (1,1,1),(2,1,2),(3,1,3),(5,1,6),(4,1,7),(6,2,5),(8,3,1),(9,3,2),(10,3,3),(7,3,5),(12,3,6),(11,3,7),(13,4,1),(14,4,2),(15,4,3),(16,4,6),(17,5,5),(18,6,5),(19,7,1),(20,7,2),(21,7,3),(23,7,6),(22,7,7),(25,8,1),(26,8,2),(27,8,3),(24,8,5),(29,8,6),(28,8,7),(30,9,1),(31,9,2),(32,9,3),(34,9,6),(33,9,7),(35,10,1),(36,10,2),(37,10,3),(39,10,6),(38,10,7),(40,11,1),(41,11,2),(42,11,3),(44,11,6),(43,11,7),(45,12,1),(46,12,2),(47,12,3),(49,12,6),(48,12,7),(51,13,1),(52,13,2),(53,13,3),(50,13,5),(55,13,6),(54,13,7),(57,14,1),(58,14,2),(59,14,3),(56,14,5),(61,14,6),(60,14,7),(63,15,1),(64,15,2),(65,15,3),(62,15,4),(67,15,6),(66,15,7);
/*!40000 ALTER TABLE `camera_recording_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_self_timer_second`
--

DROP TABLE IF EXISTS `camera_self_timer_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_self_timer_second` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `self_timer_second_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_self_timer_second_camera_id_self_timer_second_id_unique` (`camera_id`,`self_timer_second_id`),
  KEY `camera_self_timer_second_self_timer_second_id_foreign` (`self_timer_second_id`),
  CONSTRAINT `camera_self_timer_second_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_self_timer_second_self_timer_second_id_foreign` FOREIGN KEY (`self_timer_second_id`) REFERENCES `self_timer_seconds` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_self_timer_second`
--

LOCK TABLES `camera_self_timer_second` WRITE;
/*!40000 ALTER TABLE `camera_self_timer_second` DISABLE KEYS */;
INSERT INTO `camera_self_timer_second` VALUES (2,1,1),(1,1,5),(4,2,1),(3,2,5),(6,3,1),(5,3,5),(8,4,1),(7,4,5),(10,7,1),(9,7,6),(12,8,1),(14,8,4),(11,8,6),(13,8,8),(16,9,1),(18,9,4),(15,9,6),(17,9,8),(20,10,1),(19,10,6),(22,11,1),(21,11,6),(24,12,1),(23,12,5),(26,13,3),(25,13,5),(28,14,1),(29,14,3),(27,14,5),(31,15,1),(32,15,3),(30,15,5);
/*!40000 ALTER TABLE `camera_self_timer_second` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_types`
--

DROP TABLE IF EXISTS `camera_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_types_name_en_unique` (`name_en`),
  UNIQUE KEY `camera_types_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_types`
--

LOCK TABLES `camera_types` WRITE;
/*!40000 ALTER TABLE `camera_types` DISABLE KEYS */;
INSERT INTO `camera_types` VALUES (1,'DSLR','一眼レフ',NULL,NULL),(2,'Mirrorless','ミラーレス',NULL,NULL),(3,'Rangefinder','レンジファインダー',NULL,NULL),(4,'Compact','コンパクト',NULL,NULL),(5,'Medium Format','中判カメラ',NULL,NULL),(6,'Film','フィルムカメラ',NULL,NULL);
/*!40000 ALTER TABLE `camera_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_video_codec`
--

DROP TABLE IF EXISTS `camera_video_codec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_video_codec` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `video_codec_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_video_codec_camera_id_video_codec_id_unique` (`camera_id`,`video_codec_id`),
  KEY `camera_video_codec_video_codec_id_foreign` (`video_codec_id`),
  CONSTRAINT `camera_video_codec_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_video_codec_video_codec_id_foreign` FOREIGN KEY (`video_codec_id`) REFERENCES `video_codecs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_video_codec`
--

LOCK TABLES `camera_video_codec` WRITE;
/*!40000 ALTER TABLE `camera_video_codec` DISABLE KEYS */;
/*!40000 ALTER TABLE `camera_video_codec` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `camera_video_format`
--

DROP TABLE IF EXISTS `camera_video_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `camera_video_format` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camera_id` bigint unsigned NOT NULL,
  `video_format_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `camera_video_format_camera_id_video_format_id_unique` (`camera_id`,`video_format_id`),
  KEY `camera_video_format_video_format_id_foreign` (`video_format_id`),
  CONSTRAINT `camera_video_format_camera_id_foreign` FOREIGN KEY (`camera_id`) REFERENCES `cameras` (`id`) ON DELETE CASCADE,
  CONSTRAINT `camera_video_format_video_format_id_foreign` FOREIGN KEY (`video_format_id`) REFERENCES `video_formats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `camera_video_format`
--

LOCK TABLES `camera_video_format` WRITE;
/*!40000 ALTER TABLE `camera_video_format` DISABLE KEYS */;
INSERT INTO `camera_video_format` VALUES (1,1,1),(2,2,1),(3,3,1),(5,4,1),(4,4,2),(8,8,1),(6,8,2),(7,8,7),(10,9,1),(9,9,2),(12,12,4),(11,12,5),(14,13,4),(13,13,5),(16,14,4),(15,14,5),(18,15,4),(17,15,5);
/*!40000 ALTER TABLE `camera_video_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cameras`
--

DROP TABLE IF EXISTS `cameras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cameras` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `manufacturer_id` bigint unsigned DEFAULT NULL,
  `camera_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `camera_type_id` bigint unsigned DEFAULT NULL,
  `lens_mount_id` bigint unsigned DEFAULT NULL,
  `release_year` date DEFAULT NULL,
  `discontinued_year` date DEFAULT NULL,
  `price` int DEFAULT NULL,
  `price_data` smallint unsigned DEFAULT NULL,
  `color_option_id` bigint unsigned DEFAULT NULL,
  `total_pixels` int DEFAULT NULL,
  `effective_pixels` int DEFAULT NULL,
  `sensor_type_id` bigint unsigned DEFAULT NULL,
  `sensor_width_mm` decimal(5,2) DEFAULT NULL,
  `sensor_height_mm` decimal(5,2) DEFAULT NULL,
  `image_sensor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_processor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `viewfinder_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `viewfinder_coverage` decimal(5,2) DEFAULT NULL,
  `viewfinder_magnification` decimal(5,2) DEFAULT NULL,
  `lcd_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lcd_size_inch` decimal(4,2) DEFAULT NULL,
  `lcd_resolution_dots` int DEFAULT NULL,
  `iso_standard_min` int DEFAULT NULL,
  `iso_standard_max` int DEFAULT NULL,
  `iso_extended_min` int DEFAULT NULL,
  `iso_extended_max` int DEFAULT NULL,
  `metering_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metering_mode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exposure_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shutter_electronic_min` decimal(10,1) DEFAULT NULL,
  `shutter_electronic_max` decimal(10,10) DEFAULT NULL,
  `shutter_mechanical_min` decimal(10,1) DEFAULT NULL,
  `shutter_mechanical_max` decimal(10,10) DEFAULT NULL,
  `drive_mode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `burst_mode_fps` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `self_timer_second_id` bigint unsigned DEFAULT NULL,
  `white_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temperature_low` int DEFAULT NULL,
  `temperature_high` int DEFAULT NULL,
  `af_methods` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `af_points` int DEFAULT NULL,
  `buffer_memory_mb` int DEFAULT NULL,
  `internal_memory_gb` int DEFAULT NULL,
  `recording_media_id` bigint unsigned DEFAULT NULL,
  `card_slot_count` int DEFAULT NULL,
  `photo_format_id` bigint unsigned DEFAULT NULL,
  `photo_size_l_mb` int DEFAULT NULL,
  `photo_size_m_mb` int DEFAULT NULL,
  `photo_size_s_mb` int DEFAULT NULL,
  `photo_resolution_l` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_resolution_m` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_resolution_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_format_id` bigint unsigned DEFAULT NULL,
  `video_codec_id` bigint unsigned DEFAULT NULL,
  `video_resolution` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `audio_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interface_model_id` bigint unsigned DEFAULT NULL,
  `bluetooth` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wifi` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `microphone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speaker` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tripod_mount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `battery_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `battery_capacity_mAh` int DEFAULT NULL,
  `battery_weight_g` decimal(6,2) DEFAULT NULL,
  `shots_per_charge` int DEFAULT NULL,
  `body_material` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operating_temp_min_c` decimal(4,1) DEFAULT NULL,
  `operating_temp_max_c` decimal(4,1) DEFAULT NULL,
  `body_width` decimal(8,2) DEFAULT NULL,
  `body_height` decimal(8,2) DEFAULT NULL,
  `body_depth` decimal(8,2) DEFAULT NULL,
  `body_weight_g` decimal(5,1) DEFAULT NULL,
  `body_total_weight_g` decimal(5,1) DEFAULT NULL,
  `accessory_id` bigint unsigned DEFAULT NULL,
  `display_language_id` bigint unsigned DEFAULT NULL,
  `feature_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cameras_manufacturer_id_foreign` (`manufacturer_id`),
  KEY `cameras_camera_type_id_foreign` (`camera_type_id`),
  KEY `cameras_lens_mount_id_foreign` (`lens_mount_id`),
  KEY `cameras_color_option_id_foreign` (`color_option_id`),
  KEY `cameras_sensor_type_id_foreign` (`sensor_type_id`),
  KEY `cameras_self_timer_second_id_foreign` (`self_timer_second_id`),
  KEY `cameras_recording_media_id_foreign` (`recording_media_id`),
  KEY `cameras_photo_format_id_foreign` (`photo_format_id`),
  KEY `cameras_video_format_id_foreign` (`video_format_id`),
  KEY `cameras_video_codec_id_foreign` (`video_codec_id`),
  KEY `cameras_interface_model_id_foreign` (`interface_model_id`),
  KEY `cameras_accessory_id_foreign` (`accessory_id`),
  KEY `cameras_display_language_id_foreign` (`display_language_id`),
  KEY `cameras_feature_id_foreign` (`feature_id`),
  CONSTRAINT `cameras_accessory_id_foreign` FOREIGN KEY (`accessory_id`) REFERENCES `accessories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_camera_type_id_foreign` FOREIGN KEY (`camera_type_id`) REFERENCES `camera_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_color_option_id_foreign` FOREIGN KEY (`color_option_id`) REFERENCES `color_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_display_language_id_foreign` FOREIGN KEY (`display_language_id`) REFERENCES `display_languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_interface_model_id_foreign` FOREIGN KEY (`interface_model_id`) REFERENCES `interface_models` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_lens_mount_id_foreign` FOREIGN KEY (`lens_mount_id`) REFERENCES `lens_mounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_manufacturer_id_foreign` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_photo_format_id_foreign` FOREIGN KEY (`photo_format_id`) REFERENCES `photo_formats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_recording_media_id_foreign` FOREIGN KEY (`recording_media_id`) REFERENCES `recording_medias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_self_timer_second_id_foreign` FOREIGN KEY (`self_timer_second_id`) REFERENCES `self_timer_seconds` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_sensor_type_id_foreign` FOREIGN KEY (`sensor_type_id`) REFERENCES `sensor_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_video_codec_id_foreign` FOREIGN KEY (`video_codec_id`) REFERENCES `video_codecs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cameras_video_format_id_foreign` FOREIGN KEY (`video_format_id`) REFERENCES `video_formats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cameras`
--

LOCK TABLES `cameras` WRITE;
/*!40000 ALTER TABLE `cameras` DISABLE KEYS */;
INSERT INTO `cameras` VALUES (1,1,'EOS R6 Mark II','5666C001',2,2,'2022-12-15',NULL,319000,NULL,NULL,2560,2420,1,36.00,24.00,'CMOS',NULL,'OLEDカラー電子ビューファインダー',100.00,0.76,'TFT式カラー液晶モニター',3.00,1620000,100,102400,50,204800,'撮像素子の出力信号による384分割（24×16）測光','評価測光、部分測光（画面中央の約5.9％）、スポット測光（画面中央の約3.0％）、中央部重点平均測光','EV-3～20',30.0,0.0000625000,30.0,0.0001250000,'高速連続撮影＋、RAWバーストモード、HDRモード、フォーカスブラケット撮影、絞り数値変化時の露出維持（ISO感度／Tv値、Tv値）設定時は、1／8000秒まで','40fps',NULL,'オート（雰囲気優先／ホワイト優先）、太陽光、日陰、くもり、白熱電球、白色蛍光灯、ストロボ、マニュアル、色温度指定（約2500～10000K）、ホワイトバランス補正、ホワイトバランスブラケティング可能',2500,10000,'デュアルピクセルCMOS AF',1053,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'6000×4000','3984×2656','2976×1984',NULL,NULL,'3840×2160','［音声圧縮：する］設定時はAAC／［音声圧縮：しない］設定時はリニアPCM',NULL,'Bluetooth Specification Version 5.0準拠','IEEE 802.11b／g／n／a／ac規格相当',NULL,NULL,NULL,'LP-E6P／LP-E6NH／LP-E6N／LP-E6',NULL,NULL,760,NULL,0.0,40.0,138.40,98.40,88.40,588.0,670.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(2,1,'EOS R1','6577C001',2,2,'2024-11-29',NULL,1089000,NULL,NULL,2670,2420,1,36.00,24.00,'裏面照射積層CMOSセンサー','DIGIC X','OLEDカラー電子ビューファインダー',100.00,0.90,'TFT式カラー液晶モニター',3.20,2100000,100,102400,50,409600,'撮像素子の出力信号による 6144分割（96×64）測光','評価測光、部分測光（画面中央の約10.0%）、スポット測光（画面中央の約5.0%）、中央部重点平均測光','EV-3～20',30.0,0.0000156250,30.0,0.0001250000,'1枚撮影、高速連続撮影＋、高速連続撮影、低速連続撮影、 セルフタイマー：10秒、セルフタイマー：2秒、セルフタイマー：連続撮影','40fps',NULL,'オート（雰囲気優先／ホワイト優先）、太陽光、日陰、くもり、白熱電球、白色蛍光灯、ストロボ、マニュアル(MWBデータ登録）、色温度指定（約2500～10000K）、ホワイトバランス補正、ホワイトバランスブラケティング可能',2500,10000,'デュアルピクセルCMOS AF',1053,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'6000×4000','3984×2656','2976×1984',NULL,NULL,'RAW 6000×3164, XF-HEVC S YCC422 4096×2160, XF-HEVC S YCC420 3840×2160','LPCM(4ch 24bit) , AAC(2ch 16bit)',NULL,'Bluetooth Specification Version 5.3準拠','IEEE 802.11b／g／n／a／ac／ax 規格相当',NULL,NULL,NULL,'LP-E19',2700,185.00,1330,NULL,0.0,45.0,157.60,149.50,87.30,920.0,1115.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(3,1,'EOS R3','4895C001',2,2,'2021-11-27',NULL,792000,NULL,NULL,2670,2410,1,36.00,24.00,'裏面照射積層CMOSセンサー','DIGIC X','OLEDカラー電子ビューファインダー',100.00,0.76,'TFT式カラー液晶モニター',3.20,4150000,100,102400,50,204800,'撮像素子の出力信号による384分割（24×16）測光','評価測光（すべてのAFフレームに対応）、部分測光（画面の約5.9％）、スポット測光（画面の約2.9％）、中央部重点平均測光','EV-3～20',30.0,0.0000156250,30.0,0.0001250000,'1枚撮影、カスタム高速連続撮影※、高速連続撮影＋、高速連続撮影、低速連続撮影、 セルフタイマー：10秒／リモコン、セルフタイマー：2秒／リモコン','30fps',NULL,'	オート（雰囲気優先）、オート（ホワイト優先）、プリセット（太陽光、日陰、くもり、白熱電球、白色蛍光灯、ストロボ※）、マニュアル、色温度指定（約2500～10000K）、ホワイトバランス補正、ホワイトバランスブラケティング可能',2500,10000,'デュアルピクセルCMOS AF',1053,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'6000×4000','3984×2656','2976×1984',NULL,NULL,'6K RAW：6000×3164, 4K DCI：4096×2160, 4K UHD：3840×2160, フルHD：1920×1080','ALL-I／IPB：AAC／リニアPCM（選択可能）、IPB（軽量）：AAC',NULL,'Bluetooth Specification Version 5.0準拠','IEEE 802.11b／g／n／a／ac規格相当','モノラルマイク内蔵',NULL,NULL,'LP-E19',2700,185.00,860,NULL,0.0,40.0,150.00,142.60,87.20,822.0,1015.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(4,4,'X-M5','FF240002',2,7,'2024-11-28',NULL,120170,NULL,NULL,NULL,2610,2,23.50,15.60,'X-Trans CMOS 4センサー 原色フィルター採用',NULL,NULL,NULL,NULL,'カラー液晶モニター、バリアングル式',3.00,1040000,160,12800,80,51200,'TTL256 分割測光','マルチ, 中央部重点, スポット, アベレージ','-5 EV～+5 EV',900.0,0.0000312500,900.0,0.0002500000,'2コマ, 3コマ, 5コマ, 7コマ, 9コマ','30fps',NULL,'晴れ, 日陰, 蛍光灯1, 蛍光灯2, 蛍光灯3, 電球, 水中',2500,10000,'インテリジェントハイブリッドAF (TTLコントラストAF / 位相差AF)',425,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'3:2:6240 x 4160, 16:9:6240 x 3512, 1:1:4160 x 4160','3:2: 4416 x 2944, 16:9: 4416 x 2488, 1:1: 2944 x 2944','3:2: 3120 x 2080, 16:9: 3120 x 1760, 1:1: 2080 x 2080',NULL,NULL,'6.2K(3:2):6240 x 4160, DCI4K(17:9):4096 x 2160, Full HD(17:9):2048 x 1080,\n                           Full HD(16:9):1920 x 1080, Full HDLP(16:9):1920 x 1080(1.29x クロップ)','LPCM, AAC',NULL,'Bluetooth Ver.5.2 (Bluetooth low energy)','IEEE802.11b/g/n（無線LAN標準プロトコル）','マイク指向性設定: 全方位 / フロント / バック/ フロント&バック',NULL,NULL,'NP-W126S',1260,47.00,NULL,NULL,0.0,40.0,111.90,66.60,38.00,307.0,355.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(5,9,'X2D II 100C','X2D II 100C',5,13,'2025-08-26',NULL,1155000,NULL,NULL,10000,10000,6,43.80,32.90,'裏面照射型 (BSI) CMOS、1 億画素',NULL,'電子ビューファインダー（EVF） Micro-OLED スクリーン',100.00,1.00,'スワイプ、スクロール、ピンチ/スプレッドでのズームなどの操作に対応したタッ チディスプレイ 広色域 OLED',3.60,2360000,50,25600,NULL,NULL,NULL,'スマート測光、スポット、中央部重点、中央スポット','-5〜5 EV 間で 1、1/2、または 1/3 ステップ毎に手動で調整',4080.0,0.0001666667,4080.0,0.0002500000,'シングル、連写、セルフタイマー、インターバルタイマー、露出ブラケット、フォ ーカスブラケット','3fps',NULL,NULL,NULL,NULL,'PDAF、CDAF、LiDAR',425,NULL,1000,NULL,1,NULL,206,NULL,NULL,'11656 × 8742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1/4','CP.HB.00000238.01',3400,NULL,327,'アルミ削り出し',-10.0,45.0,148.50,106.00,75.00,730.0,840.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(6,9,'X2D 100C','X2D 100C',5,13,'2022-09-13',NULL,1265000,NULL,NULL,10000,10000,6,43.80,32.90,'裏面照射型 (BSI) CMOS','ハッセルブラッド ナチュラルカラーソリューション（HNCS）','電子ビューファインダー（EVF）OLED',100.00,1.00,'TFTタイプ、24ビットフルカラー、タッチ機能',3.60,2360000,64,25600,NULL,NULL,'TTL中央重点測光システム','スポット、中央部重点、中央スポット','-3〜+3EV',4080.0,0.0002500000,4080.0,0.0001666667,'シングル＆連写ドライブ、セルフタイマー、インターバルタイマー、露出ブラケット',NULL,NULL,NULL,NULL,NULL,'。位相差検出とコントラスト検出を使用したオートフォーカス',294,NULL,1000,NULL,1,NULL,206,NULL,NULL,'11656 × 8742',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'802.11b/a/g/n/ac/ax、2×2 MIMO Wi-Fiに対応',NULL,NULL,'1/4',NULL,3400,NULL,NULL,'アルミ削り出し',-10.0,45.0,148.50,106.00,74.50,790.0,895.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(7,6,'M11-P','20212',3,NULL,'2023-10-28',NULL,1562000,NULL,NULL,NULL,6030,1,36.00,24.00,'BSI CMOS','ライカ マエストロシリーズ（Maestro III）','大型ブライトフレームレンジファインダー',NULL,0.73,'TFT液晶モニター',2.95,2332800,64,50000,NULL,NULL,'TTL測光（レンズの実絞りによる測光）','スポット、中央重点、多点、ハイライト重点','±3 EV（1/3 EVステップ）',60.0,0.0000625000,3600.0,0.0002500000,'1コマ, コンティニュアス - 低速 (3 fps], コンティニュアス - 高速 (4.5 fps], インターバル撮影, オートブラケット','4.5fps',NULL,'オート（オート）、プリセット（晴天-5200K、くもり-6100K、日かげ（晴天時）-6600K、白熱灯-2950K、HMI-5700K、蛍光灯（暖色）-\n                        3650K、蛍光灯（寒色）-5800K、フラッシュ-6600K）、マニュアル（グレーカード）、色温度マニュアル設定（色温度 - 2000K～11500K）',NULL,NULL,NULL,NULL,3000,256,NULL,1,NULL,120,70,40,'9528 x 6328','7416 x 4928','5272 x 3498',NULL,NULL,NULL,NULL,NULL,'Bluetooth v4.2 BR/EDR/LE','2.4 GHz/5 GHz* dual band IEEE802.11 a/b/g/n/ac Wave2ワイヤレスLAN',NULL,NULL,'A 1/4（1/4インチ、DIN4503に準拠）、合金製','BP-SCL7',1800,75.00,NULL,'金属製（マグネシウム、アルミニウム）、合皮外装',0.0,40.0,139.00,80.00,38.50,455.0,530.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(8,6,'SL3','10608',2,10,'2024-03-16',NULL,1100000,NULL,NULL,NULL,6030,1,NULL,NULL,'フルサイズ裏面照射型CMOSイメージセンサー','ライカ マエストロシリーズ(Maestro IV)','電子ビューファインダー',120.00,0.78,'チルト式3.2型モニター',3.20,2332800,100,100000,50,100000,'TTL測光','スポット、中央重点、ハイライト重点、多点','±3EVの範囲で1/3EVステップ',1.0,0.0000625000,3600.0,0.0001250000,'15コマ/秒(電子シャッター)、9コマ/秒(電子シャッター)、7コマ/秒(メカシャッター)、6コマ/秒(メカシャッター)、5コマ/秒(メカシャッター)、4コマ/秒(メカシャッター)、2コマ/秒(メカシャッター)','15fps',NULL,'オート、晴天、くもり、日かげ(晴天時)、白熱灯、HMI、蛍光灯(暖色)、蛍光灯(寒色)、フラッシュ、マニュアル、色温度設定',2000,11500,'撮像エリアに像面位相差AFセンサーを配置した像面位相差検出方式、コントラスト検出方式、深度マップ測定を組み合わせた ハイブリッドAF',315,8000,NULL,NULL,2,NULL,70,NULL,NULL,'9520 × 6336','7404 × 4928','5288 × 3518',NULL,NULL,'C8K：8192×4320、８K：7680×4320、C4K：4096×2160、４K：3840×2160、Full HD：1920×1080',NULL,NULL,'Bluetooth5.0LE：チャンネル0－39(2402-2480MHz)','2.4GHz/5GHz dual band IEEE802.11 a/n/ac Wave2ワイヤレスLAN(標準ワイヤレスプロトコル)、暗号化方式：ワイヤレスLAN対応 WPA™/WPA2™/WPA3™、アクセス方式：インフラストモード',NULL,NULL,'A 1/4(1/4インチ、DIN4503に準拠)　ステンレス製','BP-SCL6',2200,84.00,260,'本体：アルミニウムおよびマグネシウムのフルメタル製、合皮外装、防塵防滴仕様(保護等級:IP54)',-10.0,40.0,141.20,108.00,84.60,769.0,853.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(9,6,'SL3-S','10644',2,10,'2025-01-25',NULL,913000,NULL,NULL,2530,2460,1,NULL,NULL,'フルサイズ裏面照射型CMOSイメージセンサー','ライカ マエストロシリーズ(Maestro IV)','電子ビューファインダー',100.00,0.78,'チルト式液晶モニター',3.20,2332800,100,200000,50,200000,'TTL測光','スポット、中央重点、ハイライト重点、多点','±3 EV（1/3 EVまたは1/2 EVステップ）',60.0,0.0000625000,1800.0,0.0001250000,'2fps, 5fps, 7fps, 15fps, 30fps','30fps',NULL,'オート（オート）、プリセット（晴天、くもり、日かげ（晴天時）、白熱灯、HMI、蛍光灯 (暖色)、蛍光灯 (寒色)、フラッシュ）、マニュアル設定（グレーカード (ピペット)、グレーカード）、色温度設定（色温度、2000 K～11500 K）',NULL,NULL,'撮像エリアに像面位相差AFセンサーを配置した像面位相差検出方式、コントラスト検出方式、深度マップ測定を組み合わせたハイブリッドAF',779,8000,NULL,NULL,2,NULL,40,NULL,NULL,'35mm: DNG 6000 x 4000','APS-C: DNG 3936 x 2624',NULL,NULL,NULL,'6K OG (3:2)	5952 x 3968, C6K (17:9)	5952 x 3136, 6K (16:9)	5888 x 3312,(H.265), 5776 x 3056 (ProRes),C4K (17:9)	4096 x 2160 (MOV/MP4), \n                           4128 x 2176 (RAW), 4K (16:9)	3840 x 2160, 3.5K (4:3)	3536 x 2656 (RAW), Full HD (16:9)	1920 x 1080','AAC 48 kHz/16 Bit, LPCM 48 kHz/24 Bit',NULL,'Bluetooth 5.0 LE：チャンネル0–39（2402–2480 MHz）','・EU/US/CN、IEEE802.11b/g/n、2.4 GHz、チャンネル1–11 (2412–24G2 MHz) 　・EU/US/CN、クライエントモード：（室内使用時のみ）、IEEE802.11a/n/ac、5 GHz、チャンネル3G–G4 (5180–5320 MHz) 　・EU/US/CN、アクセスポイント+クライエントモード：IEEE802.11a/n/ac、5 GHz、チャンネル149–1G5 (5745–5825 MHz) 　・JP、アクセスポイント+クライエントモード：（室内使用時のみ） IEEE802.11a/n/ac、5 GHz、チャンネル3G–48 (5180–5240 MHz) 　・JP、クライエントモード：（室内使用時のみ）IEEE802.11a/n/ac、5 GHz、チャンネル 52–144 (52G0–5720 MHz)',NULL,NULL,'A 1/4（1/4インチ、DIN4503に準拠）、ステンレス製','BP-SCL6',2200,NULL,1042,'金属製（マグネシウム、アルミニウム）、合皮外装、防滴性（IEC 60529に準拠、保護等級：IP54）',-10.0,40.0,141.20,108.00,84.60,768.0,NULL,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(10,6,'M11-P Safari','20236',3,9,'2025-05-17',NULL,1760000,NULL,NULL,NULL,6030,1,NULL,NULL,'裏面照射型（BSI）CMOSセンサー','ライカ マエストロシリーズ（Maestro III）','大型ブライトフレームレンジファインダー',NULL,0.73,'アクティブ・マトリクス駆動TFT液晶モニター',2.95,2332800,64,50000,NULL,NULL,'TTL測光','スポット、中央重点、ハイライト重点、多点','±3 EV（1/3EVステップ）',60.0,0.0000625000,3600.0,0.0002500000,'1コマ コンティニュアス - 低速 (3fps) コンティニュアス - 高速 (4.5fps) インターバル撮影 オートブラケット','4.5fps',NULL,'オート（オート）、プリセット（晴天-5200K、くもり-6100K、日かげ（晴天時）-6600K、白熱灯-2950K、HMI-5700K、蛍光灯（暖色）-\n                        3650K、蛍光灯（寒色）-5800K、フラッシュ-6600K）、マニュアル（グレーカード）、色温度マニュアル設定（色温度 - 2000K～11500K）',NULL,NULL,NULL,NULL,3000,256,NULL,1,NULL,120,70,40,'9528 x 6328','7416 x 4928','5272 x 3498',NULL,NULL,NULL,NULL,NULL,'Bluetooth v4.2 BR/EDR/LE, BR/DRチャンネル 1‒79、LEチャンネル 0‒39（2402–2480MHz）','2.4GHz/5GHz* dual band IEEE802.11 a/b/g/n/ac Wave2ワイヤレスLAN（標準ワイヤレスプロトコル）、暗号化方式：ワイヤレスLAN対応WPA™/WPA2™、アクセス方式：インフラストラクチャーモード',NULL,NULL,'A 1/4（1/4インチ、DIN4503に準拠）、合金製','BP-SCL7',1800,75.00,1700,'マグネシウムと真鍮のフルメタル製、合成皮革の外装',0.0,40.0,139.00,80.00,38.50,565.0,640.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(11,6,'M11-D ブラック・ペイント','20221',3,9,'2024-09-21',NULL,1584000,NULL,NULL,NULL,6030,1,NULL,NULL,'裏面照射型（BSI）CMOSセンサー','ライカ マエストロシリーズ（Maestro III）','大型ブライトフレームレンジファインダー',NULL,0.73,NULL,NULL,NULL,64,50000,NULL,NULL,'TTL測光','スポット、中央重点、ハイライト重点、多点','±3 EV（1/3 EVステップ）',60.0,0.0000625000,3600.0,0.0002500000,'1コマ コンティニュアス - 低速 (3 fps) コンティニュアス - 高速 (4.5 fps) インターバル撮影 オートブラケット','4.5fps',NULL,'オート（オート）、プリセット（晴天-5200K、くもり-6100K、日かげ（晴天時）-6600K、白熱灯-2950K、HMI-5700K、蛍光灯（暖色）-\n                        3650K、蛍光灯（寒色）-5800K、フラッシュ-6600K）、マニュアル（グレーカード）、色温度マニュアル設定（色温度 - 2000K～11500K）',2000,11500,NULL,NULL,3000,256,NULL,1,NULL,120,70,40,'9528 x 6328','7416 x 4928','5272 x 3498',NULL,NULL,NULL,NULL,NULL,'Bluetooth v4.2 BR/EDR/LE BR/DRチャンネル 1‒79、LEチャンネル 0‒39（2402–2480 MHz）','2.4 GHz/5 GHz* dual band IEEE802.11 a/b/g/n/ac Wave2ワイヤレスLAN（標準ワイヤレスプロトコル） 暗号化方式：ワイヤレスLAN対応WPA™/WPA2™、アクセス方式：インフラストラクチャーモード',NULL,NULL,'A 1/4（1/4インチ、DIN4503に準拠）、ステンレススチール製','BP-SCL7',1800,82.00,1700,'ブラック：金属製（マグネシウム、アルミニウム）、合皮外装',0.0,40.0,139.00,80.00,38.50,457.0,539.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(12,3,'α7C II','ILCE-7CM2',2,5,'2023-10-13',NULL,306900,NULL,NULL,3410,3300,1,35.90,23.90,'Exmor R CMOSセンサー',NULL,'1.0 cm (0.39型)電子式ビューファインダー (XGA OLED)',100.00,0.70,'TFT駆動',3.00,1036800,100,51200,50,204800,'1200分割ライブビュー分析測光','マルチ, 中央重点, スポット, 画面全体平均, ハイライト重点','±5.0 EV (1/3 EV、1/2 EV ステップ選択可能)',30.0,0.0001250000,30.0,0.0002500000,'1枚撮影, 連続撮影, セルフタイマー（1枚）, セルフタイマー（連続）, 連続ブラケット, 1枚ブラケット, フォーカスブラケット, ホワイトバランスブラケット, DROブラケット','Hi+: 最高約10コマ/秒',NULL,'オート /  オート: 雰囲気優先 /  オート: ホワイト優先 / 太陽光 / 日陰 / 曇天 / 電球 / 蛍光灯: 温白色 / 蛍光灯: 白色 / 蛍光灯: 昼白色 / 蛍光灯: 昼光色 / \n                         フラッシュ （静止画撮影時のみ） / 水中オート / 色温度/カラーフィルター / カスタム 1/カスタム 2/カスタム 3',NULL,NULL,'ファストハイブリッドAF (位相差検出方式 / コントラスト検出方式)',759,NULL,0,NULL,1,NULL,33,14,8,'7008 x 4672','4608 x 3072','3504 x 2336',NULL,NULL,'8294400','LPCM 2ch (48 kHz 16 bit], LPCM 2ch (48 kHz 24 bit) , LPCM 4ch (48 kHz 24 bit)',NULL,'Bluetooth 標準規格Ver. 4.2 (2.4 GHz帯)','Wi-Fiに準拠、IEEE 802.11a/b/g/n/ac (2.4 GHz帯/5 GHz帯)','ステレオマイク内蔵','モノラルスピーカー内蔵',NULL,'NP-FZ100',2280,83.00,NULL,NULL,0.0,40.0,124.00,71.10,63.40,429.0,514.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(13,3,'α1 II','ILCE-1M2',2,5,'2024-12-13',NULL,990000,NULL,NULL,NULL,5010,1,35.90,24.00,'Exmor RS CMOSセンサー','BIONZ XR','電子式ビューファインダー (Quad-XGA OLED)',NULL,0.90,'8.0 cmTFT駆動',3.20,2095104,100,32000,50,102400,'1200分割ライブビュー分析測光','マルチ, 中央重点, スポット, 画面全体平均, ハイライト重点','EV-3 - EV20',30.0,0.0000312500,30.0,0.0001250000,'AUTO/電子シャッター時: Hi+時: 最高約30コマ/秒、メカシャッター時: Hi+: 最高約10コマ/秒','30fps',NULL,' オート /  オート: 雰囲気優先 /  オート: ホワイト優先 / 太陽光 / 日陰 / 曇天 / 電球 / 蛍光灯: 温白色 / 蛍光灯: 白色 / 蛍光灯: 昼白色 / 蛍光灯: 昼光色 / \n                         フラッシュ （静止画撮影時のみ） / 水中オート / 色温度/カラーフィルター / カスタム 1/カスタム 2/カスタム 3',2500,9900,'ファストハイブリッドAF (位相差検出方式 / コントラスト検出方式)',759,NULL,NULL,NULL,2,NULL,50,21,12,'8640 x 5760','5616 x 3744','4320 x 2880',NULL,NULL,'XAVC HS 8K:7680 x 4320, XAVC HS 4K:3840 x 2160, XAVC S HD:1920 x 1080','LPCM 2ch (48 kHz 16 bit)、LPCM 2ch (48 kHz 24 bit) 、LPCM 4ch (48 kHz 24 bit)',NULL,'Bluetooth 標準規格Ver. 5.0 (2.4 GHz帯)','Wi-Fiに準拠、IEEE 802.11a/b/g/n/ac (2.4 GHz帯/5 GHz帯)','ステレオマイク内蔵、ボイスメモマイク内蔵','モノラルスピーカー内蔵','1/4-20 UNCのネジに対応','NP-FZ100',2280,83.00,NULL,NULL,0.0,40.0,136.10,96.90,82.90,743.0,658.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(14,3,'α1','ILCE-1',2,5,'2021-03-19',NULL,880000,NULL,NULL,5050,5010,1,35.90,24.00,'Exmor RS CMOSセンサー','BIONZ XR','電子式ビューファインダー (Quad-XGA OLED)',100.00,0.90,'液晶モニター',3.00,1440000,100,32000,50,102400,'1200分割ライブビュー分析測光','マルチ, 中央重点, スポット, 画面全体平均, ハイライト重点','±5.0EV (1/3EV、1/2EV ステップ選択可能) (ダイヤル操作時: ±3EV (1/3EV ステップ))',30.0,0.0000312500,30.0,0.0001250000,'1枚撮影、連続撮影 (Hi+/Hi/Mid/Lo切り替え可)、セルフタイマー、セルフタイマー (連続)、1枚ブラケット、連続ブラケット、ホワイトバランスブラケット、DROブラケット','30fps',NULL,' オート /  オート: 雰囲気優先 /  オート: ホワイト優先 / 太陽光 / 日陰 / 曇天 / 電球 / 蛍光灯: 温白色 / 蛍光灯: 白色 / 蛍光灯: 昼白色 / 蛍光灯: 昼光色 / \n                         フラッシュ / 水中オート / 色温度/カラーフィルター / カスタム 1/カスタム 2/カスタム 3',NULL,NULL,'ファストハイブリッドAF (位相差検出方式 / コントラスト検出方式)',759,NULL,NULL,NULL,2,NULL,50,21,12,'8640 x 5760','5616 x 3744','4320 x 2880',NULL,NULL,'XAVC HS 8K:7680 x 4320, XAVC HS 4K:3840 x 2160, XAVC S HD:1920 x 1080','LPCM 2ch（48kHz 16bit）、LPCM 2ch（48kHz 24bit）、LPCM 4ch（48kHz 24bit）、MPEG-4 AAC-LC 2ch',NULL,'Bluetooth 標準規格Ver. 5.0 (2.4GHz帯)','Wi-Fiに準拠、IEEE 802.11a/b/g/n/ac (2.4GHz帯/5GHz帯)','ステレオマイク内蔵','モノラルスピーカー内蔵',NULL,'NP-FZ100',2280,83.00,530,NULL,0.0,40.0,128.90,96.90,80.80,652.0,737.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56'),(15,3,'α9 III','ILCE-9M3',1,5,'2024-01-26',NULL,935000,NULL,NULL,2520,2460,1,35.60,23.80,'Exmor RS CMOSセンサー','BIONZ XR','電子式ビューファインダー (Quad-XGA OLED)',NULL,0.90,'液晶モニター TFT駆動',3.20,2095104,250,25600,125,51200,'1200分割ライブビュー分析測光','マルチ, 中央重点, スポット, 画面全体平均, ハイライト重点','EV-3 - EV20',30.0,0.0000125000,NULL,NULL,'1枚撮影, 連続撮影, セルフタイマー,  ブラケット','120fps',NULL,'オート / オート: 雰囲気優先 / オート: ホワイト優先 / 太陽光 / 日陰 / 曇天 / 電球 / 蛍光灯: 温白色 / 蛍光灯: 白色 / 蛍光灯: 昼白色 / 蛍光灯: 昼光色 / フラッシュ （静止画撮影時のみ）/ 水中オート/ 色温度/カラーフィルター / カスタム 1/カスタム 2/カスタム 3',2500,9900,'ファストハイブリッドAF (位相差検出方式 / コントラスト検出方式)',759,NULL,NULL,NULL,2,NULL,24,10,6,'6000 x 4000','3936 x 2632','3008 x 2000',NULL,NULL,'XAVC HS 4K 3840 x 2160, XAVC S HD 1920 x 1080','LPCM 2ch (48 kHz 16 bit)、LPCM 2ch (48 kHz 24 bit) 、LPCM 4ch (48 kHz 24 bit)',NULL,'Bluetooth 標準規格Ver. 5.0 (2.4 GHz帯)','Wi-Fiに準拠、IEEE 802.11a/b/g/n/ac (2.4 GHz帯/5 GHz帯)','ステレオマイク内蔵、ボイスメモマイク内蔵','モノラルスピーカー内蔵',NULL,'NP-FZ100',2280,83.00,520,NULL,0.0,40.0,136.10,96.90,82.90,618.0,703.0,NULL,NULL,NULL,'2025-09-19 04:57:56','2025-09-19 04:57:56');
/*!40000 ALTER TABLE `cameras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color_options`
--

DROP TABLE IF EXISTS `color_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `color_options_name_en_unique` (`name_en`),
  UNIQUE KEY `color_options_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_options`
--

LOCK TABLES `color_options` WRITE;
/*!40000 ALTER TABLE `color_options` DISABLE KEYS */;
INSERT INTO `color_options` VALUES (1,'Black','ブラック',NULL,NULL),(2,'Silver','シルバー',NULL,NULL),(3,'White','ホワイト',NULL,NULL),(4,'Gray','グレー',NULL,NULL),(5,'Red','レッド',NULL,NULL),(6,'Blue','ブルー',NULL,NULL),(7,'Brown','ブラウン',NULL,NULL),(8,'Green','グリーン',NULL,NULL),(9,'Champagne','シャンパンゴールド',NULL,NULL),(10,'Titanium','チタン',NULL,NULL),(11,'Beige','ベージュ',NULL,NULL),(12,'Pink','ピンク',NULL,NULL),(13,'Orange','オレンジ',NULL,NULL),(14,'Navy','ネイビー',NULL,NULL),(15,'Olive','オリーブ',NULL,NULL),(16,'Graphite','グラファイト',NULL,NULL),(17,'Gunmetal','ガンメタリック',NULL,NULL),(18,'Limited Edition','限定カラー',NULL,NULL);
/*!40000 ALTER TABLE `color_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `display_languages`
--

DROP TABLE IF EXISTS `display_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `display_languages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `display_languages_name_en_unique` (`name_en`),
  UNIQUE KEY `display_languages_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `display_languages`
--

LOCK TABLES `display_languages` WRITE;
/*!40000 ALTER TABLE `display_languages` DISABLE KEYS */;
INSERT INTO `display_languages` VALUES (1,'English','英語',NULL,NULL),(2,'German','ドイツ語',NULL,NULL),(3,'French','フランス語',NULL,NULL),(4,'Italian','イタリア語',NULL,NULL),(5,'Spanish','スペイン語',NULL,NULL),(6,'Portuguese','ポルトガル語',NULL,NULL),(7,'Russian','ロシア語',NULL,NULL),(8,'Japanese','日本語',NULL,NULL),(9,'Traditional Chinese','繁体中国語',NULL,NULL),(10,'Simplified Chinese','簡体中国語',NULL,NULL),(11,'Korean','韓国語',NULL,NULL),(12,'Arabic','アラビア語',NULL,NULL),(13,'Persian','ペルシャ語',NULL,NULL),(14,'Thai','タイ語',NULL,NULL),(15,'Malay','マレー語',NULL,NULL);
/*!40000 ALTER TABLE `display_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `features_name_en_unique` (`name_en`),
  UNIQUE KEY `features_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Dust and Splash Resistance','防塵・防滴',NULL,NULL),(2,'Image Stabilization','手ブレ補正機構',NULL,NULL),(3,'5-Axis Stabilization','5軸手ブレ補正',NULL,NULL),(4,'Selfie Support','自分撮り機能',NULL,NULL),(5,'Touch Panel','タッチパネル',NULL,NULL),(6,'Dust Removal System','ゴミ取り機構',NULL,NULL),(7,'Built-in Flash','内蔵フラッシュ',NULL,NULL),(8,'Time-lapse Photography','タイムラプス',NULL,NULL),(9,'Live View','ライブビュー',NULL,NULL),(10,'GPS','GPS',NULL,NULL),(11,'USB Charging','UBS充電',NULL,NULL),(12,'RAW+JPEG Simultaneous Recording','RAW+JPEG同時記録',NULL,NULL),(13,'Bulb Mode','バルブ',NULL,NULL),(14,'Wi-Fi','Wi-Fi',NULL,NULL),(15,'NFC','NFC',NULL,NULL),(16,'Focus Peaking','ピーキング表示',NULL,NULL);
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_models`
--

DROP TABLE IF EXISTS `interface_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interface_models` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `interface_models_name_en_unique` (`name_en`),
  UNIQUE KEY `interface_models_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_models`
--

LOCK TABLES `interface_models` WRITE;
/*!40000 ALTER TABLE `interface_models` DISABLE KEYS */;
INSERT INTO `interface_models` VALUES (1,'Accessory Shoe','アクセサリーシュー（電子接点無）',NULL,NULL),(2,'Hot Shoe','ホットシュー（電子接点有）',NULL,NULL),(3,'Sync Terminal / Timecode Terminal','シンクロターミナル/タイムコード端子',NULL,NULL),(4,'Remote Terminal (Type N3)','リモコン端子（タイプN3）',NULL,NULL),(5,'USB 3.1 Gen1 Type-C','USB 3.1 Gen1 Type C',NULL,NULL),(6,'HDMI Type-A Terminal (2.1)','HDMI端子 2.1 Type A',NULL,NULL),(7,'HDMI Micro Terminal (Type D)','HDMIマイクロ端子（タイプD）',NULL,NULL),(8,'Audio Output (3.5mm)','オーディオ アウト3.5 mm',NULL,NULL),(9,'Audio Input (3.5mm)','オーディオ イン3.5 mm',NULL,NULL),(10,'LAN Terminal','LAN端子',NULL,NULL),(11,'Communication Interface','通信インターフェース',NULL,NULL);
/*!40000 ALTER TABLE `interface_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lens_mounts`
--

DROP TABLE IF EXISTS `lens_mounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lens_mounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lens_mounts_name_en_unique` (`name_en`),
  UNIQUE KEY `lens_mounts_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lens_mounts`
--

LOCK TABLES `lens_mounts` WRITE;
/*!40000 ALTER TABLE `lens_mounts` DISABLE KEYS */;
INSERT INTO `lens_mounts` VALUES (1,'Canon EF','キヤノンEFマウント',NULL,NULL),(2,'Canon RF','キヤノンRFマウント',NULL,NULL),(3,'Nikon F','ニコンFマウント',NULL,NULL),(4,'Nikon Z','ニコンZマウント',NULL,NULL),(5,'Sony E','ソニーEマウント',NULL,NULL),(6,'Sony A','ソニーAマウント',NULL,NULL),(7,'Fujifilm X','富士フイルムXマウント',NULL,NULL),(8,'Micro Four Thirds','マイクロフォーサーズマウント',NULL,NULL),(9,'Leica M','ライカMバヨネットマウント',NULL,NULL),(10,'Leica L','ライカLバヨネットマウント',NULL,NULL),(11,'Leica L39','ライカL39マウント',NULL,NULL),(12,'Pentax K','ペンタックスKマウント',NULL,NULL),(13,'Hasselblad X (XCD)','ハッセルブラッド Xマウント (XCD)',NULL,NULL);
/*!40000 ALTER TABLE `lens_mounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_ja` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `founded_year` smallint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'Canon','キヤノン','Japan','日本',1937,NULL,NULL),(2,'Nikon','ニコン','Japan','日本',1917,NULL,NULL),(3,'Sony','ソニー','Japan','日本',1946,NULL,NULL),(4,'Fujifilm','富士フイルム','Japan','日本',1934,NULL,NULL),(5,'Olympus','オリンパス','Japan','日本',1919,NULL,NULL),(6,'Leica','ライカ','Germany','ドイツ',1914,NULL,NULL),(7,'Panasonic','パナソニック','Japan','日本',1918,NULL,NULL),(8,'Pentax','ペンタックス','Japan','日本',1919,NULL,NULL),(9,'Hasselblad','ハッセルブラッド','Sweden','スウェーデン',1841,NULL,NULL);
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_06_09_112300_create_manufacturers_table',1),(5,'2025_06_09_112301_create_camera_types_table',1),(6,'2025_06_09_112302_create_lens_mounts_table',1),(7,'2025_06_09_112303_create_sensor_types_table',1),(8,'2025_06_09_112312_create_display_languages_table',1),(9,'2025_06_09_112316_create_self_timer_seconds_table',1),(10,'2025_06_09_112329_create_photo_formats_table',1),(11,'2025_06_09_112331_create_video_formats_table',1),(12,'2025_06_09_112339_create_video_codecs_table',1),(13,'2025_06_09_112340_create_color_options_table',1),(14,'2025_06_09_112342_create_interface_models_table',1),(15,'2025_06_09_112345_create_recording_medias_table',1),(16,'2025_06_09_112347_create_accessories_table',1),(17,'2025_06_09_112350_create_features_table',1),(18,'2025_06_10_112310_create_cameras_table',1),(19,'2025_06_11_055042_create_camera_color_option_table',1),(20,'2025_06_11_055045_create_camera_selftimer_second_table',1),(21,'2025_06_11_055049_create_camera_photo_format_table',1),(22,'2025_06_11_055050_create_camera_video_format_table',1),(23,'2025_06_11_055051_create_camera_video_codec_table',1),(24,'2025_06_11_055052_create_camera_interface_model_table',1),(25,'2025_06_11_055053_create_camera_recording_media_table',1),(26,'2025_06_11_055054_create_camera_accessory_table',1),(27,'2025_06_11_055055_create_camera_display_language_table',1),(28,'2025_06_11_055056_create_camera_feature_table',1),(29,'2025_06_13_112311_create_camera_prices_table',1),(30,'2025_08_25_073759_create_contacts_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_formats`
--

DROP TABLE IF EXISTS `photo_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo_formats` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `photo_formats_name_en_unique` (`name_en`),
  UNIQUE KEY `photo_formats_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_formats`
--

LOCK TABLES `photo_formats` WRITE;
/*!40000 ALTER TABLE `photo_formats` DISABLE KEYS */;
INSERT INTO `photo_formats` VALUES (1,'JPEG','JPEG',NULL,NULL),(2,'HEIF','HEIF',NULL,NULL),(3,'RAW','RAW',NULL,NULL),(4,'DPRAW','DPRAW',NULL,NULL),(5,'C-RAW','C-RAW',NULL,NULL),(6,'3FR RAW','3FR RAW',NULL,NULL),(7,'DNG','DNG',NULL,NULL),(8,'NEF(RAW)','NEF（RAW）',NULL,NULL),(9,'TIFF','TIFF',NULL,NULL);
/*!40000 ALTER TABLE `photo_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recording_medias`
--

DROP TABLE IF EXISTS `recording_medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recording_medias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recording_medias_name_en_unique` (`name_en`),
  UNIQUE KEY `recording_medias_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recording_medias`
--

LOCK TABLES `recording_medias` WRITE;
/*!40000 ALTER TABLE `recording_medias` DISABLE KEYS */;
INSERT INTO `recording_medias` VALUES (1,'SD','SD',NULL,NULL),(2,'SDHC','SDHC',NULL,NULL),(3,'SDXC','SDXC',NULL,NULL),(4,'CFexpress card type A','CFexpress card type A',NULL,NULL),(5,'CFexpress card type B','CFexpress card type B',NULL,NULL),(6,'UHS-I','UHS-I対応',NULL,NULL),(7,'UHS-II','UHS-II対応',NULL,NULL);
/*!40000 ALTER TABLE `recording_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `self_timer_seconds`
--

DROP TABLE IF EXISTS `self_timer_seconds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `self_timer_seconds` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `self_timer_seconds_name_en_unique` (`name_en`),
  UNIQUE KEY `self_timer_seconds_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `self_timer_seconds`
--

LOCK TABLES `self_timer_seconds` WRITE;
/*!40000 ALTER TABLE `self_timer_seconds` DISABLE KEYS */;
INSERT INTO `self_timer_seconds` VALUES (1,'2s','2秒',NULL,NULL),(2,'3s','3秒',NULL,NULL),(3,'5s','5秒',NULL,NULL),(4,'6s','6秒',NULL,NULL),(5,'10s','10秒',NULL,NULL),(6,'12s','12秒',NULL,NULL),(7,'20s','20秒',NULL,NULL),(8,'30s','30秒',NULL,NULL);
/*!40000 ALTER TABLE `self_timer_seconds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor_types`
--

DROP TABLE IF EXISTS `sensor_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensor_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sensor_types_name_en_unique` (`name_en`),
  UNIQUE KEY `sensor_types_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor_types`
--

LOCK TABLES `sensor_types` WRITE;
/*!40000 ALTER TABLE `sensor_types` DISABLE KEYS */;
INSERT INTO `sensor_types` VALUES (1,'Full Frame','フルサイズ',NULL,NULL),(2,'APS-C','APS-C',NULL,NULL),(3,'APS-H','APS-H',NULL,NULL),(4,'Micro Four Thirds','マイクロフォーサーズ',NULL,NULL),(5,'1 inch','1型',NULL,NULL),(6,'Medium Format','中判',NULL,NULL),(7,'1/1.7 inch','1/1.7型',NULL,NULL),(8,'1/2.3 inch','1/2.3型',NULL,NULL),(9,'Four Thirds','フォーサーズ',NULL,NULL),(10,'CX (1 inch Nikon)','CX（ニコン1型）',NULL,NULL);
/*!40000 ALTER TABLE `sensor_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('gVuHP0qEQVhmueK01AulyzKwgIQ5AqRER2JN2bGi',NULL,'172.18.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2lZc3lCczd3RnZJZlY1VWd6UEdBR2VqSWRTNjA1ZXpwQW1kaTZwZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA2OiJodHRwOi8vbG9jYWxob3N0L3NlYXJjaC1jYW1lcmE/ZWZmZWN0aXZlX3BpeGVscz0xMDAwMCZpc29fbWF4PSZpc29fbWluPSZrZXl3b3JkPSZwYWdlPTImcHJpY2VfcmFuZ2UlNUIwJTVEPTUwMDAwJnByaWNlX3JhbmdlJTVCMSU1RD0yMDAwMDAwJnJlbGVhc2VfeWVhcj0xOTgwJndlaWdodF9yYW5nZSU1QjAlNUQ9MTAwJndlaWdodF9yYW5nZSU1QjElNUQ9MTUwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1758258548);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','test@example.com',NULL,'$2y$12$EkzhLjQb2zSa9hiQZ51flOFcouNUqcY61TeqwrmRQuFxsre7ndZUe',NULL,NULL,NULL,1),(2,'normaluser','normal@example.com',NULL,'$2y$12$xv/Pa5425eoyZYzo7gCfQeP96BCFbHCVu33OJY8g/1KtnY4O0/MPK',NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_codecs`
--

DROP TABLE IF EXISTS `video_codecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_codecs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_codecs_name_en_unique` (`name_en`),
  UNIQUE KEY `video_codecs_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_codecs`
--

LOCK TABLES `video_codecs` WRITE;
/*!40000 ALTER TABLE `video_codecs` DISABLE KEYS */;
INSERT INTO `video_codecs` VALUES (1,'H.264','H.264 (MPEG-4 Part 10/AVC)',NULL,NULL),(2,'H.265','H.265 (MPEG-H Part 2/HEVC)',NULL,NULL),(3,'ProRes','ProRes (422/HQ/LT)',NULL,NULL),(4,'ProRes RAW','ProRes RAW(Apple)',NULL,NULL),(5,'BRAW','BRAW（Blackmagic RAW）',NULL,NULL),(6,'Canon RAW/CRM','Canon RAW/CRM（Cinema RAW Light）',NULL,NULL),(7,'N-RAW','N-RAW',NULL,NULL),(8,'Long GOP','Long GOP',NULL,NULL);
/*!40000 ALTER TABLE `video_codecs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_formats`
--

DROP TABLE IF EXISTS `video_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_formats` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_ja` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_formats_name_en_unique` (`name_en`),
  UNIQUE KEY `video_formats_name_ja_unique` (`name_ja`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_formats`
--

LOCK TABLES `video_formats` WRITE;
/*!40000 ALTER TABLE `video_formats` DISABLE KEYS */;
INSERT INTO `video_formats` VALUES (1,'MP4','MP4',NULL,NULL),(2,'MOV','MOV',NULL,NULL),(3,'AVCHD','AVCHD',NULL,NULL),(4,'XAVC S','XAVC S',NULL,NULL),(5,'XAVC HS','XAVC HS',NULL,NULL),(6,'XAVC S-I','XAVC S-I',NULL,NULL),(7,'MOV All-I / IPB','MOV All-I/IPB',NULL,NULL);
/*!40000 ALTER TABLE `video_formats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-19  5:20:26
