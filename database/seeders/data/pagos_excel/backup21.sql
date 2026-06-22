/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: centropre
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academic_cycle_shifts`
--

DROP TABLE IF EXISTS `academic_cycle_shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_cycle_shifts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `campus_id` bigint(20) unsigned NOT NULL,
  `shift_id` bigint(20) unsigned NOT NULL,
  `capacity` int(10) unsigned NOT NULL,
  `enrolled` int(10) unsigned NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_cycle_shifts_cycle_campus_shift_unique` (`academic_cycle_id`,`campus_id`,`shift_id`),
  KEY `academic_cycle_shifts_campus_id_foreign` (`campus_id`),
  KEY `academic_cycle_shifts_shift_id_foreign` (`shift_id`),
  KEY `academic_cycle_shifts_status_academic_cycle_id_index` (`status`,`academic_cycle_id`),
  CONSTRAINT `academic_cycle_shifts_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `academic_cycle_shifts_campus_id_foreign` FOREIGN KEY (`campus_id`) REFERENCES `campuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `academic_cycle_shifts_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_cycle_shifts`
--

LOCK TABLES `academic_cycle_shifts` WRITE;
/*!40000 ALTER TABLE `academic_cycle_shifts` DISABLE KEYS */;
INSERT INTO `academic_cycle_shifts` VALUES
(1,1,1,4,840,151,1,'2026-06-16 19:00:44','2026-06-19 15:01:40');
/*!40000 ALTER TABLE `academic_cycle_shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_cycles`
--

DROP TABLE IF EXISTS `academic_cycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_cycles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academic_cycles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_cycles`
--

LOCK TABLES `academic_cycles` WRITE;
/*!40000 ALTER TABLE `academic_cycles` DISABLE KEYS */;
INSERT INTO `academic_cycles` VALUES
(1,'CICLO INTENSIVO 2026-I',1,'2026-06-16','2026-08-30','2026-06-16 19:00:35','2026-06-16 19:00:35');
/*!40000 ALTER TABLE `academic_cycles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` bigint(20) unsigned DEFAULT NULL,
  `module` varchar(80) NOT NULL,
  `action` varchar(80) NOT NULL,
  `description` varchar(500) NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_logs_subject_type_subject_id_index` (`subject_type`,`subject_id`),
  KEY `activity_logs_staff_id_created_at_index` (`staff_id`,`created_at`),
  KEY `activity_logs_module_created_at_index` (`module`,`created_at`),
  KEY `activity_logs_module_index` (`module`),
  KEY `activity_logs_action_index` (`action`),
  CONSTRAINT `activity_logs_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=534 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES
(1,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 18:57:45','2026-06-16 18:57:45'),
(2,1,'staff','updated','Actualizo empleado: Super Admin','App\\Models\\Staff',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"dni\":{\"before\":\"74357593\",\"after\":\"88888888\"}}}','2026-06-16 18:58:10','2026-06-16 18:58:10'),
(3,1,'staff','created','Creo empleado: ELBER JESUS QUIROZ','App\\Models\\Staff',2,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-16 18:58:56','2026-06-16 18:58:56'),
(4,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 18:58:59','2026-06-16 18:58:59'),
(5,2,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 18:59:06','2026-06-16 18:59:06'),
(6,2,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 18:59:23','2026-06-16 18:59:23'),
(7,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 18:59:37','2026-06-16 18:59:37'),
(8,1,'shifts','created','Creo turno: Mañana y Tarde','App\\Models\\Shift',4,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-16 18:59:51','2026-06-16 18:59:51'),
(9,1,'academic_cycles','created','Creo ciclo académico: CICLO INTENSIVO 2026-I','App\\Models\\AcademicCycle',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-16 19:00:35','2026-06-16 19:00:35'),
(10,1,'schedules','created','Creo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-16 19:00:44','2026-06-16 19:00:44'),
(11,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"registration_enabled\":{\"before\":true,\"after\":false},\"active_verification_mail_enabled\":{\"before\":false,\"after\":true}}}','2026-06-16 19:03:41','2026-06-16 19:03:41'),
(12,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"active_verification_mail_enabled\":{\"before\":true,\"after\":false}}}','2026-06-16 19:04:21','2026-06-16 19:04:21'),
(13,1,'students','created','Creo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-16 19:10:50','2026-06-16 19:10:50'),
(14,1,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":0,\"after\":1}}}','2026-06-16 19:10:50','2026-06-16 19:10:50'),
(15,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 19:10:54','2026-06-16 19:10:54'),
(16,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 19:11:04','2026-06-16 19:11:04'),
(17,1,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"shift_id\":{\"before\":1,\"after\":\"4\"}}}','2026-06-16 19:11:35','2026-06-16 19:11:35'),
(18,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-16 19:11:40','2026-06-16 19:11:40'),
(19,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:19:51','2026-06-17 07:19:51'),
(20,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"academic_group\",\"shift\",\"registration_date\",\"status\"]}','2026-06-17 07:19:59','2026-06-17 07:19:59'),
(21,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:20:14','2026-06-17 07:20:14'),
(22,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:21:44','2026-06-17 07:21:44'),
(23,1,'staff','created','Creo empleado: JOSE ANCAJIMA','App\\Models\\Staff',3,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:23:17','2026-06-17 07:23:17'),
(24,1,'staff','created','Creo empleado: DIEGO JOSE SALSACHIN','App\\Models\\Staff',4,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:24:34','2026-06-17 07:24:34'),
(25,4,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0',NULL,'2026-06-17 07:25:09','2026-06-17 07:25:09'),
(26,3,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:25:38','2026-06-17 07:25:38'),
(27,3,'academic_evaluations','created','Creo evaluación: Examen de ubicación','App\\Models\\Evaluation',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:30:44','2026-06-17 07:30:44'),
(28,3,'academic_evaluations','created','Creo evaluación: Examen medio ciclo','App\\Models\\Evaluation',2,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:30:44','2026-06-17 07:30:44'),
(29,3,'academic_evaluations','created','Creo evaluación: Examen final','App\\Models\\Evaluation',3,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:30:44','2026-06-17 07:30:44'),
(30,3,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:46:47','2026-06-17 07:46:47'),
(31,1,'students','created','Creo alumno: ELBER JESUS SANCHEZ QUIROZ','App\\Models\\Student',2,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:52:12','2026-06-17 07:52:12'),
(32,1,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":1,\"after\":2}}}','2026-06-17 07:52:12','2026-06-17 07:52:12'),
(33,1,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":2,\"after\":1}}}','2026-06-17 07:52:33','2026-06-17 07:52:33'),
(34,1,'students','deleted','Elimino alumno: ELBER JESUS SANCHEZ QUIROZ','App\\Models\\Student',2,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 07:52:33','2026-06-17 07:52:33'),
(35,3,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 07:59:36','2026-06-17 07:59:36'),
(36,3,'students','created','Creo alumno: YAIR VALENTIN CAYAO MONJA','App\\Models\\Student',3,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 08:08:43','2026-06-17 08:08:43'),
(37,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":1,\"after\":2}}}','2026-06-17 08:08:43','2026-06-17 08:08:43'),
(38,1,'students','created','Creo alumno: CAMILA DEL ROCIO VELIZ RIMARACHIN','App\\Models\\Student',4,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 08:12:08','2026-06-17 08:12:08'),
(39,1,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":2,\"after\":3}}}','2026-06-17 08:12:08','2026-06-17 08:12:08'),
(40,4,'students','created','Creo alumno: KEYLA REBECA SANCHEZ VASQUEZ','App\\Models\\Student',5,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 08:13:09','2026-06-17 08:13:09'),
(41,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":3,\"after\":4}}}','2026-06-17 08:13:09','2026-06-17 08:13:09'),
(42,1,'students','updated','Actualizo alumno: CAMILA DEL ROCIO VELIZ RIMARACHIN','App\\Models\\Student',4,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"birth_date\":{\"before\":\"2009-02-12T05:00:00.000000Z\",\"after\":\"2009-02-10 00:00:00\"}}}','2026-06-17 08:14:40','2026-06-17 08:14:40'),
(43,3,'students','created','Creo alumno: JOSE ENRIQUE TERRONES CHAYAN','App\\Models\\Student',6,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 08:25:25','2026-06-17 08:25:25'),
(44,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":4,\"after\":5}}}','2026-06-17 08:25:25','2026-06-17 08:25:25'),
(45,3,'students','updated','Actualizo alumno: JOSE ENRIQUE TERRONES CHAYAN','App\\Models\\Student',6,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"career_id\":{\"before\":1,\"after\":2},\"status\":{\"before\":\"pending\",\"after\":\"active\"}}}','2026-06-17 08:26:04','2026-06-17 08:26:04'),
(46,3,'students','created','Creo alumno: YVET ADRIANA CHAVESTA SANCHEZ','App\\Models\\Student',7,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 08:53:20','2026-06-17 08:53:20'),
(47,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":5,\"after\":6}}}','2026-06-17 08:53:20','2026-06-17 08:53:20'),
(48,4,'students','created','Creo alumno: ANGELA MASSIEL POLO FLORES','App\\Models\\Student',8,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 08:53:33','2026-06-17 08:53:33'),
(49,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":6,\"after\":7}}}','2026-06-17 08:53:33','2026-06-17 08:53:33'),
(50,3,'students','updated','Actualizo alumno: YVET ADRIANA CHAVESTA SANCHEZ','App\\Models\\Student',7,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"address\":{\"before\":\"LA PRADERA MZ:F LT: 2, CHICLAYO, CHICLAYO, LAMBAYEQUE\",\"after\":\"CPM LOS JARDINES PRADERA OESTE MZ F LT 2, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-17 08:55:28','2026-06-17 08:55:28'),
(51,4,'students','created','Creo alumno: ALISON ANALISSE SANDOVAL ENEQUE','App\\Models\\Student',9,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:01:42','2026-06-17 09:01:42'),
(52,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":7,\"after\":8}}}','2026-06-17 09:01:42','2026-06-17 09:01:42'),
(53,3,'students','created','Creo alumno: YAREM ALEJANDRO TORRES BANCES','App\\Models\\Student',10,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:02:26','2026-06-17 09:02:26'),
(54,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":8,\"after\":9}}}','2026-06-17 09:02:26','2026-06-17 09:02:26'),
(55,4,'students','created','Creo alumno: FRANCISCO ARNALDO NECIOSUP CALDERON','App\\Models\\Student',11,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:07:54','2026-06-17 09:07:54'),
(56,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":9,\"after\":10}}}','2026-06-17 09:07:54','2026-06-17 09:07:54'),
(57,3,'students','created','Creo alumno: MARICIELO ANAIS BARRIENTOS BRIONES','App\\Models\\Student',12,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:08:39','2026-06-17 09:08:39'),
(58,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":10,\"after\":11}}}','2026-06-17 09:08:39','2026-06-17 09:08:39'),
(59,4,'students','created','Creo alumno: BRITHANY DAYANA PISFIL SOLANO','App\\Models\\Student',13,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:14:09','2026-06-17 09:14:09'),
(60,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":11,\"after\":12}}}','2026-06-17 09:14:09','2026-06-17 09:14:09'),
(61,3,'students','created','Creo alumno: RODERICK HARIM VILCHEZ PERALTA','App\\Models\\Student',14,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:15:29','2026-06-17 09:15:29'),
(62,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":12,\"after\":13}}}','2026-06-17 09:15:29','2026-06-17 09:15:29'),
(63,4,'students','updated','Actualizo alumno: MARICIELO ANAIS BRIONES BARRIENTOS','App\\Models\\Student',12,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"last_name\":{\"before\":\"BARRIENTOS\",\"after\":\"BRIONES\"},\"mother_last_name\":{\"before\":\"BRIONES\",\"after\":\"BARRIENTOS\"}}}','2026-06-17 09:15:55','2026-06-17 09:15:55'),
(64,4,'students','created','Creo alumno: RAQUEL TAFUR MUÑOZ','App\\Models\\Student',15,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:22:21','2026-06-17 09:22:21'),
(65,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":13,\"after\":14}}}','2026-06-17 09:22:21','2026-06-17 09:22:21'),
(66,4,'students','updated','Actualizo alumno: RAQUEL TAFUR MUÑOZ','App\\Models\\Student',15,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"address\":{\"before\":\"CALLE ANTONIO RAYMONDI 253, CHICLAYO, CHICLAYO, LAMBAYEQUE\",\"after\":\"JUAN ITURREGUI 155, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-17 09:23:50','2026-06-17 09:23:50'),
(67,3,'students','created','Creo alumno: IOANA LUCIA NAVARRETE PAUCAR','App\\Models\\Student',16,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:24:34','2026-06-17 09:24:34'),
(68,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":14,\"after\":15}}}','2026-06-17 09:24:34','2026-06-17 09:24:34'),
(69,3,'students','updated','Actualizo alumno: IOANA LUCÍA NAVARRETE PAUCAR','App\\Models\\Student',16,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"first_name\":{\"before\":\"IOANA LUCIA\",\"after\":\"IOANA LUC\\u00cdA\"}}}','2026-06-17 09:25:22','2026-06-17 09:25:22'),
(70,4,'students','created','Creo alumno: ANYA KIREY ESTEVES MOZO','App\\Models\\Student',17,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:31:25','2026-06-17 09:31:25'),
(71,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":15,\"after\":16}}}','2026-06-17 09:31:25','2026-06-17 09:31:25'),
(72,3,'students','created','Creo alumno: SHEILA YUSEIDY ALARCON RAFAEL','App\\Models\\Student',18,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:35:45','2026-06-17 09:35:45'),
(73,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":16,\"after\":17}}}','2026-06-17 09:35:45','2026-06-17 09:35:45'),
(74,4,'students','created','Creo alumno: MARCELLO JOAQUIN RODAS MORANTE','App\\Models\\Student',19,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:36:54','2026-06-17 09:36:54'),
(75,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":17,\"after\":18}}}','2026-06-17 09:36:54','2026-06-17 09:36:54'),
(76,4,'students','updated','Actualizo alumno: SHEILA YUSEIDY ALARCON RAFAEL','App\\Models\\Student',18,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"address\":{\"before\":\"URB. LAS PALMAS MZ. R LT. 02, CAJAMARCA, CAJAMARCA, CAJAMARCA\",\"after\":\"URB. LAS PALMAS MZ. R LT. 02, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-17 09:38:47','2026-06-17 09:38:47'),
(77,3,'students','created','Creo alumno: GIOVANNI FABRIZZIO PISCOYA REUPO','App\\Models\\Student',20,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:41:06','2026-06-17 09:41:06'),
(78,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":18,\"after\":19}}}','2026-06-17 09:41:06','2026-06-17 09:41:06'),
(79,4,'students','created','Creo alumno: MARTHA HEIRY CAPUÑAY SILVA','App\\Models\\Student',21,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:45:59','2026-06-17 09:45:59'),
(80,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":19,\"after\":20}}}','2026-06-17 09:45:59','2026-06-17 09:45:59'),
(81,3,'students','created','Creo alumno: JORGE LUIS GUTIERREZ GALVEZ','App\\Models\\Student',22,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:47:47','2026-06-17 09:47:47'),
(82,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":20,\"after\":21}}}','2026-06-17 09:47:47','2026-06-17 09:47:47'),
(83,4,'students','updated','Actualizo alumno: MARTHA HEIRY CAPUÑAY SILVA','App\\Models\\Student',21,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"address\":{\"before\":\"CALLE LOS LIBERTADORES MZ D LT 06, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE\",\"after\":\"RESIDENCIAL EL CARMEN BLOCK D DPTO 202, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE\"},\"email\":{\"before\":\"fencgohen27@gmail.com\",\"after\":\"fencohen27@gmail.com\"}}}','2026-06-17 09:48:02','2026-06-17 09:48:02'),
(84,3,'students','created','Creo alumno: JHONATAN ALEXANDER VALVERDE MACALOPU','App\\Models\\Student',23,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 09:54:38','2026-06-17 09:54:38'),
(85,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":21,\"after\":22}}}','2026-06-17 09:54:38','2026-06-17 09:54:38'),
(86,4,'students','created','Creo alumno: CARLOS DANIEL BENITES CASTRO','App\\Models\\Student',24,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 09:56:19','2026-06-17 09:56:19'),
(87,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":22,\"after\":23}}}','2026-06-17 09:56:19','2026-06-17 09:56:19'),
(88,3,'students','created','Creo alumno: BRUNO ALDAIR DIAZ LLATAS','App\\Models\\Student',25,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:00:46','2026-06-17 10:00:46'),
(89,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":23,\"after\":24}}}','2026-06-17 10:00:46','2026-06-17 10:00:46'),
(90,4,'students','created','Creo alumno: ADRIANA ELIZABETH MORALES CUBAS','App\\Models\\Student',26,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:01:28','2026-06-17 10:01:28'),
(91,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":24,\"after\":25}}}','2026-06-17 10:01:28','2026-06-17 10:01:28'),
(92,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"school\",\"registration_date\",\"status\"]}','2026-06-17 10:03:56','2026-06-17 10:03:56'),
(93,4,'students','updated','Actualizo alumno: MARTHA HEIRY CAPUÑAY SILVA','App\\Models\\Student',21,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"phone\":{\"before\":\"954998152\",\"after\":\"960221786\"},\"email\":{\"before\":\"fencohen27@gmail.com\",\"after\":\"marthaheirysilva.18@gmail.com\"}}}','2026-06-17 10:17:11','2026-06-17 10:17:11'),
(94,3,'students','created','Creo alumno: MIZUKI CAMILA MEJIA SILVA','App\\Models\\Student',27,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:17:18','2026-06-17 10:17:18'),
(95,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":25,\"after\":26}}}','2026-06-17 10:17:18','2026-06-17 10:17:18'),
(96,3,'students','created','Creo alumno: LINDA JASUE AREVALO ALVARADO','App\\Models\\Student',28,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:26:39','2026-06-17 10:26:39'),
(97,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":26,\"after\":27}}}','2026-06-17 10:26:39','2026-06-17 10:26:39'),
(98,3,'students','updated','Actualizo alumno: LINDA JASUE AREVALO ALVARADO','App\\Models\\Student',28,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"address\":{\"before\":\"PASAJE OLIVOS 175, CAJAMARCA, CAJAMARCA, CAJAMARCA\",\"after\":\"PASAJE OLIVOS 175, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-17 10:27:53','2026-06-17 10:27:53'),
(99,4,'students','created','Creo alumno: JUAN JOSE TAPIA SAAVEDRA','App\\Models\\Student',29,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:27:53','2026-06-17 10:27:53'),
(100,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":27,\"after\":28}}}','2026-06-17 10:27:53','2026-06-17 10:27:53'),
(101,4,'students','created','Creo alumno: ROSITA GUADALUPE SANTOS REQUENA','App\\Models\\Student',30,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:34:05','2026-06-17 10:34:05'),
(102,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":28,\"after\":29}}}','2026-06-17 10:34:05','2026-06-17 10:34:05'),
(103,4,'students','updated','Actualizo alumno: ROSITA GUADALUPE SANTOS REQUENA','App\\Models\\Student',30,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"phone\":{\"before\":\"936160461\",\"after\":\"936160464\"}}}','2026-06-17 10:35:28','2026-06-17 10:35:28'),
(104,3,'students','created','Creo alumno: JENNIFER KATHERINE ANCAJIMA TORO','App\\Models\\Student',31,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:37:30','2026-06-17 10:37:30'),
(105,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":29,\"after\":30}}}','2026-06-17 10:37:30','2026-06-17 10:37:30'),
(106,3,'students','updated','Actualizo alumno: JENNIFER KATHERINE ANCAJIMA TORO','App\\Models\\Student',31,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"jeen885491@gmail.com\",\"after\":\"jenn885491@gmail.com\"},\"career_id\":{\"before\":1,\"after\":28},\"status\":{\"before\":\"pending\",\"after\":\"active\"}}}','2026-06-17 10:38:36','2026-06-17 10:38:36'),
(107,4,'students','created','Creo alumno: CIELO NARELLA ALACHE GASTULO','App\\Models\\Student',32,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:40:12','2026-06-17 10:40:12'),
(108,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":30,\"after\":31}}}','2026-06-17 10:40:12','2026-06-17 10:40:12'),
(109,3,'students','created','Creo alumno: CESAR DEMETRIO VIDAURRE SALAZAR','App\\Models\\Student',33,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:43:06','2026-06-17 10:43:06'),
(110,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":31,\"after\":32}}}','2026-06-17 10:43:06','2026-06-17 10:43:06'),
(111,4,'students','created','Creo alumno: DANIELA VICTORIA TALLEDO CHAMBERGO','App\\Models\\Student',34,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:46:20','2026-06-17 10:46:20'),
(112,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":32,\"after\":33}}}','2026-06-17 10:46:20','2026-06-17 10:46:20'),
(113,4,'students','updated','Actualizo alumno: DANIELA VICTORIA TALLEDO CHAMBERGO','App\\Models\\Student',34,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"email\":{\"before\":\"tvtch234@gamil.com\",\"after\":\"tvtch234@gmail.com\"}}}','2026-06-17 10:46:44','2026-06-17 10:46:44'),
(114,4,'students','updated','Actualizo alumno: DANIELA VICTORIA TALLEDO CHAMBERGO','App\\Models\\Student',34,'190.236.29.40','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"email\":{\"before\":\"tvtch234@gmail.com\",\"after\":\"dvtch234@gmail.com\"}}}','2026-06-17 10:48:40','2026-06-17 10:48:40'),
(115,3,'students','created','Creo alumno: MILAGROS ELIANA SANCHEZ TARRILLO','App\\Models\\Student',35,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:49:40','2026-06-17 10:49:40'),
(116,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":33,\"after\":34}}}','2026-06-17 10:49:40','2026-06-17 10:49:40'),
(117,4,'students','created','Creo alumno: FRANK MAURICIO ENEQUE CHANCAFE','App\\Models\\Student',36,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 10:55:13','2026-06-17 10:55:13'),
(118,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":34,\"after\":35}}}','2026-06-17 10:55:13','2026-06-17 10:55:13'),
(119,3,'students','created','Creo alumno: SANTIAGO RAUL ZUÑIGA ANDRADE','App\\Models\\Student',37,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 10:55:28','2026-06-17 10:55:28'),
(120,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":35,\"after\":36}}}','2026-06-17 10:55:28','2026-06-17 10:55:28'),
(121,4,'students','created','Creo alumno: HADEMIR JOSEPT TAPIA CORONEL','App\\Models\\Student',38,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:00:40','2026-06-17 11:00:40'),
(122,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":36,\"after\":37}}}','2026-06-17 11:00:40','2026-06-17 11:00:40'),
(123,3,'students','created','Creo alumno: SAMUEL BENJAMIN BERNAL ESPINOZA','App\\Models\\Student',39,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:01:16','2026-06-17 11:01:16'),
(124,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":37,\"after\":38}}}','2026-06-17 11:01:16','2026-06-17 11:01:16'),
(125,4,'students','updated','Actualizo alumno: HADEMIR JOSEPT TAPIA CORONEL','App\\Models\\Student',38,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"email\":{\"before\":\"hademir10jpsept@gmail.com\",\"after\":\"hademir10josept@gmail.com\"}}}','2026-06-17 11:01:25','2026-06-17 11:01:25'),
(126,4,'students','created','Creo alumno: ANDERSON PAUL BENAVIDES SIGUEÑAS','App\\Models\\Student',40,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:08:25','2026-06-17 11:08:25'),
(127,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":38,\"after\":39}}}','2026-06-17 11:08:25','2026-06-17 11:08:25'),
(128,3,'students','created','Creo alumno: NATSUSHI MILIAN RODRIGUEZ','App\\Models\\Student',41,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:14:42','2026-06-17 11:14:42'),
(129,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":39,\"after\":40}}}','2026-06-17 11:14:42','2026-06-17 11:14:42'),
(130,4,'students','created','Creo alumno: ANA VALENTINA APOLO GONZALES','App\\Models\\Student',42,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:16:23','2026-06-17 11:16:23'),
(131,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":40,\"after\":41}}}','2026-06-17 11:16:23','2026-06-17 11:16:23'),
(132,3,'students','created','Creo alumno: MARIA JULIA GONZALES REQUEJO','App\\Models\\Student',43,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:19:27','2026-06-17 11:19:27'),
(133,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":41,\"after\":42}}}','2026-06-17 11:19:27','2026-06-17 11:19:27'),
(134,4,'students','created','Creo alumno: JANY LUANY SALSAÑA LEYVA','App\\Models\\Student',44,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:21:41','2026-06-17 11:21:41'),
(135,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":42,\"after\":43}}}','2026-06-17 11:21:41','2026-06-17 11:21:41'),
(136,4,'students','updated','Actualizo alumno: JANY LUANY SALDAÑA LEYVA','App\\Models\\Student',44,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"last_name\":{\"before\":\"SALSA\\u00d1A\",\"after\":\"SALDA\\u00d1A\"}}}','2026-06-17 11:25:16','2026-06-17 11:25:16'),
(137,3,'students','created','Creo alumno: DANAE TAMARA PAISIC DE LOS SANTOS','App\\Models\\Student',45,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:28:11','2026-06-17 11:28:11'),
(138,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":43,\"after\":44}}}','2026-06-17 11:28:11','2026-06-17 11:28:11'),
(139,4,'students','created','Creo alumno: SILVIA MARICRISTI GONZALES GONZALES','App\\Models\\Student',46,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:32:25','2026-06-17 11:32:25'),
(140,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":44,\"after\":45}}}','2026-06-17 11:32:25','2026-06-17 11:32:25'),
(141,3,'students','created','Creo alumno: ANAMILET LUCIA MACO CESPEDES','App\\Models\\Student',47,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:33:46','2026-06-17 11:33:46'),
(142,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":45,\"after\":46}}}','2026-06-17 11:33:46','2026-06-17 11:33:46'),
(143,4,'students','created','Creo alumno: DARIKSON STEVE LOZADA SOPLAPUCO','App\\Models\\Student',48,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:40:05','2026-06-17 11:40:05'),
(144,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":46,\"after\":47}}}','2026-06-17 11:40:05','2026-06-17 11:40:05'),
(145,3,'students','created','Creo alumno: EDINSON ALDAIR CARRASCO MORE','App\\Models\\Student',49,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:40:40','2026-06-17 11:40:40'),
(146,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":47,\"after\":48}}}','2026-06-17 11:40:40','2026-06-17 11:40:40'),
(147,4,'students','created','Creo alumno: CATHERINE ROUSSE PERLECHE VEGA','App\\Models\\Student',50,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:46:24','2026-06-17 11:46:24'),
(148,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":48,\"after\":49}}}','2026-06-17 11:46:24','2026-06-17 11:46:24'),
(149,3,'students','created','Creo alumno: PIERO GERMAN MANAY CAMPOS','App\\Models\\Student',51,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:47:06','2026-06-17 11:47:06'),
(150,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":49,\"after\":50}}}','2026-06-17 11:47:06','2026-06-17 11:47:06'),
(151,4,'students','updated','Actualizo alumno: CATHERINE ROUSSE PERLECHE VEGA','App\\Models\\Student',50,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"email\":{\"before\":\"catherinep2019@gmail.com\",\"after\":\"ecatherinep2019@gmail.com\"}}}','2026-06-17 11:47:24','2026-06-17 11:47:24'),
(152,4,'students','created','Creo alumno: RIHANNA FABIANA GUERRERO SILVA','App\\Models\\Student',52,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 11:52:32','2026-06-17 11:52:32'),
(153,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":50,\"after\":51}}}','2026-06-17 11:52:32','2026-06-17 11:52:32'),
(154,3,'students','created','Creo alumno: GLORIA SARAHI YAMUNAQUE INOÑAN','App\\Models\\Student',53,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 11:53:22','2026-06-17 11:53:22'),
(155,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":51,\"after\":52}}}','2026-06-17 11:53:22','2026-06-17 11:53:22'),
(156,4,'students','updated','Actualizo alumno: RIHANNA FABIANA GUERRERO SILVA','App\\Models\\Student',52,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"address\":{\"before\":\"PROLONGACION AV UNION, LA VICTORIA, CHICLAYO, LAMBAYEQUE\",\"after\":\"CALLE CACTUS 156, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-17 11:53:38','2026-06-17 11:53:38'),
(157,3,'students','created','Creo alumno: ISAEL YAJAHUANCA CONTRERAS','App\\Models\\Student',54,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 12:00:27','2026-06-17 12:00:27'),
(158,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":52,\"after\":53}}}','2026-06-17 12:00:27','2026-06-17 12:00:27'),
(159,4,'students','created','Creo alumno: DAIANA NAYELI ITURRIA SHOWING','App\\Models\\Student',55,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 12:01:12','2026-06-17 12:01:12'),
(160,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":53,\"after\":54}}}','2026-06-17 12:01:12','2026-06-17 12:01:12'),
(161,4,'students','created','Creo alumno: JESUS FERNANDO MONTENEGRO MALCA','App\\Models\\Student',56,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 12:08:59','2026-06-17 12:08:59'),
(162,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":54,\"after\":55}}}','2026-06-17 12:08:59','2026-06-17 12:08:59'),
(163,4,'students','updated','Actualizo alumno: JESUS FERNANDO MONTENEGRO MALCA','App\\Models\\Student',56,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"birth_date\":{\"before\":\"2004-06-07T05:00:00.000000Z\",\"after\":\"2004-05-07 00:00:00\"}}}','2026-06-17 12:09:40','2026-06-17 12:09:40'),
(164,3,'students','created','Creo alumno: DIEGO ENRIQUE LOPEZ ROSALES','App\\Models\\Student',57,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 12:11:11','2026-06-17 12:11:11'),
(165,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":55,\"after\":56}}}','2026-06-17 12:11:11','2026-06-17 12:11:11'),
(166,3,'students','created','Creo alumno: JOSE LUIS RODRIGUEZ YOVERA','App\\Models\\Student',58,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 12:34:48','2026-06-17 12:34:48'),
(167,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":56,\"after\":57}}}','2026-06-17 12:34:48','2026-06-17 12:34:48'),
(168,4,'students','created','Creo alumno: MIA MELISA OTAZU PEZO','App\\Models\\Student',59,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 12:40:04','2026-06-17 12:40:04'),
(169,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":57,\"after\":58}}}','2026-06-17 12:40:04','2026-06-17 12:40:04'),
(170,3,'students','created','Creo alumno: JHENIFFER SELENNE KISIMOTO RISCO','App\\Models\\Student',60,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 13:39:59','2026-06-17 13:39:59'),
(171,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":58,\"after\":59}}}','2026-06-17 13:39:59','2026-06-17 13:39:59'),
(172,4,'students','created','Creo alumno: DOMENIKA ANAIS OROZCO MACO','App\\Models\\Student',61,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 13:45:01','2026-06-17 13:45:01'),
(173,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":59,\"after\":60}}}','2026-06-17 13:45:01','2026-06-17 13:45:01'),
(174,3,'students','created','Creo alumno: LUIS ALFREDO LLONTOP JIBAJA','App\\Models\\Student',62,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 13:46:33','2026-06-17 13:46:33'),
(175,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":60,\"after\":61}}}','2026-06-17 13:46:33','2026-06-17 13:46:33'),
(176,3,'students','created','Creo alumno: MICHELL XIN LING FERNANDEZ TAY','App\\Models\\Student',63,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 14:20:53','2026-06-17 14:20:53'),
(177,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":61,\"after\":62}}}','2026-06-17 14:20:53','2026-06-17 14:20:53'),
(178,4,'students','created','Creo alumno: DAMARIS XIMENA LLOCYA PAISIG','App\\Models\\Student',64,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 14:23:20','2026-06-17 14:23:20'),
(179,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":62,\"after\":63}}}','2026-06-17 14:23:20','2026-06-17 14:23:20'),
(180,3,'students','created','Creo alumno: YURIANA ABIGAIL PLASENCIO LOPEZ','App\\Models\\Student',65,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 14:30:30','2026-06-17 14:30:30'),
(181,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":63,\"after\":64}}}','2026-06-17 14:30:30','2026-06-17 14:30:30'),
(182,3,'students','updated','Actualizo alumno: YURIANA ABIGAIL PLASENCIO LOPEZ','App\\Models\\Student',65,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"yuriana_lch@gmail.com\",\"after\":\"yurilopezchavez1@gmail.com\"}}}','2026-06-17 14:32:52','2026-06-17 14:32:52'),
(183,3,'students','created','Creo alumno: ERIKA JASMIN COTRINA PEREZ','App\\Models\\Student',66,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 14:53:37','2026-06-17 14:53:37'),
(184,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":64,\"after\":65}}}','2026-06-17 14:53:37','2026-06-17 14:53:37'),
(185,4,'students','created','Creo alumno: MELANIA SAYURI RENTERIA VIDAL','App\\Models\\Student',67,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":null}','2026-06-17 14:55:20','2026-06-17 14:55:20'),
(186,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0','{\"changed\":{\"enrolled\":{\"before\":65,\"after\":66}}}','2026-06-17 14:55:20','2026-06-17 14:55:20'),
(187,3,'students','created','Creo alumno: NATALIA ELIZABETH CAMPOVERDE PARIATON','App\\Models\\Student',68,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 15:00:51','2026-06-17 15:00:51'),
(188,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.26','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":66,\"after\":67}}}','2026-06-17 15:00:51','2026-06-17 15:00:51'),
(189,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 18:41:41','2026-06-17 18:41:41'),
(190,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"academic_group\",\"payment_voucher_number\",\"payment_date\"]}','2026-06-17 18:44:44','2026-06-17 18:44:44'),
(191,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"academic_group\",\"shift\",\"registration_date\",\"status\"]}','2026-06-17 20:26:58','2026-06-17 20:26:58'),
(192,2,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0',NULL,'2026-06-17 20:29:31','2026-06-17 20:29:31'),
(193,1,'staff','created','Creo empleado: RODOLFO TINEO','App\\Models\\Staff',5,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-17 20:35:46','2026-06-17 20:35:46'),
(194,1,'roles_permissions','updated','Actualizó permisos del rol: Asistente','App\\Models\\Role',4,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"status\":{\"before\":true,\"after\":true},\"role_permissions\":{\"before\":null,\"after\":{\"Agregados\":[],\"Quitados\":[\"Importar notas academicas\",\"Ver m\\u00f3dulo acad\\u00e9mico\",\"Registrar alumnos\",\"Editar alumnos\"]}}}}','2026-06-17 20:36:41','2026-06-17 20:36:41'),
(195,2,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0',NULL,'2026-06-17 20:37:04','2026-06-17 20:37:04'),
(196,5,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0',NULL,'2026-06-17 20:37:19','2026-06-17 20:37:19'),
(197,1,'roles_permissions','updated','Actualizó permisos del rol: Asistente','App\\Models\\Role',4,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"status\":{\"before\":true,\"after\":true},\"role_permissions\":{\"before\":null,\"after\":{\"Agregados\":[\"Exportar reporte de notas\",\"Ver reporte de notas\",\"Exportar correos de alumnos\",\"Exportar todos los reportes administrativos\",\"Exportar reporte de alumnos\",\"Exportar reporte de alumnos por grupo\",\"Exportar reporte de tesoreria\",\"Ver reportes administrativos\"],\"Quitados\":[]}}}}','2026-06-17 20:38:09','2026-06-17 20:38:09'),
(198,1,'roles_permissions','updated','Actualizó permisos del rol: Asistente','App\\Models\\Role',4,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"status\":{\"before\":true,\"after\":true},\"role_permissions\":{\"before\":null,\"after\":{\"Agregados\":[\"Descargar documentos de alumnos\"],\"Quitados\":[]}}}}','2026-06-17 20:38:21','2026-06-17 20:38:21'),
(199,5,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-17 20:39:32','2026-06-17 20:39:32'),
(200,5,'reports','download_pdf','Genero PDF de reporte de tesoreria.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0','{\"career_id\":null,\"academic_cycle_id\":null,\"shift_id\":null,\"student_search\":null}','2026-06-17 20:39:51','2026-06-17 20:39:51'),
(201,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 20:45:02','2026-06-17 20:45:02'),
(202,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-17 21:02:30','2026-06-17 21:02:30'),
(203,5,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0',NULL,'2026-06-17 21:37:56','2026-06-17 21:37:56'),
(204,2,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 04:41:18','2026-06-18 04:41:18'),
(205,2,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 04:42:47','2026-06-18 04:42:47'),
(206,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 04:43:11','2026-06-18 04:43:11'),
(207,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-18 04:43:16','2026-06-18 04:43:16'),
(208,1,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"guerrerofloresthani66@gmail.com\",\"after\":\"elberjesus09@gmail.com\"}}}','2026-06-18 04:45:55','2026-06-18 04:45:55'),
(209,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"registration_confirmation_message\":{\"before\":null,\"after\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\"},\"registration_mail_enabled\":{\"before\":false,\"after\":true},\"registration_mail_attach_enrollment_form\":{\"before\":true,\"after\":false}}}','2026-06-18 04:47:03','2026-06-18 04:47:03'),
(210,1,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 04:47:23\"}}}','2026-06-18 04:47:23','2026-06-18 04:47:23'),
(211,1,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"elberjesus09@gmail.com\",\"after\":\"guerrerofloresthani66@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-18T09:47:23.000000Z\",\"after\":null}}}','2026-06-18 04:48:41','2026-06-18 04:48:41'),
(212,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-18 04:48:56','2026-06-18 04:48:56'),
(213,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":\"law_social\",\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-18 04:57:13','2026-06-18 04:57:13'),
(214,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":\"law_social\",\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-18 04:57:16','2026-06-18 04:57:16'),
(215,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"institutional_message\":{\"before\":null,\"after\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\"},\"registration_confirmation_message\":{\"before\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\",\"after\":null}}}','2026-06-18 05:14:13','2026-06-18 05:14:13'),
(216,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 05:14:45','2026-06-18 05:14:45'),
(217,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 05:21:20','2026-06-18 05:21:20'),
(218,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-18 05:21:27','2026-06-18 05:21:27'),
(219,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 06:59:52','2026-06-18 06:59:52'),
(220,1,'reports','download_txt','Genero TXT de correos de alumnos.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null}','2026-06-18 07:00:02','2026-06-18 07:00:02'),
(221,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:01:02','2026-06-18 07:01:02'),
(222,2,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:11:48','2026-06-18 07:11:48'),
(223,2,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"guerrerofloresthani66@gmail.com\",\"after\":\"o3971312@gmail.com\"}}}','2026-06-18 07:13:05','2026-06-18 07:13:05'),
(224,2,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 07:14:07\"}}}','2026-06-18 07:14:07','2026-06-18 07:14:07'),
(225,2,'students','updated','Actualizo alumno: THANI ARIADNE GUERRERO FLORES','App\\Models\\Student',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"o3971312@gmail.com\",\"after\":\"guerrerofloresthani66@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-18T12:14:07.000000Z\",\"after\":null}}}','2026-06-18 07:15:43','2026-06-18 07:15:43'),
(226,2,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:31:24','2026-06-18 07:31:24'),
(227,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:55:11','2026-06-18 07:55:11'),
(228,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"institutional_message\":{\"before\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\",\"after\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\\r\\nEnviar al Correo : soporteinformatico_cpu@unprg.edu.pe\"}}}','2026-06-18 07:56:01','2026-06-18 07:56:01'),
(229,1,'exam_settings','updated','Actualizo comunicados: ID 1','App\\Models\\ExamSetting',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"institutional_message\":{\"before\":\"Especificaciones para la foto del carnet\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\\r\\nEnviar al Correo : soporteinformatico_cpu@unprg.edu.pe\",\"after\":\"Especificaciones para la foto del carnet\\r\\n\\r\\nFoto tama\\u00f1o pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\\r\\nFormato JPG.\\r\\nFondo blanco.\\r\\nEl alumno debe mirar directamente a la c\\u00e1mara, con expresi\\u00f3n neutral y ojos abiertos.\\r\\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\\r\\nNo se aceptan selfies.\\r\\nNo se aceptan fotos tomadas a una foto impresa.\\r\\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\\r\\nSe rechazar\\u00e1 toda foto que no cumpla con estas especificaciones\\r\\nEnviar al Correo : soporteinformatico_cpu@unprg.edu.pe\"}}}','2026-06-18 07:56:11','2026-06-18 07:56:11'),
(230,1,'staff','created','Creo empleado: ANA BARON','App\\Models\\Staff',6,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 07:58:17','2026-06-18 07:58:17'),
(231,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:58:21','2026-06-18 07:58:21'),
(232,6,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:58:32','2026-06-18 07:58:32'),
(233,6,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:58:55','2026-06-18 07:58:55'),
(234,3,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 07:59:25','2026-06-18 07:59:25'),
(235,4,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0',NULL,'2026-06-18 08:01:34','2026-06-18 08:01:34'),
(236,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 08:06:46','2026-06-18 08:06:46'),
(237,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 08:06:56','2026-06-18 08:06:56'),
(238,6,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-18 08:07:01','2026-06-18 08:07:01'),
(239,3,'students','created','Creo alumno: FABIANA ALEXANDRA JULCA ROMERO','App\\Models\\Student',69,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:11:14','2026-06-18 08:11:14'),
(240,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":67,\"after\":68}}}','2026-06-18 08:11:14','2026-06-18 08:11:14'),
(241,4,'students','created','Creo alumno: RODRIGO ALBERTO RAMOS SANDOVAL','App\\Models\\Student',70,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:13:16','2026-06-18 08:13:16'),
(242,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":68,\"after\":69}}}','2026-06-18 08:13:16','2026-06-18 08:13:16'),
(243,4,'students','updated','Actualizo alumno: RODRIGO ALBERTO RAMOS SANDOVAL','App\\Models\\Student',70,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:14:14\"}}}','2026-06-18 08:14:14','2026-06-18 08:14:14'),
(244,4,'students','updated','Actualizo alumno: RODRIGO ALBERTO RAMOS SANDOVAL','App\\Models\\Student',70,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email\":{\"before\":\"rodrigoramos9171@gamil.com\",\"after\":\"rodrigoramos9171@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-18T13:14:14.000000Z\",\"after\":null}}}','2026-06-18 08:15:38','2026-06-18 08:15:38'),
(245,4,'students','updated','Actualizo alumno: RODRIGO ALBERTO RAMOS SANDOVAL','App\\Models\\Student',70,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:15:52\"}}}','2026-06-18 08:15:52','2026-06-18 08:15:52'),
(246,3,'students','created','Creo alumno: EMANUEL JESUS OBLITAS RODRIGUEZ','App\\Models\\Student',71,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:19:45','2026-06-18 08:19:45'),
(247,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":69,\"after\":70}}}','2026-06-18 08:19:45','2026-06-18 08:19:45'),
(248,3,'students','updated','Actualizo alumno: FABIANA ALEXANDRA JULCA ROMERO','App\\Models\\Student',69,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:20:00\"}}}','2026-06-18 08:20:00','2026-06-18 08:20:00'),
(249,3,'students','updated','Actualizo alumno: EMANUEL JESUS OBLITAS RODRIGUEZ','App\\Models\\Student',71,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:20:31\"}}}','2026-06-18 08:20:31','2026-06-18 08:20:31'),
(250,4,'students','created','Creo alumno: ANTONIO FRANZ TINEO DIAZ','App\\Models\\Student',72,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:21:53','2026-06-18 08:21:53'),
(251,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":70,\"after\":71}}}','2026-06-18 08:21:53','2026-06-18 08:21:53'),
(252,4,'students','updated','Actualizo alumno: ANTONIO FRANZ TINEO DIAZ','App\\Models\\Student',72,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:22:42\"}}}','2026-06-18 08:22:42','2026-06-18 08:22:42'),
(253,3,'students','created','Creo alumno: SNAIDER DE JESUS NUÑEZ HORNA','App\\Models\\Student',73,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:27:10','2026-06-18 08:27:10'),
(254,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":71,\"after\":72}}}','2026-06-18 08:27:10','2026-06-18 08:27:10'),
(255,4,'students','created','Creo alumno: MARCO SEBASTIAN SANTIN ROJAS','App\\Models\\Student',74,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:27:19','2026-06-18 08:27:19'),
(256,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":72,\"after\":73}}}','2026-06-18 08:27:19','2026-06-18 08:27:19'),
(257,3,'students','updated','Actualizo alumno: SNAIDER DE JESUS NUÑEZ HORNA','App\\Models\\Student',73,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:27:21\"}}}','2026-06-18 08:27:21','2026-06-18 08:27:21'),
(258,4,'students','updated','Actualizo alumno: MARCO SEBASTIAN SANTIN ROJAS','App\\Models\\Student',74,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:28:13\"}}}','2026-06-18 08:28:13','2026-06-18 08:28:13'),
(259,3,'students','created','Creo alumno: GRACIELA SANTAMARIA ALAMO','App\\Models\\Student',75,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:34:19','2026-06-18 08:34:19'),
(260,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":73,\"after\":74}}}','2026-06-18 08:34:19','2026-06-18 08:34:19'),
(261,3,'students','updated','Actualizo alumno: GRACIELA SANTAMARIA ALAMO','App\\Models\\Student',75,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:34:30\"}}}','2026-06-18 08:34:30','2026-06-18 08:34:30'),
(262,4,'students','created','Creo alumno: JENY JARITZA ZEÑA PANTALEON','App\\Models\\Student',76,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:39:03','2026-06-18 08:39:03'),
(263,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":74,\"after\":75}}}','2026-06-18 08:39:03','2026-06-18 08:39:03'),
(264,4,'students','updated','Actualizo alumno: JENY JARITZA ZEÑA PANTALEON','App\\Models\\Student',76,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:40:06\"}}}','2026-06-18 08:40:06','2026-06-18 08:40:06'),
(265,3,'students','created','Creo alumno: CRISTIAN KELVIN BECERRA HERRERA','App\\Models\\Student',77,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:45:30','2026-06-18 08:45:30'),
(266,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":75,\"after\":76}}}','2026-06-18 08:45:30','2026-06-18 08:45:30'),
(267,3,'students','updated','Actualizo alumno: CRISTIAN KELVIN BECERRA HERRERA','App\\Models\\Student',77,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:45:40\"}}}','2026-06-18 08:45:40','2026-06-18 08:45:40'),
(268,4,'students','created','Creo alumno: CESAR RICARDO GONZALES VENEGAS','App\\Models\\Student',78,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:46:12','2026-06-18 08:46:12'),
(269,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":76,\"after\":77}}}','2026-06-18 08:46:12','2026-06-18 08:46:12'),
(270,4,'students','updated','Actualizo alumno: CESAR RICARDO GONZALES VENEGAS','App\\Models\\Student',78,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:46:52\"}}}','2026-06-18 08:46:52','2026-06-18 08:46:52'),
(271,3,'students','created','Creo alumno: BIANKA ELIZABETH PERALTA SUCLUPE','App\\Models\\Student',79,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 08:52:29','2026-06-18 08:52:29'),
(272,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":77,\"after\":78}}}','2026-06-18 08:52:29','2026-06-18 08:52:29'),
(273,3,'students','updated','Actualizo alumno: BIANKA ELIZABETH PERALTA SUCLUPE','App\\Models\\Student',79,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:52:43\"}}}','2026-06-18 08:52:43','2026-06-18 08:52:43'),
(274,4,'students','created','Creo alumno: LUCIANA NICOLLE CELIS FERNANDEZ','App\\Models\\Student',80,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 08:55:28','2026-06-18 08:55:28'),
(275,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":78,\"after\":79}}}','2026-06-18 08:55:28','2026-06-18 08:55:28'),
(276,4,'students','updated','Actualizo alumno: LUCIANA NICOLLE CELIS FERNANDEZ','App\\Models\\Student',80,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 08:56:28\"}}}','2026-06-18 08:56:28','2026-06-18 08:56:28'),
(277,3,'students','created','Creo alumno: MARYCIELO CACHAY DELGADO','App\\Models\\Student',81,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 09:08:00','2026-06-18 09:08:00'),
(278,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":79,\"after\":80}}}','2026-06-18 09:08:00','2026-06-18 09:08:00'),
(279,3,'students','updated','Actualizo alumno: MARYCIELO CACHAY DELGADO','App\\Models\\Student',81,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 09:08:14\"}}}','2026-06-18 09:08:14','2026-06-18 09:08:14'),
(280,4,'students','created','Creo alumno: KIARA BRIGGITT BERMEO MILIAN','App\\Models\\Student',82,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 09:36:58','2026-06-18 09:36:58'),
(281,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":80,\"after\":81}}}','2026-06-18 09:36:58','2026-06-18 09:36:58'),
(282,3,'students','created','Creo alumno: NICOLL SILVA RUBIO','App\\Models\\Student',83,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 09:37:44','2026-06-18 09:37:44'),
(283,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":81,\"after\":82}}}','2026-06-18 09:37:44','2026-06-18 09:37:44'),
(284,3,'students','updated','Actualizo alumno: NICOLL SILVA RUBIO','App\\Models\\Student',83,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 09:38:00\"}}}','2026-06-18 09:38:00','2026-06-18 09:38:00'),
(285,4,'students','updated','Actualizo alumno: KIARA BRIGGITT BERMEO MILIAN','App\\Models\\Student',82,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 09:38:07\"}}}','2026-06-18 09:38:07','2026-06-18 09:38:07'),
(286,4,'students','created','Creo alumno: JUAN RICARDO ESTELA COBEÑAS','App\\Models\\Student',84,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 09:42:37','2026-06-18 09:42:37'),
(287,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":82,\"after\":83}}}','2026-06-18 09:42:37','2026-06-18 09:42:37'),
(288,4,'students','updated','Actualizo alumno: JUAN RICARDO ESTELA COBEÑAS','App\\Models\\Student',84,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 09:43:47\"}}}','2026-06-18 09:43:47','2026-06-18 09:43:47'),
(289,3,'students','created','Creo alumno: LIZBETH CAROLINA GARCIA LINARES','App\\Models\\Student',85,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 09:46:02','2026-06-18 09:46:02'),
(290,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":83,\"after\":84}}}','2026-06-18 09:46:02','2026-06-18 09:46:02'),
(291,3,'students','updated','Actualizo alumno: LIZBETH CAROLINA GARCIA LINARES','App\\Models\\Student',85,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 09:46:14\"}}}','2026-06-18 09:46:14','2026-06-18 09:46:14'),
(292,3,'students','created','Creo alumno: PAULO JAVIER RAMIREZ CASTAÑEDA','App\\Models\\Student',86,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 10:03:17','2026-06-18 10:03:17'),
(293,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":84,\"after\":85}}}','2026-06-18 10:03:17','2026-06-18 10:03:17'),
(294,3,'students','updated','Actualizo alumno: PAULO JAVIER RAMIREZ CASTAÑEDA','App\\Models\\Student',86,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:03:39\"}}}','2026-06-18 10:03:39','2026-06-18 10:03:39'),
(295,3,'students','created','Creo alumno: KEYKO JASMIN TAPIA FLORES','App\\Models\\Student',87,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 10:11:51','2026-06-18 10:11:51'),
(296,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":85,\"after\":86}}}','2026-06-18 10:11:51','2026-06-18 10:11:51'),
(297,3,'students','updated','Actualizo alumno: KEYKO JASMIN TAPIA FLORES','App\\Models\\Student',87,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:12:00\"}}}','2026-06-18 10:12:00','2026-06-18 10:12:00'),
(298,3,'students','updated','Actualizo alumno: KEYKO JASMIN TAPIA FLORES','App\\Models\\Student',87,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"tapiakeyko10@gmail.com\",\"after\":\"florenciafloresordonez@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-18T15:12:00.000000Z\",\"after\":null}}}','2026-06-18 10:14:39','2026-06-18 10:14:39'),
(299,3,'students','updated','Actualizo alumno: KEYKO JASMIN TAPIA FLORES','App\\Models\\Student',87,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:14:49\"}}}','2026-06-18 10:14:49','2026-06-18 10:14:49'),
(300,3,'students','created','Creo alumno: MARIA ELIZABETH FLORES SIGNOL','App\\Models\\Student',88,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 10:37:51','2026-06-18 10:37:51'),
(301,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":86,\"after\":87}}}','2026-06-18 10:37:51','2026-06-18 10:37:51'),
(302,3,'students','updated','Actualizo alumno: MARIA ELIZABETH FLORES SIGNOL','App\\Models\\Student',88,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:38:13\"}}}','2026-06-18 10:38:13','2026-06-18 10:38:13'),
(303,4,'students','created','Creo alumno: AMMY GISEL REQUEJO ESTEVES','App\\Models\\Student',89,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 10:39:42','2026-06-18 10:39:42'),
(304,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":87,\"after\":88}}}','2026-06-18 10:39:42','2026-06-18 10:39:42'),
(305,4,'students','updated','Actualizo alumno: AMMY GISEL REQUEJO ESTEVES','App\\Models\\Student',89,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email\":{\"before\":\"ammyrequejoestevez102@gmail.com\",\"after\":\"ammyrequejoesteves102@gmail.com\"}}}','2026-06-18 10:40:46','2026-06-18 10:40:46'),
(306,4,'students','updated','Actualizo alumno: AMMY GISEL REQUEJO ESTEVES','App\\Models\\Student',89,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:41:08\"}}}','2026-06-18 10:41:08','2026-06-18 10:41:08'),
(307,3,'students','created','Creo alumno: DANIELA ABIGAIL JIMENEZ THURKOWLSKY','App\\Models\\Student',90,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 10:45:58','2026-06-18 10:45:58'),
(308,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":88,\"after\":89}}}','2026-06-18 10:45:58','2026-06-18 10:45:58'),
(309,3,'students','updated','Actualizo alumno: DANIELA ABIGAIL JIMENEZ THURKOWLSKY','App\\Models\\Student',90,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 10:46:11\"}}}','2026-06-18 10:46:11','2026-06-18 10:46:11'),
(310,3,'students','created','Creo alumno: FLAVIA JAHAIRA SERRANO QUEVEDO','App\\Models\\Student',91,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 11:13:53','2026-06-18 11:13:53'),
(311,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":89,\"after\":90}}}','2026-06-18 11:13:53','2026-06-18 11:13:53'),
(312,3,'students','updated','Actualizo alumno: FLAVIA JAHAIRA SERRANO QUEVEDO','App\\Models\\Student',91,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:14:19\"}}}','2026-06-18 11:14:19','2026-06-18 11:14:19'),
(313,4,'students','created','Creo alumno: LIDIA DEL CARMEN DE LA CRUZ PRADA','App\\Models\\Student',92,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 11:17:47','2026-06-18 11:17:47'),
(314,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":90,\"after\":91}}}','2026-06-18 11:17:47','2026-06-18 11:17:47'),
(315,4,'students','updated','Actualizo alumno: LIDIA DEL CARMEN DE LA CRUZ PRADA','App\\Models\\Student',92,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:18:39\"}}}','2026-06-18 11:18:39','2026-06-18 11:18:39'),
(316,3,'students','created','Creo alumno: MARYORY DAYANA TEQUEN PUESCAS','App\\Models\\Student',93,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 11:44:17','2026-06-18 11:44:17'),
(317,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":91,\"after\":92}}}','2026-06-18 11:44:17','2026-06-18 11:44:17'),
(318,3,'students','updated','Actualizo alumno: MARYORY DAYANA TEQUEN PUESCAS','App\\Models\\Student',93,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:44:27\"}}}','2026-06-18 11:44:27','2026-06-18 11:44:27'),
(319,4,'students','created','Creo alumno: PIERO SILVA SEGURA','App\\Models\\Student',94,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 11:44:35','2026-06-18 11:44:35'),
(320,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":92,\"after\":93}}}','2026-06-18 11:44:35','2026-06-18 11:44:35'),
(321,4,'students','updated','Actualizo alumno: PIERO SILVA SEGURA','App\\Models\\Student',94,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:45:12\"}}}','2026-06-18 11:45:12','2026-06-18 11:45:12'),
(322,4,'students','created','Creo alumno: MARIA DE LOURDES CAMPOS VALENCIA','App\\Models\\Student',95,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 11:48:50','2026-06-18 11:48:50'),
(323,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":93,\"after\":94}}}','2026-06-18 11:48:50','2026-06-18 11:48:50'),
(324,4,'students','updated','Actualizo alumno: MARIA DE LOURDES CAMPOS VALENCIA','App\\Models\\Student',95,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email\":{\"before\":\"mariacampos01@gmail.com\",\"after\":\"camposvalenciamaria01@gmail.com\"}}}','2026-06-18 11:49:52','2026-06-18 11:49:52'),
(325,4,'students','updated','Actualizo alumno: MARIA DE LOURDES CAMPOS VALENCIA','App\\Models\\Student',95,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:50:37\"}}}','2026-06-18 11:50:37','2026-06-18 11:50:37'),
(326,3,'students','updated','Actualizo alumno: MARYORY DAYANA TEQUEN PUESCAS','App\\Models\\Student',93,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"tequenmaryory5@gmail.com\",\"after\":\"pascualtequendelgado@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-18T16:44:27.000000Z\",\"after\":null}}}','2026-06-18 11:51:22','2026-06-18 11:51:22'),
(327,3,'students','updated','Actualizo alumno: MARYORY DAYANA TEQUEN PUESCAS','App\\Models\\Student',93,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:51:36\"}}}','2026-06-18 11:51:36','2026-06-18 11:51:36'),
(328,4,'students','created','Creo alumno: MARCO ANTONIO MARTINEZ MACALOPU','App\\Models\\Student',96,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 11:53:57','2026-06-18 11:53:57'),
(329,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":94,\"after\":95}}}','2026-06-18 11:53:57','2026-06-18 11:53:57'),
(330,4,'students','updated','Actualizo alumno: MARCO ANTONIO MARTINEZ MACALOPU','App\\Models\\Student',96,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:54:30\"}}}','2026-06-18 11:54:30','2026-06-18 11:54:30'),
(331,3,'students','created','Creo alumno: LUIS MIGUEL ECHIVERRE SAYAGO','App\\Models\\Student',97,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 11:56:30','2026-06-18 11:56:30'),
(332,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":95,\"after\":96}}}','2026-06-18 11:56:30','2026-06-18 11:56:30'),
(333,3,'students','updated','Actualizo alumno: LUIS MIGUEL ECHIVERRE SAYAGO','App\\Models\\Student',97,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 11:56:39\"}}}','2026-06-18 11:56:39','2026-06-18 11:56:39'),
(334,4,'students','created','Creo alumno: ANDER YERMI TOCTO RACHO','App\\Models\\Student',98,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 11:59:49','2026-06-18 11:59:49'),
(335,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":96,\"after\":97}}}','2026-06-18 11:59:49','2026-06-18 11:59:49'),
(336,4,'students','updated','Actualizo alumno: ANDER YERMI TOCTO RACHO','App\\Models\\Student',98,'190.236.30.136','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 12:00:30\"}}}','2026-06-18 12:00:30','2026-06-18 12:00:30'),
(337,3,'students','created','Creo alumno: JAIRO YAMIL INCIO CARRASCO','App\\Models\\Student',99,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 12:03:50','2026-06-18 12:03:50'),
(338,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":97,\"after\":98}}}','2026-06-18 12:03:50','2026-06-18 12:03:50'),
(339,3,'students','updated','Actualizo alumno: JAIRO YAMIL INCIO CARRASCO','App\\Models\\Student',99,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 12:04:00\"}}}','2026-06-18 12:04:00','2026-06-18 12:04:00'),
(340,4,'students','created','Creo alumno: MATEO SEBASTIAN RODAS ALCANTARA','App\\Models\\Student',100,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:04:55','2026-06-18 13:04:55'),
(341,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":98,\"after\":99}}}','2026-06-18 13:04:55','2026-06-18 13:04:55'),
(342,4,'students','updated','Actualizo alumno: MATEO SEBASTIAN RODAS ALCANTARA','App\\Models\\Student',100,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:05:31\"}}}','2026-06-18 13:05:31','2026-06-18 13:05:31'),
(343,3,'students','created','Creo alumno: CARLOS RENATO ARRIAGA ANGELES','App\\Models\\Student',101,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:05:45','2026-06-18 13:05:45'),
(344,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":99,\"after\":100}}}','2026-06-18 13:05:45','2026-06-18 13:05:45'),
(345,3,'students','updated','Actualizo alumno: CARLOS RENATO ARRIAGA ANGELES','App\\Models\\Student',101,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:05:55\"}}}','2026-06-18 13:05:55','2026-06-18 13:05:55'),
(346,4,'students','created','Creo alumno: JOSE RENZO ÑIQUEN NECIOSUP','App\\Models\\Student',102,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:10:15','2026-06-18 13:10:15'),
(347,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":100,\"after\":101}}}','2026-06-18 13:10:15','2026-06-18 13:10:15'),
(348,4,'students','updated','Actualizo alumno: JOSE RENZO ÑIQUEN NECIOSUP','App\\Models\\Student',102,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"address\":{\"before\":\"AV BLOIVAR 901, ETEN, CHICLAYO, LAMBAYEQUE\",\"after\":\"CALLE CHICLAYO 202, ETEN, CHICLAYO, LAMBAYEQUE\"},\"email\":{\"before\":\"joserenzoniqueneciosup@gmail.com\",\"after\":\"joserenzoniquenneciosup@gmail.com\"}}}','2026-06-18 13:12:05','2026-06-18 13:12:05'),
(349,4,'students','updated','Actualizo alumno: JOSE RENZO ÑIQUEN NECIOSUP','App\\Models\\Student',102,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:12:29\"}}}','2026-06-18 13:12:29','2026-06-18 13:12:29'),
(350,3,'students','created','Creo alumno: KYARA YAMILET GIRON CHAVEZ','App\\Models\\Student',103,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:14:56','2026-06-18 13:14:56'),
(351,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":101,\"after\":102}}}','2026-06-18 13:14:56','2026-06-18 13:14:56'),
(352,3,'students','updated','Actualizo alumno: KYARA YAMILET GIRON CHAVEZ','App\\Models\\Student',103,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:15:07\"}}}','2026-06-18 13:15:07','2026-06-18 13:15:07'),
(353,3,'students','updated','Actualizo alumno: KYARA YAMILET GIRON CHAVEZ','App\\Models\\Student',103,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:15:11\"}}}','2026-06-18 13:15:11','2026-06-18 13:15:11'),
(354,4,'students','created','Creo alumno: ADRIANA TICLIAHUANCA TUESTA','App\\Models\\Student',104,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:19:58','2026-06-18 13:19:58'),
(355,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":102,\"after\":103}}}','2026-06-18 13:19:58','2026-06-18 13:19:58'),
(356,4,'students','updated','Actualizo alumno: ADRIANA TICLIAHUANCA TUESTA','App\\Models\\Student',104,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"address\":{\"before\":\"CALLE LOS GUABOS 290, CHICLAYO, CHICLAYO, LAMBAYEQUE\",\"after\":\"CALLE LOS GUABOS 290 DPTO 4 INT 401, CHICLAYO, CHICLAYO, LAMBAYEQUE\"}}}','2026-06-18 13:21:30','2026-06-18 13:21:30'),
(357,4,'students','updated','Actualizo alumno: ADRIANA TICLIAHUANCA TUESTA','App\\Models\\Student',104,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:21:56\"}}}','2026-06-18 13:21:56','2026-06-18 13:21:56'),
(358,3,'students','created','Creo alumno: MARIA FERNANDA SAMPEN BERNAOLA','App\\Models\\Student',105,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:22:18','2026-06-18 13:22:18'),
(359,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":103,\"after\":104}}}','2026-06-18 13:22:18','2026-06-18 13:22:18'),
(360,3,'students','updated','Actualizo alumno: MARIA FERNANDA SAMPEN BERNAOLA','App\\Models\\Student',105,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:22:30\"}}}','2026-06-18 13:22:30','2026-06-18 13:22:30'),
(361,4,'students','created','Creo alumno: JIMENA SOFIA TENORIO TAPIA','App\\Models\\Student',106,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:26:23','2026-06-18 13:26:23'),
(362,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":104,\"after\":105}}}','2026-06-18 13:26:23','2026-06-18 13:26:23'),
(363,4,'students','updated','Actualizo alumno: JIMENA SOFIA TENORIO TAPIA','App\\Models\\Student',106,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:27:32\"}}}','2026-06-18 13:27:32','2026-06-18 13:27:32'),
(364,3,'students','created','Creo alumno: CAMILA ARACELY GONZALES CASTAÑEDA','App\\Models\\Student',107,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:28:30','2026-06-18 13:28:30'),
(365,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":105,\"after\":106}}}','2026-06-18 13:28:30','2026-06-18 13:28:30'),
(366,3,'students','updated','Actualizo alumno: CAMILA ARACELY GONZALES CASTAÑEDA','App\\Models\\Student',107,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:28:40\"}}}','2026-06-18 13:28:40','2026-06-18 13:28:40'),
(367,4,'students','created','Creo alumno: JOAQUIN ANTONIO SANDOVAL CAYOTOPA','App\\Models\\Student',108,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:33:09','2026-06-18 13:33:09'),
(368,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":106,\"after\":107}}}','2026-06-18 13:33:09','2026-06-18 13:33:09'),
(369,3,'students','created','Creo alumno: AYMAR CUSTODIO CHAVESTA','App\\Models\\Student',109,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:34:49','2026-06-18 13:34:49'),
(370,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":107,\"after\":108}}}','2026-06-18 13:34:49','2026-06-18 13:34:49'),
(371,3,'students','updated','Actualizo alumno: AYMAR CUSTODIO CHAVESTA','App\\Models\\Student',109,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:34:58\"}}}','2026-06-18 13:34:58','2026-06-18 13:34:58'),
(372,4,'students','updated','Actualizo alumno: JOAQUIN ANTONIO SANDOVAL CAYOTOPA','App\\Models\\Student',108,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:35:05\"}}}','2026-06-18 13:35:05','2026-06-18 13:35:05'),
(373,3,'students','created','Creo alumno: GORKI DUBERLI LABAN BANCES','App\\Models\\Student',110,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:41:16','2026-06-18 13:41:16'),
(374,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":108,\"after\":109}}}','2026-06-18 13:41:16','2026-06-18 13:41:16'),
(375,3,'students','updated','Actualizo alumno: GORKI DUBERLI LABAN BANCES','App\\Models\\Student',110,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:41:24\"}}}','2026-06-18 13:41:24','2026-06-18 13:41:24'),
(376,4,'students','updated','Actualizo alumno: SILVIA MARICRISTI GONZALES GONZALES','App\\Models\\Student',46,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:50:01\"}}}','2026-06-18 13:50:01','2026-06-18 13:50:01'),
(377,3,'students','created','Creo alumno: CESAR ABRAHAM PALACIOS RUIZ','App\\Models\\Student',111,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 13:52:14','2026-06-18 13:52:14'),
(378,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":109,\"after\":110}}}','2026-06-18 13:52:14','2026-06-18 13:52:14'),
(379,3,'students','updated','Actualizo alumno: CESAR ABRAHAM PALACIOS RUIZ','App\\Models\\Student',111,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:52:25\"}}}','2026-06-18 13:52:25','2026-06-18 13:52:25'),
(380,4,'students','created','Creo alumno: LUIS FERNANDO ALEXANDRO FLORES RODRIGUEZ','App\\Models\\Student',112,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:54:49','2026-06-18 13:54:49'),
(381,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":110,\"after\":111}}}','2026-06-18 13:54:49','2026-06-18 13:54:49'),
(382,4,'students','updated','Actualizo alumno: LUIS FERNANDO ALEXANDRO FLORES RODRIGUEZ','App\\Models\\Student',112,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:55:29\"}}}','2026-06-18 13:55:29','2026-06-18 13:55:29'),
(383,3,'students','updated','Actualizo alumno: CESAR ABRAHAM PALACIOS RUIZ','App\\Models\\Student',111,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"guardian_id\":{\"before\":81,\"after\":null}}}','2026-06-18 13:56:36','2026-06-18 13:56:36'),
(384,4,'students','created','Creo alumno: JENNIFFER ESMERALDA FLORES RODRIGUEZ','App\\Models\\Student',113,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 13:58:58','2026-06-18 13:58:58'),
(385,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":111,\"after\":112}}}','2026-06-18 13:58:58','2026-06-18 13:58:58'),
(386,4,'students','updated','Actualizo alumno: JENNIFFER ESMERALDA FLORES RODRIGUEZ','App\\Models\\Student',113,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 13:59:28\"}}}','2026-06-18 13:59:28','2026-06-18 13:59:28'),
(387,4,'students','updated','Actualizo alumno: JENNIFFER ESMERALDA FLORES RODRIGUEZ','App\\Models\\Student',113,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"dni\":{\"before\":\"71672785\",\"after\":\"71672798\"}}}','2026-06-18 14:01:05','2026-06-18 14:01:05'),
(388,4,'students','created','Creo alumno: ANDERSON SALVADOR FACIO CARRASCO','App\\Models\\Student',114,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 14:09:54','2026-06-18 14:09:54'),
(389,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":112,\"after\":113}}}','2026-06-18 14:09:54','2026-06-18 14:09:54'),
(390,4,'students','updated','Actualizo alumno: ANDERSON SALVADOR FACIO CARRASCO','App\\Models\\Student',114,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:10:40\"}}}','2026-06-18 14:10:40','2026-06-18 14:10:40'),
(391,3,'students','created','Creo alumno: CARLOS RAUL LIZA YANCUL','App\\Models\\Student',115,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 14:16:12','2026-06-18 14:16:12'),
(392,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":113,\"after\":114}}}','2026-06-18 14:16:12','2026-06-18 14:16:12'),
(393,3,'students','updated','Actualizo alumno: CARLOS RAUL LIZA YANCUL','App\\Models\\Student',115,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:16:21\"}}}','2026-06-18 14:16:21','2026-06-18 14:16:21'),
(394,4,'students','created','Creo alumno: CLAUDIO MARCELO MIRANDA CHIRA','App\\Models\\Student',116,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 14:21:03','2026-06-18 14:21:03'),
(395,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":114,\"after\":115}}}','2026-06-18 14:21:03','2026-06-18 14:21:03'),
(396,4,'students','updated','Actualizo alumno: CLAUDIO MARCELO MIRANDA CHIRA','App\\Models\\Student',116,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email\":{\"before\":\"claudiomarcelomch@gmail.com\",\"after\":\"claumarcelomch@gmail.com\"}}}','2026-06-18 14:21:52','2026-06-18 14:21:52'),
(397,4,'students','updated','Actualizo alumno: CLAUDIO MARCELO MIRANDA CHIRA','App\\Models\\Student',116,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:22:13\"}}}','2026-06-18 14:22:13','2026-06-18 14:22:13'),
(398,3,'students','created','Creo alumno: ALEXHA BELEN PALOMINO PAREDES','App\\Models\\Student',117,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 14:23:17','2026-06-18 14:23:17'),
(399,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":115,\"after\":116}}}','2026-06-18 14:23:17','2026-06-18 14:23:17'),
(400,3,'students','updated','Actualizo alumno: ALEXHA BELEN PALOMINO PAREDES','App\\Models\\Student',117,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:23:30\"}}}','2026-06-18 14:23:30','2026-06-18 14:23:30'),
(401,4,'students','created','Creo alumno: JOSE MARIA DE JESUS PINTADO CORDOVA','App\\Models\\Student',118,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-18 14:26:51','2026-06-18 14:26:51'),
(402,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":116,\"after\":117}}}','2026-06-18 14:26:51','2026-06-18 14:26:51'),
(403,4,'students','updated','Actualizo alumno: JOSE MARIA DE JESUS PINTADO CORDOVA','App\\Models\\Student',118,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:27:44\"}}}','2026-06-18 14:27:44','2026-06-18 14:27:44'),
(404,3,'students','created','Creo alumno: ANIBAL ANTONIO CAJIAN SEGURA','App\\Models\\Student',119,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 14:30:42','2026-06-18 14:30:42'),
(405,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":117,\"after\":118}}}','2026-06-18 14:30:42','2026-06-18 14:30:42'),
(406,3,'students','updated','Actualizo alumno: ANIBAL ANTONIO CAJIAN SEGURA','App\\Models\\Student',119,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:30:52\"}}}','2026-06-18 14:30:52','2026-06-18 14:30:52'),
(407,3,'students','created','Creo alumno: FRANKLYN CALEB SALAZAR OBLITAS','App\\Models\\Student',120,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-18 14:38:09','2026-06-18 14:38:09'),
(408,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":118,\"after\":119}}}','2026-06-18 14:38:09','2026-06-18 14:38:09'),
(409,3,'students','updated','Actualizo alumno: FRANKLYN CALEB SALAZAR OBLITAS','App\\Models\\Student',120,'132.157.128.71','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-18 14:38:18\"}}}','2026-06-18 14:38:18','2026-06-18 14:38:18'),
(410,4,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0',NULL,'2026-06-19 07:50:30','2026-06-19 07:50:30'),
(411,6,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 07:52:25','2026-06-19 07:52:25'),
(412,4,'students','created','Creo alumno: OBED MAIKELL ROJAS MUÑOZ','App\\Models\\Student',121,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":null}','2026-06-19 07:54:31','2026-06-19 07:54:31'),
(413,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"enrolled\":{\"before\":119,\"after\":120}}}','2026-06-19 07:54:31','2026-06-19 07:54:31'),
(414,4,'students','updated','Actualizo alumno: OBED MAIKELL ROJAS MUÑOZ','App\\Models\\Student',121,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 07:55:18\"}}}','2026-06-19 07:55:18','2026-06-19 07:55:18'),
(415,3,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 09:32:47','2026-06-19 09:32:47'),
(416,3,'students','created','Creo alumno: JEREMY JAREN FERNANDEZ ARRASCUE','App\\Models\\Student',122,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 09:36:15','2026-06-19 09:36:15'),
(417,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":120,\"after\":121}}}','2026-06-19 09:36:15','2026-06-19 09:36:15'),
(418,3,'students','updated','Actualizo alumno: JEREMY JAREN FERNANDEZ ARRASCUE','App\\Models\\Student',122,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 09:37:01\"}}}','2026-06-19 09:37:01','2026-06-19 09:37:01'),
(419,4,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0',NULL,'2026-06-19 09:39:47','2026-06-19 09:39:47'),
(420,3,'students','created','Creo alumno: EDUARDO SANTIAGO YGNACIO HUANGAL','App\\Models\\Student',123,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 09:44:41','2026-06-19 09:44:41'),
(421,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":121,\"after\":122}}}','2026-06-19 09:44:41','2026-06-19 09:44:41'),
(422,3,'students','updated','Actualizo alumno: EDUARDO SANTIAGO YGNACIO HUANGAL','App\\Models\\Student',123,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 09:44:53\"}}}','2026-06-19 09:44:53','2026-06-19 09:44:53'),
(423,4,'students','created','Creo alumno: WILLIAM RAUL DELGADO MORALES','App\\Models\\Student',124,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 09:48:12','2026-06-19 09:48:12'),
(424,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":122,\"after\":123}}}','2026-06-19 09:48:12','2026-06-19 09:48:12'),
(425,6,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"registration_date\",\"payment_voucher_number\",\"payment_agency_number\",\"payment_date\"]}','2026-06-19 09:48:41','2026-06-19 09:48:41'),
(426,4,'students','updated','Actualizo alumno: WILLIAM RAUL DELGADO MORALES','App\\Models\\Student',124,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"address\":{\"before\":\"CIRO ALEGRIA 680, BAGUA GRANDE, UTCUBAMBA, AMAZONAS\",\"after\":\"18 DE FEBRERO MZ LT 10, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE\"}}}','2026-06-19 09:49:33','2026-06-19 09:49:33'),
(427,4,'students','updated','Actualizo alumno: WILLIAM RAUL DELGADO MORALES','App\\Models\\Student',124,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 09:50:09\"}}}','2026-06-19 09:50:09','2026-06-19 09:50:09'),
(428,6,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\",\"career\",\"academic_cycle\",\"shift\",\"registration_date\",\"status\"]}','2026-06-19 09:55:14','2026-06-19 09:55:14'),
(429,3,'students','created','Creo alumno: LUZ DE BELEN INCIO CUBAS','App\\Models\\Student',125,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 10:19:21','2026-06-19 10:19:21'),
(430,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":123,\"after\":124}}}','2026-06-19 10:19:21','2026-06-19 10:19:21'),
(431,3,'students','updated','Actualizo alumno: LUZ DE BELEN INCIO CUBAS','App\\Models\\Student',125,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:19:31\"}}}','2026-06-19 10:19:31','2026-06-19 10:19:31'),
(432,4,'students','created','Creo alumno: ANAHI GIOVANNA VIDAURRE DAVILA','App\\Models\\Student',126,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 10:28:10','2026-06-19 10:28:10'),
(433,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":124,\"after\":125}}}','2026-06-19 10:28:10','2026-06-19 10:28:10'),
(434,3,'students','created','Creo alumno: MEDALITH RUBY GUERRERO PAJARES','App\\Models\\Student',127,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 10:28:44','2026-06-19 10:28:44'),
(435,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":125,\"after\":126}}}','2026-06-19 10:28:44','2026-06-19 10:28:44'),
(436,3,'students','updated','Actualizo alumno: MEDALITH RUBY GUERRERO PAJARES','App\\Models\\Student',127,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:28:56\"}}}','2026-06-19 10:28:56','2026-06-19 10:28:56'),
(437,4,'students','updated','Actualizo alumno: ANAHI GIOVANNA VIDAURRE DAVILA','App\\Models\\Student',126,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:29:14\"}}}','2026-06-19 10:29:14','2026-06-19 10:29:14'),
(438,6,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"email\"]}','2026-06-19 10:38:50','2026-06-19 10:38:50'),
(439,6,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":null,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"phone\",\"email\"]}','2026-06-19 10:42:49','2026-06-19 10:42:49'),
(440,4,'students','created','Creo alumno: EDUARDO MOISES NIQUEN PEREZ','App\\Models\\Student',128,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 10:49:27','2026-06-19 10:49:27'),
(441,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":126,\"after\":127}}}','2026-06-19 10:49:27','2026-06-19 10:49:27'),
(442,4,'students','updated','Actualizo alumno: EDUARDO MOISES NIQUEN PEREZ','App\\Models\\Student',128,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:50:44\"}}}','2026-06-19 10:50:44','2026-06-19 10:50:44'),
(443,6,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 10:54:24','2026-06-19 10:54:24'),
(444,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 10:54:38','2026-06-19 10:54:38'),
(445,4,'students','created','Creo alumno: NESTOR ANDRES CHAVEZ CABRERA','App\\Models\\Student',129,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 10:54:41','2026-06-19 10:54:41'),
(446,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":127,\"after\":128}}}','2026-06-19 10:54:41','2026-06-19 10:54:41'),
(447,1,'students','updated','Actualizo alumno: SAMUEL BENJAMIN BERNAL ESPINOZA','App\\Models\\Student',39,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"bernalesespinozabenjamin@gmail.com\",\"after\":\"bernalespinozabenjamin@gmail.com\"}}}','2026-06-19 10:54:58','2026-06-19 10:54:58'),
(448,1,'students','updated','Actualizo alumno: SAMUEL BENJAMIN BERNAL ESPINOZA','App\\Models\\Student',39,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:55:12\"}}}','2026-06-19 10:55:12','2026-06-19 10:55:12'),
(449,4,'students','updated','Actualizo alumno: NESTOR ANDRES CHAVEZ CABRERA','App\\Models\\Student',129,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:55:23\"}}}','2026-06-19 10:55:23','2026-06-19 10:55:23'),
(450,3,'students','created','Creo alumno: JUNIOR JOEL BANCES BANCES','App\\Models\\Student',130,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 10:55:36','2026-06-19 10:55:36'),
(451,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":128,\"after\":129}}}','2026-06-19 10:55:36','2026-06-19 10:55:36'),
(452,3,'students','updated','Actualizo alumno: JUNIOR JOEL BANCES BANCES','App\\Models\\Student',130,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 10:55:47\"}}}','2026-06-19 10:55:47','2026-06-19 10:55:47'),
(453,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 10:56:46','2026-06-19 10:56:46'),
(454,3,'students','created','Creo alumno: ANGELES MILAGROS FERNANDEZ PUMARICRA','App\\Models\\Student',131,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 11:25:18','2026-06-19 11:25:18'),
(455,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":129,\"after\":130}}}','2026-06-19 11:25:18','2026-06-19 11:25:18'),
(456,3,'students','updated','Actualizo alumno: ANGELES MILAGROS FERNANDEZ PUMARICRA','App\\Models\\Student',131,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 11:25:31\"}}}','2026-06-19 11:25:31','2026-06-19 11:25:31'),
(457,3,'students','created','Creo alumno: FIORELLA ELIZABETH VELASQUEZ SENMACHE','App\\Models\\Student',132,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 11:43:32','2026-06-19 11:43:32'),
(458,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":130,\"after\":131}}}','2026-06-19 11:43:32','2026-06-19 11:43:32'),
(459,3,'students','updated','Actualizo alumno: FIORELLA ELIZABETH VELASQUEZ SENMACHE','App\\Models\\Student',132,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 11:43:43\"}}}','2026-06-19 11:43:43','2026-06-19 11:43:43'),
(460,3,'students','created','Creo alumno: KEILA BETSABE BARRIENTOS PUICON','App\\Models\\Student',133,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 11:59:05','2026-06-19 11:59:05'),
(461,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":131,\"after\":132}}}','2026-06-19 11:59:05','2026-06-19 11:59:05'),
(462,3,'students','updated','Actualizo alumno: KEILA BETSABE BARRIENTOS PUICON','App\\Models\\Student',133,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 11:59:32\"}}}','2026-06-19 11:59:32','2026-06-19 11:59:32'),
(463,4,'students','created','Creo alumno: JOSE PANTALEON VASQUEZ MILIAN','App\\Models\\Student',134,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 12:09:40','2026-06-19 12:09:40'),
(464,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":132,\"after\":133}}}','2026-06-19 12:09:40','2026-06-19 12:09:40'),
(465,4,'students','updated','Actualizo alumno: JOSE PANTALEON VASQUEZ MILIAN','App\\Models\\Student',134,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:10:39\"}}}','2026-06-19 12:10:39','2026-06-19 12:10:39'),
(466,4,'students','created','Creo alumno: WILY BRAYAN BECERRA GONZALEZ','App\\Models\\Student',135,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 12:20:35','2026-06-19 12:20:35'),
(467,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":133,\"after\":134}}}','2026-06-19 12:20:35','2026-06-19 12:20:35'),
(468,4,'students','updated','Actualizo alumno: WILY BRAYAN BECERRA GONZALEZ','App\\Models\\Student',135,'190.236.25.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:21:17\"}}}','2026-06-19 12:21:17','2026-06-19 12:21:17'),
(469,3,'students','created','Creo alumno: NAHOMY DEL MILAGRO TIPIANI LOPEZ','App\\Models\\Student',136,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 12:22:37','2026-06-19 12:22:37'),
(470,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":134,\"after\":135}}}','2026-06-19 12:22:37','2026-06-19 12:22:37'),
(471,3,'students','updated','Actualizo alumno: NAHOMY DEL MILAGRO TIPIANI LOPEZ','App\\Models\\Student',136,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:22:54\"}}}','2026-06-19 12:22:54','2026-06-19 12:22:54'),
(472,3,'students','updated','Actualizo alumno: NAHOMY DEL MILAGRO TIPIANI LOPEZ','App\\Models\\Student',136,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email\":{\"before\":\"tipileonardo9@gmail.com\",\"after\":\"nahotipiani@gmail.com\"},\"email_verified_at\":{\"before\":\"2026-06-19T17:22:54.000000Z\",\"after\":null}}}','2026-06-19 12:25:22','2026-06-19 12:25:22'),
(473,3,'students','updated','Actualizo alumno: NAHOMY DEL MILAGRO TIPIANI LOPEZ','App\\Models\\Student',136,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:25:37\"}}}','2026-06-19 12:25:37','2026-06-19 12:25:37'),
(474,4,'students','created','Creo alumno: OSCAR THOMAS PAICO DIAZ','App\\Models\\Student',137,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 12:32:20','2026-06-19 12:32:20'),
(475,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":135,\"after\":136}}}','2026-06-19 12:32:20','2026-06-19 12:32:20'),
(476,4,'students','updated','Actualizo alumno: OSCAR THOMAS PAICO DIAZ','App\\Models\\Student',137,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:32:44\"}}}','2026-06-19 12:32:44','2026-06-19 12:32:44'),
(477,3,'students','created','Creo alumno: AARON JHOEL VALENCIA CORTEZ','App\\Models\\Student',138,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 12:38:32','2026-06-19 12:38:32'),
(478,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":136,\"after\":137}}}','2026-06-19 12:38:32','2026-06-19 12:38:32'),
(479,3,'students','updated','Actualizo alumno: AARON JHOEL VALENCIA CORTEZ','App\\Models\\Student',138,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:38:41\"}}}','2026-06-19 12:38:41','2026-06-19 12:38:41'),
(480,3,'students','created','Creo alumno: AYMAR YADIRA ZETA CORTEZ','App\\Models\\Student',139,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 12:44:51','2026-06-19 12:44:51'),
(481,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":137,\"after\":138}}}','2026-06-19 12:44:51','2026-06-19 12:44:51'),
(482,3,'students','updated','Actualizo alumno: AYMAR YADIRA ZETA CORTEZ','App\\Models\\Student',139,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 12:44:59\"}}}','2026-06-19 12:44:59','2026-06-19 12:44:59'),
(483,3,'students','created','Creo alumno: JOSE SEBASTIAN CHIMOY SIGNOL','App\\Models\\Student',140,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 13:36:25','2026-06-19 13:36:25'),
(484,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":138,\"after\":139}}}','2026-06-19 13:36:25','2026-06-19 13:36:25'),
(485,4,'students','created','Creo alumno: NICOLE STEPHANIE ZEVALLOS QUIROZ','App\\Models\\Student',141,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 13:36:40','2026-06-19 13:36:40'),
(486,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":139,\"after\":140}}}','2026-06-19 13:36:40','2026-06-19 13:36:40'),
(487,3,'students','updated','Actualizo alumno: JOSE SEBASTIAN CHIMOY SIGNOL','App\\Models\\Student',140,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 13:36:51\"}}}','2026-06-19 13:36:51','2026-06-19 13:36:51'),
(488,4,'students','updated','Actualizo alumno: NICOLE STEPHANIE ZEVALLOS QUIROZ','App\\Models\\Student',141,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email\":{\"before\":\"mayraquirosramirez@gmail.com\",\"after\":\"mayraquirozramirez@gmail.com\"}}}','2026-06-19 13:37:35','2026-06-19 13:37:35'),
(489,4,'students','updated','Actualizo alumno: NICOLE STEPHANIE ZEVALLOS QUIROZ','App\\Models\\Student',141,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 13:37:46\"}}}','2026-06-19 13:37:46','2026-06-19 13:37:46'),
(490,3,'students','created','Creo alumno: JHOSELIN LUCERO GONZALES ROMAN','App\\Models\\Student',142,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 13:47:13','2026-06-19 13:47:13'),
(491,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":140,\"after\":141}}}','2026-06-19 13:47:13','2026-06-19 13:47:13'),
(492,3,'students','updated','Actualizo alumno: JHOSELIN LUCERO GONZALES ROMAN','App\\Models\\Student',142,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 13:47:30\"}}}','2026-06-19 13:47:30','2026-06-19 13:47:30'),
(493,4,'students','created','Creo alumno: MIRIAM HERNANDEZ CALVAY','App\\Models\\Student',143,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:09:31','2026-06-19 14:09:31'),
(494,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":141,\"after\":142}}}','2026-06-19 14:09:31','2026-06-19 14:09:31'),
(495,4,'students','updated','Actualizo alumno: MIRIAM HERNANDEZ CALVAY','App\\Models\\Student',143,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:10:30\"}}}','2026-06-19 14:10:30','2026-06-19 14:10:30'),
(496,4,'students','created','Creo alumno: DAVID VILLALOBOS VILLALOBOS','App\\Models\\Student',144,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:16:30','2026-06-19 14:16:30'),
(497,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":142,\"after\":143}}}','2026-06-19 14:16:30','2026-06-19 14:16:30'),
(498,4,'students','updated','Actualizo alumno: DAVID VILLALOBOS VILLALOBOS','App\\Models\\Student',144,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:17:29\"}}}','2026-06-19 14:17:29','2026-06-19 14:17:29'),
(499,3,'students','created','Creo alumno: RONALD MANUEL UBILLUS DAVILA','App\\Models\\Student',145,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 14:18:14','2026-06-19 14:18:14'),
(500,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":143,\"after\":144}}}','2026-06-19 14:18:14','2026-06-19 14:18:14'),
(501,3,'students','updated','Actualizo alumno: RONALD MANUEL UBILLUS DAVILA','App\\Models\\Student',145,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:18:28\"}}}','2026-06-19 14:18:28','2026-06-19 14:18:28'),
(502,4,'students','created','Creo alumno: CARLOS ALEJANDRO MINGUILLO DE LA CRUZ','App\\Models\\Student',146,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:21:33','2026-06-19 14:21:33'),
(503,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":144,\"after\":145}}}','2026-06-19 14:21:33','2026-06-19 14:21:33'),
(504,4,'students','updated','Actualizo alumno: CARLOS ALEJANDRO MINGUILLO DE LA CRUZ','App\\Models\\Student',146,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:22:32\"}}}','2026-06-19 14:22:32','2026-06-19 14:22:32'),
(505,4,'students','created','Creo alumno: BRYANNA XIMENA ALCANTARA HORNA','App\\Models\\Student',147,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:31:26','2026-06-19 14:31:26'),
(506,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":145,\"after\":146}}}','2026-06-19 14:31:26','2026-06-19 14:31:26'),
(507,4,'students','updated','Actualizo alumno: BRYANNA XIMENA ALCANTARA HORNA','App\\Models\\Student',147,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:33:09\"}}}','2026-06-19 14:33:09','2026-06-19 14:33:09'),
(508,4,'students','created','Creo alumno: LIONEL PRIESSNITZ CAMPOS BERMEO','App\\Models\\Student',148,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:38:54','2026-06-19 14:38:54'),
(509,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":146,\"after\":147}}}','2026-06-19 14:38:54','2026-06-19 14:38:54'),
(510,4,'students','updated','Actualizo alumno: LIONEL PRIESSNITZ CAMPOS BERMEO','App\\Models\\Student',148,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:39:36\"}}}','2026-06-19 14:39:36','2026-06-19 14:39:36'),
(511,4,'students','created','Creo alumno: MARIA JOSE NUÑEZ FARRO','App\\Models\\Student',149,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:52:01','2026-06-19 14:52:01'),
(512,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":147,\"after\":148}}}','2026-06-19 14:52:01','2026-06-19 14:52:01'),
(513,4,'students','updated','Actualizo alumno: MARIA JOSE NUÑEZ FARRO','App\\Models\\Student',149,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email\":{\"before\":\"nunezfarromaria@gmail.com\",\"after\":\"nunezfarromarie@gmail.com\"}}}','2026-06-19 14:52:53','2026-06-19 14:52:53'),
(514,4,'students','updated','Actualizo alumno: MARIA JOSE NUÑEZ FARRO','App\\Models\\Student',149,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:53:19\"}}}','2026-06-19 14:53:19','2026-06-19 14:53:19'),
(515,3,'students','created','Creo alumno: DARIANNE AYLEEN YUNIS PEREZ','App\\Models\\Student',150,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 14:56:15','2026-06-19 14:56:15'),
(516,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":148,\"after\":149}}}','2026-06-19 14:56:15','2026-06-19 14:56:15'),
(517,3,'students','updated','Actualizo alumno: DARIANNE AYLEEN YUNIS PEREZ','App\\Models\\Student',150,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:56:26\"}}}','2026-06-19 14:56:26','2026-06-19 14:56:26'),
(518,4,'students','created','Creo alumno: MARIA GABRIELLA ZEÑA CAMPOS','App\\Models\\Student',151,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":null}','2026-06-19 14:57:23','2026-06-19 14:57:23'),
(519,4,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"enrolled\":{\"before\":149,\"after\":150}}}','2026-06-19 14:57:23','2026-06-19 14:57:23'),
(520,4,'students','updated','Actualizo alumno: MARIA GABRIELLA ZEÑA CAMPOS','App\\Models\\Student',151,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"gender\":{\"before\":\"male\",\"after\":\"female\"}}}','2026-06-19 14:58:07','2026-06-19 14:58:07'),
(521,4,'students','updated','Actualizo alumno: MARIA GABRIELLA ZEÑA CAMPOS','App\\Models\\Student',151,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:152.0) Gecko/20100101 Firefox/152.0','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 14:58:25\"}}}','2026-06-19 14:58:25','2026-06-19 14:58:25'),
(522,3,'students','created','Creo alumno: BRUNO FERNANDEZ SOBRINO','App\\Models\\Student',152,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":null}','2026-06-19 15:01:40','2026-06-19 15:01:40'),
(523,3,'schedules','updated','Actualizo programacion: ID 1','App\\Models\\AcademicCycleShift',1,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"enrolled\":{\"before\":150,\"after\":151}}}','2026-06-19 15:01:40','2026-06-19 15:01:40'),
(524,3,'students','updated','Actualizo alumno: BRUNO FERNANDEZ SOBRINO','App\\Models\\Student',152,'132.184.55.138','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"email_verified_at\":{\"before\":null,\"after\":\"2026-06-19 15:01:52\"}}}','2026-06-19 15:01:52','2026-06-19 15:01:52'),
(525,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 17:07:34','2026-06-19 17:07:34'),
(526,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 17:09:41','2026-06-19 17:09:41'),
(527,5,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 17:09:53','2026-06-19 17:09:53'),
(528,5,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-19 17:16:38','2026-06-19 17:16:38'),
(529,1,'auth','login','Inicio sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-20 08:25:06','2026-06-20 08:25:06'),
(530,1,'students','updated','Actualizo alumno: KYARA YAMILET GIRON CHAVEZ','App\\Models\\Student',103,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"payment_voucher_number\":{\"before\":\"183580\",\"after\":\"3183580\"}}}','2026-06-20 08:59:46','2026-06-20 08:59:46'),
(531,1,'students','updated','Actualizo alumno: MARIA FERNANDA SAMPEN BERNAOLA','App\\Models\\Student',105,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"changed\":{\"payment_voucher_number\":{\"before\":\"705262\",\"after\":\"5705262\"}}}','2026-06-20 09:01:15','2026-06-20 09:01:15'),
(532,1,'reports','download_pdf','Genero PDF de reporte de alumnos.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','{\"career_id\":null,\"academic_cycle_id\":1,\"academic_group\":null,\"student_search\":null,\"columns\":[\"dni\",\"full_name\",\"registration_date\",\"payment_voucher_number\",\"payment_agency_number\",\"payment_date\"]}','2026-06-20 09:30:39','2026-06-20 09:30:39'),
(533,1,'auth','logout','Cerro sesion en el panel administrativo.',NULL,NULL,'38.250.131.73','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36',NULL,'2026-06-20 10:16:56','2026-06-20 10:16:56');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admission_processes`
--

DROP TABLE IF EXISTS `admission_processes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission_processes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(32) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admission_processes_status_index` (`status`),
  KEY `admission_processes_start_date_end_date_index` (`start_date`,`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission_processes`
--

LOCK TABLES `admission_processes` WRITE;
/*!40000 ALTER TABLE `admission_processes` DISABLE KEYS */;
/*!40000 ALTER TABLE `admission_processes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(160) NOT NULL,
  `body` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `external_url` varchar(2048) DEFAULT NULL,
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `announcements_starts_at_index` (`starts_at`),
  KEY `announcements_ends_at_index` (`ends_at`),
  KEY `announcements_is_published_index` (`is_published`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES
('cpu-unprg-cache-03286b1c26b376aaa992092cb08a3d4c','i:1;',1781962806),
('cpu-unprg-cache-03286b1c26b376aaa992092cb08a3d4c:timer','i:1781962806;',1781962806),
('cpu-unprg-cache-056ebd2d4966a727a3a5a4988300c632','i:1;',1781849498),
('cpu-unprg-cache-056ebd2d4966a727a3a5a4988300c632:timer','i:1781849498;',1781849498),
('cpu-unprg-cache-131ce0bd8a07263c2f414f15c49efb79','i:1;',1781907893),
('cpu-unprg-cache-131ce0bd8a07263c2f414f15c49efb79:timer','i:1781907893;',1781907893),
('cpu-unprg-cache-4b20fec5eb53731212bad3191a44059a','i:1;',1781906839),
('cpu-unprg-cache-4b20fec5eb53731212bad3191a44059a:timer','i:1781906839;',1781906839),
('cpu-unprg-cache-5f1deed841a6608a0f375d99aa265190','i:1;',1781873810),
('cpu-unprg-cache-5f1deed841a6608a0f375d99aa265190:timer','i:1781873810;',1781873810),
('cpu-unprg-cache-602a96db928978a46a0aa8bb231e5150','i:1;',1781785608),
('cpu-unprg-cache-602a96db928978a46a0aa8bb231e5150:timer','i:1781785608;',1781785608),
('cpu-unprg-cache-662d64f50b91d32be077b44df496fc1b','i:1;',1781884567),
('cpu-unprg-cache-662d64f50b91d32be077b44df496fc1b:timer','i:1781884567;',1781884567),
('cpu-unprg-cache-769fcfab6fdd4f4a9ba6a987b1a3f113','i:1;',1781880467),
('cpu-unprg-cache-769fcfab6fdd4f4a9ba6a987b1a3f113:timer','i:1781880467;',1781880467),
('cpu-unprg-cache-81999fa77e46ce574094a3d982343d23','i:2;',1781788412),
('cpu-unprg-cache-81999fa77e46ce574094a3d982343d23:timer','i:1781788412;',1781788412),
('cpu-unprg-cache-903ae0c9f4d2f37c53765dafa419f744','i:1;',1781899161),
('cpu-unprg-cache-903ae0c9f4d2f37c53765dafa419f744:timer','i:1781899161;',1781899161),
('cpu-unprg-cache-968aa25799c5432fba0a5f5f1f3bdeba','i:1;',1781898945),
('cpu-unprg-cache-968aa25799c5432fba0a5f5f1f3bdeba:timer','i:1781898945;',1781898945),
('cpu-unprg-cache-9b3cea2b175d0a08e875a5b4a3c16967','i:2;',1781899109),
('cpu-unprg-cache-9b3cea2b175d0a08e875a5b4a3c16967:timer','i:1781899109;',1781899109),
('cpu-unprg-cache-9ecd600ee11c549a1f0c809c556d7212','i:1;',1781899365),
('cpu-unprg-cache-9ecd600ee11c549a1f0c809c556d7212:timer','i:1781899365;',1781899365),
('cpu-unprg-cache-a3cd99558a851db69f554dc46b37e040','i:1;',1781899368),
('cpu-unprg-cache-a3cd99558a851db69f554dc46b37e040:timer','i:1781899368;',1781899368),
('cpu-unprg-cache-d2e9528a96700fc5c9847f8d3a7e5b55','i:2;',1781788211),
('cpu-unprg-cache-d2e9528a96700fc5c9847f8d3a7e5b55:timer','i:1781788211;',1781788211),
('cpu-unprg-cache-d4d25bacce348d71d9127a41e714956b','i:1;',1781880886),
('cpu-unprg-cache-d4d25bacce348d71d9127a41e714956b:timer','i:1781880886;',1781880886),
('cpu-unprg-cache-d5deca824adffab69ee36d10b2455cb2','i:1;',1781788594),
('cpu-unprg-cache-d5deca824adffab69ee36d10b2455cb2:timer','i:1781788594;',1781788594),
('cpu-unprg-cache-d9af9c14830c1f7b5b2e46ad1185afc4','i:1;',1781788465),
('cpu-unprg-cache-d9af9c14830c1f7b5b2e46ad1185afc4:timer','i:1781788465;',1781788465),
('cpu-unprg-cache-db5d17e42f5088642d8edb1b9a239212','i:1;',1781784902),
('cpu-unprg-cache-db5d17e42f5088642d8edb1b9a239212:timer','i:1781784902;',1781784902),
('cpu-unprg-cache-dc822ea149c2bf43ae3cb76759db41cb','i:1;',1781874445),
('cpu-unprg-cache-dc822ea149c2bf43ae3cb76759db41cb:timer','i:1781874445;',1781874445),
('cpu-unprg-cache-dcd59439050e4ec7cdd106c9edf7e909','i:1;',1781888796),
('cpu-unprg-cache-dcd59439050e4ec7cdd106c9edf7e909:timer','i:1781888796;',1781888796),
('cpu-unprg-cache-e66f0e80d5bfd1fe207b9d275428487c','i:1;',1781885377),
('cpu-unprg-cache-e66f0e80d5bfd1fe207b9d275428487c:timer','i:1781885377;',1781885377),
('cpu-unprg-cache-eb76de21ef0649d659be68bf3f5ff0fe','i:1;',1781811006),
('cpu-unprg-cache-eb76de21ef0649d659be68bf3f5ff0fe:timer','i:1781811006;',1781811006),
('cpu-unprg-cache-spatie.permission.cache','a:3:{s:5:\"alias\";a:5:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";s:1:\"j\";s:6:\"status\";}s:11:\"permissions\";a:33:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:18:\"exam-settings.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:18:\"announcements.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:20:\"announcements.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:20:\"announcements.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:20:\"announcements.delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:14:\"dashboard.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:10:\"staff.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:12:\"staff.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:12:\"staff.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:12:\"staff.delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:10:\"roles.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:12:\"roles.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:20:\"academic-cycles.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:22:\"academic-cycles.manage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:20:\"exam-settings.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:13:\"students.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:15:\"students.create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:15:\"students.update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:15:\"students.delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:18:\"students.documents\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:13:\"academic.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:26:\"academic.classrooms.manage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:28:\"academic.distribution.manage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:22:\"academic.grades.manage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:23:\"academic.imports.manage\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:12:\"reports.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:14:\"reports.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:23:\"reports.students.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:21:\"reports.emails.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:23:\"reports.treasury.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:21:\"academic.reports.view\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:23:\"academic.reports.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:29:\"reports.students.group.export\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:4;}}}s:5:\"roles\";a:4:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"j\";i:1;s:1:\"c\";s:3:\"web\";}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:5:\"admin\";s:1:\"j\";i:1;s:1:\"c\";s:3:\"web\";}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:10:\"trabajador\";s:1:\"j\";i:1;s:1:\"c\";s:3:\"web\";}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:9:\"asistente\";s:1:\"j\";i:1;s:1:\"c\";s:3:\"web\";}}}',1782048306),
('cpu-unprg-cache-students.catalog.campuses.active.v1','O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:17:\"App\\Models\\Campus\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"campuses\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:54:\"Centro Preuniversitario Juan Francisco Aguinaga Castro\";s:7:\"address\";s:44:\"Av. José Leonardo Ortiz 405, Chiclayo, Peru\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:54:\"Centro Preuniversitario Juan Francisco Aguinaga Castro\";s:7:\"address\";s:44:\"Av. José Leonardo Ortiz 405, Chiclayo, Peru\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:7:\"address\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}',1782086624),
('cpu-unprg-cache-students.catalog.careers.active.v2','O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:44:{i:0;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:15:\"ADMINISTRACIÓN\";s:4:\"code\";s:3:\"ADM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:15:\"ADMINISTRACIÓN\";s:4:\"code\";s:3:\"ADM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:1;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:2;s:4:\"name\";s:10:\"AGRONOMÍA\";s:4:\"code\";s:3:\"AGR\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:2;s:4:\"name\";s:10:\"AGRONOMÍA\";s:4:\"code\";s:3:\"AGR\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:2;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:3;s:4:\"name\";s:12:\"ARQUEOLOGÍA\";s:4:\"code\";s:3:\"ARK\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:3;s:4:\"name\";s:12:\"ARQUEOLOGÍA\";s:4:\"code\";s:3:\"ARK\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:3;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:4;s:4:\"name\";s:12:\"ARQUITECTURA\";s:4:\"code\";s:3:\"ARC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:4;s:4:\"name\";s:12:\"ARQUITECTURA\";s:4:\"code\";s:3:\"ARC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:4;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:5;s:4:\"name\";s:23:\"ARTE - ARTES PLÁSTICAS\";s:4:\"code\";s:3:\"ARP\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:5;s:4:\"name\";s:23:\"ARTE - ARTES PLÁSTICAS\";s:4:\"code\";s:3:\"ARP\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:5;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:7;s:4:\"name\";s:13:\"ARTE - DANZAS\";s:4:\"code\";s:3:\"ARD\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:7;s:4:\"name\";s:13:\"ARTE - DANZAS\";s:4:\"code\";s:3:\"ARD\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:6;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:8;s:4:\"name\";s:14:\"ARTE - MÚSICA\";s:4:\"code\";s:3:\"ARM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:8;s:4:\"name\";s:14:\"ARTE - MÚSICA\";s:4:\"code\";s:3:\"ARM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:7;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:6;s:4:\"name\";s:28:\"ARTE - PEDAGOGÍA ARTÍSTICA\";s:4:\"code\";s:3:\"APA\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:6;s:4:\"name\";s:28:\"ARTE - PEDAGOGÍA ARTÍSTICA\";s:4:\"code\";s:3:\"APA\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:8;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:9;s:4:\"name\";s:13:\"ARTE - TEATRO\";s:4:\"code\";s:3:\"ART\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:9;s:4:\"name\";s:13:\"ARTE - TEATRO\";s:4:\"code\";s:3:\"ART\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:9;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:10;s:4:\"name\";s:17:\"CIENCIA POLÍTICA\";s:4:\"code\";s:3:\"CPO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:10;s:4:\"name\";s:17:\"CIENCIA POLÍTICA\";s:4:\"code\";s:3:\"CPO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:10;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:11;s:4:\"name\";s:32:\"CIENCIAS BIOLÓGICAS - BIOLOGÍA\";s:4:\"code\";s:3:\"CBB\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:11;s:4:\"name\";s:32:\"CIENCIAS BIOLÓGICAS - BIOLOGÍA\";s:4:\"code\";s:3:\"CBB\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:11;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:12;s:4:\"name\";s:32:\"CIENCIAS BIOLÓGICAS - BOTÁNICA\";s:4:\"code\";s:3:\"CBT\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:12;s:4:\"name\";s:32:\"CIENCIAS BIOLÓGICAS - BOTÁNICA\";s:4:\"code\";s:3:\"CBT\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:12;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:13;s:4:\"name\";s:54:\"CIENCIAS BIOLÓGICAS - MICROBIOLOGÍA - PARASITOLOGÍA\";s:4:\"code\";s:3:\"CBM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:13;s:4:\"name\";s:54:\"CIENCIAS BIOLÓGICAS - MICROBIOLOGÍA - PARASITOLOGÍA\";s:4:\"code\";s:3:\"CBM\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:13;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:14;s:4:\"name\";s:33:\"CIENCIAS BIOLÓGICAS - PESQUERÍA\";s:4:\"code\";s:3:\"CBP\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:14;s:4:\"name\";s:33:\"CIENCIAS BIOLÓGICAS - PESQUERÍA\";s:4:\"code\";s:3:\"CBP\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:14;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:15;s:4:\"name\";s:28:\"CIENCIAS DE LA COMUNICACIÓN\";s:4:\"code\";s:3:\"CDC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:15;s:4:\"name\";s:28:\"CIENCIAS DE LA COMUNICACIÓN\";s:4:\"code\";s:3:\"CDC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:15;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:16;s:4:\"name\";s:35:\"COMERCIO Y NEGOCIOS INTERNACIONALES\";s:4:\"code\";s:3:\"CNI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:16;s:4:\"name\";s:35:\"COMERCIO Y NEGOCIOS INTERNACIONALES\";s:4:\"code\";s:3:\"CNI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:16;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:17;s:4:\"name\";s:12:\"CONTABILIDAD\";s:4:\"code\";s:3:\"CON\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:17;s:4:\"name\";s:12:\"CONTABILIDAD\";s:4:\"code\";s:3:\"CON\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:17;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:18;s:4:\"name\";s:7:\"DERECHO\";s:4:\"code\";s:3:\"DER\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:18;s:4:\"name\";s:7:\"DERECHO\";s:4:\"code\";s:3:\"DER\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:18;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:19;s:4:\"name\";s:9:\"ECONOMÍA\";s:4:\"code\";s:3:\"ECO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:19;s:4:\"name\";s:9:\"ECONOMÍA\";s:4:\"code\";s:3:\"ECO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:19;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:20;s:4:\"name\";s:45:\"EDUCACIÓN - CIENCIAS HIST. SOC. Y FILOSOFÍA\";s:4:\"code\";s:3:\"EHS\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:20;s:4:\"name\";s:45:\"EDUCACIÓN - CIENCIAS HIST. SOC. Y FILOSOFÍA\";s:4:\"code\";s:3:\"EHS\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:20;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:21;s:4:\"name\";s:31:\"EDUCACIÓN - CIENCIAS NATURALES\";s:4:\"code\";s:3:\"ECN\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:21;s:4:\"name\";s:31:\"EDUCACIÓN - CIENCIAS NATURALES\";s:4:\"code\";s:3:\"ECN\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:21;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:22;s:4:\"name\";s:31:\"EDUCACIÓN - EDUCACIÓN FÍSICA\";s:4:\"code\";s:3:\"EEF\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:22;s:4:\"name\";s:31:\"EDUCACIÓN - EDUCACIÓN FÍSICA\";s:4:\"code\";s:3:\"EEF\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:22;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:23;s:4:\"name\";s:32:\"EDUCACIÓN - IDIOMAS EXTRANJEROS\";s:4:\"code\";s:3:\"EIE\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:23;s:4:\"name\";s:32:\"EDUCACIÓN - IDIOMAS EXTRANJEROS\";s:4:\"code\";s:3:\"EIE\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:23;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:24;s:4:\"name\";s:20:\"EDUCACIÓN - INICIAL\";s:4:\"code\";s:3:\"EIN\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:24;s:4:\"name\";s:20:\"EDUCACIÓN - INICIAL\";s:4:\"code\";s:3:\"EIN\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:24;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:25;s:4:\"name\";s:32:\"EDUCACIÓN - LENGUA Y LITERATURA\";s:4:\"code\";s:3:\"ELL\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:25;s:4:\"name\";s:32:\"EDUCACIÓN - LENGUA Y LITERATURA\";s:4:\"code\";s:3:\"ELL\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:25;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:26;s:4:\"name\";s:39:\"EDUCACIÓN - MATEMÁTICA Y COMPUTACIÓN\";s:4:\"code\";s:3:\"EMC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:26;s:4:\"name\";s:39:\"EDUCACIÓN - MATEMÁTICA Y COMPUTACIÓN\";s:4:\"code\";s:3:\"EMC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:26;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:27;s:4:\"name\";s:21:\"EDUCACIÓN - PRIMARIA\";s:4:\"code\";s:3:\"EPR\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:27;s:4:\"name\";s:21:\"EDUCACIÓN - PRIMARIA\";s:4:\"code\";s:3:\"EPR\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:27;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:28;s:4:\"name\";s:11:\"ENFERMERÍA\";s:4:\"code\";s:3:\"ENF\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:28;s:4:\"name\";s:11:\"ENFERMERÍA\";s:4:\"code\";s:3:\"ENF\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:28;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:29;s:4:\"name\";s:12:\"ESTADÍSTICA\";s:4:\"code\";s:3:\"EST\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:29;s:4:\"name\";s:12:\"ESTADÍSTICA\";s:4:\"code\";s:3:\"EST\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:29;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:30;s:4:\"name\";s:7:\"FÍSICA\";s:4:\"code\";s:3:\"FIS\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:30;s:4:\"name\";s:7:\"FÍSICA\";s:4:\"code\";s:3:\"FIS\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:30;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:31;s:4:\"name\";s:21:\"INGENIERÍA AGRÍCOLA\";s:4:\"code\";s:3:\"IAG\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:31;s:4:\"name\";s:21:\"INGENIERÍA AGRÍCOLA\";s:4:\"code\";s:3:\"IAG\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:31;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:32;s:4:\"name\";s:17:\"INGENIERÍA CIVIL\";s:4:\"code\";s:3:\"ICV\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:32;s:4:\"name\";s:17:\"INGENIERÍA CIVIL\";s:4:\"code\";s:3:\"ICV\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:32;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:33;s:4:\"name\";s:38:\"INGENIERÍA DE INDUSTRIAS ALIMENTARIAS\";s:4:\"code\";s:3:\"IIA\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:33;s:4:\"name\";s:38:\"INGENIERÍA DE INDUSTRIAS ALIMENTARIAS\";s:4:\"code\";s:3:\"IIA\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:33;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:34;s:4:\"name\";s:23:\"INGENIERÍA DE SISTEMAS\";s:4:\"code\";s:3:\"ISI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:34;s:4:\"name\";s:23:\"INGENIERÍA DE SISTEMAS\";s:4:\"code\";s:3:\"ISI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:34;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:35;s:4:\"name\";s:24:\"INGENIERÍA ELECTRÓNICA\";s:4:\"code\";s:3:\"IEL\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:35;s:4:\"name\";s:24:\"INGENIERÍA ELECTRÓNICA\";s:4:\"code\";s:3:\"IEL\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:35;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:36;s:4:\"name\";s:42:\"INGENIERÍA EN COMPUTACIÓN E INFORMÁTICA\";s:4:\"code\";s:3:\"ICI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:36;s:4:\"name\";s:42:\"INGENIERÍA EN COMPUTACIÓN E INFORMÁTICA\";s:4:\"code\";s:3:\"ICI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:36;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:37;s:4:\"name\";s:34:\"INGENIERÍA MECÁNICA Y ELÉCTRICA\";s:4:\"code\";s:3:\"IME\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:37;s:4:\"name\";s:34:\"INGENIERÍA MECÁNICA Y ELÉCTRICA\";s:4:\"code\";s:3:\"IME\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:37;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:38;s:4:\"name\";s:20:\"INGENIERÍA QUÍMICA\";s:4:\"code\";s:3:\"IQU\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:38;s:4:\"name\";s:20:\"INGENIERÍA QUÍMICA\";s:4:\"code\";s:3:\"IQU\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:38;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:39;s:4:\"name\";s:21:\"INGENIERÍA ZOOTECNIA\";s:4:\"code\";s:3:\"IZO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:39;s:4:\"name\";s:21:\"INGENIERÍA ZOOTECNIA\";s:4:\"code\";s:3:\"IZO\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:39;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:40;s:4:\"name\";s:12:\"MATEMÁTICAS\";s:4:\"code\";s:3:\"MAT\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:40;s:4:\"name\";s:12:\"MATEMÁTICAS\";s:4:\"code\";s:3:\"MAT\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:40;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"MEDICINA HUMANA\";s:4:\"code\";s:3:\"MED\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:41;s:4:\"name\";s:15:\"MEDICINA HUMANA\";s:4:\"code\";s:3:\"MED\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:41;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:42;s:4:\"name\";s:20:\"MEDICINA VETERINARIA\";s:4:\"code\";s:3:\"MVE\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:42;s:4:\"name\";s:20:\"MEDICINA VETERINARIA\";s:4:\"code\";s:3:\"MVE\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:42;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:43;s:4:\"name\";s:11:\"PSICOLOGÍA\";s:4:\"code\";s:3:\"PSI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:43;s:4:\"name\";s:11:\"PSICOLOGÍA\";s:4:\"code\";s:3:\"PSI\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}i:43;O:17:\"App\\Models\\Career\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:7:\"careers\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:44;s:4:\"name\";s:11:\"SOCIOLOGÍA\";s:4:\"code\";s:3:\"SOC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:44;s:4:\"name\";s:11:\"SOCIOLOGÍA\";s:4:\"code\";s:3:\"SOC\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:4:\"code\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}',1782086624),
('cpu-unprg-cache-students.catalog.schedules.public.v1','O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:1:{i:0;O:29:\"App\\Models\\AcademicCycleShift\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:21:\"academic_cycle_shifts\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:9:{s:2:\"id\";i:1;s:17:\"academic_cycle_id\";i:1;s:9:\"campus_id\";i:1;s:8:\"shift_id\";i:4;s:8:\"capacity\";i:840;s:8:\"enrolled\";i:151;s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 19:00:44\";s:10:\"updated_at\";s:19:\"2026-06-19 15:01:40\";}s:11:\"\0*\0original\";a:9:{s:2:\"id\";i:1;s:17:\"academic_cycle_id\";i:1;s:9:\"campus_id\";i:1;s:8:\"shift_id\";i:4;s:8:\"capacity\";i:840;s:8:\"enrolled\";i:151;s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 19:00:44\";s:10:\"updated_at\";s:19:\"2026-06-19 15:01:40\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:3:{s:13:\"academicCycle\";O:24:\"App\\Models\\AcademicCycle\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:15:\"academic_cycles\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:7:{s:2:\"id\";i:1;s:4:\"name\";s:22:\"CICLO INTENSIVO 2026-I\";s:6:\"status\";i:1;s:10:\"start_date\";s:10:\"2026-06-16\";s:8:\"end_date\";s:10:\"2026-08-30\";s:10:\"created_at\";s:19:\"2026-06-16 19:00:35\";s:10:\"updated_at\";s:19:\"2026-06-16 19:00:35\";}s:11:\"\0*\0original\";a:7:{s:2:\"id\";i:1;s:4:\"name\";s:22:\"CICLO INTENSIVO 2026-I\";s:6:\"status\";i:1;s:10:\"start_date\";s:10:\"2026-06-16\";s:8:\"end_date\";s:10:\"2026-08-30\";s:10:\"created_at\";s:19:\"2026-06-16 19:00:35\";s:10:\"updated_at\";s:19:\"2026-06-16 19:00:35\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:3:{s:6:\"status\";s:7:\"boolean\";s:10:\"start_date\";s:4:\"date\";s:8:\"end_date\";s:4:\"date\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:4:{i:0;s:4:\"name\";i:1;s:6:\"status\";i:2;s:10:\"start_date\";i:3;s:8:\"end_date\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:6:\"campus\";O:17:\"App\\Models\\Campus\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:8:\"campuses\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:54:\"Centro Preuniversitario Juan Francisco Aguinaga Castro\";s:7:\"address\";s:44:\"Av. José Leonardo Ortiz 405, Chiclayo, Peru\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:11:\"\0*\0original\";a:6:{s:2:\"id\";i:1;s:4:\"name\";s:54:\"Centro Preuniversitario Juan Francisco Aguinaga Castro\";s:7:\"address\";s:44:\"Av. José Leonardo Ortiz 405, Chiclayo, Peru\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:56:16\";s:10:\"updated_at\";s:19:\"2026-06-16 18:56:16\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:3:{i:0;s:4:\"name\";i:1;s:7:\"address\";i:2;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}s:5:\"shift\";O:16:\"App\\Models\\Shift\":33:{s:13:\"\0*\0connection\";s:5:\"mysql\";s:8:\"\0*\0table\";s:6:\"shifts\";s:13:\"\0*\0primaryKey\";s:2:\"id\";s:10:\"\0*\0keyType\";s:3:\"int\";s:12:\"incrementing\";b:1;s:7:\"\0*\0with\";a:0:{}s:12:\"\0*\0withCount\";a:0:{}s:19:\"preventsLazyLoading\";b:0;s:10:\"\0*\0perPage\";i:15;s:6:\"exists\";b:1;s:18:\"wasRecentlyCreated\";b:0;s:28:\"\0*\0escapeWhenCastingToString\";b:0;s:13:\"\0*\0attributes\";a:5:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Mañana y Tarde\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:59:51\";s:10:\"updated_at\";s:19:\"2026-06-16 18:59:51\";}s:11:\"\0*\0original\";a:5:{s:2:\"id\";i:4;s:4:\"name\";s:15:\"Mañana y Tarde\";s:6:\"status\";i:1;s:10:\"created_at\";s:19:\"2026-06-16 18:59:51\";s:10:\"updated_at\";s:19:\"2026-06-16 18:59:51\";}s:10:\"\0*\0changes\";a:0:{}s:11:\"\0*\0previous\";a:0:{}s:8:\"\0*\0casts\";a:1:{s:6:\"status\";s:7:\"boolean\";}s:17:\"\0*\0classCastCache\";a:0:{}s:21:\"\0*\0attributeCastCache\";a:0:{}s:13:\"\0*\0dateFormat\";N;s:10:\"\0*\0appends\";a:0:{}s:19:\"\0*\0dispatchesEvents\";a:0:{}s:14:\"\0*\0observables\";a:0:{}s:12:\"\0*\0relations\";a:0:{}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:2:{i:0;s:4:\"name\";i:1;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:10:\"\0*\0touches\";a:0:{}s:27:\"\0*\0relationAutoloadCallback\";N;s:26:\"\0*\0relationAutoloadContext\";N;s:10:\"timestamps\";b:1;s:13:\"usesUniqueIds\";b:0;s:9:\"\0*\0hidden\";a:0:{}s:10:\"\0*\0visible\";a:0:{}s:11:\"\0*\0fillable\";a:6:{i:0;s:17:\"academic_cycle_id\";i:1;s:9:\"campus_id\";i:2;s:8:\"shift_id\";i:3;s:8:\"capacity\";i:4;s:8:\"enrolled\";i:5;s:6:\"status\";}s:10:\"\0*\0guarded\";a:1:{i:0;s:1:\"*\";}}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}',1782086069);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
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
-- Table structure for table `campuses`
--

DROP TABLE IF EXISTS `campuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campuses_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campuses`
--

LOCK TABLES `campuses` WRITE;
/*!40000 ALTER TABLE `campuses` DISABLE KEYS */;
INSERT INTO `campuses` VALUES
(1,'Centro Preuniversitario Juan Francisco Aguinaga Castro','Av. José Leonardo Ortiz 405, Chiclayo, Peru',1,'2026-06-16 18:56:16','2026-06-16 18:56:16');
/*!40000 ALTER TABLE `campuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `careers`
--

DROP TABLE IF EXISTS `careers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `careers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `careers_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `careers`
--

LOCK TABLES `careers` WRITE;
/*!40000 ALTER TABLE `careers` DISABLE KEYS */;
INSERT INTO `careers` VALUES
(1,'ADMINISTRACIÓN','ADM',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(2,'AGRONOMÍA','AGR',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(3,'ARQUEOLOGÍA','ARK',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(4,'ARQUITECTURA','ARC',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(5,'ARTE - ARTES PLÁSTICAS','ARP',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(6,'ARTE - PEDAGOGÍA ARTÍSTICA','APA',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(7,'ARTE - DANZAS','ARD',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(8,'ARTE - MÚSICA','ARM',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(9,'ARTE - TEATRO','ART',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(10,'CIENCIA POLÍTICA','CPO',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(11,'CIENCIAS BIOLÓGICAS - BIOLOGÍA','CBB',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(12,'CIENCIAS BIOLÓGICAS - BOTÁNICA','CBT',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(13,'CIENCIAS BIOLÓGICAS - MICROBIOLOGÍA - PARASITOLOGÍA','CBM',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(14,'CIENCIAS BIOLÓGICAS - PESQUERÍA','CBP',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(15,'CIENCIAS DE LA COMUNICACIÓN','CDC',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(16,'COMERCIO Y NEGOCIOS INTERNACIONALES','CNI',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(17,'CONTABILIDAD','CON',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(18,'DERECHO','DER',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(19,'ECONOMÍA','ECO',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(20,'EDUCACIÓN - CIENCIAS HIST. SOC. Y FILOSOFÍA','EHS',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(21,'EDUCACIÓN - CIENCIAS NATURALES','ECN',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(22,'EDUCACIÓN - EDUCACIÓN FÍSICA','EEF',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(23,'EDUCACIÓN - IDIOMAS EXTRANJEROS','EIE',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(24,'EDUCACIÓN - INICIAL','EIN',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(25,'EDUCACIÓN - LENGUA Y LITERATURA','ELL',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(26,'EDUCACIÓN - MATEMÁTICA Y COMPUTACIÓN','EMC',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(27,'EDUCACIÓN - PRIMARIA','EPR',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(28,'ENFERMERÍA','ENF',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(29,'ESTADÍSTICA','EST',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(30,'FÍSICA','FIS',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(31,'INGENIERÍA AGRÍCOLA','IAG',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(32,'INGENIERÍA CIVIL','ICV',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(33,'INGENIERÍA DE INDUSTRIAS ALIMENTARIAS','IIA',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(34,'INGENIERÍA DE SISTEMAS','ISI',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(35,'INGENIERÍA ELECTRÓNICA','IEL',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(36,'INGENIERÍA EN COMPUTACIÓN E INFORMÁTICA','ICI',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(37,'INGENIERÍA MECÁNICA Y ELÉCTRICA','IME',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(38,'INGENIERÍA QUÍMICA','IQU',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(39,'INGENIERÍA ZOOTECNIA','IZO',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(40,'MATEMÁTICAS','MAT',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(41,'MEDICINA HUMANA','MED',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(42,'MEDICINA VETERINARIA','MVE',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(43,'PSICOLOGÍA','PSI',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(44,'SOCIOLOGÍA','SOC',1,'2026-06-16 18:56:16','2026-06-16 18:56:16');
/*!40000 ALTER TABLE `careers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom_movements`
--

DROP TABLE IF EXISTS `classroom_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom_movements` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `from_classroom_id` bigint(20) unsigned DEFAULT NULL,
  `to_classroom_id` bigint(20) unsigned NOT NULL,
  `moved_by` bigint(20) unsigned DEFAULT NULL,
  `reason` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_movements_student_id_foreign` (`student_id`),
  KEY `classroom_movements_from_classroom_id_foreign` (`from_classroom_id`),
  KEY `classroom_movements_to_classroom_id_foreign` (`to_classroom_id`),
  KEY `classroom_movements_moved_by_foreign` (`moved_by`),
  KEY `cm_cycle_student_created_index` (`academic_cycle_id`,`student_id`,`created_at`),
  CONSTRAINT `classroom_movements_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `classroom_movements_from_classroom_id_foreign` FOREIGN KEY (`from_classroom_id`) REFERENCES `classrooms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `classroom_movements_moved_by_foreign` FOREIGN KEY (`moved_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  CONSTRAINT `classroom_movements_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classroom_movements_to_classroom_id_foreign` FOREIGN KEY (`to_classroom_id`) REFERENCES `classrooms` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom_movements`
--

LOCK TABLES `classroom_movements` WRITE;
/*!40000 ALTER TABLE `classroom_movements` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classrooms`
--

DROP TABLE IF EXISTS `classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `classrooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(32) NOT NULL,
  `floor` smallint(5) unsigned NOT NULL DEFAULT 1,
  `capacity` smallint(5) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `academic_priority` smallint(5) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classrooms_cycle_code_unique` (`academic_cycle_id`,`code`),
  KEY `classrooms_cycle_status_priority_index` (`academic_cycle_id`,`status`,`academic_priority`),
  CONSTRAINT `classrooms_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classrooms`
--

LOCK TABLES `classrooms` WRITE;
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluations`
--

DROP TABLE IF EXISTS `evaluations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(40) NOT NULL DEFAULT 'regular',
  `weight` decimal(6,2) NOT NULL DEFAULT 1.00,
  `counts_for_average` tinyint(1) NOT NULL DEFAULT 1,
  `rounding_decimals` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `evaluations_cycle_name_unique` (`academic_cycle_id`,`name`),
  KEY `evaluations_created_by_foreign` (`created_by`),
  KEY `evaluations_cycle_type_status_index` (`academic_cycle_id`,`type`,`status`),
  CONSTRAINT `evaluations_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `evaluations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluations`
--

LOCK TABLES `evaluations` WRITE;
/*!40000 ALTER TABLE `evaluations` DISABLE KEYS */;
INSERT INTO `evaluations` VALUES
(1,1,'Examen de ubicación','ubicación',0.00,0,2,1,NULL,'2026-06-17 07:30:44','2026-06-17 07:30:44',NULL),
(2,1,'Examen medio ciclo','medio_ciclo',1.00,1,2,1,NULL,'2026-06-17 07:30:44','2026-06-17 07:30:44',NULL),
(3,1,'Examen final','final',1.00,1,2,1,NULL,'2026-06-17 07:30:44','2026-06-17 07:30:44',NULL);
/*!40000 ALTER TABLE `evaluations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_settings`
--

DROP TABLE IF EXISTS `exam_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `exam_date` date DEFAULT NULL,
  `exam_time` varchar(64) DEFAULT NULL,
  `exam_location` varchar(500) DEFAULT NULL,
  `institutional_message` text DEFAULT NULL,
  `registration_success_message` text DEFAULT NULL,
  `registration_confirmation_message` text DEFAULT NULL,
  `active_verification_message` text DEFAULT NULL,
  `registration_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `registration_mail_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `registration_mail_attach_enrollment_form` tinyint(1) NOT NULL DEFAULT 1,
  `registration_mail_attach_regulations` tinyint(1) NOT NULL DEFAULT 1,
  `active_verification_mail_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `public_results_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_settings`
--

LOCK TABLES `exam_settings` WRITE;
/*!40000 ALTER TABLE `exam_settings` DISABLE KEYS */;
INSERT INTO `exam_settings` VALUES
(1,NULL,NULL,NULL,'Especificaciones para la foto del carnet\r\n\r\nFoto tamaño pasaporte, preferentemente 3.8 cm x 4.8 cm o similar.\r\nFormato JPG.\r\nFondo blanco.\r\nEl alumno debe mirar directamente a la cámara, con expresión neutral y ojos abiertos.\r\nRostro totalmente despejado, sin cabello cubriendo la cara, lentes, piercing, collares, gorros u otros accesorios.\r\nNo se aceptan selfies.\r\nNo se aceptan fotos tomadas a una foto impresa.\r\nEl archivo debe nombrarse con el DNI del alumno, por ejemplo: 12345678.jpg.\r\nSe rechazará toda foto que no cumpla con estas especificaciones\r\nEnviar al Correo : soporteinformatico_cpu@unprg.edu.pe',NULL,NULL,NULL,0,1,0,1,0,0,'2026-06-16 18:56:16','2026-06-18 07:56:11');
/*!40000 ALTER TABLE `exam_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `grades` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `evaluation_id` bigint(20) unsigned NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `observations` varchar(500) DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grades_student_id_evaluation_id_unique` (`student_id`,`evaluation_id`),
  KEY `grades_created_by_foreign` (`created_by`),
  KEY `grades_evaluation_id_score_index` (`evaluation_id`,`score`),
  KEY `grades_student_id_score_index` (`student_id`,`score`),
  CONSTRAINT `grades_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  CONSTRAINT `grades_evaluation_id_foreign` FOREIGN KEY (`evaluation_id`) REFERENCES `evaluations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `grades_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guardians`
--

DROP TABLE IF EXISTS `guardians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guardians` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `mother_last_name` varchar(255) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `phone` varchar(9) NOT NULL,
  `relationship` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guardians`
--

LOCK TABLES `guardians` WRITE;
/*!40000 ALTER TABLE `guardians` DISABLE KEYS */;
INSERT INTO `guardians` VALUES
(1,'CARMEN ROSA','IZQUIERDO','CORDOVA','41386378','942926927','guardian','2026-06-16 19:10:50','2026-06-16 19:10:50'),
(2,'SEGUNDO LEONCIO','CAYAO','CHAVEZ','41625031','978256303','father','2026-06-17 08:08:43','2026-06-17 08:08:43'),
(3,'JOSE ANTONIO','VELIZ','NARBAIZA','16783974','971482811','father','2026-06-17 08:12:08','2026-06-17 08:12:08'),
(4,'KELLY YSABEL','SANCHEZ','CORONADO','16700201','957843615','mother','2026-06-17 08:13:09','2026-06-17 08:13:09'),
(5,'JUANA KARINA','TERRONES','CHAYAN','47533630','974817487','guardian','2026-06-17 08:25:25','2026-06-17 08:25:25'),
(6,'CESAR ALBERTO','CHAVESTA','PAIVA','17446848','979998090','father','2026-06-17 08:53:20','2026-06-17 08:53:20'),
(7,'EDSON LIONEL','POLO','MEDINA','16672962','978953589','father','2026-06-17 08:53:33','2026-06-17 08:53:33'),
(8,'GIULLIANA PAMELA','BANCES','LORENZO','41993461','969581813','mother','2026-06-17 09:02:26','2026-06-17 09:02:26'),
(9,'MILAGROS DEL CARMEN','CALDERON','MILLONES','40027550','916631960','mother','2026-06-17 09:07:54','2026-06-17 09:07:54'),
(10,'MONICA','BARRIENTOS','ALEMAN','00244304','947662021','mother','2026-06-17 09:08:39','2026-06-17 09:08:39'),
(11,'ANA MARIA','SOLANO','LEYVA','48665627','932101141','mother','2026-06-17 09:14:09','2026-06-17 09:14:09'),
(12,'KATHRINE YULIANA','PERALTA','ARROYO','44310742','918658868','mother','2026-06-17 09:15:29','2026-06-17 09:19:54'),
(13,'MARTHA','RAFAEL','BAUTISTA','41929594','943220518','mother','2026-06-17 09:35:45','2026-06-17 09:35:45'),
(14,'VIRGINIA ELIZABETH','MORANTE','ROJAS','40623176','963137640','mother','2026-06-17 09:36:54','2026-06-17 09:36:54'),
(15,'ELSA PIEDAD','REUPO','BRENIS','40098181','978100065','mother','2026-06-17 09:41:06','2026-06-17 09:41:06'),
(16,'HENGER','CAPUÑAY','FENCO','16729793','960221786','father','2026-06-17 09:45:59','2026-06-17 10:22:04'),
(17,'MARITZA DEL ROCIO','MACALOPU','PURISACA','45499296','940601369','mother','2026-06-17 09:54:38','2026-06-17 09:54:38'),
(18,'ISABEL CRISTINA','CASTRO','TAVARA','42754536','954404307','mother','2026-06-17 09:56:19','2026-06-17 09:56:19'),
(19,'DELINA','CUBAS','MEJIA','45571880','947959115','mother','2026-06-17 10:01:28','2026-06-17 10:01:28'),
(20,'MARIA DEL ROSARIO','YABE','HUAMAN','16484610','942686199','guardian','2026-06-17 10:17:18','2026-06-17 10:17:18'),
(21,'ALAN SAMUEL','AREVALO','CASTILLO','46402525','976519711','father','2026-06-17 10:26:39','2026-06-17 10:26:39'),
(22,'JESUS MARIA','REQUENA','MARQUEZ','03367971','969572307','mother','2026-06-17 10:34:05','2026-06-17 10:34:05'),
(23,'VANESSA YOLANDA','TORO','SANCHEZ','41810030','947594227','mother','2026-06-17 10:37:30','2026-06-17 10:37:30'),
(24,'LUIS ALBERTO','ALACHE','CALLACNA','42109762','951562530','father','2026-06-17 10:40:12','2026-06-17 10:40:12'),
(25,'LUIS ENRIQUE','CHAMBERGO','ALCALDE','16448358','979174252','guardian','2026-06-17 10:46:20','2026-06-17 10:46:20'),
(26,'OSMAR OSWALDO','SANCHEZ','MALCA','42398453','969618209','father','2026-06-17 10:49:40','2026-06-17 10:49:40'),
(27,'CESAR','ENEQUE','FLORES','16627465','979553539','father','2026-06-17 10:55:13','2026-06-17 10:55:13'),
(28,'PABLO EPIFANIO','ZUÑIGA','NAVARRO','20028644','996020150','father','2026-06-17 10:55:28','2026-06-17 10:55:28'),
(29,'MARIA ROXANA','ESPINOZA','PUICAN','44268574','965912920','mother','2026-06-17 11:01:16','2026-06-17 11:01:16'),
(30,'LUCIA','SIGUEÑAS','REYES','42595315','915129051','mother','2026-06-17 11:08:25','2026-06-17 11:08:25'),
(31,'TANIA JHANETH','RODRIGUEZ','GERONIMO','44142877','947599035','mother','2026-06-17 11:14:42','2026-06-17 11:14:42'),
(32,'CARMEN SOCORRO','GONZALES','MURO DE APOLO','16737491','985480612','mother','2026-06-17 11:16:23','2026-06-17 11:16:23'),
(33,'MAXIMO GUSTAVO','GONZALES','LOPEZ','16723294','979825172','father','2026-06-17 11:19:27','2026-06-17 11:19:27'),
(34,'JUAN AUGUSTO','SALDAÑA','CAJUSOL','42558076','978093618','father','2026-06-17 11:21:41','2026-06-17 11:21:41'),
(35,'LOURDES YSABEL','DE LOS SANTOS','CASTRO','43394363','971995238','mother','2026-06-17 11:28:11','2026-06-17 11:28:11'),
(36,'MARIA TERESA','GONZALES','GALAN DE GONZLAES','17596566','978433129','mother','2026-06-17 11:32:25','2026-06-17 11:32:25'),
(37,'SANDRO TOMAS','MACO','ROBLES','17401729','965941939','father','2026-06-17 11:33:46','2026-06-17 11:33:46'),
(38,'YERI','SOPLAPUCO','CAJUSOL','45655623','969591424','mother','2026-06-17 11:40:05','2026-06-17 11:40:05'),
(39,'CINTHIA CATHERINE','VEGA','ARAGON','44191267','941173207','mother','2026-06-17 11:46:24','2026-06-17 11:46:24'),
(40,'ROXANA','CAMPOS','CALDERON','40421580','930971420','mother','2026-06-17 11:47:06','2026-06-17 11:47:06'),
(41,'GUILLERMO OMAR','GUERRERO','CERVANTES','16710161','923188244','father','2026-06-17 11:52:32','2026-06-17 11:52:32'),
(42,'SANDRA JANET','INOÑAN','SANTOYO','42492990','912817257','mother','2026-06-17 11:53:22','2026-06-17 11:53:22'),
(43,'MELISSA SCARLET','SHOWING','TERAN','45490131','989520360','mother','2026-06-17 12:01:12','2026-06-17 12:01:12'),
(44,'HELDER ENRIQUE','LOPEZ','FERNANDEZ','16801280','941123989','father','2026-06-17 12:11:11','2026-06-17 12:11:11'),
(45,'JOSE LUIS','RODRIGUEZ','CESPEDES','17452712','938315198','father','2026-06-17 12:34:48','2026-06-17 12:34:48'),
(46,'KARIN NATALY','PEZO','FRANCO','41555589','938952175','mother','2026-06-17 12:40:04','2026-06-17 12:40:04'),
(47,'MARIA AUREA','CORONADO','PITA','27681610','976870779','guardian','2026-06-17 13:39:59','2026-06-17 13:39:59'),
(48,'DORIS MARITZA','MACO','SERRATO','40772750','979268581','mother','2026-06-17 13:45:01','2026-06-17 13:45:01'),
(49,'ROXANA MARINA','TAY','LLONTOP','40920756','931444381','mother','2026-06-17 14:20:53','2026-06-17 14:20:53'),
(50,'NORMA DHAYANA','PAISIG','FERNANEZ','73622237','976349314','guardian','2026-06-17 14:23:20','2026-06-17 14:23:20'),
(51,'YURI YOANA','LOPEZ','CHAVEZ','45899646','920101899','mother','2026-06-17 14:30:30','2026-06-17 14:30:30'),
(52,'NOEMI','PEREZ','URIARTE','45268776','978182268','mother','2026-06-17 14:53:37','2026-06-17 14:53:37'),
(53,'KELY','VIDAL','VEGA','16793604','905774549','mother','2026-06-17 14:55:20','2026-06-17 14:55:20'),
(54,'MARIA ALTAGRACIA','PARIATON','CHAMBA','03120995','970083928','mother','2026-06-17 15:00:51','2026-06-17 15:00:51'),
(55,'OMAR BALTAZAR','OBLITAS','GUERRERO','27736515','957884929','father','2026-06-18 08:19:45','2026-06-18 08:19:45'),
(56,'ROSA ANGELICA','DIAZ','CARHUANTANTA DE TINEO','40981499','950933759','mother','2026-06-18 08:21:53','2026-06-18 08:21:53'),
(57,'CESAR AUGUSTO','SANTAMARIA','CHAPOÑAN','17638258','923660564','father','2026-06-18 08:34:19','2026-06-18 08:34:19'),
(58,'DILMER JOEL','DIAZ','RODRIGUEZ','74646099','961345544','guardian','2026-06-18 08:45:30','2026-06-18 08:45:30'),
(59,'LEIDY XIOMARA','PERALTA','SUCLUPE','76368491','979481969','guardian','2026-06-18 08:52:29','2026-06-18 08:52:29'),
(60,'JUANA ELISSET','FERNANDEZ','DIAZ','43257890','966537390','mother','2026-06-18 08:55:28','2026-06-18 08:55:28'),
(61,'ZENAIDA ANABELLA','DELGADO','CARPIO','16662727','945105334','mother','2026-06-18 09:08:00','2026-06-18 09:08:00'),
(62,'IRIS MANERELY','MILIAN','ROSALES','16716179','929852581','mother','2026-06-18 09:36:58','2026-06-18 09:36:58'),
(63,'ISABEL','RUBIO','MARIN','40545915','999199063','mother','2026-06-18 09:37:44','2026-06-18 09:37:44'),
(64,'CARLA ELIZABETH','COBEÑAS','MONTEZA','43352879','920125738','mother','2026-06-18 09:42:37','2026-06-18 09:42:37'),
(65,'EDGAR OVIDIO','GARCIA','CARBAJAL','10341268','938481799','father','2026-06-18 09:46:02','2026-06-18 09:46:02'),
(66,'ALEJANDRA ISABEL','RAMIREZ','CASTAÑEDA','75133603','922588644','guardian','2026-06-18 10:03:17','2026-06-18 10:03:17'),
(67,'FLORENCIA','FLORES','ORDOÑEZ','42418477','983148687','mother','2026-06-18 10:11:51','2026-06-18 10:11:51'),
(68,'ROXANY ELIZABETH','SIGNOL','TORRES','47353374','950434758','aunt','2026-06-18 10:37:51','2026-06-18 10:37:51'),
(69,'ILIANA DEL LOURDES','ESTEVES','CORTEZ','17639096','978076469','aunt','2026-06-18 10:39:42','2026-06-18 10:39:42'),
(70,'MARY OLIVIA','THURKOWLSKY','PUNTRIANO','27722162','946229978','guardian','2026-06-18 10:45:58','2026-06-18 10:45:58'),
(71,'GLADYS','PUESCAS','SABA','40732601','945047345','mother','2026-06-18 11:44:17','2026-06-18 11:44:17'),
(72,'SILVIA DEL PILAR','CARRASCO','RAMOS','16691081','902044057','mother','2026-06-18 12:03:50','2026-06-18 12:03:50'),
(73,'JACQUELINE MEDALID','ALCANTARA','VASQUEZ','16804350','945980221','mother','2026-06-18 13:04:55','2026-06-18 13:04:55'),
(74,'CARLOS EDUARDO','ARRIAGA','ALVARADO','16690317','972349359','father','2026-06-18 13:05:45','2026-06-18 13:05:45'),
(75,'NATHALY GERALDINE','NECIOSUP','ANGELES','43472298','950612754','mother','2026-06-18 13:10:15','2026-06-18 13:10:15'),
(76,'PATRICIA IVONNE','CHAVEZ','RIVAS','40663704','972683471','mother','2026-06-18 13:14:56','2026-06-18 13:14:56'),
(77,'LUIS ALBERTO','TUESTA','JIMENEZ','44378013','925369567','uncle','2026-06-18 13:19:58','2026-06-18 13:19:58'),
(78,'JORGE ARMANDO','SAMPEN','CELIS','40831841','955979662','father','2026-06-18 13:22:18','2026-06-18 13:22:18'),
(79,'MARCO ANTONIO','CUSTODIO','BALLENA','16765068','910427410','father','2026-06-18 13:34:48','2026-06-18 13:34:48'),
(80,'JUANITA ROSA','BANCES','ÑAÑAQUE','45298660','939381485','mother','2026-06-18 13:41:16','2026-06-18 13:41:16'),
(82,'EVERT YOEL','FACIO','SOPLOPUCO','45020195','945141991','father','2026-06-18 14:09:54','2026-06-18 14:12:19'),
(83,'CARLOS ALBERTO','LIZA','DIAZ','40179551','979690317','father','2026-06-18 14:16:12','2026-06-18 14:16:12'),
(84,'CAMILA LUCIA','MIRANDA','CHIRA','70269361','984277995','guardian','2026-06-18 14:21:03','2026-06-18 14:21:03'),
(85,'ROXANA MARIBEL','PAREDES','CALDERON','41954237','951840143','mother','2026-06-18 14:23:17','2026-06-18 14:23:17'),
(86,'MENNELIA','CORDOVA','AMBULAY','45624090','912956455','mother','2026-06-18 14:26:51','2026-06-18 14:26:51'),
(87,'MARIA DEL PILAR','SEGURA','SANTAMARIA','46257419','978713222','mother','2026-06-18 14:30:42','2026-06-18 14:30:42'),
(88,'SANTOS WILMER','ROJAS','RODAS','19331722','989880253','father','2026-06-19 07:54:31','2026-06-19 07:54:31'),
(89,'KIARA ANAHI','DELGADO','MORALES','61160207','935092154','guardian','2026-06-19 09:48:12','2026-06-19 09:48:12'),
(90,'JOSE ANTONIO','GUERRERO','MENDOZA','17595354','939594179','father','2026-06-19 10:28:44','2026-06-19 10:28:44'),
(91,'ROSA ANGELICA','PEREZ','TERRONES','40876960','931531998','mother','2026-06-19 10:49:27','2026-06-19 10:49:27'),
(92,'ALESSANDRA EFIGENIA','FERNANDEZ','PUMARICRA','60791126','957495549','guardian','2026-06-19 11:25:18','2026-06-19 11:25:18'),
(93,'MARIA SANTOS','SENMACHE','LLONTOP','16679830','996153203','mother','2026-06-19 11:43:32','2026-06-19 11:43:32'),
(94,'JANET YVONNE','PUICON','BANCES','16730910','927744386','mother','2026-06-19 11:59:05','2026-06-19 11:59:05'),
(95,'JANNET JACKELINE','MILIAN','ROSALES','16773568','960860893','mother','2026-06-19 12:09:40','2026-06-19 12:09:40'),
(96,'LEONARDO ALONSO','TIPIANI','CAMACHO','42002276','939422103','father','2026-06-19 12:22:37','2026-06-19 12:22:37'),
(97,'LORENA LISSET','CORTEZ','LIZANA','44411856','942331929','mother','2026-06-19 12:38:32','2026-06-19 12:38:32'),
(98,'JUANA JANNET','CORTEZ','JARA','16784871','979931871','mother','2026-06-19 12:44:51','2026-06-19 12:44:51'),
(99,'DAYANA JAMILET','RIQUERO','BAZAN','70741760','985128903','guardian','2026-06-19 13:47:13','2026-06-19 13:47:13'),
(100,'CARLOS MANUEL','MINGUILLO','SAENZ','16688389','950701827','father','2026-06-19 14:21:33','2026-06-19 14:21:33'),
(101,'SAULO FARID','YUNIS','OLIVERA','42262088','903004431','father','2026-06-19 14:56:15','2026-06-19 14:56:15');
/*!40000 ALTER TABLE `guardians` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2026_05_11_100000_create_roles_table',1),
(5,'2026_05_11_100001_create_staff_table',1),
(6,'2026_05_11_100002_drop_legacy_user_tables',1),
(7,'2026_05_11_110000_create_campuses_table',1),
(8,'2026_05_11_110001_create_shifts_table',1),
(9,'2026_05_11_110002_create_academic_cycles_table',1),
(10,'2026_05_11_110003_create_academic_cycle_shifts_table',1),
(11,'2026_05_11_120000_create_guardians_table',1),
(12,'2026_05_11_120001_create_schools_table',1),
(13,'2026_05_11_120002_create_careers_table',1),
(14,'2026_05_11_120003_create_students_table',1),
(15,'2026_05_11_140000_add_registration_performance_indexes',1),
(16,'2026_05_12_120000_create_exam_settings_table',1),
(17,'2026_05_12_120001_create_student_mail_logs_table',1),
(18,'2026_05_14_100000_create_admission_processes_table',1),
(19,'2026_05_14_100001_add_admission_process_id_to_students_table',1),
(20,'2026_05_15_000001_allow_student_dni_per_academic_cycle',1),
(21,'2026_05_15_100000_add_student_admin_listing_indexes',1),
(22,'2026_05_16_180000_add_payment_fields_to_students_table',1),
(23,'2026_05_17_150000_add_registration_mail_enabled_to_exam_settings_table',1),
(24,'2026_05_19_081321_create_activity_logs_table',1),
(25,'2026_05_23_110000_create_academic_management_tables',1),
(26,'2026_05_24_100000_add_spatie_permission_support',1),
(27,'2026_05_24_110000_create_staff_temporary_permission_grants_table',1),
(28,'2026_05_25_180000_add_public_results_enabled_to_exam_settings_table',1),
(29,'2026_05_28_000000_make_student_guardian_nullable',1),
(30,'2026_06_06_100000_add_registration_enabled_to_exam_settings_table',1),
(31,'2026_06_07_130000_create_announcements_table',1),
(32,'2026_06_15_120000_add_email_verification_fields_to_students_table',1),
(33,'2026_06_16_090000_add_separate_registration_messages_to_exam_settings_table',1),
(34,'2026_06_16_100000_add_active_verification_mail_enabled_to_exam_settings_table',1),
(35,'2026_06_16_154500_expand_academic_cycle_name_length',1),
(36,'2026_06_17_120000_add_student_group_report_permission',2),
(37,'2026_06_17_130000_add_registration_mail_attachment_settings_to_exam_settings_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES
(1,'App\\Models\\Staff',1),
(3,'App\\Models\\Staff',2),
(3,'App\\Models\\Staff',3),
(3,'App\\Models\\Staff',4),
(4,'App\\Models\\Staff',5),
(4,'App\\Models\\Staff',6);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'exam-settings.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(2,'announcements.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(3,'announcements.create','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(4,'announcements.update','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(5,'announcements.delete','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(6,'dashboard.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(7,'staff.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(8,'staff.create','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(9,'staff.update','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(10,'staff.delete','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(11,'roles.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(12,'roles.update','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(13,'academic-cycles.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(14,'academic-cycles.manage','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(15,'exam-settings.update','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(16,'students.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(17,'students.create','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(18,'students.update','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(19,'students.delete','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(20,'students.documents','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(21,'academic.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(22,'academic.classrooms.manage','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(23,'academic.distribution.manage','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(24,'academic.grades.manage','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(25,'academic.imports.manage','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(26,'reports.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(27,'reports.export','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(28,'reports.students.export','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(29,'reports.emails.export','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(30,'reports.treasury.export','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(31,'academic.reports.view','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(32,'academic.reports.export','web','2026-06-16 18:56:16','2026-06-16 18:56:16'),
(33,'reports.students.group.export','web','2026-06-17 20:25:51','2026-06-17 20:25:51');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES
(1,1),
(1,2),
(2,1),
(2,2),
(3,1),
(3,2),
(4,1),
(4,2),
(5,1),
(5,2),
(6,1),
(6,2),
(6,3),
(6,4),
(7,1),
(7,2),
(8,1),
(8,2),
(9,1),
(9,2),
(10,1),
(10,2),
(11,1),
(11,2),
(12,1),
(12,2),
(13,1),
(13,2),
(14,1),
(14,2),
(15,1),
(15,2),
(16,1),
(16,2),
(16,3),
(16,4),
(17,1),
(17,2),
(17,3),
(18,1),
(18,2),
(18,3),
(19,1),
(19,2),
(20,1),
(20,2),
(20,3),
(20,4),
(21,1),
(21,2),
(21,3),
(22,1),
(22,2),
(23,1),
(23,2),
(24,1),
(24,2),
(25,1),
(25,2),
(25,3),
(26,1),
(26,2),
(26,4),
(27,1),
(27,2),
(27,4),
(28,1),
(28,2),
(28,4),
(29,1),
(29,2),
(29,4),
(30,1),
(30,2),
(30,4),
(31,1),
(31,2),
(31,4),
(32,1),
(32,2),
(32,4),
(33,1),
(33,2),
(33,4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) NOT NULL DEFAULT 'web',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`),
  KEY `roles_guard_name_index` (`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'super_admin',1,'2026-06-16 18:56:16','2026-06-16 18:56:16','web'),
(2,'admin',1,'2026-06-16 18:56:16','2026-06-16 18:56:16','web'),
(3,'trabajador',1,'2026-06-16 18:56:16','2026-06-16 18:56:16','web'),
(4,'asistente',1,'2026-06-16 18:56:16','2026-06-16 18:56:16','web');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `schools` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `graduation_year` smallint(5) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES
(1,'I.E. IGNACIA VELÁSQUEZ','SAN MARTÍN','MOYOBAMBA','MOYOBAMBA',2025,'2026-06-16 19:10:50','2026-06-16 19:10:50'),
(3,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2023,'2026-06-17 08:08:43','2026-06-17 08:08:43'),
(4,'NUESTRA SEÑORA DEL CARMEN','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-17 08:12:08','2026-06-17 08:12:08'),
(5,'IE LA MEDALLA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2020,'2026-06-17 08:13:09','2026-06-17 08:13:09'),
(6,'AFULL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2024,'2026-06-17 08:25:25','2026-06-17 08:25:25'),
(7,'ELIAS AGUIRRE','LAMBAYEQUE','CHICLAYO','PIMENTEL',2021,'2026-06-17 08:53:20','2026-06-17 08:55:28'),
(8,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 08:53:33','2026-06-17 08:53:33'),
(9,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2021,'2026-06-17 09:01:42','2026-06-17 09:01:42'),
(10,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 09:02:26','2026-06-17 09:02:26'),
(11,'MANUEL PARDO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 09:07:54','2026-06-17 09:07:54'),
(12,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 09:08:39','2026-06-17 09:08:39'),
(13,'INTERNACIONAL DE ELIM','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 09:14:09','2026-06-17 09:14:09'),
(14,'PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2024,'2026-06-17 09:15:29','2026-06-17 09:15:29'),
(15,'EMPRENDEDORES GAJEL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2017,'2026-06-17 09:22:21','2026-06-17 09:22:21'),
(16,'JOSE BAQUIJANO Y CARRILLO','LIMA','LIMA','LINCE',2023,'2026-06-17 09:24:34','2026-06-17 09:28:10'),
(17,'AUGUSTA LOPEZ ARENAS','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2022,'2026-06-17 09:31:25','2026-06-17 09:31:25'),
(18,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 09:35:45','2026-06-17 09:35:45'),
(19,'MARIA LUCRECIA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2022,'2026-06-17 09:36:54','2026-06-17 09:36:54'),
(20,'MARIA INMACULADA','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2025,'2026-06-17 09:41:06','2026-06-17 09:41:06'),
(21,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2021,'2026-06-17 09:45:59','2026-06-17 10:20:45'),
(22,'ELIAS AGUIRRE','LAMBAYEQUE','CHICLAYO','PIMENTEL',2024,'2026-06-17 09:47:47','2026-06-17 09:47:47'),
(23,'AFULL','LAMBAYEQUE','FERREÑAFE','PUEBLO NUEVO',2024,'2026-06-17 09:54:38','2026-06-17 09:54:38'),
(24,'PARROQUIAL SEÑOR DE HUAMANTANGA','CAJAMARCA','JAÉN','JAÉN',2025,'2026-06-17 09:56:19','2026-06-17 09:56:19'),
(25,'ELIAS AGUIRRE','LAMBAYEQUE','CHICLAYO','PIMENTEL',2019,'2026-06-17 10:00:46','2026-06-17 10:00:46'),
(26,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-17 10:01:28','2026-06-17 10:01:28'),
(27,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 10:17:18','2026-06-17 10:17:18'),
(28,'VLEP COLLEGE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 10:26:39','2026-06-17 10:26:39'),
(29,'SAN JOSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 10:27:53','2026-06-17 10:27:53'),
(30,'TUPAC AMARU','LAMBAYEQUE','CHICLAYO','TUMAN',2025,'2026-06-17 10:34:05','2026-06-17 10:34:05'),
(31,'PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 10:37:30','2026-06-17 10:37:30'),
(32,'SARA ANTONIETA BULLON','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2024,'2026-06-17 10:40:12','2026-06-17 10:40:12'),
(33,'PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2023,'2026-06-17 10:43:06','2026-06-17 10:43:06'),
(34,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2021,'2026-06-17 10:46:20','2026-06-17 10:46:20'),
(35,'ADVENTISTA','LAMBAYEQUE','CHICLAYO','PIMENTEL',2025,'2026-06-17 10:49:40','2026-06-17 10:49:40'),
(36,'FEDERICO CASTRO','LAMBAYEQUE','CHICLAYO','MONSEFU',2025,'2026-06-17 10:55:13','2026-06-17 10:55:13'),
(37,'ADVENTISTA','LAMBAYEQUE','CHICLAYO','PIMENTEL',2025,'2026-06-17 10:55:28','2026-06-17 10:55:28'),
(38,'PARROQUIAL SEÑOR DE HUAMANTANGA','CAJAMARCA','JAÉN','JAÉN',2024,'2026-06-17 11:00:40','2026-06-17 11:00:40'),
(39,'EMANUEL','LAMBAYEQUE','CHICLAYO','SANTA ROSA',2024,'2026-06-17 11:01:16','2026-06-17 11:01:16'),
(40,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:08:25','2026-06-17 11:08:25'),
(41,'PERUANO CANADIENSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:14:42','2026-06-17 11:14:42'),
(42,'LA ANUNCIATA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2022,'2026-06-17 11:16:23','2026-06-17 11:17:11'),
(43,'SANTA MARIA REINA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:19:27','2026-06-17 11:19:27'),
(44,'ADVENTISTA','LAMBAYEQUE','CHICLAYO','PIMENTEL',2025,'2026-06-17 11:21:41','2026-06-17 11:21:41'),
(45,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:28:11','2026-06-17 11:28:11'),
(46,'SAN PEDRO','LAMBAYEQUE','LAMBAYEQUE','SAN JOSÉ',2022,'2026-06-17 11:32:25','2026-06-17 11:32:25'),
(47,'AGUSTA LOPEZ ARENAS','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2025,'2026-06-17 11:33:46','2026-06-17 11:33:46'),
(48,'CIMA','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-17 11:40:05','2026-06-17 11:40:05'),
(49,'MIGUEL ANGEL BUONARROTI','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2020,'2026-06-17 11:40:40','2026-06-17 11:40:40'),
(50,'NUESTRA SEÑORA DEL ROSARIO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:46:24','2026-06-17 11:46:24'),
(51,'PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:47:06','2026-06-17 11:47:06'),
(52,'NUESTRA SEÑORA DEL ROSARIO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 11:52:32','2026-06-17 11:52:32'),
(53,'EXCELENCIA','LAMBAYEQUE','LAMBAYEQUE','JAYANCA',2025,'2026-06-17 11:53:22','2026-06-17 11:53:22'),
(54,'SAN IGNACIO OYOLA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2013,'2026-06-17 12:00:27','2026-06-17 12:00:27'),
(55,'CONSTANTINO CARVALLO','LAMBAYEQUE','CHICLAYO','REQUE',2023,'2026-06-17 12:01:12','2026-06-17 12:01:12'),
(56,'LA APLICACION UNPRG','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2020,'2026-06-17 12:08:59','2026-06-17 12:08:59'),
(57,'I.E.P. SANTO TORIBIO DE MOGROVEJO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 12:11:11','2026-06-17 12:11:11'),
(58,'MARIA INMACULADA','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2024,'2026-06-17 12:34:48','2026-06-17 12:34:48'),
(59,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-17 12:40:04','2026-06-17 12:40:04'),
(60,'FELIZ TELLO ROJAS','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-17 13:39:59','2026-06-17 13:39:59'),
(61,'CIMA','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-17 13:45:01','2026-06-17 13:45:01'),
(62,'PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2022,'2026-06-17 13:46:33','2026-06-17 13:46:33'),
(63,'NUESTRA SEÑORA DEL ROSARIO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-17 14:20:53','2026-06-17 14:20:53'),
(64,'TRINITY','CAJAMARCA','CUTERVO','CUTERVO',2025,'2026-06-17 14:23:20','2026-06-17 14:24:02'),
(65,'JOHANS KEPLER','LAMBAYEQUE','CHICLAYO','TUMAN',2025,'2026-06-17 14:30:30','2026-06-17 14:30:30'),
(66,'JUAN PABLO VIZCARDO','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-17 14:53:37','2026-06-17 14:53:37'),
(67,'ADEU','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2024,'2026-06-17 14:55:20','2026-06-17 14:55:20'),
(68,'JAMBUR 15164','PIURA','AYABACA','PAIMAS',2019,'2026-06-17 15:00:51','2026-06-17 15:00:51'),
(69,'PERUANO CANADIENSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 08:11:14','2026-06-18 08:11:14'),
(70,'UNIVERSITY COLLEGE','LAMBAYEQUE','LAMBAYEQUE','TUCUME',2024,'2026-06-18 08:13:16','2026-06-18 08:13:16'),
(71,'SAN JOSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2027,'2026-06-18 08:19:45','2026-06-18 08:19:45'),
(72,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 08:21:53','2026-06-18 08:21:53'),
(73,'I.E. SIMON BOLIVAR','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2024,'2026-06-18 08:27:10','2026-06-18 08:27:10'),
(74,'JUAN MEJIA BACA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2023,'2026-06-18 08:27:19','2026-06-18 08:27:19'),
(75,'INGA GARCILAZO DE LA VEGA','LAMBAYEQUE','LAMBAYEQUE','MORROPE',2023,'2026-06-18 08:34:19','2026-06-18 08:34:19'),
(76,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2023,'2026-06-18 08:39:03','2026-06-18 08:39:03'),
(77,'ABRAHAM VALDEDOMAR PINTO','SAN MARTÍN','RIOJA','PARDO MIGUEL',2025,'2026-06-18 08:45:30','2026-06-18 08:45:30'),
(78,'UCAYALI','UCAYALI','CORONEL PORTILLO','CALLERIA',2022,'2026-06-18 08:46:12','2026-06-18 08:46:12'),
(79,'0006','SAN MARTÍN','MARISCAL CÁCERES','JUANJUÍ',2025,'2026-06-18 08:52:29','2026-06-18 08:52:29'),
(80,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 08:55:28','2026-06-18 08:55:28'),
(81,'NUESTRA SEÑORA DEL ROSARIO','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 09:08:00','2026-06-18 09:08:00'),
(82,'INMACULADA CONCEPCION N°11014','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 09:36:58','2026-06-18 09:37:49'),
(83,'I.E. PEDRO RUIZ GALLO','LAMBAYEQUE','CHICLAYO','POMALCA',2025,'2026-06-18 09:37:44','2026-06-18 09:37:44'),
(84,'LIDER STAR','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-18 09:42:37','2026-06-18 09:42:37'),
(85,'PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-18 09:46:02','2026-06-18 09:46:02'),
(86,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 10:03:17','2026-06-18 10:03:17'),
(87,'JOSE LEONARDO ORTIZ','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2024,'2026-06-18 10:11:51','2026-06-18 10:11:51'),
(88,'PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 10:37:51','2026-06-18 10:37:51'),
(89,'PEDRO RUIZ GALLO','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2025,'2026-06-18 10:39:42','2026-06-18 10:39:42'),
(90,'INTERNACIONAL ELIM','LAMBAYEQUE','CHICLAYO','CHICLAYO',2026,'2026-06-18 10:45:58','2026-06-18 10:45:58'),
(91,'CIMA','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2024,'2026-06-18 11:13:53','2026-06-18 11:13:53'),
(92,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2020,'2026-06-18 11:17:47','2026-06-18 11:17:47'),
(93,'SANTA MARIA DE LA PAZ','LAMBAYEQUE','CHICLAYO','PIMENTEL',2025,'2026-06-18 11:44:17','2026-06-18 11:44:17'),
(94,'MARIA INMACULADA','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2024,'2026-06-18 11:44:35','2026-06-18 11:44:35'),
(95,'AFUL','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2022,'2026-06-18 11:48:50','2026-06-18 11:48:50'),
(96,'MANUEL ANTONIO MESONES MURO','LAMBAYEQUE','FERREÑAFE','FERREÑAFE',2023,'2026-06-18 11:53:57','2026-06-18 11:53:57'),
(97,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2022,'2026-06-18 11:56:30','2026-06-18 11:56:30'),
(98,'JOSE MARIA ARGUEDAS DE CHIRINOS','CAJAMARCA','SAN IGNACIO','SAN IGNACIO',2025,'2026-06-18 11:59:49','2026-06-18 11:59:49'),
(99,'GAJEL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 12:03:50','2026-06-18 12:03:50'),
(100,'PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 13:04:55','2026-06-18 13:04:55'),
(101,'PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-18 13:05:45','2026-06-18 13:05:45'),
(102,'PEDRO RUIZ GALLO','LAMBAYEQUE','CHICLAYO','ETEN',2025,'2026-06-18 13:10:15','2026-06-18 13:10:15'),
(103,'CIMA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 13:14:56','2026-06-18 13:14:56'),
(104,'INMACULADA CONCEPCION N°11014','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 13:19:58','2026-06-18 13:19:58'),
(105,'SAN AGUSTIN','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 13:22:18','2026-06-18 13:22:18'),
(106,'AUGUATO SALAZAR BONDY','CAJAMARCA','JAÉN','JAÉN',2023,'2026-06-18 13:26:23','2026-06-18 13:27:07'),
(107,'PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 13:28:30','2026-06-18 13:28:30'),
(108,'UNIVERSIA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2022,'2026-06-18 13:33:09','2026-06-18 13:34:14'),
(109,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','MONSEFU',2024,'2026-06-18 13:34:49','2026-06-18 13:34:49'),
(110,'EXCELENCIA COLLEGE','LAMBAYEQUE','LAMBAYEQUE','TUCUME',2025,'2026-06-18 13:41:16','2026-06-18 13:41:16'),
(111,'FANNY ABANTO CALLE 10923','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2021,'2026-06-18 13:52:14','2026-06-18 13:54:18'),
(112,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2023,'2026-06-18 13:54:49','2026-06-18 13:54:49'),
(113,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 13:58:58','2026-06-18 13:58:58'),
(114,'IEP SANTO TORIBIO DE MOGROVEJO','LAMBAYEQUE','LAMBAYEQUE','MOTUPE',2025,'2026-06-18 14:09:54','2026-06-18 14:09:54'),
(115,'SANTOS LLATAS COLLEGE','LAMBAYEQUE','CHICLAYO','REQUE',2025,'2026-06-18 14:16:12','2026-06-18 14:16:12'),
(116,'ADEU','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-18 14:21:03','2026-06-18 14:21:03'),
(117,'EDUVIGIS NORIEGA DE LAFORA','LA LIBERTAD','PACASMAYO','GUADALUPE',2025,'2026-06-18 14:23:17','2026-06-18 14:23:17'),
(118,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-18 14:26:51','2026-06-18 14:26:51'),
(119,'JOSE ANTONIO ENCINAS','LAMBAYEQUE','LAMBAYEQUE','MOCHUMI',2025,'2026-06-18 14:30:42','2026-06-18 14:30:42'),
(120,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-18 14:38:09','2026-06-18 14:38:09'),
(121,'PORVERNIR','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-19 07:54:31','2026-06-19 07:54:31'),
(122,'PEDRO ABEL LAVARTE DURAN','LAMBAYEQUE','CHICLAYO','CHICLAYO',2022,'2026-06-19 09:36:15','2026-06-19 09:36:15'),
(123,'VIRGEN DE LA MEDALLA MILAGROSA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2021,'2026-06-19 09:44:41','2026-06-19 09:44:41'),
(124,'AFUL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-19 09:48:12','2026-06-19 09:48:12'),
(125,'I.E. PARTICULAR SANTOS LLATAS COLLEGE','LAMBAYEQUE','CHICLAYO','REQUE',2024,'2026-06-19 10:19:21','2026-06-19 10:19:21'),
(126,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-19 10:28:10','2026-06-19 10:28:10'),
(127,'NUESTRA SEÑORA DEL CARMEN','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2025,'2026-06-19 10:28:44','2026-06-19 10:28:44'),
(128,'EMANUEL','LAMBAYEQUE','CHICLAYO','SANTA ROSA',2025,'2026-06-19 10:49:27','2026-06-19 10:50:15'),
(129,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-19 10:54:41','2026-06-19 10:54:41'),
(130,'INKA GARCILAZO DE LA VEGA','LAMBAYEQUE','LAMBAYEQUE','MORROPE',2017,'2026-06-19 10:55:36','2026-06-19 10:55:36'),
(131,'CONSORCIO MONTESSORI','CAJAMARCA','JAÉN','JAÉN',2025,'2026-06-19 11:25:18','2026-06-19 11:25:18'),
(132,'CIMA','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-19 11:43:32','2026-06-19 11:43:32'),
(133,'KARLWEISS','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-19 11:59:05','2026-06-19 11:59:05'),
(134,'SAN JOSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2026,'2026-06-19 12:09:40','2026-06-19 12:09:40'),
(135,'JUAN UGAZ','CAJAMARCA','SANTA CRUZ','SANTA CRUZ',2023,'2026-06-19 12:20:35','2026-06-19 12:20:35'),
(136,'MARIA DE LOURDES','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2024,'2026-06-19 12:22:37','2026-06-19 12:22:37'),
(137,'SAN JOSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2019,'2026-06-19 12:32:20','2026-06-19 12:32:20'),
(138,'LAANUNCIATA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2025,'2026-06-19 12:38:32','2026-06-19 12:38:32'),
(139,'LAANUNCIATA','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2025,'2026-06-19 12:44:51','2026-06-19 12:44:51'),
(140,'SANTA MARGARITA','LAMBAYEQUE','CHICLAYO','MONSEFU',2023,'2026-06-19 13:36:25','2026-06-19 13:36:25'),
(141,'IEP PERUANO ESPAÑOL','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-19 13:36:40','2026-06-19 13:36:40'),
(142,'MATER ADMIRABILIS','LAMBAYEQUE','CHICLAYO','JOSÉ LEONARDO ORTIZ',2025,'2026-06-19 13:47:13','2026-06-19 13:47:13'),
(143,'JUAN MANUEL ITURREGUI','LAMBAYEQUE','LAMBAYEQUE','LAMBAYEQUE',2024,'2026-06-19 14:09:31','2026-06-19 14:09:31'),
(144,'VIRGEN DEL CARMEN','LAMBAYEQUE','CHICLAYO','CHICLAYO',2010,'2026-06-19 14:16:30','2026-06-19 14:16:30'),
(145,'SEÑOR DE HUAMANTANGA','CAJAMARCA','JAÉN','JAÉN',2024,'2026-06-19 14:18:14','2026-06-19 14:18:14'),
(146,'CIMA','LAMBAYEQUE','CHICLAYO','LA VICTORIA',2025,'2026-06-19 14:21:33','2026-06-19 14:21:33'),
(147,'SABIDURIA DE DIOS','LAMBAYEQUE','CHICLAYO','ETEN',2024,'2026-06-19 14:31:26','2026-06-19 14:31:26'),
(148,'EMBLEMATICO BRACAMOROS','CAJAMARCA','JAÉN','JAÉN',2024,'2026-06-19 14:38:54','2026-06-19 14:38:54'),
(149,'SANTA ANGELA','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-19 14:52:01','2026-06-19 14:52:01'),
(150,'PERUANO CANADIENSE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-19 14:56:15','2026-06-19 14:56:15'),
(151,'JORGE BASADRE','LAMBAYEQUE','CHICLAYO','CHICLAYO',2024,'2026-06-19 14:57:23','2026-06-19 14:57:23'),
(152,'FELIX TELLO ROJAS','LAMBAYEQUE','CHICLAYO','CHICLAYO',2025,'2026-06-19 15:01:40','2026-06-19 15:01:40');
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
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
INSERT INTO `sessions` VALUES
('085Hs1g1Ivk9XgcNoK8Rna0WcTEsrqKZ7GdLUDIf',NULL,'216.180.246.176','Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)','ZXlKcGRpSTZJa1J5T1VKSWVsVnNlRTB2VTAxd1lsWkdXSGh5VG5jOVBTSXNJblpoYkhWbElqb2lNSEpKWTBjNE1IVnlTRTFpZDFaNFEyRlRWMEl2T1ZSSVFVWm5TRTEzVkVaMVRFNURUSFF4ZFc1RlZVbGhNMWR0WTJOWVMycHVVR0ZsWTJKRVlqTmxkalEwUmxnM1ZXeEZXRVJITmxwQlUyOWtORVkyTkVVclIxWk1ZVmhrWVRNd2EwUXdTM2hIVGt0NmR6Um1iVmx4SzJwTVNscHljSFJZYWtZd1pYQmlRVFJMWlVwNlMwWlRSMGd3TjJ3NFQyUlpTR2R4Y2xZMGJuWkJPR2RSVEd4UVEyVlJiVTlvZUdGTmEwdzFVRVpaYUU5MGFITnFhWGhLTkUxcE1FcFBMMjFJZG5obVUyOURURWxoU0U5blFVMHhNRE15T1RWTmR6MDlJaXdpYldGaklqb2lZamM1TTJSbVpUTmlZamcyWW1Jd1pUZ3hNemhqTWprell6SmlPREJtTVdWaVlUazVOMk5rTkdRNE16UmlPRFJsWVROa1lXVTVNV1ZsWXprMFpXUTJOU0lzSW5SaFp5STZJaUo5',1782064342),
('0FdBwEGwwckTpWQQuAcnqRAw2NR2Aw2Lo9H506JX',NULL,'203.154.14.18','','ZXlKcGRpSTZJbmxCYkc5c1JEZHVjbTVaYm1wdWNVVnpiMWhuYldjOVBTSXNJblpoYkhWbElqb2lLekZ4Ykc1amNWY3hOMFU1VTJ0bFZtWnZTRW9yZWs1UlEzQkZTVzFqU1hOc1JqY3pWbXBTYUVOak9VNXpXU3RJTW1sbFNVSjJNR0o1U1RCTE1VNXRhbUpuZVdOaGJETkViRVZqWkROc01sRXJXRFJDVEhwSFNrZDZWa3hvTlVOWlZXWkxlRFU1UTBsbWFWRm5ZakEwYTBOdVFrTndNbEJQVUV0bVZrZFhkamh2TDNoeGVqaE5aRUk0V1dORWR6ZzBPVEJrU1hZdmRGWnNVMEZHYlRneEx6VndlWE5ZUzNFelVXaFJlbkZZWlU1TVRXVmhabXMwYzFWUFRXUndhbk5yVmtkQlNucFlhREZ1Tm1GdFoxTXlNR1JEY1dkUVFUMDlJaXdpYldGaklqb2lZemRtTmpKbFltVmtOekZoT1RZME1ETTNOV0U0TlRaa1pqZzJPV1F3Wm1FMk5XSTBOakUxTldNeVpESXhZalk1WXpOaU56UXdNbUV6WkRsbVpqZzNPQ0lzSW5SaFp5STZJaUo5',1782064914),
('1E845T0r8J5aW2eVIaQROCmwEP3UBgw0Y3BjRz41',NULL,'124.31.107.12','','ZXlKcGRpSTZJbEpvV1ZveUwyRmpaWE4wYXk5dVVGVnJTVEIwVkdjOVBTSXNJblpoYkhWbElqb2lRbXB4WW5sNFFVNHhNbGhOUlhneGMxbE1NVnBCZEdaWVZYZEhiWEZyTWxSUkx6Y3pOMHB2WkdaWFpVRnZWV2x3V1dJdlRGVkJkQzlRYlV0SFlrdFphRFpRTUVwV09IWmFURUpSTVc5WmVrUlRTVzk2ZFdOSlRqUTRkWGhXT1c1WlJFaFlSVk55ZUdWQlpESTBPVk5aTmtaSVNscG1NM0JLVGxaUldsVmFZMUl6WTJjd2FGUlNVek5RVlVWamRVRTFXbTVtTTBVM1lrNW5SakpVTjNJM05DOHJOa3BHVUROaWJrcFJjVEZSVUVOb1VrRndXamx1WkV4NVlXeHhSMDlaZVRKQ2FFWXljemN6WWk5R1VVVkxjWGhwUW5CVVp6MDlJaXdpYldGaklqb2lNRGc1TW1FNVpUTXpOVE00TnpGbE1UUXhOVGRrWTJVellqVmtZekppTWpOaFl6Z3pPVGN6TkRZeU9XSTNaREZpT0RjME1EaGhPV0kxTVdNeVpUSXlZeUlzSW5SaFp5STZJaUo5',1782074043),
('30lLPd15VFhkHtKMBTepzMOjFIBvwtOySmQAfnHh',NULL,'185.12.59.118','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:132.0) Gecko/20100101 Firefox/132.0','ZXlKcGRpSTZJa292UVd0RFltZG1Wa2xYT0dZNWVuQkxXVTVETUZFOVBTSXNJblpoYkhWbElqb2lTREp4YjBKamNtSkdjRlkyUW1wa04xUTFTMGRxWkRkb1pFTTBLM2hFT1ZsMGJuZG9PRTh3WkM5RFdVazRWR2M1VFRWd1IzSnhPVXd3Y2taT1IzaEZOMHRXTkU1SVRYQklWM1pZWVN0cmExY3JUMkZCZWtJMFV5c3dNbEpYVHpGSVRWRjNlVFpYU2tvNFlUTTNOV3RETXpKTmVqWXhhR1kyV0ROVmEwSlVka1pPVVhadk9HaFhWMDVMVEhsdldIUktWbkpRV1dWa1FuQXdaelZVU1haRGJYcFJVbUpaWm5WTFMwZE1UV1pyWjB4cE5rVnpUV0UyUVdVcmNWSkVPRGxxUVhOcE0xZEdlbU5RY1U1S1JrWjRaazF6YjI1UFFUMDlJaXdpYldGaklqb2lNak0xWW1NME1HUXhNRGcyTmpVMFpHWTRNakJtTlRFek5HTTRPVGxpTXpWa01ESXlNVGszTVdVME5UZGxPRE14TkRkbVl6UTRaamt3WkRBeU4yVm1PQ0lzSW5SaFp5STZJaUo5',1782066073),
('48Ztwn4kjNNK6xm5OaFk6lwHlGyHzkskVKFXVFqJ',NULL,'35.195.84.127','python-requests/2.32.5','ZXlKcGRpSTZJa0UwWkdsTVMzQnJaRUpUZUdOUGJYRjBPRWxXZVdjOVBTSXNJblpoYkhWbElqb2lWVUZ6UjFFeFdEZzRVRzE1VFZwblRHVmpjR05ZVERKS1NrTlhlbll5T1dOQ2FIZE9OVzh3UnpWTVExZDZUVE4wZFV4SmVsSkdZME52VmpOemIzSlJWazVHT1RKcFQyNTJaa2xzVTFONFkxRnRlWGhMUm5SYWJUbFRUV1JtYVVwTVpWSnVkRWhDUkRjNVJEWTRPRGh1YzFCcGNreEhRek16TWtveU1XSmxjM04zV1ZsdGMyd3lVR0pqT1VKRFNtcHhjV3d5YmpWRlIwSjBkMGsyV25WUlRFWklLelI2ZHpsUVlVVnNTVEV3VWpCeFJXRTFkMkpHWlZSWE5IaHNTV1lyTkZRNVlTdGhkbEJuS3pFNFJtRnpPVFZyYWtaQ1VUMDlJaXdpYldGaklqb2laRGd5WXpFM09XRmhZbVEyT1dRM1ltWmxaamM0TUdVd01tWTFNekkwTkRoaE5qVmhZV1kyTVdReE1qUTBNVEZoT0RaaE9UUm1OV1UyTkdRNU5qaG1PU0lzSW5SaFp5STZJaUo5',1782070807),
('4FBYLKHxe1GPPeoptXYRBMwgmGdhcF5LeGRVK6qo',NULL,'223.83.130.199','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbHB2ZVhObVNWcFZjV2RKVURoVFZFUldWRlEwVUZFOVBTSXNJblpoYkhWbElqb2laMDVSVkRoWWVrdzVUekJXY0RnclFuZFdXREowTWs5TldXMHJNRzU0YjFNNFJFSlhUbE5EZG1sV1ZVaEdUR0ZqTUZVeFpYQkZjRWw2ZW5GcVlqWkphQ3RFTms5SVEydHRSM1JPUTJFNFVFa3ZVa0pLZVM5SVdGaEtSRUZCT0dOM1V6Y3ZWREkxVkVSMlMwTlRPWFJVVEdGMWNGcHFWRXBwYW1vclIxZHNNR1pEUkcxVVJTdEhWMWt5UTNCVGMwODRLMDUzYzFZNWRETXhXWGs0TWtzeVJHVkZZbGg0VkM5Tk9UWlNkelIxWkRoR1VITlhZMlpZUzFCWlYwTmxUM0pIUjBVelVXZHZaM1pRV0hwVU1IVlFZM1ZhTDBKSGR6MDlJaXdpYldGaklqb2lPVEE0TWpKbVlqSmtNVEpqTVRreFpqUTBPRFF5WlRaaE1qWTRaV1JqWWpFNU4yWmhOMlkyTm1KbFpqSTNOV1pqTkRBMll6QTFPRFJqWWpZM05tUXpOaUlzSW5SaFp5STZJaUo5',1782074872),
('4uBES1VnuMaTj928aE3KA9RjI0tREdDCr4DPwn48',NULL,'144.123.76.122','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbUp5UVVkR1oyVTNkazByVkdWc056WmtlbE55TUdjOVBTSXNJblpoYkhWbElqb2laMVpKY0U1dVJGcEhiMWxMVld3NVRsWkNjbXh6V0d0emJIaFliRmsyWjFkd1ZrNVpXRk5rWWsxd1VDdEtSbU5hV1ZOVFZWQnBTRFZqVUUxV2FIUklXalJ4YjB4V2RVcFlkRlZLYTNSTlkyZDVWWEpNVDFsbksxSlBNREJsVjFVdlJXUlhRMHRGV1RaQmJsRjJPRmQxVkhWTWRFZHRXV2hTUzFObGRGcGhTME5xY0hWUlJqQlJZa2xFY2twb1prZHZjSGxtVkZGVFRUWjVjVFZpVlZkQ05GSk1lWGhIZFd4emFGQjJiVmh4ZW01VWFHaGphalpSV2xsWlR5ODBTR2hEZFRNNWMwUm5TakZLY0d4cU4wcExlRWRQTTBsNGR6MDlJaXdpYldGaklqb2lPR0UwTlRGa1pqaGxNVFk0T0RsaFpUa3hPVEUyWWpRNE9EY3dOR1ppTUdRNE1HUXhPR1JrTVRZME1EYzJNalV4WWpZd1pqVmpaakkxTnpZMU56STFNU0lzSW5SaFp5STZJaUo5',1782074455),
('4vlQjJGatgmzih9YIbz0E85LNPXTpXdnKJLwIwVm',NULL,'176.65.139.66','Shodan-Pull/1.0','ZXlKcGRpSTZJazVHZFZsTVUxSjJlVnB6VEZGSFdtSlRaWFp0VW5jOVBTSXNJblpoYkhWbElqb2lNM2hUUnpSMWNWVlJSRFJaVW5KVEsyaGFXR2M1V1V0V1l6VkpVVkpPZFZsc1ZUVmtNWElyYjJSU0wwTjROalJyTmtkUE9VZHNVbFZxTUZnMFdIUTBTbkl2VjJVeFowVnZOWFZwYm1OcVJXVTRZVGhDWkhRMGRtbDJZME52ZWpKTFpURmtVR3hHVkZkUldtaHlZV053ZVZSMmVrMXpZa1puWW04eWJtTm9VR2N2VUN0TlpFcHdjRkJSVFZockwzWk5jVzE2UWxWQlpuVndXa001ZFUxa01sUk9jelppVDBSRVREQlZaa2xuTmxSak5FbFVPRVE0TVRSSmRrWlpVeTlrYWtaTlVGQkNkVXBxVlRJNFpWQkNaM05CTlZsd2R6MDlJaXdpYldGaklqb2lNR1ZsTkRRelpEVXdaVFF5WldVd04yRmxZams1WkRObVpESXlPV0V3TTJRMFpUZ3labVJqTURjMU5qYzFZV001WkRNM09USXpZemsxTVRjNVpqZzVaQ0lzSW5SaFp5STZJaUo5',1782065811),
('56IMCwC6VRTL2Av6WOWMiO2SAxXm0kyV057b3Ul5',NULL,'220.177.9.169','','ZXlKcGRpSTZJbVZUYzJWMldFbzVaSGRKZHpaNFdGTmxTeloxU1hjOVBTSXNJblpoYkhWbElqb2lRVXh6VDJoWlNXVlphVXRQVUU4Mk0wcHBVV0pHZDBkaVRsSnZaR1pzTTFWTllUUkRVR1EwTldsRGVXbGtWVFJ3WjFSUUwxRXlTeTlFYlRGSlRGRjFSVzVJVFU1YVkyWmtla1p2V0hCT2J6TldkWFZDYkdjck9GWmxkMHA1YlNzM1UwMU1ZU3RUVTJWd2VWUTNiMkZyY2pkM2JsWXZkRTVXWlVrMlZqWTFZbEF5Y25GMVJtOU5ORUV6V2pjclZsWkpWVmxvYUZwb2VqRXdjREZ3VDFGVVUzRnBkbVZhYlZadlRUVTFSa2RHY1VobFYyUnJWWGt3UW1OR1pVeDJNMjlwVERReVoxTnhiblF5Ym5seVFqQnZNbnBoZGtsalVUMDlJaXdpYldGaklqb2lOV1V6TTJWaVltTXdaREpoTkRJeU9XUXpNR1l6TVRrM09XWXhZalpsTlRNMU9HVmpOR1l6WlRobFpUTTVOVFZqT1dVME1UVTFZbUl6WXpNd05qZ3paaUlzSW5SaFp5STZJaUo5',1782074025),
('752maHvtNZVj15OUZV5HOYRklmKsH8vGPETSDN2d',NULL,'203.154.14.18','','ZXlKcGRpSTZJamRFZVhaS2VtaFhRMHhvY213MWN6SmtkM0ptZG5jOVBTSXNJblpoYkhWbElqb2lTMEp6ZEhnck4yRldXR3RpY21ocU0wRkxjMk5YYUVvNFFWaEhWV0pqV1c4cmIySk9ObFpXY1ZkbFVGWnViVFZqY21Vck4zTlhlRWhaTUdNelJreHNUMWR0WmxObGJuWTJUa2RJTVRoS1JFZEdZbkIwVjBaNmQxUmphbHB2WTNwV2JHVnJVMnhpTnpSUU5FVnZUVU5TVlN0V1FtOUVRWHBuZG1WUWIwSlZTbTlSWVhWUmEydGlORU5NUmpCTFpXaFZTbEJVVHpSdlpUWmhPV1pPVldseFpYZFRSamxVYUVWSFRGTk9RbVZ3VEdSQlUxQk1OVTkyU0RCUVpGY3Jabk55V25Sb1IwWm5OMGh1VWpRMFlraFlSR1J2YWtocFVUMDlJaXdpYldGaklqb2labU14TW1KalpUQmlZbVU1Wm1ObFlXRTJZakkwTnpaa1pEZ3pPV0ZpWlRJMFpqUmxZamsyWm1NNU5EUmtNekZpTVdKak9UZ3pNakF4T0RFME1EZGpNaUlzSW5SaFp5STZJaUo5',1782082540),
('90jwIi7umiA2XH1e6VXXgJBq00kCcjzrJQR79wjd',NULL,'123.178.210.172','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbkpDUlV0NFZtMDFSbmRIWkhkTmIwRnJiMWN5T1djOVBTSXNJblpoYkhWbElqb2lOVVpCZW1KQ1p6Um1UbmRUVUhkbldEVjBkR05ZVjBnNVlVTlVjRkJVVEVWU2RuUllhMjlWUWxCak4wSTNWMWhzU0RkWFJYVXZkMlpGU25seU9HYzVTWEZGYTFoR2NXSlljalZHWkZCYVZrMXNOU3R4YUU1UVMxRlhkWGxVVkVoUE4wVTBZbEZvWm1OcFVDOVVUSFF3T1VFNGJuWkZkRVZQS3pWbVREaGpaRkZLYlhsc2IxTmFURkZ6TTBwc1VtVTRVRzgwUkdWeGIxZzJiRFZzU1hSd2R5OUtOelkzUm05cU9XaHBPV3BMUWxkdmNsZGlMMUpRWkRKNFNUSk5VVE00YnpGclF6RkNWRFZJU1ZWdGRTdEpabkpHT0dkUlVUMDlJaXdpYldGaklqb2lZamMzWm1JeE1EbGhNMlU0WTJNd09UZ3lObUl4TW1Nd01qQTNNVFU0TXpsbVpqQmhNMk5oT0dRd1pUbGlPV0psTjJZd1lXRm1aV1JrWkRRNFpqQXhPU0lzSW5SaFp5STZJaUo5',1782074360),
('9ctx2r8JphgUxbkXWD4xWDI5ITgoRi0ykW3rddpj',NULL,'172.104.210.105','Mozilla/5.0 zgrab/0.x','ZXlKcGRpSTZJa0pHT0haUk9VVnFRMjR6YmtWRE4zcEZSRWd6VWtFOVBTSXNJblpoYkhWbElqb2lRUzl1VFZOVU9YaG9XVmx5U1M5TFFqWjNORzlzVmtncmN6SktkMDFwUkRrMFlqVnFZemxHTHpCR00wOW9UM012WTNoSldtRTJWelZ3TkdwUk5taGFSVmRwVlM5d1VTdHJMMDlxTUc5RVpGQlJPR1JSVW5oUE0wZ3hZVnBPZEVoV1RsQjVOakpDWTFWdVEwWTFRemczUzJGRVdITmxZMlIzVnpKU2RXaFNSazQwWlVsaWN6WjVlbmRyVDBObWFWRlBVbmxhVjJGTU5rSklZelJwZGpOalVVRjNlVGxHV0ZwTE9UaDFUM2xzWm5WQ1pERnpkemRJYUZGUVRrZFdiRkZuTTI4eWVWSkhRMnhwT0VKcmRtNTVPRVp6UlVSelp6MDlJaXdpYldGaklqb2lNR1kwTXpJeE9ESXdPRFkyTnpabFpXSmhOekkyWWpaaU9HTTRObU5tTTJRMFltRXpOalV6TWpFMk1XTmxNR0V6T0dSa1lXTmpaV0U0TlRJMk5tWXdNU0lzSW5SaFp5STZJaUo5',1782070916),
('9keAouOaLqmEx89NdaiKKZ7ipMQaeoFM5x0D48WZ',NULL,'47.91.75.137','curl/7.74.0','ZXlKcGRpSTZJbWgxYkhsTVZrRTBaMkpLZVdKUEwzWnNWa3RKVGtFOVBTSXNJblpoYkhWbElqb2lWV0o1WmtsVFpUUm9XRmRrZDB0aGNXcGhRV2xUZGxseFJUZGtiRGhvU0ZVd2VuRktWakJLWTJGSmEzTm9lbEJCWjBKRU1raHlNWE5zZDBRNFJVVkZOMFJSY2xSWE16ZzBiWFpxTDFsVmFteEVUM2huWTBSM2MwVTBOakpHVmpKV1NWZFZlRWh2WVRKSlMwSlZTVkp3ZGk5RmJGaFJWRGd3U1RkWVMzbGtSbVpVWVdSVmNIcHliWFpEYVd4aWIyc3hXREpaYUVkYVVHeENaemxpT1ZaNFpsVjVSVmRJWlRNeU1sRTBkVWt6VW00NVpIWmpRblVyTDFkNWVFWjZjR05sTTFkdFdITXhkRFZtTTFSeU1VbDVRV2hPU1dOM1VUMDlJaXdpYldGaklqb2laV1k1WW1ZeU5XRmtaV05rWWpNNVpqZ3pZVFF6WldZMFpHVmxPREZoTm1SbVpXSm1aRFF4Wm1RMU56Y3pNbUppWXpjNU9UVmxNemRrWTJVME5UTmpNaUlzSW5SaFp5STZJaUo5',1782067557),
('a1bCmtzXecQe1SsuTpT5KNwCctP9ni5tWVbOn7Jl',NULL,'47.82.103.217','Go-http-client/1.1','ZXlKcGRpSTZJbEpQVlRaT2NEaGpiSGxPV2xKVmJHNVJkMWR2Y0ZFOVBTSXNJblpoYkhWbElqb2lWMWx6ZWxaeVRYbFBZa2t3TkVVMWFXVmtVak1ySzFSV2VXRXhOMnM1UzB4a1JuRkNVVGgwU1RReWFuUmtNRzVVYVhOeVdEWlpNR2hqTlZGclRUbDVSa1kxZDJoMmRUSlpOeXMyUkV4dlJFRmFaRzFNZFhadGJVWkhOemxOYTJFMVFYUlpaa1pYY0dKdmJsVlRUM0JKYzFkYVV5dFhVazlxWlVGSVJVeHFVVTFKV1haSGNXTnVkVGhxTlZKWFpVUm5URXhuUkUxb1QwVjJXVVpFZVhadVVVTlRTblYxWmpKNlZGRmxTSFF4ZGpGcVNHeDVNRWhhSzBVdllVUkpZVlUwWTFBeVdEVkxUMmRMVURSWVJUVnJSemR5Y2t0c1FUMDlJaXdpYldGaklqb2lNekV3TnpVMllqZ3lOelpqWkRZd1ltWXpObVppWW1Nek5HSTJZakEwTVRJM05tTXdNakEwTVdZNVl6RmpNR0ZoTWpRelkyVTRPV000TjJGa1pXRmxZeUlzSW5SaFp5STZJaUo5',1782059619),
('aztF4s1QhSoWh7tNjC4eEIbEjQDZGE994GzAZ2dx',NULL,'152.32.133.102','','ZXlKcGRpSTZJalJIZWtaelJHdFJPRWxIZVVwaVduWlFWa2xYVWtFOVBTSXNJblpoYkhWbElqb2lSM0pXZFd0dVoyMWpZU3MzTm14eWNVWnhaRmRRUjFOR2FtVmhjRkZSUWtWbksxUjZVMVp1VUVoRWJWUmliRmhRYjNSeVlYVnRNbGwxWkhaRU1rOUJlRFpDZGtkUVJWUTRWWE5hUjIxUU56SjVZWFpJTlhwdWRVczJaR0p6U0dOWVozZGhXa3RVZW5CMGFDOUxNMWxSWWk5UU9FVjZXV3hsTUZZNWR5dFdabFp1UkZOdFNubG5hbXBGVlRsR1J6aG1SbEJIVWtGek5qTkhNek5oVFV0aVVEQjBUR0ZCTm5nemMwbHRNeXRFTnpoV1JFUlliR1ZuUm5keGFHdENNVmQwU3paTmJFTjNhSEUzT1hZMVdrZFJkVWhaUWt3MVVUMDlJaXdpYldGaklqb2lNR1prWldZMk5tTmtOemhqTm1Rd01qUTFPRE13TTJReU1tSTVaalJoWWpGa04ySXlNalkwTXpBM00yVmhaRFZoTTJGak0yRmlPVFEyTURFMlpXTmlNU0lzSW5SaFp5STZJaUo5',1782061540),
('E55nMWPmfS6d3bESr3O9IpK0nt6PYc6YC0QlJENs',NULL,'123.138.72.199','','ZXlKcGRpSTZJbUpZTkRReWJEUnhOVmhyVDFCV1RFcENPQzlLTlVFOVBTSXNJblpoYkhWbElqb2lRVFV4YmtwYVowTnNXVXRuYzA1cVJraDFaSEZHVkdWdFFrOXlVWGxxUlhwUVVVdFpVMnRXUkRBd2VTOHpUblpFVlROdE1GSnVlRGRQVERkMVFrUmtiR2xuWkRRNFpHRndURFJwYVU5U1NWQjRWRUp4Y1d4eWIxbHhSa2xQYVVnclUxUndWREZXYTFkaVJsTTRSRVpCWjFOTk1VcFZRMDlGTkc1S2JUQXZja1JqWmxWWGNsRm1hR2hIVmxWMlIxTTJaSFUwYlRrMWR6RjRPRXRRY0ZSYUsxVkVjM1ZIUlhBdk56Vm5kbEEyTkZweFJuSTNVRTVGVkd4SGFYUnVkRzAyUkdOaGQzZzFTa2RxU0ZwVmNUZHFhQzlZUkM5alVUMDlJaXdpYldGaklqb2lZelk1TXpZeE9HWm1NekE0TXpFeE5UUmhaRFEwWXpRMU1HWmtOekk1T1dVeFpERmxaVEF5TTJZd1pERXlPVEV5TlRNME0yTmlOelExT1dFd05qYzRaQ0lzSW5SaFp5STZJaUo5',1782074034),
('eBsK5QqVPbU46T1sODy6KyRPVjiSaB4JOSQKjLRg',NULL,'216.180.246.176','Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)','ZXlKcGRpSTZJazl2ZEhSek5GbElWRGN6YVdsSlFVbE1SblkyV1VFOVBTSXNJblpoYkhWbElqb2ljMEpqZWxNdmNFVTVhRXMwVjJsbWNtc3lUMjFsYm5nMGFESXZNRlJETmtwNGRXWjNlblZSVWxadkx6RjJhbkZaZURBMlJXY3ljV0ZWTlRkVGRFMXlNelZqWWxkdldVbGtTM1JRWldSUmRWZEtVMlphY210NFJYWk1Nek5VU0M5dllVSnBWblpNVUdOVlpucDJWRVkxVkdWRVoxaE1MemhRUWtWNlNVcFFSbFYwVXpKRVpFVkVOME4xWWpKbVdtaFBZVkE0VFZGbmFXOVRRMnBsTjNSUmMxUjBUbmQxTUdWbE1GcDRUekl4WWs1NVVVaE5abEZ4Y2xCUVpuTlRSV3hpTVV4a1JEVk1jbWRLY1RJd05sZElWM2xhWW1aVlVUMDlJaXdpYldGaklqb2laREZqTmpVMVlUZzRNVEUxTURSa09UQXlOVFEyTWpWaE9EazBORFF3TkdaaVlqVXdZMkU1TmpjellqWXpNVE5rTmpsbE5XUmpNVEUyTjJRNVpHRTVPQ0lzSW5SaFp5STZJaUo5',1782064381),
('EmRwYgIQVi3F1hOGM1lH73jsISGLML3w9tquuMvj',NULL,'20.38.5.218','Go-http-client/1.1','ZXlKcGRpSTZJamhEYnpNMFZIcG1abEIyUWtSa1VuZzRRMFU1YVdjOVBTSXNJblpoYkhWbElqb2liazFJVkVwQmRIVnRObEp4T1dOU1JYWjBjazFxU2xOb1JWWnBhamg1ZDFWV1owdG9UWGQxYkZFelJXdzJiRmgyZDFKeGJWcEdRMWRpUjNacldIUjRkVWhJZERGNmMxQkVORlZIVWxkVFQyaHFiVkJVV25velpsSnRTSE5FWWk4ME5tTkdNbmRqZVV4VlRFMUNSbnBUTlROak9WSkRiMUpvYUc1M1pXcEVUVFZXUWtGNU1tdENSRlpXT1U4MmRqQnJPVXhCUjNBM1ZXMTNSMVpNWVRGbmFtTlNSVGxrT0ZGblZ6QnRkME0xYkc5bE0xaFBWakZwZEdwMFUzcEdUMHRMUTBFcmFscHZjRkpFYXpBM05WTm1UMnN2ZGxFdlFUMDlJaXdpYldGaklqb2laamN6T1RSak1qZzVZelZtTmpFMU9HSTJZV1poWmpNd016QXdNREF6TlRZNFpERmxZek0yWm1JMk5XRmhNRE5pWWpsbE1EaGxPREE0TmpaaE16UTBOeUlzSW5SaFp5STZJaUo5',1782074286),
('ERO2v15OH2L7RnikQgScZwt1WMhz2w7br38autU2',NULL,'5.61.209.92','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46','ZXlKcGRpSTZJalZ5VWtORVoxQm9abElyVFdWc1JqZG9XV3Q2V2xFOVBTSXNJblpoYkhWbElqb2lSazR4ZVRoblVsTmhNM2wxTkVOSFkwWXdMMGxCTTI4MmMwNXhabm94ZURRck9GUXZWbk5pVW5ac1VWZERRWGhNYkV0RGFFNTBaRVpTUTBaNE5sbGpMM0ZaT0hwTWFXbENRVEF3YWxSTk5EbFZWRFU1Y0M5Rk5HdFpNVll6TlhoTFZWRjZiblZTUWl0elRISnRWRlYxY1hNeFIxcDRNMlZYV0VseWRXRXlRWGNpTENKdFlXTWlPaUppWVRBellUVXhZbU5sWWpFMlpXTm1ZVFJsWm1Zd09EWmlaalExTWpBMVpEWTJabVJoWVROaE5HVTNNems1TmprNE16Y3dPR0kyWW1JNU9XSTJNelpoSWl3aWRHRm5Jam9pSW4wPQ==',1782068782),
('f4frS8blUSTyhgYzlaAO0eZaT1yYwZhHdgNm5las',NULL,'144.123.77.69','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbXQyYVd4WmJHTnZjSE5ST1V0bGNUUnRWMVZvZEZFOVBTSXNJblpoYkhWbElqb2lORXBWWjJsUU9IUjBjbEJOY1RKTVozRldRbFZoVDNOb1pGQk1UM1JuUWt4dWJWTmxUVkJtUmxSRE5EZ3pORXd3VFRVeVJuQlhaVzlZYzA0ck1sRkVMMWhJU204NFMyZGlkRFJqTTJKWVpWTjNjVlUyYVd4SlpEa3JVMHRDVFUxdk9WRXljVEpHUlVFNVFuQlpkbmRaVEhCWFFTdFJhbGwwVFRWVWFEUmpWRTloZW1aaWNqWTRlWFp5Yms5VGFWZDNRak5sYzJORmJFdDFibmxKVW14TVRHUnFWa2hsTWtnNU0xVXdVMHhxZFVReWMzaDRRbk5OTTFGRWExazJVR0pGUTJoWFluQXhiRkpXVW01M1dVaEJialpTV1V0VmR6MDlJaXdpYldGaklqb2lOekF4TTJVME5EVXhNV0kxWmpSalltTXdOVFZoTkRCa1kySTFaR1l4TkROa1ltRTFNR1JrTldJeU9ESTRabVEwT1RJd1lqWXhNVE0yWVRRd1pUZ3daQ0lzSW5SaFp5STZJaUo5',1782074188),
('fFsc0qKe2fG0uxSYOKS8EdcDyf81379ExM1KBeFc',NULL,'47.91.75.137','curl/7.64.1','ZXlKcGRpSTZJaTg1YjNwcWNVcHNjRkJMVkhSbVQzWTJka3MwVjBFOVBTSXNJblpoYkhWbElqb2lVVlJRUmtvdlZYVjZaRlpHV21zMVMzRlBkMnhPYkZSdVVWUk5lSHA2UTBaSk1rNWhMMjFyVUcxakszUXJZWFJOWWtFNGNXMHlZV3R1Y0VWTFQyZDRhSHBFVkRoUFRHNW1SV0pYUWxaU2EyNW1iMDF6Y21jeE1rMTZaRmxEYmxCNVZYQjBaMnBNWkZWS1FuZzVUMElyVTNoWFIyaGhRa3BKUTJkNE55OTVUM0JzTWtwUFFYSXpTR05PZUZGQmNYTlFiRWxMTVRkRlFUZEhVbFJqTmtkcVYwRm9kVXR3UW5CaWEwZHNaREJsVVhCRVdDOUJjeXR6VGk5RFdpdGFZVk42TTNaVlltbEZlbUpQYXpkeVlrOWhNalp2YlRkTFVUMDlJaXdpYldGaklqb2lZalkyT1RjeE1UQTVOV1V5TVRjMk1qUTFNRFF6Wm1FMlltVmhZakEwTXprd1ptTXdNVGN4TldFek1tTmtOamRpT1RnME9UazRabU15WmpoalkyWmlOeUlzSW5SaFp5STZJaUo5',1782067556),
('FJpQciwoT1lv5f1io4SOzw9I38c9JMJD07dVcT0U',NULL,'57.129.12.51','Python/3.10 aiohttp/3.13.5','ZXlKcGRpSTZJbEk1YnpVMlVFOU9OMmxpT0VGbU1EbFBUelpEYW1jOVBTSXNJblpoYkhWbElqb2lZbkp2VjJKQ2IwOVlOR1YxUVVadUswUkhZMlpNUzNNdlZVczNiRTlEUkZkaU1HdG9NbWc1TWxSTFNXc3dUbFo1TW05UFNIQk1URWxHTUVKQ2NERjJaSGRaUWxCSlNEbDZRelF2VjJ0dGNrdEdWMnBoZDBrMU5WRkVaa2N2Vm5KSVJ6RlNjSE53TUdRdmVuRlBSR2REWlZGbGMzZE1NWG8zY1VsVk9VbHpVMWx0YzBOVE5uYzVaVkJUYXpacWVsRnNaU3ROU25saFUwcHRMelIxTlRKWGFtZzViVk5FTVZaVlJrWlZWV1puVldGVlpYcGFabEJTWm5sTmNXcGxkMHMzVW5kQ1NGUlBVSFV3Um5sWWRHSXpNVzhyU0hsQlVUMDlJaXdpYldGaklqb2laV1U1WWpVeFpqWTNZakk0TVdJMU5UZzVZV0V3WkRRM05UYzNNMlF3WkRJNFl6QmtNV1l5WTJFek5URm1ZVEF5T1dSbU5Ea3hPVFl5TkRRMVptSm1ZeUlzSW5SaFp5STZJaUo5',1782084714),
('FNp5IpnX95vS7CJxE1GLRZYq2lTuGYv6tpTpe9UA',NULL,'147.185.132.52','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','ZXlKcGRpSTZJbU5OYmtNelNFbFlUVEpWT1hJMFNXcHFUVFJQWWxFOVBTSXNJblpoYkhWbElqb2lZVkJqVFRWWlpqWXdRemRrY1doT0wxcHVPV0pZZVZCU1FXWnhhU3MwYzJ0a00yUk9RM0l3TWpaWlZFTlplbk5VZGxsNE5GWkdhMGxaWjBvME1GaE9NM1ZoTm5veU5XaFFUWEZ4TlRJd1JGWXlaMHRYV0hKa05HbElRMVZWY2xaRGJVaHRReXR1TVd0M05GWnlOalJ5ZEU1a1IwTndia2xHTDFCNE9IVXZiR052UmpKRk9ESmxZVzgyTlZwMU9VbDNVR2h6ZERaR2FESlZMM0l5Y0ZKWldYZFBOSFZ2YzJOc1lsQlpjSE5JV21Nd2FYQlVabWhuWVhVeVpYQllWMnBHU0ZSdU9XMHdWMGwwZFVGSVZWVkVSRzlZUWpCa1VUMDlJaXdpYldGaklqb2laREppTXpSallXSXhNek5qWkRJNU16RTJZbUZsWW1ZM05HVmpaamxoWVROaU9UZ3hZamd4TXpjeFpERXdaVFJqWXpNMU1ESm1OR1ppTnpSaFlUTTBNU0lzSW5SaFp5STZJaUo5',1782068851),
('fp1v79XaF1g8QfmgM6wyOJnprvUbnSLRiyyqoIjV',NULL,'124.88.113.9','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbFJ5V1ZSelpGWm5VM0pqT0hRNFVsWjVOR1l6Wm1jOVBTSXNJblpoYkhWbElqb2lTR2hITmxORE0wWmxNbmd3TlRWRmVHeEtiM3BhT1VaUlVpdHhVR2t2ZUhsWFVteDJUMW93Vm1wSGJGZDRWRXgwVGxFeWJHaHVjRUpOVGxZMlR6TmhaM1p2T1VaYWVrOHhkVWd3U1ZkSFUyRjBkMDFtVFhKUWNVWlFXbUpTTW05dlEwUnphRlpZWjNsRVRWRmtVRTVrTjIwNVYzSkdTbVpKZFc5R05WSm1TbFpOUWtwdVpEbEhibTR6UTJkdGRUSTBVVFZTZUhZMGRuaHBOVGd5ZFhkV1UwOXVMMlpsZWxKTE5FaE9SVVpQVjBKSFRXaGlkMFJuVDJSSGJ6QTJVMU5IVGt0SVdXbDJZbk5LZVd4dVEzWjNTME5VWkdGRFFUMDlJaXdpYldGaklqb2lOV0U0WlRSa09URXhNRGd6WkdRek9UQTJZVFUyWkRKaE16ZGtZMkV6Tm1KaVl6QXhNV0ZoWXpneE1tRXlNbUl3TkRBM1ltRXpaRFZpTkRNeVlUUTRPQ0lzSW5SaFp5STZJaUo5',1782075311),
('glhQLtxhsHOjEzsRDQkatlsWTJLfUF6zgp9679tX',NULL,'152.32.133.102','','ZXlKcGRpSTZJbWRwTUdZNVNHVnhOVWhEUkRJelMyMVRLMFZhUTFFOVBTSXNJblpoYkhWbElqb2lUVXRtZUhoTWMxaEVaRVozVmxVdk1VeE5OVTFvUkRGeGVIY3hVM3BpUVROalNVRkxTRk5rU1dseU1HOVFPRzkzTlhka2QzcE9NVTQzWmpKNVNGbzROMFpNWWl0S1VqRmFkelpzU0daSVJFaDFOWGt2WjJ4d2F6SjNUMEkyTVhwVldGRjRSMFEwVDNSR2RrcEdURzF6U2pSS1FtVnBRMFJhUjJSM1JFeGhMemhYYVd4eFQzVjZjRkZpU2tKTE1VWnZPR3RaZW1wMmJuRTFaWEUwYkZJNVF6UnpPVTVPTjNsdllreEtNWGxsTHpBdlIwTktSekJKSzFCMFdscHBXazVoYkZCNVEyeDFWMnMxY2pCSlRteGxiWEpNTUdWMVp6MDlJaXdpYldGaklqb2lNemM0WldObVpHVTJZekU0TkRVMk1qZzBZemxtTXpJME1Ua3pOemt6WVdNME5EYzVaamd4TURGa05EWXlObU0xTVRCbU9ERXdNMlF3WTJKbFkyWm1ZU0lzSW5SaFp5STZJaUo5',1782061537),
('gX9426Zwztczv0mJG0fiAyTVp18mOPknIDJ1L8Fg',NULL,'45.148.10.200','l9tcpid/v1.1.0','ZXlKcGRpSTZJbTlQTjFaUmVEWjFaVnBrUkZwTVRsUjRhbnBEWVZFOVBTSXNJblpoYkhWbElqb2lZM0ZLZEVaTk4ybERTRFZqVFdrNGVXcGhWeXN6ZHpKcVZYTktjSFpHTWs5cVNtdEtkSEZ5TlRWQlIyVTJUMGt4YlN0V2EyWjBjSFJUTDJWelFWSmhWVWxGU3pBclNGWkhZbHBuVUhWcGVVcFFhSFpqUTA5ck9UQkJORTFyU1c5VGJtSTRhRWQ2Y3paSlVIWkhVSEpVU2xoWVNtVlhhRzFTYW5CSlUzaDRTMGQzYlZwcWMwbzJWVmhWYm5rMmJsUnVOa0Y0VmprcmVGUjNURlU0ZEZObWNGSkZiVnBNWTA1a1p6SjFPRFp6WTB4SGRFSlpZVWhTWkRsM09EQldjSEZrY0hJMVQzQjZhV1pXTlZoVU5GVnlNa2RtYkV4dVVUMDlJaXdpYldGaklqb2lNelUxWXpneE16a3dNV1JqWXpjM05tVTJOVFZtWkROaE5UWXlaVFZpWXpJell6RTVZbVZoT1RZM1lXRXpOVE5pTmpBd01UZzVaRFZpTnpKaU1ERXpPU0lzSW5SaFp5STZJaUo5',1782079166),
('GY9locZvXxUmdTMujyosvravMvKYfmmcH4hcTeu5',NULL,'172.236.228.218','Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36','ZXlKcGRpSTZJalZyY3pWVFIxWmxVVzlNWTIxNVdXRTVOMGRDVlZFOVBTSXNJblpoYkhWbElqb2labTR6ZVV0Rk5td3JSbVV2YmtKalVESm1NbWxqTUhCVGFtMTNTbTF2TTJSR1lVSlZiMDUzTW5WTU5TOWpLMk51ZUhJd1owTTRkbWRuUVd0aVZFWmFRbFpZYlZkalowdzFMMUZ3Vm0xb0wyZElZMnhYUWpaV2JXbEljMG8zUWxOMWIxWXZXR0Z4U2pKeFJWaFlXVWgzUkRVMFoyOWxWRXg1TWs5eFoyTmlla2xGUTFBNE1UTXdZVTR2ZVZkSk9Ya3lVMjF5UjNCV1dWaENRMHhsVGs1RlZVbGxVMjFpVFhrek5raFhLM1JOTjAxWlFVMTZWbXhQVUV3M1ptOW5lbWt2UjJOSVMyUmFWamhOU21OaVJWRlFlWFZWTUhaeWR6MDlJaXdpYldGaklqb2lPVEF5WXpVM1lUZ3haak13TldWa05HSXdOemhoTldKaU9USmtPVFpoTlRBMFptSXhaVEkxTURnM05UQmxNRE5tTVRBME0yUXdNekJrWVdWbFpHWmtZaUlzSW5SaFp5STZJaUo5',1782073858),
('Iz9pe2fgEIN9iIV0jBPCUPyNjIehr2Cxg60FjdTT',NULL,'198.235.24.127','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','ZXlKcGRpSTZJbmx5VXpKcWNWVjFkRWRZYVhsS05HSm1lV0ZzZDJjOVBTSXNJblpoYkhWbElqb2lNMmt3VTB3eVIzQk9ibWROTWpsb2JWRnlVSGRaYm1scGFXaHZRbWRLTkVWVk5tSjJXblZqVERsclVuTTNka05PZVVoa1UwWmphbFIwZVZkb1VVbzVURWxWZFdSc2IzbFhkMDFSWkVaS1QyaEthMnBrVWtSc1YxbFdlRTlYZVVNMU9FWnNUVkp4WkRCSE1Fb3djRTlzVVhOTFEzQmtNbG9yZW5ndmNWUmhZVFZCYzNOalpFVnZjeTlUT0RNNU9IUkZkVGx3VlZWdU9GbzRPVEZ3V0ZKQmRIZERVWGxRU1d0dVVIRnZSR1ZRZFRsWVZXcHJiazV2UldJd1VWUkVaRWxoTmpRdmRFRkZVM2t3U25wS1NWRkJhVTh4UlV3MFVUMDlJaXdpYldGaklqb2lZMk5sWlRrMU56VTROamt3TmprM01UTTJOakJoWVRaak1HTTNaakEyWVRsbVlqWTROMkl3WTJObVpUazVaakl6WkdNNE5EUmlaRGs1WkRsaFltWTVOaUlzSW5SaFp5STZJaUo5',1782085801),
('J7ujRf4UJc8Tj8yztUaWY2JtAmf0eqMrT0jSwPfI',NULL,'58.212.237.213','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbGczUTNKT1NFZGlOa1p5VUhwRlZFcGFPVzFDTDBFOVBTSXNJblpoYkhWbElqb2lVR1U1Vmxwc2NVd3haRnB2T0RkM0wxSTFkbE5EWmtVMldYWkNLems0UjI1eVRXRnJUblZCU1Rkd1EybzFiV2xvVm5KMWVsaHJTMVl6TnpSMmFGazFXV1U0UW1ZeVdVNWxXazVhWm01RWVESkxlSFF4ZG1aRldXaFVUV1V2YjI5emEzTmtSVWhoUTJFelZ6UTVNR3N4VUVVemQwODJjWEZNYUdsa1UzQk9TM1Z3WmtkSU9HaHFkVk5zU1hFeWQxWnhNSFZhTDJRcmExUk5TaXRvUkZoRmVrMXFlbFpZZWtGVlZGZGhhMnRzTjBsaVpUUnJNbGxPY0haa2VIZFVhMU15TUUxWmRXWjRRa1JCVDNsR1FsSlRZM1pCUWtvNVp6MDlJaXdpYldGaklqb2lNV00xTkdJeU56Qm1PV1l3TkdOa016RXpZVFkwWTJOaFpUWXlNV0UwTnpFME5EWmxNMlprT0dZeFpqSmlNV0ZoTW1ZM09EUXlOR1V6TW1JME5XVmxNQ0lzSW5SaFp5STZJaUo5',1782075269),
('jF8BnqSyyNBTKSApaeFPeSB5wk7oUBb78Vv6yGfW',NULL,'139.212.70.6','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbU5QVFRadU5XNDJlVTQyUzBoV2JXdE5PRTVMVVZFOVBTSXNJblpoYkhWbElqb2lSV05KWWtOalowWTBiMHhQWTBrdlZpdHFXV3RMUVdaRWFIUklUekp4VXpkMk1YazBaR3BDZVd0blNHRklPWFUwV2poVWFHbzRVMjA0Y1dkRVpteHhTRlIwYzNacVZsZGFSVmRrZEZwbVMyVlBjalIwY21sdGEzZEZaa1p4WmxvcmRVaHBXSGhOYW5CMU0wcHFTWEUyUnpGUlZIVnhaMlpOYTNkNlpHMUNlbVpSY2pOWU9YaDVMMjlSU1VZeGNHbERUVWhyV1Zvd1VtNUdZVWNyY1ZsRWRVUmpRMFpuUlZCU1VGVkxORWhoUldKWk1YWlNUbFpzVm1kWFIwUTJielZ3VnpScWRXbFVjbk5EY25oWU1tWnpOMWRpYWs5TlFUMDlJaXdpYldGaklqb2lNekZqWmpNM09UTTJaVFF3WWpVek1HTTFZekJtTm1JMk1XWXhPRGxqWVRrME4ySmhNek5sTURnd1pqTmpZbVl5TlRJeE4yTXdZV0kyTjJJd01USXhaaUlzSW5SaFp5STZJaUo5',1782074788),
('Jpmg4aXAKcNdQTyhknS3Cwu0cJXPaVjeVkmJlSVp',NULL,'153.75.91.100','l9tcpid/v1.1.0','ZXlKcGRpSTZJazA0V210bk1EaExRV3R2VWtwTVozTTJXV1F5Tm5jOVBTSXNJblpoYkhWbElqb2lSM3AxYlVkdWJrVjBaMVY0VDFKa05EaENUVXQ1Y1hCMFYxcEpRbVpGUldSSU16TmlWeTgxYTBKVWJVMWFaMWMzVWpaWFoxTk1kWEJpVGtWSFIweGtPRGR2WW01NGRHWkJXa3QwVVM5MWQyOUtNbXRrSzA0eVZuWjRkbVpuVFd4MFoyTlhRbXRFYjJaV2VYY3lTemwyV0dKMVRVVTFSbGxpYW5Fdk9YZ3hVRzQyTjNveWVXWlJVMlZYUWpCWVZVaEZiRmRuV21jdmVtODNWMWxDYURSSVUyWkpLMGxpZDFSMWFVZFJTVUUwUldaR1MweHZkbFJ2U0hCSmFVUjBWbWRMWldWUFdFcDBUREJMUWxSNUwwbGpaMUppTmtrelp6MDlJaXdpYldGaklqb2lNRGRoWVdOaU16STVOV0UyTXpVMVptRXdNbUk0T1dJNE1EZzFZbVZqWW1WaE56VmpOalV5T1RneU5HRTNPRGhtWVRFd00yRm1ZakJtWVdReU9XVTRNQ0lzSW5SaFp5STZJaUo5',1782052081),
('KQaOl0gXvI8JD7hd4Ke5MEOWxqskyKin1CMo2vkG',NULL,'60.16.198.70','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJamd2YVhsVlNVZHZTRnBrYUZGRGJFTlVNaTluVVhjOVBTSXNJblpoYkhWbElqb2liMWRzYVVVM1FqUm9SeXRVZFVaSE1EUjFZV3QzTUV4MGRVbFlSVmxFTWxrek5HNDRWVVU0S3paeVFtWlVZMjluVDJkNldGaHZVVGRIUkU1MVNITlVNVkYwWVRoUlNHWm5WVlZwYmxscFUwaFBiR05QY0ZGV1JrRjBhVkZYWjNkU016VlNlV29yZEdKclJFSlJRWHBzYnpCcFRsVmpXWEF6YjJzNVVtVTRRVkJIV1VNMWIyUnFhekJOYUZSQ1ZEQXdaVUpFUjNGUVV6Sm5TVlYyVkZkdGJETjJLMmwyVEZkblQwTnlVbmxtT0hscmVUZExaM0IyZURKcGFtc3JXVk12V1ZGMGNsaGtkblpFY0RaT1NDOVlaVkpXVTA5Wlp6MDlJaXdpYldGaklqb2lZV0poT1RVNFpqYzJOelptTlRnek5ERXpOV0kzT0RjNU9UWmxOamt6TnpObU5XVTNNR1EwTnpKa01XWXpaR1E0TW1NeE5HRTJOMkpsWTJFNE9ESTFOeUlzSW5SaFp5STZJaUo5',1782074262),
('krs6m7gKD9dqnG4NyqjfLBjlMm9f5NIRpBNOdrP6',NULL,'152.32.133.102','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJazk0ZEdSdlJETnVRV2RSVjJ4cU1tdHJSVVJ4VUVFOVBTSXNJblpoYkhWbElqb2laRXhwZDBsWlVtOUxhRXhxVkVwbVV6WnNla0ZJTlRKbVFUSlBlREpXYVdkdGJIaFNOakJWYkVOa2NrcHBjRmt6VDFSdFVqRm1XRGR2YjFSRVFUSmxWelpHYWs1RE5tUkxkRUp0YlVOeWJYSXJZV3RqUkRjMVRsQjVja1pTVm1oV01GTXpWMUYzYW5adFYzQmFSVWx6Vm14S1VsVnhla1kwTkhOU1kwdE1SWGhUVDJoMVVHeHlaR1pSVkhsRlVFRkRNR0poTlROS2NtRkVjRmQxYVU5blRGSlFTelZzTlhKNFdXcGtNMlkwWmpKME1VVTNORTB6Tm5WR0x6RkNaUzl4WW5oU2FFRXZNa1JDYW5kR2VEVlNRazVCYTBwbGR6MDlJaXdpYldGaklqb2lZV1UxTlRRME5UYzBaR0ZqTTJaaVptTTNNVGMwWWpaa1lqSTJNbVJtWkdZM1kyRmpNRGRpTVdReFpEWTFNMk5qTldRME5XWmhZV0psWWpSbU1HRTNPQ0lzSW5SaFp5STZJaUo5',1782061543),
('l47QYG6LhwFDuBBLB6gJyDdPKFVwS19SuPjhChK0',NULL,'45.148.10.200','l9tcpid/v1.1.0','ZXlKcGRpSTZJbFF3ZFVkelJXWXpNVEIyWWk5Wk0zaG1hV05WT1VFOVBTSXNJblpoYkhWbElqb2labkJFTkZKdVVrdHJRVE5OUjJzNE9UaENTVkZsTkhaUE5qZEpTbVJ4Wm5kSlUxWTFka0ZZVHpKNVZYVXdZVm81TjAxMFR6RkdiMjF3TlhaNU56ZHdaMmROTkhsTWVVRTRaMGswYkhSTFlqSkRObTVLVjJoV1ZqRnZabEp4WnpoNVJVOURRaXM0TkVJMWFVTjZSUzltT0ZoV2JuQkdkRE15WTFGbVdHeFVhVEIwZW5RM1oySllTMVY0U2s1c2IzSXllREYzTkVsclZUTXlOa040YVhGTGMyeFJVV1IzYW5GdWRrNWhWVW80YTNSbWNFSnlibWRPTHpBMFIzRk1Sa3cyYlRJeU9HNWljWEZ4VWs4dlQwVmlRMlIwVHpGU1VUMDlJaXdpYldGaklqb2lOMll6WVdNeU5qRmlabU5sT1RZNU1HTmxNbVk0Tm1RME1UUTBaVFV4TVRCalpEWXpaVGN4WmpKaFlUQTVPREpqWlRVM1kyUXpaRFppWldSak5ESXdaQ0lzSW5SaFp5STZJaUo5',1782056255),
('LfcxV1HJAaub0m7fVA2J4t7Axf8ub5Kx53E31P5p',NULL,'176.65.139.66','Shodan-Pull/1.0','ZXlKcGRpSTZJbW96VDNkNGIwbG9jbmRZVVROYVJucFZTR3MxVjNjOVBTSXNJblpoYkhWbElqb2ljMDVKUWtKV1VFSnNPRmc0Ykc1RmR5OVVaM05sU25CR1NEQnNOelpVTWpNdk4zaDNWblI2TkhkQmIzSllhemxZYVc0cmJXZFVUelJXU0RkS2IzTjZSazlEU1RZd1FVWmhha2xoYTNSdFJFUktTRWRNTWpOeVQzWnhWM1pwV1ZCUlYzUjBTSGhWZGxWMFl6WjFWVmR6YXpoMUwyMTNTV1Y0WjB4d2FuUXhXV3RSWW1WeVQxcHdSREZIU0ZodFkxcFlkMUlyY2pKUmVVdHZRVXRaU1RscVUydHNkemQwVEZwUU1IbHRXV014WldKR1RYSnpjMDVJYjFGcWRHNTJVVFJKYjFvNFdWVjRXRkV6TDBWSU0yNVRNa05FVTNBeFVUMDlJaXdpYldGaklqb2lORFl6TlRsbU1XWTFOVFJsTVRCak5EQm1OalExWlRnNVlUQTRNV1prWkRVMFpUVmpORGhqWWpRMk5tVmpNREV5WWpKa056VmpNelpqWm1KbFlXUm1ZU0lzSW5SaFp5STZJaUo5',1782070698),
('moA90w0FQE7QKkRMAigrtgQEJZYo1JzsO78L45FI',NULL,'18.218.118.203','visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36','ZXlKcGRpSTZJblJMTjFobFltUlBkSGhzUzBaaFIzcExOMVZIZEZFOVBTSXNJblpoYkhWbElqb2lOSGhHTkdZck4ySlpMMGxTVFV4aFozWlpObFpMZUU5NU1VWjBSR05rZGxkWk1ESmpUVFpSVjJaeU4wbE5SbmxhWTBrMmFuTTFUV3hvV2pCME4yUjZkRGswU1V4eFNsQjZlSFppTTJ4WU1ISndXRmhqUzJwTFNGWldlazg0WTNJM01HMXRXWFJOWVd0eVRTdGxUbWwxWmpKRWRuRmhlSGhxU1dKWmFXOUlOMHQ2ZFRBM1kwZHZaekk1TVZGTmJVMXNiek5aTWs1YWFESmhPWHBQVnk5dU9UWXdNakowZWtKSmFXNHhWeXR5U2t0a1VFSkRNWEZ4WVZwMlNsUjNZbkkxTkVkemVXOWlaVWw2YjJ3dmRtWnpZbTlwVVV3M1p6MDlJaXdpYldGaklqb2lPREJsTVRobU1EVTJPRE5pTlRjM01qWmxOelU1WWpJME16SXlOelZsWVRVNVpqRXdOelkxTWpKbU1qYzRNVFkyT0RBME5EQTNNVFJrWmpSbE56STNZU0lzSW5SaFp5STZJaUo5',1782069454),
('mpOtICTV9DflTqvn34KqKxV4KUtRfJYHzbB2gCP1',NULL,'203.154.14.18','','ZXlKcGRpSTZJbFYxTldGa0szTTJaV3RPVjJKMWEyRk1UR0p4UjNjOVBTSXNJblpoYkhWbElqb2liakZVU1VsSlVIQkVPRk53VDNnNGFTOTRhbHBOZW1GWk4zaHhiaXQzVld0UFlsZE9hMHhpYURoemJuQXdVVXQzU0RoYVkzTnZhRTFSUlhsaVFqaHJSbTk0ZWk4MGVGQlVjSEZwVGxKcFF6bGlTbXQ1V1ZWR1RIZHBLelp0Y1dOSlNsWjRRamhFVGtsaE1USjVSR1ppWjBwcWRtRmxkWGwwZDFaRk1rdG9RVnB0VEVOWVQyaFVUVFp2TkZCVk5qYzVlbmhJUkRReFduWXZTekZwUjNsWmJEbGpjR3RoZEhWWFZGbHBTR1JhYm1WclYxQmpaMUpuTlVzNU1tZzBaRTlxTVhnMFVFVmpkbXhGYkZOWVIwaDROVzF4ZGpOb1p6MDlJaXdpYldGaklqb2lOV1ZtTXpCaFpETTRPR1F4WVRRNVlXVTVabUkyWWpJeVkySXlabUUwTXpoaU9XWmpOV0kxWmpGbU4yUTRNVEUxWkdRNE9URmlOakJrTVRrMllqYzFaQ0lzSW5SaFp5STZJaUo5',1782086024),
('MvEQ8cEO4a8jCNBfUjT9zRBIt3BG3USlyJWn8HOz',NULL,'124.117.194.44','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJazk0SzJSelR6SjRiRGRZVEdOV1VHMVdjaXR3U2xFOVBTSXNJblpoYkhWbElqb2labEZJZFcxTmFFZ3hWbWRtWlVOQ2NtcGpNR05VY0dkNGIzaFZlVGx5TjJRd2JUVXdZVTAxVkVwa1EwVm9Sa05DUjNjMGRua3pWRXh0WjJwcFYwWk9iSFJSVVc1dE1uVkRXakZoYXpWUk5rVkVWbFpxYkdSV2VteHdOMnRKUlZCUlMzWXdTR3h3ZVZodWJpOVJVMWx6YVRCcVZrd3ZjRWd3TVV4WU1XcFFVMmN6VjJWb01YcFhVbVZzYjFscFQwdEdSRUZ4WWpaeWFrNDVhM1ZLT1hKTGIwdHdVMUpaVEVFM1ZFbFZSRkV4VDNRd1dTODVORmQxWldnMFFraHNjbkZOSzNKdmJXWlZjeXN5Y1RCclJYaHNkMlJKYkVsSVp6MDlJaXdpYldGaklqb2lZMk13TUdFeU1UWmlabUkyTldFNE5XTXhaakk0T0dFMk1UWmpOVGMwT1RZelkyTmpaalEzTmpWbE16a3hOMlkzWmpJNE5URTVaakZqT0dVelptSm1OeUlzSW5SaFp5STZJaUo5',1782074969),
('N8mLhKEtwFJuWNlqRNrK6PZBjrje7S9fXeXJDDDz',NULL,'216.180.246.176','Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)','ZXlKcGRpSTZJbEZtZW5oRGJ6a3hhU3N4U1RkNmVuSlZlVzFHTUVFOVBTSXNJblpoYkhWbElqb2lTelo1U0RacFZ6TlZTVWxhV1hkdFdtbzFiV3B1WjNOMGNqQkZOelpwVVVGdlZqRk1lblJzVGpaWGJWcG5ObEpLVFVGVVRTdFlVa2RITW05cVVEZHBWVTVzU2tadWIySnZXRVpMZWxWUVNtcGtWbE5DYjIxNWIxWlhhVXRDYW1rNVZrVmtVMEU1T0hkaFRVOVJSSFprTm1obUt6Sk9aWEpvYVdobFJUaGlVbUp0ZURNMFdubzFNMUV4VDJSRVlrY3JhWGMwTTJoSlpFeExXazltWkVKbU0xaGpMM0JFV20xQ1QyVndjVFYyYzNjck9HOW5SM0JSY1dwelptOUxVVlZQYUVsT2JGVXlaVzU0Y0V0dVdXNUVaVmRCUmxKM1VUMDlJaXdpYldGaklqb2lORFV3TmpKbU9XRTBObUUxTURSbFlqazROakJsWlRGbU16UmlaRFF6WXpFeFpEQTJZV1JtWkRJeFpXTmlaV0kzTkdGaE5UbGhNbUl5WXpBMU56ZGpOQ0lzSW5SaFp5STZJaUo5',1782064463),
('Nd9gu7eH5NzranohjnlTmgfMXCtbx7p8JPmULsmo',NULL,'152.32.133.102','','ZXlKcGRpSTZJalV4UjJRNGVsTmxkMkp0TkVseE1HcElOMDVUUkZFOVBTSXNJblpoYkhWbElqb2lRVmh3UzBKa2RYUm9TSE00T0VKRVJWcEhRVTFQUzFFeFdEaE9hVEZpWjFsdk1Ea3hSbU42YkRKS1FuVk9URXRzVEZOMWJHOWxiRUprWm1WTGNVRldZVW96TWtkRU5HUlBRakZQZVZFNVZHaHBlRlFyZDJOdGVUbDRhRVJUZW1sbmJqTlBUMVpSYnpaYU9EZzJPRk4xWlZNeVkwbHdNV1l2UlRSbmQwSkpWWGRLVG5OVFdqWkRlbGRoVjJ4TVRraFRWbWhLTjFwdlZreEhVQzlIV25Sd1ExSjVURGMxTWsxeVdWTXlkR1poZWtwU1dETmxSMWcyWVZkd2JFaE9UbTFJWVhSU1lrTlhTVzVwY1dRM1RWQXZVbmh0VUhScWR6MDlJaXdpYldGaklqb2lOalV4WWpVeFpqazVNamd5TmpBNE9UVTVabUZrTkRKaE1qTmhPR0ZrWTJJMlpEbGlOamN6WVRBM1lqbGhaakJqWlRWbU5EWmtOVGs0WVRnMU1tTTFPQ0lzSW5SaFp5STZJaUo5',1782061535),
('nfpecP6iwdJ4WYXTt6By0zOQ3UpXYvVnzcLZiSX3',NULL,'172.236.228.115','Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36','ZXlKcGRpSTZJalZPUTFkRGR6ZDNPRkpDVkVRemR6ZDVhMDlaSzBFOVBTSXNJblpoYkhWbElqb2ljVWQ0Um10TWRWZFdhRGhOWmtNM2EybzRTUzl5VkZKWVR6ZERORTFqTldFclNqSTFWMU4zYVZwNFUzbHZSalp6Ym5KNU9UUmFkWE16YldaeU5HbzBaMFp2YUhGeU5DOXdRVkkyVWtFd05sWXhTV0Y2UjFabVdsWmFRa2hSWWs1SVQycGlkV3RGWnpWU1ZuUnJOM2wxWTNGSlEwcFJOek54VkVwNmNGWlVORE5aU1VGUFVEUTJPVkJZTDNGRGVEazJZVVZDZEVkSlVUSjJZeXRDZFdkbmN6aHdOMDlLY1U1QmJuaDFlV0UzUTJaUE5EUmxXRzlIWkN0YVMwbDBLMWxGTkdKdlRsbFdWMnQwY1RJeFJYbHZORFpoZFZNeVFUMDlJaXdpYldGaklqb2lZak5sWkRabU56ZzFNMlU1TnpJNE9UUmhOR05qWkdRM1pUVXdOV0V3TURVeE1tVm1PR0UxWTJJME9XSTNabVV6TVdGbVlqSXlNakptT1dGbVpUSmxaQ0lzSW5SaFp5STZJaUo5',1782073341),
('OEcLKc67jcR0GICSzUq1lUPIDP0cxHrUo4uU2yNf',NULL,'216.180.246.176','Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)','ZXlKcGRpSTZJa0ZsYzFoSFJHeE5WMkpMYmtoeFpscDJiVFJXV1djOVBTSXNJblpoYkhWbElqb2lSRVZSZWk5V1ZUQkJaMWN2WkhCVGJtUkJLM2Q1UlVreU1qUkhaRlpVYW05WVIwZE9LMnBFYUdaSFRHTmxUWGxTY2toNWRWbFRMekpxVWxkaVR6bEJTVEJTUms5QlVEQjVWMU40U1dOcVZGazRaMVUxWlhReldETjFaRVUzTWt4MU5XZHJVRUZXWmxaUGRFbElSMWRGVFRscVpYazRhWFpTYlVoa2J6bE5UV3haYUdWVFZGUk1kWEppYXpKbFV6WjVNR1pXVldsYVlrZHJUQzk2VERCclNtVm5RekZ2VEZkVEwzWjZWSHBQTkhoMk0zWldZVzlFWWpaUE9IVlRXV1JrYjBKT2F6UjZSbkYwVDJ0aVFqUlhSVTVuTUhBMVVUMDlJaXdpYldGaklqb2laV1EzTXpFeU1qSmtOVEV6TVdZNU5URmlaR0ZpTlRrNU5HVmpaVFV5TXprd01XVmhZamhqTW1JMU16STJOV1JpWldJMll6VTNZVGRtTWpBMFlUWmtaU0lzSW5SaFp5STZJaUo5',1782064544),
('OwvUaM6jSraMcSlu0sGTmKfJLBAe906KZAFcxgb0',NULL,'45.148.10.200','l9tcpid/v1.1.0','ZXlKcGRpSTZJbnBuTlV3clNVOUVSazEyVTFSUFJqWjRiWFJLTWtFOVBTSXNJblpoYkhWbElqb2lRemROTm5VeFdqUllVM2hMUnpoa05UaFNiMmhCUld4ak1GcE5abUY1Y2tsbVVYTkpTRUppVVVoM05FOTJiRlk0ZFRoeWNHaHJZMHBIT1hCVFJXdDVZbGRsTmtKS1dIcFZlVUZWSzNZek5VdFFOWGRPUXpOc01IQjJiMlUzWmxJMk1ETnZXVE5xVWtkelZYcHlkV1I2UVd4WlRqWTVibXhZUzBZeVQwWlFiSEkyU0Zad1ptVk1aRWxSUmt0UVkyOUZZekI2Ukd0TE5HOHpUMmxKU0d4bWJsWk1NRXBTWTNWak0wOUtSMHd4TURBclVrNXlWV2hzV2paNVNYQnNkVGMyVjAxSE9GQkVjRkZzT0VnMmVHdHBiVEZNYlRaa2R6MDlJaXdpYldGaklqb2lOV1F4WVRjek56QXdPRGcwWXpRMllUaGhORFV4TWpJMU1qbGpZVEZtTkdSbU9HWm1Zek5sT1RRMk5USmpOamxrWlRreU5EVXdaamszWTJNNU1qYzFNeUlzSW5SaFp5STZJaUo5',1782075688),
('pjCvilxrrO3WMZGNlhlle7UAWB8iCYDsYcyN58pQ',NULL,'182.54.23.135','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbFJKT1RCWVZtTjRUQ3RuTkZSWlFTc3daREYxUjBFOVBTSXNJblpoYkhWbElqb2ljMWxQYUZsQk9XRkxPSFpCZWtaNFkydEpaMlJFT1hWbFZEZFNiSEUyYldoUFFtMVNZMDFxYTNsSlYwRmxZemg2WmpselMwbHJXVmh6UjAxYWVWVk9aMXByWjI5cVdtODJSMUZrVUd0VVYxVnVWUzlyZVUwd1pFSmtSbGNyU1ZkbmFIYzNaa0ZyYjBKRVVqZ3daMXBtZDBwTWJGazVhbTl1ZVZWbVFtaFVTR3d4Y2pCRWRtaDBjR04xZVU5WGFpOVZjbEJXWWtOMFJFNWlURGxCTlVGRmMxRXZSR0pTTVhFeFNXOVdSMDFHYVZScVFqbHBXV1pwTTNwWVJuRlZNa3czVm05dU5UQlViVTAzYjI1ck1WaDVRbWN6Y2tsVVFUMDlJaXdpYldGaklqb2lZamxsTTJRM1pUUTJZVEJtTmpBeVpURTBORFE0T1RVeU1EQTFOMkl5TURaaVlqVTBNekF3TWpRM09USm1NMkZoTm1NeE1UbGxNMlJsWVdVd056RTJPQ0lzSW5SaFp5STZJaUo5',1782075080),
('PsIceioWldWPngDWw5w7TDy4kocuf4MyraPIkBm3',NULL,'144.123.76.248','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbU5VTHpoQ2VFNTFaa29yYTNRcmF6VTJXak15VFhjOVBTSXNJblpoYkhWbElqb2laMDlxTVZGMVdXbGtiR3RaYVdaV2JsTkZRbU15UXk5QmRsRlNVMDh3VXpWR016QXJaRXBRVkVoM1NUSTJaVFUyWm5kdU5FdFFWRW8wWWtkM2VWWXlUelpZWlROWFRIZzFhRTltU3lzMVQyaE5hazFOUzB0bVNVZFFMMFJKU1VGSFlTdHVlVE5oWld4dGVuWlNObUoxUlhwVGFTdDJTRzkyYmprMlUzZE5XVFZ0Ym5rd1ZYZElXVkY2ZFZwcWRUaGlORWc1UlRGVGNWSnpPRWh3TUVoaFVIbENiaXRUZDB0UVExVmlXRUZTUjFrM04wVkpNRVUwZDFKeGN6bDRkbTAzYjJ4RmEycGxUREJOWlRGTmJGaFlPVlpaU25nM1FUMDlJaXdpYldGaklqb2lNMkU0TjJFMFpqVmlaREV6TWpnNE1qaGxZVE5qWVdJek9XWTNZbVpsTmpRek1tTmtZekF6T0dSallUY3lZalU1TmpFMk9HUXhZMlF6Tm1WaE0yVmxaQ0lzSW5SaFp5STZJaUo5',1782074105),
('pvPbFhhz6CkpUZFrS2YcqVfYoPejxdnWBZH7VZWR',NULL,'165.232.99.130','Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0','ZXlKcGRpSTZJakpRU2l0a2NHNU9jREZLYjFveVpIUm5OMHRvYVhjOVBTSXNJblpoYkhWbElqb2lhRXBNT0ZaQ2NGUkViRWxPTUdOc1FqWlhjemRZYVZsVU5WbHZiazV6UkZoeWFHWlhTMFpoVEhvNU5ERjVhVEp3Y25ORFZFcElhMnN4ZEZaVFdrcHBjMlZaU0dsWlRrdFJablZrVkZwQ2FHVTVVaXQwUlRSWVRGSmFRWGhhZVc1eVpUbHhRekUzUjB4R1VEQjFSWFo0WkRkbmNXdFVXVVpQZVhCbFZ6VlRlR2hFZW5sdVpuUnpSazkyU2t4cFJFSmthRzh4ZUZCU2FYQTRXbk52VWxVMk1YSXdSMlZaV2xoa2RTOU5aSFl2VVd0VE1YSXphVEp6UlZaM2VIVmFOblZYVFRSRE5sWlVNelJrVGpOYU4zUlBMMG8xTlVWSlFUMDlJaXdpYldGaklqb2lPVFJqTkRsaVkyVmpaVGcxT1RCaU1XWm1NRE5qWXpFME9EVXlaRFF6T1RKbVl6UXpNekpoWlRNd09UTTNOVFE0T0dGaVpHTmlZMlJoTmpObU5HVTNNU0lzSW5SaFp5STZJaUo5',1782071223),
('RIOR9tx1dyTb4iCPWQOjLBBYPhrZM5syQ5eRWEIT',NULL,'60.166.82.233','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJalptVUdwYVRHa3JXbVZsV1hvMlpWWjBLMEV2WVVFOVBTSXNJblpoYkhWbElqb2lMMGs0VGpGRmRGSlFRMVJJWkRZMU9IVTNLMEpPWlZjM1pIb3hjRW96ZVRWT09IWlFaaTltTWpocllWZDRObWxvZGxFME1rMHpka2xNT1ZZNVNFVnhWbXRGVVVoSFlsUTBla3N6TUhCT1pIbFRZbE5uTDJ0RmIyODNaMGN2Ym5ScE1XZE5MMDkxZVhaR05EUnljR1p6TVdsUU9YWkVRa0p5U1djeGNIUXJkVlJ5WjFsd09HSkdhVUZJWkVkbmNWVTRTMlpYYVVrMVQyVkVUREJWWlhOd1RXSnJlVkJNU2s1dE9YTkpWSEZOWXpsUmVFNW1SVEZGVmtGUVFreG5VbXh4U2xrMVYwMWtZbWhHZG5GVWRVMW1Va3BxZUhac1VUMDlJaXdpYldGaklqb2laV1l6Tmprd1kyWmhOVFZpWWpNM1lUVm1aRFEzTjJKall6QXdNVEpqTkRJMk16TTFaRFF3T1RJNU5tTTNNMlJsT1RBNFlUbGhaak5sTnpabE1HSm1aaUlzSW5SaFp5STZJaUo5',1782075465),
('sYx8yvhCHWjalxciB8jIjpTTA15uWDdtzXrcSv3U',NULL,'111.113.89.244','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJa1V4Um1GSGJYSTRVekJXY0dGV2FXbFRiVkE0TW5jOVBTSXNJblpoYkhWbElqb2lNR0U1TDJ4bVdtMHZiM1UwZGxSNldXdEVOa1p6YWtkaU1UTkNZMjkyWmpsTVRtVnlUVlZ1TVhKcWVDdG9hMjAwWkdONVEyMVRNbHA1YlZKTlZDdFJhV3hhUlZoa1ZuWlhVemh6Tms1Sk1raGtiVE01V2sxTk1tdzFhVFJaU1ZkcE9VbFhNVlpCYld0blZqUjZWV3BDVjFSb1pHaHRNWGxsWVV4U1ZuaHVNM0ZMUlRWdU1uRm1OR2N5ZUVZMWRWUnJTVkJpUldOSU4zSm1WM1pTSzI5NVowUmtNR2syVmtoa01FNDJiSGwzYW5CYU5FaHRUVmN5ZDNOTk0xZDJTV3hvWVc5bVREbGxTbmxRYUhKclJFaHFUM281U0hZM2R6MDlJaXdpYldGaklqb2lObUUwTXpCbE9EZGlabUUxT0RrNVpUQmtNemt4TUdReE5XVm1NR0V4WkRSbU9UQXhNR00yWkRFMFlXSmlZMkZoT1dRd04ySmxOMlUyTnpobU1EazROQ0lzSW5SaFp5STZJaUo5',1782074695),
('TN1sQy5SvWOnh3Y5aodCJddr5TqNomlE49UnWYVH',NULL,'185.247.137.180','Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)','ZXlKcGRpSTZJbGxxZUhwd1JUQm9Za0ZZYzNoWE1FVmFiRmRqYmxFOVBTSXNJblpoYkhWbElqb2lhSGh2VTNNeWJUZEhMMnhtUzFOMlIwTk9WMFJhUkZRMk5VVjNZMEpTYkRkM1VUWk5aM0ZxTUVkUGQzcG9ObXR1V1hjMWFuWlZNMEZZZEhSM1NFdEdTa1ZyWkZGMWJqVkxXR3BQYkZOTmEzRnlWM0J0TkRGRFFuaHBRa05pVWpBNFVDdGhNV2x6UVU5TU9VNXRWMlpMTUVJNVlYcEdXblZXU0dWME1rRjNWVTAxY2pSR1V6TmtaQzlVY0VreGQyeHdUVEJDWlUxM1QxRlZTbGhhTDJkb1dYcE5Xa3hJVkdaeFNHcHhiamRKWTI1d2VXZ3ZTM1pPZW5kNVZsRTVNMEV5TUdoSVZqTndXbGxQZGl0dmJXRTVUVVpXWjJOcFFUMDlJaXdpYldGaklqb2lOV1JrT1RZeE1HWm1NbUZpTXpBM09URmxZams0TlRrME1UZzFPRGd6TjJFM09HTXhORGs0TTJSaU5EY3pObUl3TWpNMk9EbGhOall4WVdGallURXhaU0lzSW5SaFp5STZJaUo5',1782079006),
('triKKaYTzBkEgzJRbkynY3h72na0TVRGiun3GIwh',NULL,'31.57.38.162','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3','ZXlKcGRpSTZJa281UmlzMGIyRlFlazFHTkRKalRtRTRhM05YYVZFOVBTSXNJblpoYkhWbElqb2ljMVpTYmxCaWFsQTRXWFp5V2pGdGRGUTBVSFpPVG05aGEwOXBjazVCWkhJNVRuWjBhVkJDVVZKVFZHaFFlbWhWYUZCbmFXNW1URU4zT0VZd2JIQm5TbUl2TWxGbEwwNHlPWEpWYWtSRVZVbG1WV1kzZUZObGNuVldhbkZTU0hsek1YUlZhbXhCVW1jM1RHdE5TVEEzY21Ga1JrUnlXbFF5YjNCdFpqVnNLMWRQVURSR2JIbDJibXhZZHpaeFIySXZaRVZNV2pjNWIwVkpUVzlIY201bE5GbFJSbWgwVDJ4TFlrMUJaalIwY0VGdmJXcFRWbTgxTm01dE1GTnRaMjlYUzFKdVZFbEZURFJuVmtrNE1FVkRWV2wyYUdSdFFUMDlJaXdpYldGaklqb2lZMlEzTURRMk1EZG1ZV1F6TmpKbFlXVXlNRE01TkdJeU9EZzRPV1JpTkRsbFpqaGlNemxqTmpZMlpEbGxaV0ZtTkRJNU5EQTFPVFV6TlROa056QmhNeUlzSW5SaFp5STZJaUo5',1782067070),
('ujggLPA4LbXYXb0vtiTDXTF8cWnqhAqsMbw9pgjc',NULL,'57.129.12.51','Python/3.10 aiohttp/3.13.5','ZXlKcGRpSTZJa0V3U1VweVJWRXpTRk5MSzJSTlNqSkNZa28zZEhjOVBTSXNJblpoYkhWbElqb2lSa0p0WVRaUVptdEZhMk12WlhNemNUWjZWVkFySzNCNFVYUjFURzkyVjJVelpqSlJOVGhHVEZWVFEzbzNlR2hUVmxsSmJ5czFhbkp2U3pVeVRYVjNhSFpJTVVSV1dXcHNWbWN2ZW10bWR6aDVOekZTVlhkaVYxbzRlSGQyV0hKSWFrRmlVRmt2U0M5R1RXRjBla0Y2ZFhSRlZ6QnpRbFU0Y1hveVNsbHlLMW9yT1UxYVQxSTVUMkZyZGxCNmVVeG1VSE5VTkM5RVMxcFhiMnhHVEhONFNHRlNOMFkwYTI5bGNqWlpMMFJ5YkRSV2FGcFhUMko1V2pFMVRuQkNVMmRoWTJ0amJDODROM2NyTVZGWlFUQjROV0p0TWtKdVp6MDlJaXdpYldGaklqb2lOamRtTVRJd1pUSTJZVEV5WldVeE5HWTRaRGRoTkRBek56QXlZMlF3WldZeE9UaG1PVE0xTkRnNU1URTNPVEZsWlRRMU5HRm1OMlkxTlRZNU56bGtPQ0lzSW5SaFp5STZJaUo5',1782084721),
('Utd8newdU4Tfe94EVDccyrXEbCK7jXiqOVOwKhsA',NULL,'124.31.104.148','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJalpaVjB4NkwwRlNMMHN4TVhOV2JHa3dVRTVrVUdjOVBTSXNJblpoYkhWbElqb2lVelZsZDB3MGVFMHhNRGhaY1d0elRrOW9jR3hyT0NzNGMwbG9ORzVrZGxKdmMyUndjVmx3YVROaWRreHpUVVpqYUUxRGRIWlVUekZZWlRkYVNFVkdkRXAzTm14SGVIWjZWbWxDYUhkVVkyczFhRzFtTkZscU1VWnJTbEU0SzBkSlFscFhTbVZRZWpWRE56TTFPRWhuYjNkbGFIVlNTbmN3UkRSb05VUklTMkppYjFWM1RTdFhZWGhpUVhaRWFuUlZRVE5OUlM5d2R6TktUMVZzVlhGd1kzcEtUMmx4UTAxYU1WbE9PR05ITkRCeVNURnZZMHN4TjJZd2N6RmxaSGRTUTBKak1UbE5hVTVLZEhFNVRqVkViM1ZZYzFoVVFUMDlJaXdpYldGaklqb2lOR1JpTm1abU1UTXhNalkzTmpSa01XTXlOVGd4TVRkaU5qRmxNR05oWm1WbU9ETm1PREprWmpCaFl6RTROREZpT1RJeU9EWmhOelU0TWpWallUZ3hZU0lzSW5SaFp5STZJaUo5',1782075156),
('UyQIcPbcgtWg83dcTbu77MILGRBw25jVCvpjwVTF',NULL,'20.38.5.218','Go-http-client/1.1','ZXlKcGRpSTZJbW81WlVGR2IxazNObmxwWTFsUlNXVlRhVlpvT0djOVBTSXNJblpoYkhWbElqb2lRMDQ1UjNKQ1MycHBiVWRoWVROVFdsRXhlRVpETkU5NE9ESnlVMHBtVW1GNmFsZFlTM2xDWW1oaWVIUldVbFJKUVRKck9ERlphR0pQUzFwb1lVZEJiak54Y2tWa1JTdEJXV1JWZW1OT2EzSTJaMnRyV0RGUVoyRjNOWEJYTldoT2NuZHRRM2R4YUdwRWNuUTFLMjVGUWtod1VGYzRSVzFqTkdGaGNrMVNXVkZDSzFwT1dtOVRlVk5XWjBKTFpESm1VMVpJVTNwVFMyRXlVa3AwVUhRMWR5c3ZRbXAxUTNJNU5uTnRPVlJyV1VaUVNqSlZVV1JKZFVac2RUbGxha1ZFV1V0blp6Wm5kREJIWm05dWFHMDBZMGRYT1Rkb1p6MDlJaXdpYldGaklqb2lNemc0T1dGbU9ETTJPR1ptTjJZeE56TmhZVEJtWkRSbVptWTVaVEZtTW1aak9XWmhOekUzT1RJM1l6WmhZakF5TnprM00yRmxOekE0WXpNMlpHUmtNU0lzSW5SaFp5STZJaUo5',1782074285),
('VIa3kGnHlvQq3PdAQ9BMPtokOv1b7qZZvoSRc3Ah',NULL,'205.210.31.44','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','ZXlKcGRpSTZJazVxUzJwaFZqaEZOME5WVmxWelZ6WnhTR2h3TjFFOVBTSXNJblpoYkhWbElqb2lWazR6TWpkck0wSk1iVzVhUTJkUGRpczNiSFJVV2l0QmFXOUtVM0ZUU21oNVNsaFphSFZHYUU5Q1RqUTFUbTVHV2pocmNtbExMekF4WTBnelpFNXRhRnBpTkZKWU9XZEdkQ3RzZFZwdFZGTmtUamhzT1Zad2VUVnRjVzk0WW1aMWR6aHJOWEJPUm05cGNUTkxVMnhFYm0xR2QwNUtZWE5QT1hCVlQwVnNkazVKTXpkdk9FbHNjbU5zYTJKQ1VXRlRkWEV5Tm5WS1YySjNha3RqZVZodlZHUnJiMkpsUnpOMVpuZEllbGhyWVRWaE1UTnFMMUI0ZGpGdlZFZG9kVEF4WTBGbFZISllPRUV4ZDJoVE56QmxRMGhUYzJaRlFUMDlJaXdpYldGaklqb2lNV014T0RjeU56VmhaalkyTXpVNVptSTJOVGt5TldVMU5UQmxOelppTldReFpETTFPV0psTldKbVkyUmhZek5pTmpkaE5UbGlaR0ZrTkRZeU1USTNZeUlzSW5SaFp5STZJaUo5',1782064207),
('wS7lg7PmUh22WNRXGvnS8hvNCLaKthiidDSsI499',NULL,'171.36.7.164','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJblYzVkZOd1lXNDFSSE5qUWxJNGFERnNXR1pTVGxFOVBTSXNJblpoYkhWbElqb2lhMmxyYTNkbFoyNWpTblZGYzAxUVkzcG1WQzlvU1d4cU5tZEtaVUZTZVZWTFEydzBlbkpSWTI0MVRXOUhkazF0U0dwQlN6bEhlV2sxT1VKSVYyaDNMMGQ1VmtNd1NubzNkVVZuUzJkelQxVjFVMlowSzB4U01sVTVjWEZvWTFKRVUxQlBSSE0xTjJwWWNqVjZZVVZvTkRsdk0yeHNRbXByYlUxbVVHVXZjazVvTXpGSU5qVjBaakZCVWlzNFkxWklkbmxEWW5rMlFtdEdlazUwVFdaNlprazNTRTE1VkRWdFEzbFBaVzB4TjNwVFJFMDBRM0JJYlU5alZrOHJXV3RpY25GM09FUmhjalVyVTFaQk1uQllLMjFNWm5oV2R6MDlJaXdpYldGaklqb2lPVGc1T1RVeE1XVXlNekV4TWpObE1qTTFOelJoT1RZMU5EazBZbU14TVRZM1l6STRPR1ZqWmpVMk1UaGhPVGt3T0RKa01XUmhPRFk0WlRjeU9HVTJOaUlzSW5SaFp5STZJaUo5',1782074548),
('WyHyvQRBn9dD5cuelEoEb5dgZZa7S5UWsqupPTQ3',NULL,'18.218.118.203','visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36','ZXlKcGRpSTZJbmRVU2xGVVJ6UmtVVTUzVjNreFIyUkZWRVJGUVZFOVBTSXNJblpoYkhWbElqb2laMFZLTWpCalJHZDRSVmhVTVZGNFRtZzNkVzlqWlhaUFZtSnllVUYyUlhoWmFraFJRWGhHTWpCR1l6TlpXRFphUjI5eFUxSjJTWEZHUkZKQ2JrZG9SbmRNTUVOSmFWRjRkVEp0ZFRobVdYaDBjVkpNWlRSclNYRmlOSE5wZWpWRVNUQXdlR05VTTNSSk5HMVhZbUV2VGxoWlMzWnBUbGR2VW5kTGRqWmxSbEZsY1VwQlVVOHZZbFZyVW1oNE4wRkVWamhWVFcxU2MwTk9UWGcxYlZsTWIxWkNhQzlhTWxWRGJDdEtWMkV4U0RWbFEzRm1aQ3RRVVdobmMxUmpXRFphUzBKVFFtTk5XRTF6UkhCSFlWUkNRVGRxSzI5UlFUMDlJaXdpYldGaklqb2lZalptTkdWallqSTNNemd5T1RsbE5URTBZVE14T0RjM05HSXdaamsxWXpFNVlUQmpaR05pTlRFNE0yVXhObU5oWWpBMlltVTVaVGN6WlRJMU9HSTJNQ0lzSW5SaFp5STZJaUo5',1782069571),
('xIUAeZsNMm1KCxCh7QK7ug0Aolsjss0FjZNDQUZZ',NULL,'216.180.246.176','Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)','ZXlKcGRpSTZJbk5VV21GbVEwWTJlVk0yYjA5bGNtMUVkM05YZG5jOVBTSXNJblpoYkhWbElqb2ljVGR4ZFc1SFNIVnlkVUZ3Y3pSeFVqZGFaRGRRVFd4U2NsUkdTRm8wTUdod2FqSlZURzgyTXpWUFFrUmlTbXQ0TWtGMVRFNVRVRXBDVG1OSlUwbEpXR0pNVW5oTGJsSkZkVXc0V1cxYVlUWTFlRUpETld4aVF6Sk1URGRIY2paM2QxTmFlRFpoZWpRMWFtUlhRVEp5Y1cxb1FuVm9lRFJtTDJaM2VERlhTMmhRV2pWR1lVSnlka05IVGxwc1dWSjRWMU55S3pKdVduWXZRMHBZWnpsT1VrUTFSblpHVUZkR05reDNPRzR2V1ZwUWNraFlTVk5UVlZGS1lWaFpSV2d4YnpsWmVtWkhlRGw0ZDIxbVYyVmhVMlpyU2pOb1p6MDlJaXdpYldGaklqb2lOalZtTVdZMFpqWTJaVEZsTkRJeU16ZzVZVFF5WWpjNVpEWTFZamRrTVRobE1qRTFOelF5TkRRMFltRXhZV0l4Wm1Nd05UUmtaV1ptWkdNeU5XVXdPU0lzSW5SaFp5STZJaUo5',1782064426),
('XrGSWws5dcyMXcZtubc7AnEM8Z51xeFGnD9taN2q',NULL,'36.106.167.37','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJbVJxUTFwRVQzTmpaVTV4U1Voa1FtdG1lbFZGYmtFOVBTSXNJblpoYkhWbElqb2lkVmsyUTNaRVdFbDJZMWhhYm5sdmFFWTNTVXR6VUhWdUx6SmpiM0ZyY0hOaFozUkxZV2xUYWxKd2VGRlFSbWw1YzNobFZ6QlBUM1k1ZEhkMloyeEtVMHBSUjI1UWNHMDNSWHB1UkhsR1VqWlhMM1kzUW5aWVJtRnphbkk0UjNJM1pEUXdSMkY1UTNGWGJ6RkxjVEpVUVVob1ZXRnFjbXB6U21SU01Fc3ZjMmc0Tmt0MFkzazBRMDR3Y0UxeEx6WkdVa3cxU2pCSGJITmhVVWRRVm1kcmFVODFMM0ZMYlZwUVpDOHpSV3RVTTNaT05qRjVkMHhJWmtSNlNHa3dUekJxT0dGVWRIVjRUa2xxTXk4M1YzSTRWQzkxTmsxUVp6MDlJaXdpYldGaklqb2lNV05sTm1Wa05tRTRNMlkxTnpVeU5EWm1aamM1TkRSbE9HUXhNelV3T0dSa056STJNRFl4TkdGaVpqZzBPVEF5T1RFMU5XRTVNVEJrWW1VM056WXdPU0lzSW5SaFp5STZJaUo5',1782075388),
('yaIamGrqS0hHwBBy5gRo6ivx9HvdwdtNmmtZDPnB',NULL,'199.45.154.136','Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)','ZXlKcGRpSTZJazQwWm5CMllXVXlTekp3WkVWalJtWlhZWEJ0ZEdjOVBTSXNJblpoYkhWbElqb2lTMWhGYkU1bU1IaHhUblJtV1ZJNVVVaE5PRFZ2UTNGMlZHNTNXalJNZG1KWU1rTnlZaTlHTlN0clVtMVNWM2hDYUM5bmRpc3JNVGx4VEU1RGVYUlVZak53UWpaelFYZEpia0pKWWtKVmRGSmpURWRsVkZBNGEycFVhVFV4Umt0V2JVMUZPSE5hYzNCRlRtRkNNaTl0YWpGa2FraHFiR3BHZFZOdE1DdEJWVFpQZVRVMmNHVlFibWMwWmt0RmJVNHpkMmsxYzNkaFNuQkNiMlZsWVhodGNEaHVTR3hrYlhsWVZqSllXazlOVFVWRVlpdEtVVGxCUTNSMFZYSmtaemRhZW1kUFozZHRMMEpWTWpVd0wwcHlTMjV2WlVSRlVUMDlJaXdpYldGaklqb2lZV0V3T0dNME1tTXdNMlpqTmpNd01EVmxNbUl5TkRsbE5XSmpPREkzTTJRd05qVmhOalV3TkdFeE16VTNaRFZrTVRNd01tWTJaVFZoWldNMFpXVTVZeUlzSW5SaFp5STZJaUo5',1782068854),
('Z5BYHpVCZOlzu5Q04ApL4vp27nPbz6lFoxQeMVPt',NULL,'175.30.48.250','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36','ZXlKcGRpSTZJalpVWlVKaU1YQjVXVFZHUm1wTk1pc3piRzloY0hjOVBTSXNJblpoYkhWbElqb2lXVXQxV1djNGNDOWpMMFJxUkZOU01UaGFUMWxHWTFZMWFWY3JZWEJRTWxWeE5qQmlkakptVjJoQ1YxTldiVmxwY1RoMlZYTmtWV0pIU0RkNE9YQlpWMjlpVHpSa0wxZGhXWEJ6VURSVVpGWjNTMjVtWkVjelMyZElSa3d5WkhNdmJXeG5kR2xKYjB4U1dFTlRWVVJhZFhSWmRtODBURFJUVlhKUFEyZzBXbkZHUVU1VFYwcElkamhFU0ZGb1ptRnhVWFJvY1cxMU5VVlNNVWsxWjFCeVdtdzRNQ3RMU21WbVpETlNObGMzTmtaVU56bDJVeTlIWWpZME5FaEVWSG93ZUdKb2FGa3ZWQzlJWlVKR2VpOXpRVEptZW01QmR6MDlJaXdpYldGaklqb2lZalppTVdZMU5qRXpObUpsWXpnNVptSmtaRGxrT1RneE5tTTNZbUZpT1dNMlltRmxaak5qWldFek56Y3dNR015WW1RNE1HWTVOREkxWWpZNU4yVmxaQ0lzSW5SaFp5STZJaUo5',1782074316);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shifts`
--

DROP TABLE IF EXISTS `shifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shifts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shifts_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shifts`
--

LOCK TABLES `shifts` WRITE;
/*!40000 ALTER TABLE `shifts` DISABLE KEYS */;
INSERT INTO `shifts` VALUES
(1,'Mañana',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(2,'Tarde',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(3,'Noche',1,'2026-06-16 18:56:16','2026-06-16 18:56:16'),
(4,'Mañana y Tarde',1,'2026-06-16 18:59:51','2026-06-16 18:59:51');
/*!40000 ALTER TABLE `shifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `mother_last_name` varchar(255) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `phone` varchar(9) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `staff_dni_unique` (`dni`),
  UNIQUE KEY `staff_email_unique` (`email`),
  UNIQUE KEY `staff_username_unique` (`username`),
  KEY `staff_role_id_foreign` (`role_id`),
  CONSTRAINT `staff_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES
(1,'Super','Admin','System','88888888','942105155','ejquirozc@unprg.edu.pe','superadmin','$2y$12$h7wQ6/Z/hTXn9wsN4ILl9.9r0l79jL.LJJRpsTRId/spKjkZQZFg2','2026-06-20 08:25:06',1,1,NULL,'2026-06-16 18:56:16','2026-06-20 08:25:06',NULL),
(2,'ELBER JESUS','QUIROZ','CORONEL','74357593','942105155','equirozc@unprg.edu.pe','Soporte01','$2y$12$hMILGYZEKjX3AhE77T/8Lub3B6u4J4QlcCV/OVtpsqMt4UFkXt9jm','2026-06-18 07:11:48',3,1,'Zh6dol9IeWVI8idTIBpHicNpuUGXjrQvfnEx45XDmRrAb9A1vZhuvu3hMsRm','2026-06-16 18:58:56','2026-06-18 07:11:48',NULL),
(3,'JOSE','ANCAJIMA','CHAVEZ','74872263','977420643','josechaveez.09@gmail.com','Soporte02','$2y$12$xZUd.YNktVCv9qbzAsI3e.vZ5k5jWjoIXeBoNeM4hEvcbJg24eFFK','2026-06-19 09:32:47',3,1,'Zz2D8M3Z0neEhgpwvSlMZoZhmIEJJF5O1aXQktlwRMkCwJL39VHA4elFPBu2','2026-06-17 07:23:17','2026-06-19 09:32:47',NULL),
(4,'DIEGO JOSE','SALSACHIN','SANTAMARIA','72664440','957148483','dsalsachin@unprg.edu.pe','Soporte03','$2y$12$lLyoIrJqBA7dk.o2OpTnCO.oNm165bY0fvwNlkl5CiGbWVJ8CdMO6','2026-06-19 09:39:47',3,1,'DBairOvaElR677DzLrz8XccnxPNGToB8xDYEcSYbuJQB2E7QygJtzmMeul5N','2026-06-17 07:24:34','2026-06-19 09:39:47',NULL),
(5,'RODOLFO','TINEO','HUANCAS','16688711','921062046','rtineo@unprg.edu.pe','Academico','$2y$12$9KBhDDFHBQDKPyFNIM3YFOfgIuFYrB801aTJTtAwotG2mdAAdIGh2','2026-06-19 17:09:53',4,1,NULL,'2026-06-17 20:35:46','2026-06-19 17:09:53',NULL),
(6,'ANA','BARON','EFFIO','74432502','902219097','baroneffioanacecilia@gmail.com','Administracion02','$2y$12$JQYiSB4g99yIIdB4.mGLp.Pd9F2QnUJjX8pvClQBOrC7V4o7I6ZQO','2026-06-19 07:52:25',4,1,NULL,'2026-06-18 07:58:17','2026-06-19 07:52:25',NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_temporary_permission_grants`
--

DROP TABLE IF EXISTS `staff_temporary_permission_grants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_temporary_permission_grants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` bigint(20) unsigned NOT NULL,
  `permission_id` bigint(20) unsigned NOT NULL,
  `granted_by` bigint(20) unsigned DEFAULT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `staff_temporary_permission_grants_staff_id_permission_id_unique` (`staff_id`,`permission_id`),
  KEY `staff_temporary_permission_grants_permission_id_foreign` (`permission_id`),
  KEY `staff_temporary_permission_grants_granted_by_foreign` (`granted_by`),
  KEY `staff_temporary_permission_grants_staff_id_expires_at_index` (`staff_id`,`expires_at`),
  KEY `staff_temporary_permission_grants_expires_at_index` (`expires_at`),
  CONSTRAINT `staff_temporary_permission_grants_granted_by_foreign` FOREIGN KEY (`granted_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  CONSTRAINT `staff_temporary_permission_grants_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_temporary_permission_grants_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_temporary_permission_grants`
--

LOCK TABLES `staff_temporary_permission_grants` WRITE;
/*!40000 ALTER TABLE `staff_temporary_permission_grants` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff_temporary_permission_grants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_classroom_assignments`
--

DROP TABLE IF EXISTS `student_classroom_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_classroom_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `classroom_id` bigint(20) unsigned DEFAULT NULL,
  `placement_score` decimal(5,2) DEFAULT NULL,
  `distribution_locked` tinyint(1) NOT NULL DEFAULT 0,
  `assigned_by` bigint(20) unsigned DEFAULT NULL,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sca_student_cycle_unique` (`student_id`,`academic_cycle_id`),
  KEY `student_classroom_assignments_classroom_id_foreign` (`classroom_id`),
  KEY `student_classroom_assignments_assigned_by_foreign` (`assigned_by`),
  KEY `sca_cycle_classroom_index` (`academic_cycle_id`,`classroom_id`),
  KEY `sca_cycle_score_index` (`academic_cycle_id`,`placement_score`),
  CONSTRAINT `student_classroom_assignments_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `student_classroom_assignments_assigned_by_foreign` FOREIGN KEY (`assigned_by`) REFERENCES `staff` (`id`) ON DELETE SET NULL,
  CONSTRAINT `student_classroom_assignments_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `student_classroom_assignments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_classroom_assignments`
--

LOCK TABLES `student_classroom_assignments` WRITE;
/*!40000 ALTER TABLE `student_classroom_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_classroom_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_mail_logs`
--

DROP TABLE IF EXISTS `student_mail_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_mail_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `channel` varchar(64) NOT NULL,
  `status` varchar(32) NOT NULL,
  `error_message` text DEFAULT NULL,
  `triggered_by_staff_id` bigint(20) unsigned DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_mail_logs_student_id_foreign` (`student_id`),
  KEY `student_mail_logs_triggered_by_staff_id_foreign` (`triggered_by_staff_id`),
  CONSTRAINT `student_mail_logs_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_mail_logs_triggered_by_staff_id_foreign` FOREIGN KEY (`triggered_by_staff_id`) REFERENCES `staff` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_mail_logs`
--

LOCK TABLES `student_mail_logs` WRITE;
/*!40000 ALTER TABLE `student_mail_logs` DISABLE KEYS */;
INSERT INTO `student_mail_logs` VALUES
(1,1,'registration_manual_resend','succeeded',NULL,1,'{\"recipient\":\"elberjesus09@gmail.com\"}','2026-06-18 04:47:23','2026-06-18 04:47:23'),
(2,1,'registration_manual_resend','succeeded',NULL,2,'{\"recipient\":\"o3971312@gmail.com\"}','2026-06-18 07:14:07','2026-06-18 07:14:07'),
(3,70,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"rodrigoramos9171@gamil.com\"}','2026-06-18 08:14:14','2026-06-18 08:14:14'),
(4,70,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"rodrigoramos9171@gmail.com\"}','2026-06-18 08:15:52','2026-06-18 08:15:52'),
(5,69,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"fabianajulcaromero@gmail.com\"}','2026-06-18 08:20:00','2026-06-18 08:20:00'),
(6,71,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"emanuel@gmail.com\"}','2026-06-18 08:20:31','2026-06-18 08:20:31'),
(7,72,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"franzantoniotineodiaz@gmail.com\"}','2026-06-18 08:22:42','2026-06-18 08:22:42'),
(8,73,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"nkarlos320@gmail.com\"}','2026-06-18 08:27:21','2026-06-18 08:27:21'),
(9,74,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"bastianrojas424@gmail.com\"}','2026-06-18 08:28:13','2026-06-18 08:28:13'),
(10,75,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"gsantamaria089@gmail.com\"}','2026-06-18 08:34:30','2026-06-18 08:34:30'),
(11,76,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"zenapantaleonjenyjaritza@gmail.com\"}','2026-06-18 08:40:06','2026-06-18 08:40:06'),
(12,77,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"kelvinbecerraherrera@gmail.com\"}','2026-06-18 08:45:40','2026-06-18 08:45:40'),
(13,78,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"cr362334@gmail.com\"}','2026-06-18 08:46:52','2026-06-18 08:46:52'),
(14,79,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"qwqbianka@gmail.com\"}','2026-06-18 08:52:43','2026-06-18 08:52:43'),
(15,80,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"cixwilmer@gmail.com\"}','2026-06-18 08:56:28','2026-06-18 08:56:28'),
(16,81,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"cachaydelgadom@gmail.com\"}','2026-06-18 09:08:14','2026-06-18 09:08:14'),
(17,83,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"nicollsilvarubio2021@gmail.com\"}','2026-06-18 09:38:00','2026-06-18 09:38:00'),
(18,82,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"kiarabermeomilian@gmail.com\"}','2026-06-18 09:38:07','2026-06-18 09:38:07'),
(19,84,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"restelacobenas@gmail.com\"}','2026-06-18 09:43:47','2026-06-18 09:43:47'),
(20,85,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"lizbeth28garcialinares@gmail.com\"}','2026-06-18 09:46:14','2026-06-18 09:46:14'),
(21,85,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"lizbeth28garcialinares@gmail.com\"}','2026-06-18 09:48:40','2026-06-18 09:48:40'),
(22,86,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"paulojavierramirez12@gmail.com\"}','2026-06-18 10:03:39','2026-06-18 10:03:39'),
(23,87,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tapiakeyko10@gmail.com\"}','2026-06-18 10:12:00','2026-06-18 10:12:00'),
(24,87,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tapiakeyko10@gmail.com\"}','2026-06-18 10:12:39','2026-06-18 10:12:39'),
(25,87,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tapiakeyko10@gmail.com\"}','2026-06-18 10:13:20','2026-06-18 10:13:20'),
(26,87,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tapiakeyko10@gmail.com\"}','2026-06-18 10:13:36','2026-06-18 10:13:36'),
(27,87,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"florenciafloresordonez@gmail.com\"}','2026-06-18 10:14:49','2026-06-18 10:14:49'),
(28,88,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"roxanasignoltorres@gmail.com\"}','2026-06-18 10:38:13','2026-06-18 10:38:13'),
(29,89,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"ammyrequejoesteves102@gmail.com\"}','2026-06-18 10:41:08','2026-06-18 10:41:08'),
(30,90,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"danielathur.11@gmail.com\"}','2026-06-18 10:46:11','2026-06-18 10:46:11'),
(31,91,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"serranoflavia2020@gmail.com\"}','2026-06-18 11:14:19','2026-06-18 11:14:19'),
(32,92,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"lidiadelacruzprada2004@gmail.com\"}','2026-06-18 11:18:39','2026-06-18 11:18:39'),
(33,93,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tequenmaryory5@gmail.com\"}','2026-06-18 11:44:27','2026-06-18 11:44:27'),
(34,94,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"pierosilvasegura1@gmail.com\"}','2026-06-18 11:45:12','2026-06-18 11:45:12'),
(35,93,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tequenmaryory5@gmail.com\"}','2026-06-18 11:49:32','2026-06-18 11:49:32'),
(36,95,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"camposvalenciamaria01@gmail.com\"}','2026-06-18 11:50:37','2026-06-18 11:50:37'),
(37,93,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"pascualtequendelgado@gmail.com\"}','2026-06-18 11:51:36','2026-06-18 11:51:36'),
(38,96,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"a30marco30@gmail.com\"}','2026-06-18 11:54:30','2026-06-18 11:54:30'),
(39,97,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"luismiguelechiverresayago@gmail.com\"}','2026-06-18 11:56:39','2026-06-18 11:56:39'),
(40,98,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"toctorachoander@gmail.com\"}','2026-06-18 12:00:30','2026-06-18 12:00:30'),
(41,99,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"jairoincio145@gmail.com\"}','2026-06-18 12:04:00','2026-06-18 12:04:00'),
(42,100,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"mateorodas874@gmail.com\"}','2026-06-18 13:05:31','2026-06-18 13:05:31'),
(43,101,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"angelessrenato947@gmail.com\"}','2026-06-18 13:05:55','2026-06-18 13:05:55'),
(44,102,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"joserenzoniquenneciosup@gmail.com\"}','2026-06-18 13:12:29','2026-06-18 13:12:29'),
(45,103,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"kyara.gch@gmail.com\"}','2026-06-18 13:15:07','2026-06-18 13:15:07'),
(46,103,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"kyara.gch@gmail.com\"}','2026-06-18 13:15:11','2026-06-18 13:15:11'),
(47,104,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"tuestaadriana327@gmail.com\"}','2026-06-18 13:21:56','2026-06-18 13:21:56'),
(48,105,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"mafersampenbernaola@gmail.com\"}','2026-06-18 13:22:30','2026-06-18 13:22:30'),
(49,106,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"jimenasofia518@gmail.com\"}','2026-06-18 13:27:32','2026-06-18 13:27:32'),
(50,107,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"camgon080308@gmail.com\"}','2026-06-18 13:28:40','2026-06-18 13:28:40'),
(51,109,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"custodiochavestaaymar@gmail.com\"}','2026-06-18 13:34:58','2026-06-18 13:34:58'),
(52,108,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"sandojoaco2301@gmail.com\"}','2026-06-18 13:35:05','2026-06-18 13:35:05'),
(53,110,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"gorkilb18@gmail.com\"}','2026-06-18 13:41:24','2026-06-18 13:41:24'),
(54,46,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"gonzales30silvia@gmail.com\"}','2026-06-18 13:50:01','2026-06-18 13:50:01'),
(55,111,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"cesarabrahampalaciosruiz@gmail.com\"}','2026-06-18 13:52:25','2026-06-18 13:52:25'),
(56,112,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"luisfernandoflores2007@gmail.com\"}','2026-06-18 13:55:29','2026-06-18 13:55:29'),
(57,113,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"jenniferfloresrodri@gmail.com\"}','2026-06-18 13:59:28','2026-06-18 13:59:28'),
(58,114,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"salvadorfaciocarrasco@gmail.com\"}','2026-06-18 14:10:40','2026-06-18 14:10:40'),
(59,115,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"crly140876@gmail.com\"}','2026-06-18 14:16:21','2026-06-18 14:16:21'),
(60,116,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"claumarcelomch@gmail.com\"}','2026-06-18 14:22:13','2026-06-18 14:22:13'),
(61,117,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"sofia1alexha@gmail.com\"}','2026-06-18 14:23:30','2026-06-18 14:23:30'),
(62,118,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"pintadocordovajosemaria@gmail.com\"}','2026-06-18 14:27:44','2026-06-18 14:27:44'),
(63,119,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"anibalsegura124@gmail.com\"}','2026-06-18 14:30:52','2026-06-18 14:30:52'),
(64,120,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"franklyncalebsalazaroblitas@gmail.com\"}','2026-06-18 14:38:18','2026-06-18 14:38:18'),
(65,121,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"obed.rojas160725@gmail.com\"}','2026-06-19 07:55:18','2026-06-19 07:55:18'),
(66,122,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"jeremyferarr@gmail.com\"}','2026-06-19 09:37:01','2026-06-19 09:37:01'),
(67,123,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"eduardoygnacio28@gmail.com\"}','2026-06-19 09:44:53','2026-06-19 09:44:53'),
(68,123,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"eduardoygnacio28@gmail.com\"}','2026-06-19 09:45:04','2026-06-19 09:45:04'),
(69,124,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"akiara.dm@gmail.com\"}','2026-06-19 09:50:09','2026-06-19 09:50:09'),
(70,125,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"belenincio1901@gmail.com\"}','2026-06-19 10:19:31','2026-06-19 10:19:31'),
(71,127,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"rubyguerreropajarzzz@gmail.com\"}','2026-06-19 10:28:56','2026-06-19 10:28:56'),
(72,126,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"anagdavila229@gmail.com\"}','2026-06-19 10:29:14','2026-06-19 10:29:14'),
(73,126,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"anagdavila229@gmail.com\"}','2026-06-19 10:33:30','2026-06-19 10:33:30'),
(74,128,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"eduardoniquenperez@gmail.com\"}','2026-06-19 10:50:44','2026-06-19 10:50:44'),
(75,39,'registration_manual_resend','succeeded',NULL,1,'{\"recipient\":\"bernalespinozabenjamin@gmail.com\"}','2026-06-19 10:55:12','2026-06-19 10:55:12'),
(76,129,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"andres6ch@gmail.com\"}','2026-06-19 10:55:23','2026-06-19 10:55:23'),
(77,130,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"juniorjoelbancesbances@gmail.com\"}','2026-06-19 10:55:47','2026-06-19 10:55:47'),
(78,131,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"angelesmilagrospumericra@gmail.com\"}','2026-06-19 11:25:31','2026-06-19 11:25:31'),
(79,132,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"fiorellavelasques26@gmail.com\"}','2026-06-19 11:43:43','2026-06-19 11:43:43'),
(80,133,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"keilabarrientospuicon@gmail.com\"}','2026-06-19 11:59:32','2026-06-19 11:59:32'),
(81,134,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"josepantaleon389@gmail.com\"}','2026-06-19 12:10:39','2026-06-19 12:10:39'),
(82,135,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"becerragonzalesb@gmail.com\"}','2026-06-19 12:21:17','2026-06-19 12:21:17'),
(83,136,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"tipileonardo9@gmail.com\"}','2026-06-19 12:22:54','2026-06-19 12:22:54'),
(84,136,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"nahotipiani@gmail.com\"}','2026-06-19 12:25:37','2026-06-19 12:25:37'),
(85,137,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"paicodiazoscarthomas@gmail.com\"}','2026-06-19 12:32:44','2026-06-19 12:32:44'),
(86,138,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"valenciacortezaa@gmail.com\"}','2026-06-19 12:38:41','2026-06-19 12:38:41'),
(87,139,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"aymarzetacortez@gmail.com\"}','2026-06-19 12:44:59','2026-06-19 12:44:59'),
(88,140,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"jschimoy123@gmail.com\"}','2026-06-19 13:36:51','2026-06-19 13:36:51'),
(89,141,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"mayraquirozramirez@gmail.com\"}','2026-06-19 13:37:46','2026-06-19 13:37:46'),
(90,142,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"lucerogr2009@gmail.com\"}','2026-06-19 13:47:30','2026-06-19 13:47:30'),
(91,143,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"mh9061532@gmail.com\"}','2026-06-19 14:10:30','2026-06-19 14:10:30'),
(92,144,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"davillalobos11@gmail.com\"}','2026-06-19 14:17:29','2026-06-19 14:17:29'),
(93,145,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"ronaldmanuel228@gmail.com\"}','2026-06-19 14:18:28','2026-06-19 14:18:28'),
(94,146,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"carlosminguillo156@gmail.com\"}','2026-06-19 14:22:32','2026-06-19 14:22:32'),
(95,147,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"xibryalho@gmail.com\"}','2026-06-19 14:33:09','2026-06-19 14:33:09'),
(96,148,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"lioncamposbermeo@gmail.com\"}','2026-06-19 14:39:36','2026-06-19 14:39:36'),
(97,149,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"nunezfarromarie@gmail.com\"}','2026-06-19 14:53:19','2026-06-19 14:53:19'),
(98,150,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"pzberly@gmail.com\"}','2026-06-19 14:56:26','2026-06-19 14:56:26'),
(99,151,'registration_manual_resend','succeeded',NULL,4,'{\"recipient\":\"gabyzena333@gmail.com\"}','2026-06-19 14:58:25','2026-06-19 14:58:25'),
(100,152,'registration_manual_resend','succeeded',NULL,3,'{\"recipient\":\"brunuianubis@gmail.com\"}','2026-06-19 15:01:52','2026-06-19 15:01:52');
/*!40000 ALTER TABLE `student_mail_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `mother_last_name` varchar(255) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(16) NOT NULL,
  `phone` varchar(9) NOT NULL,
  `address` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `email_verification_sent_at` timestamp NULL DEFAULT NULL,
  `payment_voucher_number` varchar(40) DEFAULT NULL,
  `payment_agency_number` varchar(4) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `registration_date` date NOT NULL,
  `guardian_id` bigint(20) unsigned DEFAULT NULL,
  `school_id` bigint(20) unsigned NOT NULL,
  `career_id` bigint(20) unsigned NOT NULL,
  `academic_cycle_id` bigint(20) unsigned NOT NULL,
  `academic_cycle_shift_id` bigint(20) unsigned NOT NULL,
  `admission_process_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_dni_academic_cycle_unique` (`dni`,`academic_cycle_id`),
  UNIQUE KEY `students_payment_voucher_number_unique` (`payment_voucher_number`),
  KEY `students_school_id_foreign` (`school_id`),
  KEY `students_academic_cycle_shift_id_index` (`academic_cycle_shift_id`),
  KEY `students_academic_cycle_id_index` (`academic_cycle_id`),
  KEY `students_career_id_index` (`career_id`),
  KEY `students_dni_index` (`dni`),
  KEY `students_registration_date_index` (`registration_date`),
  KEY `students_admin_process_recent_index` (`admission_process_id`,`registration_date`,`id`),
  KEY `students_admin_cycle_recent_index` (`academic_cycle_id`,`registration_date`,`id`),
  KEY `students_guardian_id_foreign` (`guardian_id`),
  CONSTRAINT `students_academic_cycle_id_foreign` FOREIGN KEY (`academic_cycle_id`) REFERENCES `academic_cycles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `students_academic_cycle_shift_id_foreign` FOREIGN KEY (`academic_cycle_shift_id`) REFERENCES `academic_cycle_shifts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `students_admission_process_id_foreign` FOREIGN KEY (`admission_process_id`) REFERENCES `admission_processes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `students_career_id_foreign` FOREIGN KEY (`career_id`) REFERENCES `careers` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `students_guardian_id_foreign` FOREIGN KEY (`guardian_id`) REFERENCES `guardians` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES
(1,'THANI ARIADNE','GUERRERO','FLORES','61550672','2008-07-12','male','902777694','JIRON PIURA 773, MOYOBAMBA, MOYOBAMBA, SAN MARTÍN','guerrerofloresthani66@gmail.com',NULL,NULL,'2405503','0531','2026-06-16','2026-06-16',1,1,18,1,1,NULL,'active','2026-06-16 19:10:50','2026-06-18 07:15:43'),
(3,'YAIR VALENTIN','CAYAO','MONJA','60869136','2006-12-11','male','929842572','VENEZUELA 838, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','yaircayaomonja1@gmail.com',NULL,NULL,'2715481','0248','2026-06-16','2026-06-17',2,3,32,1,1,NULL,'active','2026-06-17 08:08:43','2026-06-17 08:08:43'),
(4,'CAMILA DEL ROCIO','VELIZ','RIMARACHIN','61539641','2009-02-10','female','983810491','AV. EDUARDO ORBEGOZO SANDOVAL 816 - LAS DUNAS, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','rv8614614@gmail.com',NULL,NULL,'2983706','0301','2026-06-16','2026-06-17',3,4,41,1,1,NULL,'active','2026-06-17 08:12:08','2026-06-17 08:14:40'),
(5,'KEYLA REBECA','SANCHEZ','VASQUEZ','73827138','2005-08-17','female','904541985','CALLE INCANATO 828, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','kerevasa.123@gmail.com',NULL,NULL,'3002830','0230','2026-06-16','2026-06-17',4,5,18,1,1,NULL,'active','2026-06-17 08:13:09','2026-06-17 08:13:09'),
(6,'JOSE ENRIQUE','TERRONES','CHAYAN','62902919','2007-04-15','male','979341459','ESMERALDAS 1599, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','josetchayan24@gmail.com',NULL,NULL,'2722580','0301','2026-06-16','2026-06-17',5,6,2,1,1,NULL,'active','2026-06-17 08:25:25','2026-06-17 08:26:04'),
(7,'YVET ADRIANA','CHAVESTA','SANCHEZ','73443663','2005-07-09','female','987123402','CPM LOS JARDINES PRADERA OESTE MZ F LT 2, CHICLAYO, CHICLAYO, LAMBAYEQUE','yvetchavezta@gmail.com',NULL,NULL,'1765536','0231','2026-06-17','2026-06-17',6,7,16,1,1,NULL,'active','2026-06-17 08:53:20','2026-06-17 08:55:28'),
(8,'ANGELA MASSIEL','POLO','FLORES','70965891','2007-11-14','female','950164629','CALLE MANUEL DUATO NOVEL 498, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','angelapolo2007@gmail.com',NULL,NULL,'1815322','0231','2026-06-17','2026-06-17',7,8,41,1,1,NULL,'active','2026-06-17 08:53:33','2026-06-17 08:53:33'),
(9,'ALISON ANALISSE','SANDOVAL','ENEQUE','75322451','2005-01-14','female','915217626','AAHH VIRGEN DE LAS MERCEDES MZ F LOTE 08, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','alissonsandoval451@gmail.com',NULL,NULL,'1758580','0231','2026-06-17','2026-06-17',NULL,9,4,1,1,NULL,'active','2026-06-17 09:01:42','2026-06-17 09:01:42'),
(10,'YAREM ALEJANDRO','TORRES','BANCES','71172080','2008-02-14','male','994740635','MZ. B LT. 13A PP.JJ. JORGE CHAVEZ, CHICLAYO, CHICLAYO, LAMBAYEQUE','yaremalejandrotorresbances@gmail.com',NULL,NULL,'1793624','0248','2026-06-17','2026-06-17',8,10,34,1,1,NULL,'active','2026-06-17 09:02:26','2026-06-17 09:02:26'),
(11,'FRANCISCO ARNALDO','NECIOSUP','CALDERON','72055779','2008-07-21','male','961708398','CALLE PEDRO RUIZ 434, ETEN, CHICLAYO, LAMBAYEQUE','franciswiligeta@gmail.com',NULL,NULL,'1776060','0231','2026-06-17','2026-06-17',9,11,41,1,1,NULL,'active','2026-06-17 09:07:54','2026-06-17 09:07:54'),
(12,'MARICIELO ANAIS','BRIONES','BARRIENTOS','71157361','2008-01-21','female','929405454','CALLE EGUZQUIZA 120 URB. FEDERICO VILLAREAL, CHICLAYO, CHICLAYO, LAMBAYEQUE','maricielobriones2101@gmail.com',NULL,NULL,'1792055','0231','2026-06-17','2026-06-17',10,12,41,1,1,NULL,'active','2026-06-17 09:08:39','2026-06-17 09:15:55'),
(13,'BRITHANY DAYANA','PISFIL','SOLANO','61157344','2007-12-20','female','939852173','CASERIO MONTEGRANDE, REQUE, CHICLAYO, LAMBAYEQUE','brithanypisfil7@gmail.com',NULL,NULL,'1712693','0250','2026-06-17','2026-06-17',11,13,42,1,1,NULL,'active','2026-06-17 09:14:09','2026-06-17 09:14:09'),
(14,'RODERICK HARIM','VILCHEZ','PERALTA','70961653','2007-11-22','male','944486917','URB. SOL DE LAMBAYEQUE MZ. A6 LT.20, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','roderickharimvilchezperalta@gmail.com',NULL,NULL,'3164214','0231','2026-06-16','2026-06-17',12,14,41,1,1,NULL,'active','2026-06-17 09:15:29','2026-06-17 09:15:29'),
(15,'RAQUEL','TAFUR','MUÑOZ','77429465','2001-01-25','female','962690463','JUAN ITURREGUI 155, CHICLAYO, CHICLAYO, LAMBAYEQUE','tafurraquel310@gmail.com',NULL,NULL,'1827959','0231','2026-06-17','2026-06-17',NULL,15,41,1,1,NULL,'active','2026-06-17 09:22:21','2026-06-17 09:23:50'),
(16,'IOANA LUCÍA','NAVARRETE','PAUCAR','70589962','2006-11-21','female','997730411','PSJ. MZ. 9 LOTE 250 URB. LAS GARZAS, PIMENTEL, CHICLAYO, LAMBAYEQUE','ioanalucia8@gmail.com',NULL,NULL,'1828812','0231','2026-06-17','2026-06-17',NULL,16,41,1,1,NULL,'active','2026-06-17 09:24:34','2026-06-17 09:25:22'),
(17,'ANYA KIREY','ESTEVES','MOZO','60934039','2006-11-23','female','995291588','MARISCAL NIETO 438, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','estevesanya@gmail.com',NULL,NULL,'1833127','0231','2026-06-17','2026-06-17',NULL,17,41,1,1,NULL,'active','2026-06-17 09:31:25','2026-06-17 09:31:25'),
(18,'SHEILA YUSEIDY','ALARCON','RAFAEL','62018219','2009-01-22','female','976406609','URB. LAS PALMAS MZ. R LT. 02, CHICLAYO, CHICLAYO, LAMBAYEQUE','alarconrafaelsheila@gmail.com',NULL,NULL,'1811100','0231','2026-06-17','2026-06-17',13,18,18,1,1,NULL,'active','2026-06-17 09:35:45','2026-06-17 09:38:47'),
(19,'MARCELLO JOAQUIN','RODAS','MORANTE','60414978','2006-06-30','male','920213088','JR LIMA 104, PIMENTEL, CHICLAYO, LAMBAYEQUE','marcello.rodas2018@gmail.com',NULL,NULL,'2007242','0248','2026-06-17','2026-06-17',14,19,41,1,1,NULL,'active','2026-06-17 09:36:54','2026-06-17 09:36:54'),
(20,'GIOVANNI FABRIZZIO','PISCOYA','REUPO','61348741','2008-05-16','male','979183132','AV. LUIS ABELARDO TAKAHASHI NUÑEZ  529, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','piscoyareupogiovannifabrizzio@gmail.com',NULL,NULL,'1805676','0231','2026-06-17','2026-06-17',15,20,41,1,1,NULL,'active','2026-06-17 09:41:06','2026-06-17 09:41:06'),
(21,'MARTHA HEIRY','CAPUÑAY','SILVA','72814563','2004-03-20','female','960221786','RESIDENCIAL EL CARMEN BLOCK D DPTO 202, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','marthaheirysilva.18@gmail.com',NULL,NULL,'1681723','0301','2026-06-17','2026-06-17',16,21,32,1,1,NULL,'active','2026-06-17 09:45:59','2026-06-17 10:17:11'),
(22,'JORGE LUIS','GUTIERREZ','GALVEZ','61117636','2007-10-25','male','995517684','SECTOR EL NARANJO MZ. H LT. 01, TUMAN, CHICLAYO, LAMBAYEQUE','jlguty2007@gmail.com',NULL,NULL,'1889415','0231','2026-06-17','2026-06-17',NULL,22,34,1,1,NULL,'active','2026-06-17 09:47:47','2026-06-17 09:47:47'),
(23,'JHONATAN ALEXANDER','VALVERDE','MACALOPU','61260737','2008-05-10','male','910776431','PROLONG. UNION 432, PUEBLO NUEVO, FERREÑAFE, LAMBAYEQUE','jvalverde100923@gmail.com',NULL,NULL,'3036107','0238','2026-06-16','2026-06-17',17,23,32,1,1,NULL,'active','2026-06-17 09:54:38','2026-06-17 09:54:38'),
(24,'CARLOS DANIEL','BENITES','CASTRO','72985723','2009-01-16','male','940339358','CALLE TERESA FANNING 548, CHICLAYO, CHICLAYO, LAMBAYEQUE','carlosdanielbenitescastro@gmail.com',NULL,NULL,'1906714','0231','2026-06-17','2026-06-17',18,24,34,1,1,NULL,'active','2026-06-17 09:56:19','2026-06-17 09:56:19'),
(25,'BRUNO ALDAIR','DIAZ','LLATAS','72132421','2003-06-22','male','923928633','COMUNID. CAMPESINA MOCHADIN, SOCOTA, CUTERVO, CAJAMARCA','brudialdilla.100@gmail.com',NULL,NULL,'1797901','0230','2026-06-17','2026-06-17',NULL,25,41,1,1,NULL,'active','2026-06-17 10:00:46','2026-06-17 10:00:46'),
(26,'ADRIANA ELIZABETH','MORALES','CUBAS','72824555','2008-12-01','female','956426178','AV LAS DUNAS MZ D5 LT 18, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','adrianamoralescubas001@gmail.com',NULL,NULL,'1720968','0301','2026-06-17','2026-06-17',19,26,43,1,1,NULL,'active','2026-06-17 10:01:28','2026-06-17 10:01:28'),
(27,'MIZUKI CAMILA','MEJIA','SILVA','72829268','2008-12-16','female','924266391','AV. NACIONALISMO 693 URB. LAS BRISAS, CHICLAYO, CHICLAYO, LAMBAYEQUE','arq.keikoyabe@gmail.com',NULL,NULL,'1944563','0248','2026-06-17','2026-06-17',20,27,34,1,1,NULL,'active','2026-06-17 10:17:18','2026-06-17 10:17:18'),
(28,'LINDA JASUE','AREVALO','ALVARADO','61444200','2008-07-06','female','993764046','PASAJE OLIVOS 175, CHICLAYO, CHICLAYO, LAMBAYEQUE','lindaajasue@gmail.com',NULL,NULL,'1983092','0248','2026-06-17','2026-06-17',21,28,41,1,1,NULL,'active','2026-06-17 10:26:39','2026-06-17 10:27:53'),
(29,'JUAN JOSE','TAPIA','SAAVEDRA','70728210','2007-08-10','male','907753780','CALLE 24 DE JULIO 280, CHICLAYO, CHICLAYO, LAMBAYEQUE','juantapiasaavedra10@gmail.com',NULL,NULL,'2132381','0231','2026-06-17','2026-06-17',NULL,29,23,1,1,NULL,'active','2026-06-17 10:27:53','2026-06-17 10:27:53'),
(30,'ROSITA GUADALUPE','SANTOS','REQUENA','61485257','2008-12-26','female','936160464','CALLE REAL 25, TUMAN, CHICLAYO, LAMBAYEQUE','mayliix.6@gmail.com',NULL,NULL,'2177937','0231','2026-06-17','2026-06-17',22,30,7,1,1,NULL,'active','2026-06-17 10:34:05','2026-06-17 10:35:28'),
(31,'JENNIFER KATHERINE','ANCAJIMA','TORO','73163216','2009-03-25','female','967017679','HAB. URB. ALAMEDA I DE LA VICTORIA MZ. N LT. 23, LA VICTORIA, CHICLAYO, LAMBAYEQUE','jenn885491@gmail.com',NULL,NULL,'1963056','0231','2026-06-17','2026-06-17',23,31,28,1,1,NULL,'active','2026-06-17 10:37:30','2026-06-17 10:38:36'),
(32,'CIELO NARELLA','ALACHE','GASTULO','61074219','2007-06-22','female','921489748','SECTOR EX COOP JOSE CARLOS MARIATEGUI, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','luchobeto3@gmail.com',NULL,NULL,'2230153','0231','2026-06-17','2026-06-17',24,32,18,1,1,NULL,'active','2026-06-17 10:40:12','2026-06-17 10:40:12'),
(33,'CESAR DEMETRIO','VIDAURRE','SALAZAR','60816712','2006-08-24','male','935350821','CASERIO LAGUNAS, MORROPE, LAMBAYEQUE, LAMBAYEQUE','cesardemetrio24@gmail.com',NULL,NULL,'1821948','0301','2026-06-17','2026-06-17',NULL,33,41,1,1,NULL,'active','2026-06-17 10:43:06','2026-06-17 10:43:06'),
(34,'DANIELA VICTORIA','TALLEDO','CHAMBERGO','74299289','2005-09-25','female','974907424','CALLE LA UNION 180, CHICLAYO, CHICLAYO, LAMBAYEQUE','dvtch234@gmail.com',NULL,NULL,'2452591','0231','2026-06-17','2026-06-17',25,34,23,1,1,NULL,'active','2026-06-17 10:46:20','2026-06-17 10:48:40'),
(35,'MILAGROS ELIANA','SANCHEZ','TARRILLO','72591268','2008-10-12','female','978880574','CALLE ESPAÑA 961 C.P. MENOR URRUNAGA, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','milagroseliana2020@gmail.com',NULL,NULL,'2436154','0231','2026-06-17','2026-06-17',26,35,41,1,1,NULL,'active','2026-06-17 10:49:40','2026-06-17 10:49:40'),
(36,'FRANK MAURICIO','ENEQUE','CHANCAFE','72061084','2008-08-08','male','969420533','QUINTA SAN ISIDRO KM1, MONSEFU, CHICLAYO, LAMBAYEQUE','cesareneque68@gmail.com',NULL,NULL,'2528771','0231','2026-06-17','2026-06-17',27,36,32,1,1,NULL,'active','2026-06-17 10:55:13','2026-06-17 10:55:13'),
(37,'SANTIAGO RAUL','ZUÑIGA','ANDRADE','61547381','2008-11-13','male','936167922','AV. VENEZUELA 3318 CPM NUEVO SAN LORENZO II ETAPA, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','leandromarce876@gmail.com',NULL,NULL,'2451176','0231','2026-06-17','2026-06-17',28,37,41,1,1,NULL,'active','2026-06-17 10:55:28','2026-06-17 10:55:28'),
(38,'HADEMIR JOSEPT','TAPIA','CORONEL','61197224','2007-08-31','male','916398026','LOS GLADIOLOS, CHICLAYO, CHICLAYO, LAMBAYEQUE','hademir10josept@gmail.com',NULL,NULL,'2575940','0231','2026-06-17','2026-06-17',NULL,38,41,1,1,NULL,'active','2026-06-17 11:00:40','2026-06-17 11:01:25'),
(39,'SAMUEL BENJAMIN','BERNAL','ESPINOZA','76464246','2008-03-26','male','922819533','CALLE JOSE DE LA RIVA AGUERO 244 CPME - LAS LOMAS, SANTA ROSA, CHICLAYO, LAMBAYEQUE','bernalespinozabenjamin@gmail.com','2026-06-19 10:55:12',NULL,'2568179','0231','2026-06-17','2026-06-17',29,39,38,1,1,NULL,'active','2026-06-17 11:01:16','2026-06-19 10:55:12'),
(40,'ANDERSON PAUL','BENAVIDES','SIGUEÑAS','72987000','2009-01-29','male','959765621','MZ 2 LT 03 PPJJ APLIACION FANNY ABANTO, CHICLAYO, CHICLAYO, LAMBAYEQUE','andersonpaulbs@gmail.com',NULL,NULL,'2447500','0248','2026-06-17','2026-06-17',30,40,32,1,1,NULL,'active','2026-06-17 11:08:25','2026-06-17 11:08:25'),
(41,'NATSUSHI','MILIAN','RODRIGUEZ','72828686','2008-12-29','female','906363948','CALLE CAMPO DE LOS SANTOS MZ. B LT. 8, LA VICTORIA, CHICLAYO, LAMBAYEQUE','natsushimilian008@gmail.com',NULL,NULL,'2222978','0250','2026-06-17','2026-06-17',31,41,41,1,1,NULL,'active','2026-06-17 11:14:42','2026-06-17 11:14:42'),
(42,'ANA VALENTINA','APOLO','GONZALES','60774457','2006-05-26','female','971303486','CALLE MOCHUMI 125, CHICLAYO, CHICLAYO, LAMBAYEQUE','valeapolo2605@gmail.com',NULL,NULL,'2753386','0248','2026-06-17','2026-06-17',32,42,41,1,1,NULL,'active','2026-06-17 11:16:23','2026-06-17 11:16:23'),
(43,'MARIA JULIA','GONZALES','REQUEJO','72825309','2008-12-22','female','965282358','CALLE JUAN RIVERA PIEDRA 101 URB. ARTURO CABREJOS FALLA, CHICLAYO, CHICLAYO, LAMBAYEQUE','majugonzalesrequejo@gmail.com',NULL,NULL,'2747022','0231','2026-06-17','2026-06-17',33,43,41,1,1,NULL,'active','2026-06-17 11:19:27','2026-06-17 11:19:27'),
(44,'JANY LUANY','SALDAÑA','LEYVA','72987994','2009-01-22','female','982085829','AV LOS INCAS, LA VICTORIA, CHICLAYO, LAMBAYEQUE','janyluanyl@gmail.com',NULL,NULL,'2683461','0248','2026-06-17','2026-06-17',34,44,4,1,1,NULL,'active','2026-06-17 11:21:41','2026-06-17 11:25:16'),
(45,'DANAE TAMARA','PAISIC','DE LOS SANTOS','61524034','2008-12-05','female','941910674','CALLE LOS CLAVELES 143 URB. SANTA VICTORIA, CHICLAYO, CHICLAYO, LAMBAYEQUE','danaepaisic@gmail.com',NULL,NULL,'2598137','0231','2026-06-17','2026-06-17',35,45,41,1,1,NULL,'active','2026-06-17 11:28:11','2026-06-17 11:28:11'),
(46,'SILVIA MARICRISTI','GONZALES','GONZALES','74141383','2005-10-30','female','931606481','MIGUEL GRAU 564, SAN JOSÉ, LAMBAYEQUE, LAMBAYEQUE','gonzales30silvia@gmail.com','2026-06-18 13:50:01',NULL,'3165114','0231','2026-06-17','2026-06-17',36,46,17,1,1,NULL,'active','2026-06-17 11:32:25','2026-06-18 13:50:01'),
(47,'ANAMILET LUCIA','MACO','CESPEDES','61429441','2008-08-11','female','947381921','CALLE SAN MARTIN MZ. A LT. 1 P. JOVEN LAS MERCEDES, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','faraonloveshadyproo@gmail.com',NULL,NULL,'2930263','0231','2026-06-17','2026-06-17',37,47,11,1,1,NULL,'active','2026-06-17 11:33:46','2026-06-17 11:33:46'),
(48,'DARIKSON STEVE','LOZADA','SOPLAPUCO','73170218','2009-03-22','male','941443256','CALLE PROGRESO 297, CHICLAYO, CHICLAYO, LAMBAYEQUE','dariksonsoplapuco@gmail.com',NULL,NULL,'2899392','0231','2026-06-17','2026-06-17',38,48,11,1,1,NULL,'active','2026-06-17 11:40:05','2026-06-17 11:40:05'),
(49,'EDINSON ALDAIR','CARRASCO','MORE','72431505','2003-09-09','male','988318200','PJ. LOS CLAVELES MZ. C LT. 22, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','edingamerpro2@gmail.com',NULL,NULL,'3067684','0231','2026-06-17','2026-06-17',NULL,49,41,1,1,NULL,'active','2026-06-17 11:40:40','2026-06-17 11:40:40'),
(50,'CATHERINE ROUSSE','PERLECHE','VEGA','72981676','2008-12-28','female','920009801','PJ PASTOR BOGGIANO MZ A LT 01, CHICLAYO, CHICLAYO, LAMBAYEQUE','ecatherinep2019@gmail.com',NULL,NULL,'3079318','0231','2026-06-17','2026-06-17',39,50,18,1,1,NULL,'active','2026-06-17 11:46:24','2026-06-17 11:47:24'),
(51,'PIERO GERMAN','MANAY','CAMPOS','73153450','2009-02-13','male','986246648','CALLE LAS ARTES 161B CPME RICARDO PALMA, CHICLAYO, CHICLAYO, LAMBAYEQUE','pieromanay3@gmail.com',NULL,NULL,'3085220','0231','2026-06-17','2026-06-17',40,51,41,1,1,NULL,'active','2026-06-17 11:47:06','2026-06-17 11:47:06'),
(52,'RIHANNA FABIANA','GUERRERO','SILVA','72344010','2008-10-04','female','936019703','CALLE CACTUS 156, CHICLAYO, CHICLAYO, LAMBAYEQUE','fabianaguerrero042008@gmail.com',NULL,NULL,'3307813','0231','2026-06-17','2026-06-17',41,52,28,1,1,NULL,'active','2026-06-17 11:52:32','2026-06-17 11:53:38'),
(53,'GLORIA SARAHI','YAMUNAQUE','INOÑAN','60696775','2008-12-08','female','902072904','PRL. MIGUE GRAU, JAYANCA, LAMBAYEQUE, LAMBAYEQUE','glorisyamunaque@gmail.com',NULL,NULL,'2081278','0302','2026-06-17','2026-06-17',42,53,32,1,1,NULL,'active','2026-06-17 11:53:22','2026-06-17 11:53:22'),
(54,'ISAEL','YAJAHUANCA','CONTRERAS','48822479','1994-12-27','male','953587148','C. POBLADO VILLA HERMOSA MZ. A3 LT. 26, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','c12852156@gmail.com',NULL,NULL,'3294535','0231','2026-06-17','2026-06-17',NULL,54,34,1,1,NULL,'active','2026-06-17 12:00:27','2026-06-17 12:00:27'),
(55,'DAIANA NAYELI','ITURRIA','SHOWING','60446101','2006-10-26','female','939443224','MIGUEL GRAU 180, REQUE, CHICLAYO, LAMBAYEQUE','nayeliiturriashowing@gmail.com',NULL,NULL,'3329191','0231','2026-06-17','2026-06-17',43,55,42,1,1,NULL,'active','2026-06-17 12:01:12','2026-06-17 12:01:12'),
(56,'JESUS FERNANDO','MONTENEGRO','MALCA','73545499','2004-05-07','male','975470770','URB ALAMEDA REAL ETAPA III MZ N LT 6, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','jefer2m754@gmail.com',NULL,NULL,'3385245','0231','2026-06-17','2026-06-17',NULL,56,41,1,1,NULL,'active','2026-06-17 12:08:59','2026-06-17 12:09:40'),
(57,'DIEGO ENRIQUE','LOPEZ','ROSALES','71170564','2008-02-06','male','969983219','CALLE MINAVIR 180 URB. SAN ISIDRO, CHICLAYO, CHICLAYO, LAMBAYEQUE','diegoenriquelopezrosales@gmail.com',NULL,NULL,'3362837','0231','2026-06-17','2026-06-17',44,57,41,1,1,NULL,'active','2026-06-17 12:11:11','2026-06-17 12:11:11'),
(58,'JOSE LUIS','RODRIGUEZ','YOVERA','61140115','2007-07-30','male','923346673','AV. TACNA MZ. G LT. 44 P. JOVEN HECTOR AURICH SOTO, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','rocel22jose@gmail.com',NULL,NULL,'1854268','0234','2026-06-17','2026-06-17',45,58,41,1,1,NULL,'active','2026-06-17 12:34:48','2026-06-17 12:34:48'),
(59,'MIA MELISA','OTAZU','PEZO','72586722','2008-10-11','female','915369428','AV PIURA 729, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','mia.melisa2008@gmail.com',NULL,NULL,'2937538','0301','2026-06-17','2026-06-17',46,59,24,1,1,NULL,'active','2026-06-17 12:40:04','2026-06-17 12:40:04'),
(60,'JHENIFFER SELENNE','KISIMOTO','RISCO','72996077','2009-02-02','female','965926638','CALLE NACIONALISMO 2518 P. JOVEN 9 DE OCTUBRE, CHICLAYO, CHICLAYO, LAMBAYEQUE','jheniffer20090202@gmail.com',NULL,NULL,'2065903','0231','2026-06-17','2026-06-17',47,60,24,1,1,NULL,'active','2026-06-17 13:39:59','2026-06-17 13:39:59'),
(61,'DOMENIKA ANAIS','OROZCO','MACO','72061694','2008-08-11','female','978832660','CALLE SAN MARTIN 691 . URB EL PORVENIR, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','domk110408@gmail.com',NULL,NULL,'1819096','0231','2026-06-17','2026-06-17',48,61,41,1,1,NULL,'active','2026-06-17 13:45:01','2026-06-17 13:45:01'),
(62,'LUIS ALFREDO','LLONTOP','JIBAJA','60775664','2006-07-06','male','972908408','CALLE LOS GERANIOS 270 URB. MIRAFLORES, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','luis.llontopj@gmail.com',NULL,NULL,'3507713','0301','2026-06-17','2026-06-17',NULL,62,41,1,1,NULL,'active','2026-06-17 13:46:33','2026-06-17 13:46:33'),
(63,'MICHELL XIN LING','FERNANDEZ','TAY','71355464','2008-04-03','female','961647717','LOS CACTUS 215 URB. FEDERICO VILLAREAL, CHICLAYO, CHICLAYO, LAMBAYEQUE','xin.fernandez08@gmail.com',NULL,NULL,'3465744','0248','2026-06-17','2026-06-17',49,63,23,1,1,NULL,'active','2026-06-17 14:20:53','2026-06-17 14:20:53'),
(64,'DAMARIS XIMENA','LLOCYA','PAISIG','61611112','2009-02-04','female','923106138','AV LORA Y LORA CDRA 3, CHICLAYO, CHICLAYO, LAMBAYEQUE','ximenallocya@gmail.com',NULL,NULL,'3550852','0231','2026-06-17','2026-06-17',50,64,19,1,1,NULL,'active','2026-06-17 14:23:20','2026-06-17 14:23:20'),
(65,'YURIANA ABIGAIL','PLASENCIO','LOPEZ','61485209','2008-11-04','female','922237463','SECTOR CASUARINAS II MZ. 130 LT. 05, TUMAN, CHICLAYO, LAMBAYEQUE','yurilopezchavez1@gmail.com',NULL,NULL,'4413199','0231','2026-06-17','2026-06-17',51,65,41,1,1,NULL,'active','2026-06-17 14:30:30','2026-06-17 14:32:52'),
(66,'ERIKA JASMIN','COTRINA','PEREZ','72991534','2009-01-15','female','933457947','CPM. ANTONIO RAYMONDI MZ. M LT. 4, LA VICTORIA, CHICLAYO, LAMBAYEQUE','erikajasmincotrinaperez@gmail.com',NULL,NULL,'3683515','0250','2026-06-17','2026-06-17',52,66,33,1,1,NULL,'active','2026-06-17 14:53:37','2026-06-17 14:53:37'),
(67,'MELANIA SAYURI','RENTERIA','VIDAL','72336923','2008-08-30','female','961940092','HORTENCIA PARDO MZ G LT 23, LA VICTORIA, CHICLAYO, LAMBAYEQUE','melaniasayurirv@gmail.com',NULL,NULL,'4530269','0231','2026-06-17','2026-06-17',53,67,28,1,1,NULL,'active','2026-06-17 14:55:20','2026-06-17 14:55:20'),
(68,'NATALIA ELIZABETH','CAMPOVERDE','PARIATON','75808207','2003-05-12','female','913249301','CASERIO MINA DE JAMBUR, PAIMAS, AYABACA, PIURA','campoverdepariaton@gmail.com',NULL,NULL,'3037659','0248','2026-06-16','2026-06-17',54,68,1,1,1,NULL,'active','2026-06-17 15:00:51','2026-06-17 15:00:51'),
(69,'FABIANA ALEXANDRA','JULCA','ROMERO','71680444','2008-06-04','female','900454383','VISTA HERMOSA MZ. E LT. 01, CHICLAYO, CHICLAYO, LAMBAYEQUE','fabianajulcaromero@gmail.com','2026-06-18 08:20:00',NULL,'5301914','0231','2026-06-17','2026-06-18',NULL,69,13,1,1,NULL,'active','2026-06-18 08:11:14','2026-06-18 08:20:00'),
(70,'RODRIGO ALBERTO','RAMOS','SANDOVAL','61261863','2008-03-20','male','901124462','CALLE CONVENTO 560, TUCUME, LAMBAYEQUE, LAMBAYEQUE','rodrigoramos9171@gmail.com','2026-06-18 08:15:52',NULL,'2768440','0309','2026-06-17','2026-06-18',NULL,70,32,1,1,NULL,'active','2026-06-18 08:13:16','2026-06-18 08:15:52'),
(71,'EMANUEL JESUS','OBLITAS','RODRIGUEZ','62252369','2010-12-01','male','982911011','CALLE LOS LAURELES 290 URB. CAJA DE DEPOSITOS, CHICLAYO, CHICLAYO, LAMBAYEQUE','emanuel@gmail.com','2026-06-18 08:20:31',NULL,'2742284','0231','2026-06-17','2026-06-18',55,71,34,1,1,NULL,'active','2026-06-18 08:19:45','2026-06-18 08:20:31'),
(72,'ANTONIO FRANZ','TINEO','DIAZ','71688277','2008-06-08','male','982194781','LOS COMBATIENTES 893, CHICLAYO, CHICLAYO, LAMBAYEQUE','franzantoniotineodiaz@gmail.com','2026-06-18 08:22:42',NULL,'5150957','0231','2026-06-17','2026-06-18',56,72,41,1,1,NULL,'active','2026-06-18 08:21:53','2026-06-18 08:22:42'),
(73,'SNAIDER DE JESUS','NUÑEZ','HORNA','78713322','2007-08-06','male','934851369','CALLE JHONSON 459 CPM URRUNAGA, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','nkarlos320@gmail.com','2026-06-18 08:27:21',NULL,'3517859','0250','2026-06-17','2026-06-18',NULL,73,18,1,1,NULL,'active','2026-06-18 08:27:10','2026-06-18 08:27:21'),
(74,'MARCO SEBASTIAN','SANTIN','ROJAS','60955533','2006-12-13','male','946815380','ATAHUALPA 843, REQUE, CHICLAYO, LAMBAYEQUE','bastianrojas424@gmail.com','2026-06-18 08:28:13',NULL,'5359714','0231','2026-06-17','2026-06-18',NULL,74,13,1,1,NULL,'active','2026-06-18 08:27:19','2026-06-18 08:28:13'),
(75,'GRACIELA','SANTAMARIA','ALAMO','61036642','2007-04-16','female','946888058','CL SOLA 520 CENTRO MORROPE, MORROPE, LAMBAYEQUE, LAMBAYEQUE','gsantamaria089@gmail.com','2026-06-18 08:34:30',NULL,'2215163','0301','2026-06-17','2026-06-18',57,75,17,1,1,NULL,'active','2026-06-18 08:34:19','2026-06-18 08:34:30'),
(76,'JENY JARITZA','ZEÑA','PANTALEON','60858734','2006-09-26','female','901702063','JOSE OLAYA 175, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','zenapantaleonjenyjaritza@gmail.com','2026-06-18 08:40:06',NULL,'5509652','0231','2026-06-17','2026-06-18',NULL,76,28,1,1,NULL,'active','2026-06-18 08:39:03','2026-06-18 08:40:06'),
(77,'CRISTIAN KELVIN','BECERRA','HERRERA','62127780','2008-08-16','male','931230488','CASERIO MIGUEL GRAU, PARDO MIGUEL, RIOJA, SAN MARTÍN','kelvinbecerraherrera@gmail.com','2026-06-18 08:45:40',NULL,'1730995','0231','2026-06-18','2026-06-18',58,77,22,1,1,NULL,'active','2026-06-18 08:45:30','2026-06-18 08:45:40'),
(78,'CESAR RICARDO','GONZALES','VENEGAS','75313830','2006-03-11','male','977428481','GRAN CHIMU 1216, LA VICTORIA, CHICLAYO, LAMBAYEQUE','cr362334@gmail.com','2026-06-18 08:46:52',NULL,'1746456','0231','2026-06-18','2026-06-18',NULL,78,17,1,1,NULL,'active','2026-06-18 08:46:12','2026-06-18 08:46:52'),
(79,'BIANKA ELIZABETH','PERALTA','SUCLUPE','71370146','2008-05-25','female','967487751','CALLE VICTOR FONSECA RIOS  144 URB. LA PRIMAVERA II ETAPA, CHICLAYO, CHICLAYO, LAMBAYEQUE','qwqbianka@gmail.com','2026-06-18 08:52:43',NULL,'1971678','0543','2026-06-17','2026-06-18',59,79,41,1,1,NULL,'active','2026-06-18 08:52:29','2026-06-18 08:52:43'),
(80,'LUCIANA NICOLLE','CELIS','FERNANDEZ','72825777','2008-12-15','female','924677520','LA ESPERANZA 194, CHICLAYO, CHICLAYO, LAMBAYEQUE','cixwilmer@gmail.com','2026-06-18 08:56:28',NULL,'1681168','0231','2026-06-18','2026-06-18',60,80,41,1,1,NULL,'active','2026-06-18 08:55:28','2026-06-18 08:56:28'),
(81,'MARYCIELO','CACHAY','DELGADO','72988036','2009-01-15','female','985746238','AV. LUIZ GONZALES 1342, CHICLAYO, CHICLAYO, LAMBAYEQUE','cachaydelgadom@gmail.com','2026-06-18 09:08:14',NULL,'5495499','0301','2026-06-17','2026-06-18',61,81,41,1,1,NULL,'active','2026-06-18 09:08:00','2026-06-18 09:08:14'),
(82,'KIARA BRIGGITT','BERMEO','MILIAN','72339109','2008-09-16','female','914412885','CALLE JUAN DIAZ ORREGO, OYOTUN, CHICLAYO, LAMBAYEQUE','kiarabermeomilian@gmail.com','2026-06-18 09:38:07',NULL,'5634697','0250','2026-06-17','2026-06-18',62,82,41,1,1,NULL,'active','2026-06-18 09:36:58','2026-06-18 09:38:07'),
(83,'NICOLL','SILVA','RUBIO','72594711','2008-11-13','female','921973965','JR. CAYETANO HEREDIA 1, POMALCA, CHICLAYO, LAMBAYEQUE','nicollsilvarubio2021@gmail.com','2026-06-18 09:38:00',NULL,'2145256','0231','2026-06-18','2026-06-18',63,83,41,1,1,NULL,'active','2026-06-18 09:37:44','2026-06-18 09:38:00'),
(84,'JUAN RICARDO','ESTELA','COBEÑAS','61476022','2008-09-22','male','937305440','VICTOR RAUL HAYA DE LA TORRE 480, CHICLAYO, CHICLAYO, LAMBAYEQUE','restelacobenas@gmail.com','2026-06-18 09:43:47',NULL,'2109248','0231','2026-06-18','2026-06-18',64,84,41,1,1,NULL,'active','2026-06-18 09:42:37','2026-06-18 09:43:47'),
(85,'LIZBETH CAROLINA','GARCIA','LINARES','61516426','2008-10-28','female','963665835','URB. LAS CASUARINAS MZ. G LT. 11, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','lizbeth28garcialinares@gmail.com','2026-06-18 09:46:14',NULL,'5113191','0231','2026-06-17','2026-06-18',65,85,41,1,1,NULL,'active','2026-06-18 09:46:02','2026-06-18 09:46:14'),
(86,'PAULO JAVIER','RAMIREZ','CASTAÑEDA','76104332','2008-09-12','male','965620475','URB. VILLA DE LA ENSENADA ETAPA I MZ. A LT. 33, PIMENTEL, CHICLAYO, LAMBAYEQUE','paulojavierramirez12@gmail.com','2026-06-18 10:03:39',NULL,'1888115','0238','2026-06-18','2026-06-18',66,86,41,1,1,NULL,'active','2026-06-18 10:03:17','2026-06-18 10:03:39'),
(87,'KEYKO JASMIN','TAPIA','FLORES','70742539','2007-10-08','female','963017576','CALLE HUSARES DE JUNIN 1401 CPM URRUNAGA, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','florenciafloresordonez@gmail.com','2026-06-18 10:14:49',NULL,'4919611','0248','2026-06-17','2026-06-18',67,87,24,1,1,NULL,'active','2026-06-18 10:11:51','2026-06-18 10:14:49'),
(88,'MARIA ELIZABETH','FLORES','SIGNOL','61157223','2007-10-30','female','925292743','CAMPIÑA CHACUPE, MONSEFU, CHICLAYO, LAMBAYEQUE','roxanasignoltorres@gmail.com','2026-06-18 10:38:13',NULL,'5521165','0236','2026-06-17','2026-06-18',68,88,17,1,1,NULL,'active','2026-06-18 10:37:51','2026-06-18 10:38:13'),
(89,'AMMY GISEL','REQUEJO','ESTEVES','61542676','2008-12-15','female','994972251','CALLE TRES MARIAS 516, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','ammyrequejoesteves102@gmail.com','2026-06-18 10:41:08',NULL,'2694765','0231','2026-06-18','2026-06-18',69,89,28,1,1,NULL,'active','2026-06-18 10:39:42','2026-06-18 10:41:08'),
(90,'DANIELA ABIGAIL','JIMENEZ','THURKOWLSKY','61849008','2009-08-29','female','943026238','CALLE CARLOS MONJOY 848, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','danielathur.11@gmail.com','2026-06-18 10:46:11',NULL,'2875340','0231','2026-06-17','2026-06-18',70,90,41,1,1,NULL,'active','2026-06-18 10:45:58','2026-06-18 10:46:11'),
(91,'FLAVIA JAHAIRA','SERRANO','QUEVEDO','73410840','2008-01-04','female','970168426','CALLE MINAVIR 242 URB. SAN ISIDRO, CHICLAYO, CHICLAYO, LAMBAYEQUE','serranoflavia2020@gmail.com','2026-06-18 11:14:19',NULL,'2610753','0231','2026-06-18','2026-06-18',NULL,91,41,1,1,NULL,'active','2026-06-18 11:13:53','2026-06-18 11:14:19'),
(92,'LIDIA DEL CARMEN','DE LA CRUZ','PRADA','75230333','2004-02-12','female','912384087','SAN ANTONIO 282, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','lidiadelacruzprada2004@gmail.com','2026-06-18 11:18:39',NULL,'1716414','0301','2026-06-18','2026-06-18',NULL,92,10,1,1,NULL,'active','2026-06-18 11:17:47','2026-06-18 11:18:39'),
(93,'MARYORY DAYANA','TEQUEN','PUESCAS','60708873','2009-01-08','female','938688628','CALLE LOS PINOS ALTO PERU MZ. P LT. 35, PIMENTEL, CHICLAYO, LAMBAYEQUE','pascualtequendelgado@gmail.com','2026-06-18 11:51:36',NULL,'3218746','0273','2026-06-18','2026-06-18',71,93,27,1,1,NULL,'active','2026-06-18 11:44:17','2026-06-18 11:51:36'),
(94,'PIERO','SILVA','SEGURA','60541042','2007-11-23','male','971380387','SANTA ANA 113, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','pierosilvasegura1@gmail.com','2026-06-18 11:45:12',NULL,'4815338','0234','2026-06-17','2026-06-18',NULL,94,41,1,1,NULL,'active','2026-06-18 11:44:35','2026-06-18 11:45:12'),
(95,'MARIA DE LOURDES','CAMPOS','VALENCIA','76083931','2006-05-01','female','966824319','SANTA ROSA 1070, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','camposvalenciamaria01@gmail.com','2026-06-18 11:50:37',NULL,'2940970','0234','2026-06-18','2026-06-18',NULL,95,41,1,1,NULL,'active','2026-06-18 11:48:50','2026-06-18 11:50:37'),
(96,'MARCO ANTONIO','MARTINEZ','MACALOPU','60972929','2006-12-30','male','934327196','TRES MARIAS 361, FERREÑAFE, FERREÑAFE, LAMBAYEQUE','a30marco30@gmail.com','2026-06-18 11:54:30',NULL,'3301354','0231','2026-06-18','2026-06-18',NULL,96,41,1,1,NULL,'active','2026-06-18 11:53:57','2026-06-18 11:54:30'),
(97,'LUIS MIGUEL','ECHIVERRE','SAYAGO','60421685','2006-05-14','male','913787278','CALLE DEMETRIO ACOSTA 453 PUEBLO JOVEN SAN MARTIN, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','luismiguelechiverresayago@gmail.com','2026-06-18 11:56:39',NULL,'3088719','0301','2026-06-18','2026-06-18',NULL,97,41,1,1,NULL,'active','2026-06-18 11:56:30','2026-06-18 11:56:39'),
(98,'ANDER YERMI','TOCTO','RACHO','60689727','2008-05-23','male','991376054','EL ARCO, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','toctorachoander@gmail.com','2026-06-18 12:00:30',NULL,'2630852','0301','2026-06-18','2026-06-18',NULL,98,2,1,1,NULL,'active','2026-06-18 11:59:49','2026-06-18 12:00:30'),
(99,'JAIRO YAMIL','INCIO','CARRASCO','60602877','2008-04-28','male','992384775','CALLE INDOAMERICA 107, REQUE, CHICLAYO, LAMBAYEQUE','jairoincio145@gmail.com','2026-06-18 12:04:00',NULL,'3332732','0231','2026-06-18','2026-06-18',72,99,41,1,1,NULL,'active','2026-06-18 12:03:50','2026-06-18 12:04:00'),
(100,'MATEO SEBASTIAN','RODAS','ALCANTARA','73402665','2009-03-19','male','912255395','URB PUERTAS DEL SOL II ETAPA MZ O LT 24, LA VICTORIA, CHICLAYO, LAMBAYEQUE','mateorodas874@gmail.com','2026-06-18 13:05:31',NULL,'3372879','0231','2026-06-18','2026-06-18',73,100,41,1,1,NULL,'active','2026-06-18 13:04:55','2026-06-18 13:05:31'),
(101,'CARLOS RENATO','ARRIAGA','ANGELES','72591797','2008-11-06','male','933446261','CALLE JORGE CHAVEZ 182 UPIS SANTO DOMINGO, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','angelessrenato947@gmail.com','2026-06-18 13:05:55',NULL,'2919222','0301','2026-06-18','2026-06-18',74,101,41,1,1,NULL,'active','2026-06-18 13:05:45','2026-06-18 13:05:55'),
(102,'JOSE RENZO','ÑIQUEN','NECIOSUP','61942692','2009-03-22','male','950612754','CALLE CHICLAYO 202, ETEN, CHICLAYO, LAMBAYEQUE','joserenzoniquenneciosup@gmail.com','2026-06-18 13:12:29',NULL,'3392126','0231','2026-06-18','2026-06-18',75,102,32,1,1,NULL,'active','2026-06-18 13:10:15','2026-06-18 13:12:29'),
(103,'KYARA YAMILET','GIRON','CHAVEZ','72825886','2008-12-08','female','985662417','CALLE SERPIENTE DE ORO 236 P. JOVEN CIRO ALEGRIA, CHICLAYO, CHICLAYO, LAMBAYEQUE','kyara.gch@gmail.com','2026-06-18 13:15:11',NULL,'3183580','0987','2026-06-18','2026-06-18',76,103,41,1,1,NULL,'active','2026-06-18 13:14:56','2026-06-20 08:59:46'),
(104,'ADRIANA','TICLIAHUANCA','TUESTA','72600509','2008-11-12','female','929735908','CALLE LOS GUABOS 290 DPTO 4 INT 401, CHICLAYO, CHICLAYO, LAMBAYEQUE','tuestaadriana327@gmail.com','2026-06-18 13:21:56',NULL,'3449664','0248','2026-06-18','2026-06-18',77,104,42,1,1,NULL,'active','2026-06-18 13:19:58','2026-06-18 13:21:56'),
(105,'MARIA FERNANDA','SAMPEN','BERNAOLA','72334483','2008-08-28','female','940049848','PSJ. VENTURA HUAMAN 180 URB. FEDERICO VILLAREAL, CHICLAYO, CHICLAYO, LAMBAYEQUE','mafersampenbernaola@gmail.com','2026-06-18 13:22:30',NULL,'5705262','0987','2026-06-17','2026-06-18',78,105,41,1,1,NULL,'active','2026-06-18 13:22:18','2026-06-20 09:01:15'),
(106,'JIMENA SOFIA','TENORIO','TAPIA','60806564','2006-09-17','female','984908889','CALLE 4 DE JUNIO, JAÉN, JAÉN, CAJAMARCA','jimenasofia518@gmail.com','2026-06-18 13:27:32',NULL,'3171739','0301','2026-06-18','2026-06-18',NULL,106,41,1,1,NULL,'active','2026-06-18 13:26:23','2026-06-18 13:27:32'),
(107,'CAMILA ARACELY','GONZALES','CASTAÑEDA','71184171','2008-03-08','female','913673291','CALLE LLOQUE YUPANQUI 1728 PUEBLO JOVEN EL BOSQUE, LA VICTORIA, CHICLAYO, LAMBAYEQUE','camgon080308@gmail.com','2026-06-18 13:28:40',NULL,'5070223','0250','2026-06-17','2026-06-18',NULL,107,18,1,1,NULL,'active','2026-06-18 13:28:30','2026-06-18 13:28:40'),
(108,'JOAQUIN ANTONIO','SANDOVAL','CAYOTOPA','76424252','2006-01-23','male','971185194','CALLE PASCUAL SACO Y OLIVEROS 146, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','sandojoaco2301@gmail.com','2026-06-18 13:35:05',NULL,'4047543','0231','2026-06-18','2026-06-18',NULL,108,41,1,1,NULL,'active','2026-06-18 13:33:09','2026-06-18 13:35:05'),
(109,'AYMAR','CUSTODIO','CHAVESTA','61157250','2007-10-26','male','926599714','CALLE MARISCAL CASTILLA 348, MONSEFU, CHICLAYO, LAMBAYEQUE','custodiochavestaaymar@gmail.com','2026-06-18 13:34:58',NULL,'3608368','0231','2026-06-18','2026-06-18',79,109,41,1,1,NULL,'active','2026-06-18 13:34:49','2026-06-18 13:34:58'),
(110,'GORKI DUBERLI','LABAN','BANCES','61509765','2008-11-01','male','956436784','CALLE LOS INCAS 220, TUCUME, LAMBAYEQUE, LAMBAYEQUE','gorkilb18@gmail.com','2026-06-18 13:41:24',NULL,'3751054','0231','2026-06-18','2026-06-18',80,110,16,1,1,NULL,'active','2026-06-18 13:41:16','2026-06-18 13:41:24'),
(111,'CESAR ABRAHAM','PALACIOS','RUIZ','74923095','2005-03-23','male','921173664','PRL. ROMA ESTE 400 URB. URRUNAGA 5TO SECTOR, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','cesarabrahampalaciosruiz@gmail.com','2026-06-18 13:52:25',NULL,'4249302','0231','2026-06-18','2026-06-18',NULL,111,37,1,1,NULL,'active','2026-06-18 13:52:14','2026-06-18 13:56:36'),
(112,'LUIS FERNANDO ALEXANDRO','FLORES','RODRIGUEZ','61050919','2007-04-20','male','978150736','TUPAC AMARU 249, LA VICTORIA, CHICLAYO, LAMBAYEQUE','luisfernandoflores2007@gmail.com','2026-06-18 13:55:29',NULL,'4241991','0231','2026-06-18','2026-06-18',NULL,112,41,1,1,NULL,'active','2026-06-18 13:54:49','2026-06-18 13:55:29'),
(113,'JENNIFFER ESMERALDA','FLORES','RODRIGUEZ','71672798','2008-05-16','female','964722906','TUPAC AMARU 249, LA VICTORIA, CHICLAYO, LAMBAYEQUE','jenniferfloresrodri@gmail.com','2026-06-18 13:59:28',NULL,'4250723','0231','2026-06-18','2026-06-18',NULL,113,41,1,1,NULL,'active','2026-06-18 13:58:58','2026-06-18 14:01:05'),
(114,'ANDERSON SALVADOR','FACIO','CARRASCO','61942036','2009-01-26','male','907930026','LAS DALIAS MZN LT 250, MOTUPE, LAMBAYEQUE, LAMBAYEQUE','salvadorfaciocarrasco@gmail.com','2026-06-18 14:10:40',NULL,'5492202','0231','2026-06-17','2026-06-18',82,114,41,1,1,NULL,'active','2026-06-18 14:09:54','2026-06-18 14:10:40'),
(115,'CARLOS RAUL','LIZA','YANCUL','72064317','2008-08-14','male','947456237','CALLE ABRAHAM VALDELOMAR 262 CPM. 28 DE JULIO, REQUE, CHICLAYO, LAMBAYEQUE','crly140876@gmail.com','2026-06-18 14:16:21',NULL,'3660048','0240','2026-06-18','2026-06-18',83,115,32,1,1,NULL,'active','2026-06-18 14:16:12','2026-06-18 14:16:21'),
(116,'CLAUDIO MARCELO','MIRANDA','CHIRA','72336576','2008-08-20','male','993320811','LUIS ORBEGOSO 135, CHICLAYO, CHICLAYO, LAMBAYEQUE','claumarcelomch@gmail.com','2026-06-18 14:22:13',NULL,'3563425','0231','2026-06-17','2026-06-18',84,116,41,1,1,NULL,'active','2026-06-18 14:21:03','2026-06-18 14:22:13'),
(117,'ALEXHA BELEN','PALOMINO','PAREDES','61279636','2008-06-25','female','954508989','CALLE MANUEL ESCORZA 319 ASENT. H. EL MOLINO, GUADALUPE, PACASMAYO, LA LIBERTAD','sofia1alexha@gmail.com','2026-06-18 14:23:30',NULL,'4205196','0231','2026-06-18','2026-06-18',85,117,4,1,1,NULL,'active','2026-06-18 14:23:17','2026-06-18 14:23:30'),
(118,'JOSE MARIA DE JESUS','PINTADO','CORDOVA','72600368','2008-11-03','male','912956455','GRAN CHIMU 1547, LA VICTORIA, CHICLAYO, LAMBAYEQUE','pintadocordovajosemaria@gmail.com','2026-06-18 14:27:44',NULL,'3299060','0231','2026-06-18','2026-06-18',86,118,41,1,1,NULL,'active','2026-06-18 14:26:51','2026-06-18 14:27:44'),
(119,'ANIBAL ANTONIO','CAJIAN','SEGURA','61358330','2008-06-11','male','922334607','CASERIO LA PAVA, MOCHUMI, LAMBAYEQUE, LAMBAYEQUE','anibalsegura124@gmail.com','2026-06-18 14:30:52',NULL,'5178593','0303','2026-06-17','2026-06-18',87,119,32,1,1,NULL,'active','2026-06-18 14:30:42','2026-06-18 14:30:52'),
(120,'FRANKLYN CALEB','SALAZAR','OBLITAS','70736534','2007-09-14','male','938922895','A. H. ANGEL DIVINO MZ. B LT. 7, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','franklyncalebsalazaroblitas@gmail.com','2026-06-18 14:38:18',NULL,'316331','0987','2026-06-18','2026-06-18',NULL,120,32,1,1,NULL,'active','2026-06-18 14:38:09','2026-06-18 14:38:18'),
(121,'OBED MAIKELL','ROJAS','MUÑOZ','61478969','2008-12-09','male','910778984','AH SAN SIMON MZ 1 LT 25, CHEPEN, CHEPÉN, LA LIBERTAD','obed.rojas160725@gmail.com','2026-06-19 07:55:18',NULL,'5383782','0231','2026-06-18','2026-06-19',88,121,32,1,1,NULL,'active','2026-06-19 07:54:31','2026-06-19 07:55:18'),
(122,'JEREMY JAREN','FERNANDEZ','ARRASCUE','72914769','2005-09-28','male','980498025','VIRREY TOLEDO 925, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','jeremyferarr@gmail.com','2026-06-19 09:37:01',NULL,'5938685','0231','2026-06-18','2026-06-19',NULL,122,28,1,1,NULL,'active','2026-06-19 09:36:15','2026-06-19 09:37:01'),
(123,'EDUARDO SANTIAGO','YGNACIO','HUANGAL','75821567','2004-10-28','male','937205080','CALLE PUERTO RICO 1250A CPM. LUJAN I ETAPA, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','eduardoygnacio28@gmail.com','2026-06-19 09:44:53',NULL,'1627160','0231','2026-06-19','2026-06-19',NULL,123,37,1,1,NULL,'active','2026-06-19 09:44:41','2026-06-19 09:44:53'),
(124,'WILLIAM RAUL','DELGADO','MORALES','61531573','2008-12-13','male','928235698','18 DE FEBRERO MZ LT 10, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','akiara.dm@gmail.com','2026-06-19 09:50:09',NULL,'2650113','0301','2026-06-18','2026-06-19',89,124,18,1,1,NULL,'active','2026-06-19 09:48:12','2026-06-19 09:50:09'),
(125,'LUZ DE BELEN','INCIO','CUBAS','60539308','2008-01-19','female','961097286','ASENT. H. LAS DELICIAS MZ. F LT. 09, REQUE, CHICLAYO, LAMBAYEQUE','belenincio1901@gmail.com','2026-06-19 10:19:31',NULL,'1687096','0240','2026-06-19','2026-06-19',NULL,125,17,1,1,NULL,'active','2026-06-19 10:19:21','2026-06-19 10:19:31'),
(126,'ANAHI GIOVANNA','VIDAURRE','DAVILA','61357481','2008-05-16','female','998954009','URB PUERTA AZUL MZ A LT 01, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','anagdavila229@gmail.com','2026-06-19 10:29:14',NULL,'2918066','0301','2026-06-16','2026-06-19',NULL,126,41,1,1,NULL,'active','2026-06-19 10:28:10','2026-06-19 10:29:14'),
(127,'MEDALITH RUBY','GUERRERO','PAJARES','72058525','2008-07-05','female','943845200','PROLONG. JHON F. KENNEDY 158 P. JOVEN LAS MARAVILLAS, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','rubyguerreropajarzzz@gmail.com','2026-06-19 10:28:56',NULL,'4529629','0301','2026-06-18','2026-06-19',90,127,27,1,1,NULL,'active','2026-06-19 10:28:44','2026-06-19 10:28:56'),
(128,'EDUARDO MOISES','NIQUEN','PEREZ','61539715','2009-02-19','male','983090827','AH 18 D FEBRERO MZ G LT 18, LAMBAYEQUE, LAMBAYEQUE, LAMBAYEQUE','eduardoniquenperez@gmail.com','2026-06-19 10:50:44',NULL,'1304846','0238','2026-06-19','2026-06-19',91,128,37,1,1,NULL,'active','2026-06-19 10:49:27','2026-06-19 10:50:44'),
(129,'NESTOR ANDRES','CHAVEZ','CABRERA','71683087','2008-06-14','male','974121009','DERRAMA MAGISTERIAL MZ E3 LT 7, CHICLAYO, CHICLAYO, LAMBAYEQUE','andres6ch@gmail.com','2026-06-19 10:55:23',NULL,'1391824','0231','2026-06-19','2026-06-19',NULL,129,41,1,1,NULL,'active','2026-06-19 10:54:41','2026-06-19 10:55:23'),
(130,'JUNIOR JOEL','BANCES','BANCES','75113538','2000-07-19','male','932278828','9 DE FEBRERO MZ. B LT. 18, MORROPE, LAMBAYEQUE, LAMBAYEQUE','juniorjoelbancesbances@gmail.com','2026-06-19 10:55:47',NULL,'2170923','0231','2026-06-19','2026-06-19',NULL,130,22,1,1,NULL,'active','2026-06-19 10:55:36','2026-06-19 10:55:47'),
(131,'ANGELES MILAGROS','FERNANDEZ','PUMARICRA','62044130','2008-11-28','female','925413482','CALLE ALFREDO BASTOS C - 11 URB. LOS ANGELES, JAÉN, JAÉN, CAJAMARCA','angelesmilagrospumericra@gmail.com','2026-06-19 11:25:31',NULL,'3560935','0231','2026-06-18','2026-06-19',92,131,41,1,1,NULL,'active','2026-06-19 11:25:18','2026-06-19 11:25:31'),
(132,'FIORELLA ELIZABETH','VELASQUEZ','SENMACHE','61485333','2008-09-26','female','939486251','CALLE TARAPACA 211, MONSEFU, CHICLAYO, LAMBAYEQUE','fiorellavelasques26@gmail.com','2026-06-19 11:43:43',NULL,'2554741','0231','2026-06-19','2026-06-19',93,132,4,1,1,NULL,'active','2026-06-19 11:43:32','2026-06-19 11:43:43'),
(133,'KEILA BETSABE','BARRIENTOS','PUICON','60986848','2007-03-06','female','925946701','AV. AREQUIPA MZ. X LT. 11 ANIMAS - CIUDADELA, CHICLAYO, CHICLAYO, LAMBAYEQUE','keilabarrientospuicon@gmail.com','2026-06-19 11:59:32',NULL,'2582239','0231','2026-06-19','2026-06-19',94,133,5,1,1,NULL,'active','2026-06-19 11:59:05','2026-06-19 11:59:32'),
(134,'JOSE PANTALEON','VASQUEZ','MILIAN','61820440','2009-06-03','male','995208093','JUAN DIAZ ORREGO, OYOTUN, CHICLAYO, LAMBAYEQUE','josepantaleon389@gmail.com','2026-06-19 12:10:39',NULL,'5190226','0250','2026-06-18','2026-06-19',95,134,37,1,1,NULL,'active','2026-06-19 12:09:40','2026-06-19 12:10:39'),
(135,'WILY BRAYAN','BECERRA','GONZALEZ','60216612','2007-03-06','male','947693368','CASERIO SAN JUAN DE DIOS, PULAN, SANTA CRUZ, CAJAMARCA','becerragonzalesb@gmail.com','2026-06-19 12:21:17',NULL,'5502070','0231','2026-06-18','2026-06-19',NULL,135,18,1,1,NULL,'active','2026-06-19 12:20:35','2026-06-19 12:21:17'),
(136,'NAHOMY DEL MILAGRO','TIPIANI','LOPEZ','61230183','2007-10-28','female','912824069','CALLE INCANATO 532 CPM. GARCES, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','nahotipiani@gmail.com','2026-06-19 12:25:37',NULL,'2809609','0231','2026-06-19','2026-06-19',96,136,23,1,1,NULL,'active','2026-06-19 12:22:37','2026-06-19 12:25:37'),
(137,'OSCAR THOMAS','PAICO','DIAZ','74304510','2003-10-07','male','901261245','MIGUEL GRAU 173, MOCHUMI, LAMBAYEQUE, LAMBAYEQUE','paicodiazoscarthomas@gmail.com','2026-06-19 12:32:44',NULL,'2693023','0301','2026-06-19','2026-06-19',NULL,137,41,1,1,NULL,'active','2026-06-19 12:32:20','2026-06-19 12:32:44'),
(138,'AARON JHOEL','VALENCIA','CORTEZ','72063578','2008-07-24','male','922399769','CALLE LAS PALMERAS 1758 PJ. SAN LORENZO, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','valenciacortezaa@gmail.com','2026-06-19 12:38:41',NULL,'2740247','0230','2026-06-19','2026-06-19',97,138,1,1,1,NULL,'active','2026-06-19 12:38:32','2026-06-19 12:38:41'),
(139,'AYMAR YADIRA','ZETA','CORTEZ','72344042','2008-10-02','female','906570621','SAN JUAN 181 PJ. NUEVO SAN LORENZO, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','aymarzetacortez@gmail.com','2026-06-19 12:44:59',NULL,'2717364','0230','2026-06-19','2026-06-19',98,139,41,1,1,NULL,'active','2026-06-19 12:44:51','2026-06-19 12:44:59'),
(140,'JOSE SEBASTIAN','CHIMOY','SIGNOL','60942618','2006-12-03','male','961703076','CPM. CALLANCA, MONSEFU, CHICLAYO, LAMBAYEQUE','jschimoy123@gmail.com','2026-06-19 13:36:51',NULL,'3789689','0231','2026-06-18','2026-06-19',NULL,140,41,1,1,NULL,'active','2026-06-19 13:36:25','2026-06-19 13:36:51'),
(141,'NICOLE STEPHANIE','ZEVALLOS','QUIROZ','71367855','2008-05-13','female','940964361','JUAN PABLO II 548, CHICLAYO, CHICLAYO, LAMBAYEQUE','mayraquirozramirez@gmail.com','2026-06-19 13:37:46',NULL,'2876609','0231','2026-06-19','2026-06-19',NULL,141,18,1,1,NULL,'active','2026-06-19 13:36:40','2026-06-19 13:37:46'),
(142,'JHOSELIN LUCERO','GONZALES','ROMAN','73158386','2009-03-10','female','929271687','PSJ. PALMO URB. JOSE MARIA MZ. F LT. 6, JOSÉ LEONARDO ORTIZ, CHICLAYO, LAMBAYEQUE','lucerogr2009@gmail.com','2026-06-19 13:47:30',NULL,'3237263','0231','2026-06-19','2026-06-19',99,142,41,1,1,NULL,'active','2026-06-19 13:47:13','2026-06-19 13:47:30'),
(143,'MIRIAM','HERNANDEZ','CALVAY','76626262','2007-07-05','female','913965908','SUGLLAQUIRO, MOYOBAMBA, MOYOBAMBA, SAN MARTÍN','mh9061532@gmail.com','2026-06-19 14:10:30',NULL,'4445146','0301','2026-06-18','2026-06-19',NULL,143,18,1,1,NULL,'active','2026-06-19 14:09:31','2026-06-19 14:10:30'),
(144,'DAVID','VILLALOBOS','VILLALOBOS','70984166','1992-10-26','male','990560724','JOSE BALTA BLOCK D - 402, CHICLAYO, CHICLAYO, LAMBAYEQUE','davillalobos11@gmail.com','2026-06-19 14:17:29',NULL,'3353663','0301','2026-06-19','2026-06-19',NULL,144,25,1,1,NULL,'active','2026-06-19 14:16:30','2026-06-19 14:17:29'),
(145,'RONALD MANUEL','UBILLUS','DAVILA','71359970','2007-12-28','male','978227502','PROLG. GARCILAZO DE LA VEGA 1320 SECTOR NUEVO HORIZONTE, JAÉN, JAÉN, CAJAMARCA','ronaldmanuel228@gmail.com','2026-06-19 14:18:28',NULL,'3610945','0231','2026-06-19','2026-06-19',NULL,145,41,1,1,NULL,'active','2026-06-19 14:18:14','2026-06-19 14:18:28'),
(146,'CARLOS ALEJANDRO','MINGUILLO','DE LA CRUZ','72996511','2009-02-12','male','948907218','LAS FLORES 124, CHICLAYO, CHICLAYO, LAMBAYEQUE','carlosminguillo156@gmail.com','2026-06-19 14:22:32',NULL,'3628302','0231','2026-06-19','2026-06-19',100,146,34,1,1,NULL,'active','2026-06-19 14:21:33','2026-06-19 14:22:32'),
(147,'BRYANNA XIMENA','ALCANTARA','HORNA','74163664','2007-11-10','female','923924432','CALLE EL COMERCIO AH PERPETUO SOCORRO MZ A LT 09, ETEN PUERTO, CHICLAYO, LAMBAYEQUE','xibryalho@gmail.com','2026-06-19 14:33:09',NULL,'4000545','0233','2026-06-18','2026-06-19',NULL,147,42,1,1,NULL,'active','2026-06-19 14:31:26','2026-06-19 14:33:09'),
(148,'LIONEL PRIESSNITZ','CAMPOS','BERMEO','60161768','2007-05-08','male','961814428','CP PUERTO HUALLAPE, SANTA ROSA, JAÉN, CAJAMARCA','lioncamposbermeo@gmail.com','2026-06-19 14:39:36',NULL,'3703893','0231','2026-06-19','2026-06-19',NULL,148,31,1,1,NULL,'active','2026-06-19 14:38:54','2026-06-19 14:39:36'),
(149,'MARIA JOSE','NUÑEZ','FARRO','71668981','2008-05-28','female','956716030','CALLE 1 DE MAYO 281, CHICLAYO, CHICLAYO, LAMBAYEQUE','nunezfarromarie@gmail.com','2026-06-19 14:53:19',NULL,'2945982','0236','2026-06-19','2026-06-19',NULL,149,18,1,1,NULL,'active','2026-06-19 14:52:01','2026-06-19 14:53:19'),
(150,'DARIANNE AYLEEN','YUNIS','PEREZ','72828368','2009-01-02','female','936058478','CALLE VICENTE DE LA VEGA 1612, CHICLAYO, CHICLAYO, LAMBAYEQUE','pzberly@gmail.com','2026-06-19 14:56:26',NULL,'3594558','0231','2026-06-19','2026-06-19',101,150,4,1,1,NULL,'active','2026-06-19 14:56:15','2026-06-19 14:56:26'),
(151,'MARIA GABRIELLA','ZEÑA','CAMPOS','71356904','2008-03-12','female','979671083','CALLE ORTIZ VELEZ 140, CHICLAYO, CHICLAYO, LAMBAYEQUE','gabyzena333@gmail.com','2026-06-19 14:58:25',NULL,'3845830','0231','2026-06-19','2026-06-19',NULL,151,28,1,1,NULL,'active','2026-06-19 14:57:23','2026-06-19 14:58:25'),
(152,'BRUNO','FERNANDEZ','SOBRINO','71686939','2008-06-18','male','973370916','CALLE W. VALDIVIEZO 189-B 2DO PISO URB. PRIMAVERA, CHICLAYO, CHICLAYO, LAMBAYEQUE','brunuianubis@gmail.com','2026-06-19 15:01:52',NULL,'2097601','0231','2026-06-19','2026-06-19',NULL,152,32,1,1,NULL,'active','2026-06-19 15:01:40','2026-06-19 15:01:52');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'centropre'
--

--
-- Dumping routines for database 'centropre'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-21 23:58:21
