-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: portal
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_ID` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  PRIMARY KEY (`course_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('C001','Computer Science'),('C002','Information Technology'),('C003','Data Science');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `fees_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `course_ID` varchar(20) DEFAULT NULL,
  `semester_ID` varchar(20) DEFAULT NULL,
  `fees_charged` decimal(10,2) NOT NULL,
  `fees_paid` decimal(10,2) DEFAULT '0.00',
  `fees_balance` decimal(10,2) GENERATED ALWAYS AS ((`fees_charged` - `fees_paid`)) STORED,
  PRIMARY KEY (`fees_ID`),
  KEY `course_ID` (`course_ID`),
  KEY `idx_fees_student` (`student_ID`),
  KEY `idx_fees_semester` (`semester_ID`),
  CONSTRAINT `fees_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`),
  CONSTRAINT `fees_ibfk_2` FOREIGN KEY (`course_ID`) REFERENCES `course` (`course_ID`),
  CONSTRAINT `fees_ibfk_3` FOREIGN KEY (`semester_ID`) REFERENCES `semester` (`semester_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` (`fees_ID`, `student_ID`, `course_ID`, `semester_ID`, `fees_charged`, `fees_paid`) VALUES ('F001','S001','C001','SEM001',50000.00,45000.00),('F002','S002','C002','SEM003',60000.00,60000.00),('F003','S003','C003','SEM005',55000.00,30000.00);
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `result_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `unit_ID` varchar(20) DEFAULT NULL,
  `marks` decimal(5,2) DEFAULT NULL,
  `grade` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`result_ID`),
  KEY `idx_results_student` (`student_ID`),
  KEY `idx_results_unit` (`unit_ID`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`),
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`unit_ID`) REFERENCES `unit` (`unit_ID`),
  CONSTRAINT `results_chk_1` CHECK (((`marks` >= 0) and (`marks` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES ('R001','S001','U001',85.00,'A'),('R002','S001','U002',78.50,'B'),('R003','S002','U003',92.00,'A'),('R004','S002','U004',88.75,'A'),('R005','S003','U005',73.25,'B');
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `semester_ID` varchar(20) NOT NULL,
  `semester_number` int DEFAULT NULL,
  `year` int NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`semester_ID`),
  KEY `course_ID` (`course_ID`),
  CONSTRAINT `semester_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `course` (`course_ID`),
  CONSTRAINT `semester_chk_1` CHECK ((`semester_number` in (1,2,3)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES ('SEM001',1,2021,'C001'),('SEM002',2,2021,'C001'),('SEM003',1,2022,'C002'),('SEM004',2,2022,'C002'),('SEM005',1,2023,'C003');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_ID` varchar(20) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `enrollment_date` date NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`student_ID`),
  KEY `idx_student_course` (`course_ID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `course` (`course_ID`),
  CONSTRAINT `student_chk_1` CHECK ((`gender` in (_utf8mb4'Male',_utf8mb4'Female',_utf8mb4'Other')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('S001','Alice Johnson','Female','2021-08-15','C001'),('S002','Bob Smith','Male','2022-01-20','C002'),('S003','Charlie Brown','Other','2023-06-10','C003');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentunitregistration`
--

DROP TABLE IF EXISTS `studentunitregistration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentunitregistration` (
  `registration_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `unit_ID` varchar(20) DEFAULT NULL,
  `registration_date` date DEFAULT (curdate()),
  PRIMARY KEY (`registration_ID`),
  UNIQUE KEY `student_ID` (`student_ID`,`unit_ID`),
  KEY `unit_ID` (`unit_ID`),
  CONSTRAINT `studentunitregistration_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `student` (`student_ID`),
  CONSTRAINT `studentunitregistration_ibfk_2` FOREIGN KEY (`unit_ID`) REFERENCES `unit` (`unit_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentunitregistration`
--

LOCK TABLES `studentunitregistration` WRITE;
/*!40000 ALTER TABLE `studentunitregistration` DISABLE KEYS */;
INSERT INTO `studentunitregistration` VALUES ('REG001','S001','U001','2021-08-16'),('REG002','S001','U002','2021-09-01'),('REG003','S002','U003','2022-01-21'),('REG004','S002','U004','2022-02-15'),('REG005','S003','U005','2023-06-11');
/*!40000 ALTER TABLE `studentunitregistration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit` (
  `unit_ID` varchar(20) NOT NULL,
  `unit_code` varchar(20) NOT NULL,
  `unit_name` varchar(100) NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`unit_ID`),
  UNIQUE KEY `unit_code` (`unit_code`),
  KEY `idx_unit_course` (`course_ID`),
  CONSTRAINT `unit_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `course` (`course_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES ('U001','CS101','Introduction to Programming','C001'),('U002','CS102','Data Structures','C001'),('U003','IT101','Networking Basics','C002'),('U004','IT102','Cybersecurity','C002'),('U005','DS101','Machine Learning','C003');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-01 23:34:36
