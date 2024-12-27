-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 27, 2024 at 02:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `UniversityDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `course_ID` varchar(20) NOT NULL,
  `course_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`course_ID`, `course_name`) VALUES
('AFT2202', 'Accounting and Finance'),
('BCT2101', 'Business Computing'),
('CS001', 'Computer Science'),
('IT001', 'Information Technology'),
('PMI2203', 'Project Management'),
('SE001', 'Software Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `Fees`
--

CREATE TABLE `Fees` (
  `fees_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `course_ID` varchar(20) DEFAULT NULL,
  `semester_ID` varchar(20) DEFAULT NULL,
  `fees_charged` decimal(10,2) NOT NULL,
  `fees_paid` decimal(10,2) DEFAULT 0.00,
  `fees_balance` decimal(10,2) GENERATED ALWAYS AS (`fees_charged` - `fees_paid`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Fees`
--

INSERT INTO `Fees` (`fees_ID`, `student_ID`, `course_ID`, `semester_ID`, `fees_charged`, `fees_paid`) VALUES
('FEE001', 'SCT211-0255/2021', 'CS001', 'SEM001', 50000.00, 45000.00),
('FEE002', 'SCT211-0256/2021', 'CS001', 'SEM002', 50000.00, 50000.00),
('FEE003', 'SCT211-0257/2021', 'SE001', 'SEM003', 60000.00, 40000.00),
('FEE004', 'SCT211-0258/2022', 'IT001', 'SEM004', 55000.00, 55000.00),
('FEE005', 'SCT211-0259/2022', 'CS001', 'SEM005', 50000.00, 30000.00),
('FEE006', 'SCT211-0260/2023', 'SE001', 'SEM006', 60000.00, 60000.00),
('FEE007', 'SCT211-0261/2023', 'IT001', 'SEM007', 55000.00, 35000.00);

-- --------------------------------------------------------

--
-- Table structure for table `Results`
--

CREATE TABLE `Results` (
  `result_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `unit_ID` varchar(20) DEFAULT NULL,
  `marks` decimal(5,2) DEFAULT NULL CHECK (`marks` >= 0 and `marks` <= 100),
  `grade` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Results`
--

INSERT INTO `Results` (`result_ID`, `student_ID`, `unit_ID`, `marks`, `grade`) VALUES
('RES001', 'SCT211-0255/2021', 'UNIT001', 78.50, 'A'),
('RES002', 'SCT211-0256/2021', 'UNIT002', 65.00, 'B'),
('RES003', 'SCT211-0257/2021', 'UNIT005', 59.00, 'C'),
('RES004', 'SCT211-0258/2022', 'UNIT003', 88.00, 'A'),
('RES005', 'SCT211-0259/2022', 'UNIT001', 73.00, 'A'),
('RES006', 'SCT211-0260/2023', 'UNIT006', 55.00, 'C'),
('RES007', 'SCT211-0261/2023', 'UNIT004', 92.00, 'A'),
('RES101', 'SCT211-0255/2021', 'UNIT001', 75.00, 'A'),
('RES102', 'SCT211-0255/2021', 'UNIT002', 68.00, 'B'),
('RES103', 'SCT211-0256/2021', 'UNIT001', 65.00, 'B'),
('RES104', 'SCT211-0256/2021', 'UNIT003', 80.00, 'A'),
('RES105', 'SCT211-0257/2021', 'UNIT002', 70.00, 'A'),
('RES106', 'SCT211-0257/2021', 'UNIT004', 85.00, 'A'),
('RES107', 'SCT211-0258/2022', 'UNIT003', 60.00, 'B'),
('RES108', 'SCT211-0258/2022', 'UNIT005', 50.00, 'C'),
('RES109', 'SCT211-0259/2022', 'UNIT003', 72.00, 'A'),
('RES110', 'SCT211-0259/2022', 'UNIT002', 55.00, 'C'),
('RES111', 'SCT211-0306/2021', 'UNIT006', 45.00, 'D');

--
-- Triggers `Results`
--
DELIMITER $$
CREATE TRIGGER `before_insert_update_results` BEFORE INSERT ON `Results` FOR EACH ROW BEGIN
    IF NEW.marks >= 70 THEN
        SET NEW.grade = 'A';
    ELSEIF NEW.marks >= 60 THEN
        SET NEW.grade = 'B';
    ELSEIF NEW.marks >= 50 THEN
        SET NEW.grade = 'C';
    ELSEIF NEW.marks >= 40 THEN
        SET NEW.grade = 'D';
    ELSE
        SET NEW.grade = 'E';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Semester`
--

CREATE TABLE `Semester` (
  `semester_ID` varchar(20) NOT NULL,
  `semester_number` int(11) DEFAULT NULL CHECK (`semester_number` in (1,2,3)),
  `year` int(11) NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Semester`
--

INSERT INTO `Semester` (`semester_ID`, `semester_number`, `year`, `course_ID`) VALUES
('SEM001', 1, 2021, 'CS001'),
('SEM002', 2, 2021, 'CS001'),
('SEM003', 1, 2022, 'SE001'),
('SEM004', 2, 2022, 'IT001'),
('SEM005', 1, 2023, 'CS001'),
('SEM006', 2, 2023, 'SE001'),
('SEM007', 1, 2024, 'IT001'),
('SEM2021-01', 1, 2021, 'CS001'),
('SEM2021-02', 2, 2021, 'BCT2101'),
('SEM2022-01', 1, 2022, 'PMI2203'),
('SEM2022-02', 2, 2022, 'CS001'),
('SEM2023-01', 1, 2023, 'CS001'),
('SEM2023-02', 2, 2023, 'BCT2101'),
('SEM2024-01', 1, 2024, 'PMI2203'),
('SEM2024-02', 2, 2024, 'BCT2101');

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `student_ID` varchar(20) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL CHECK (`gender` in ('Male','Female','Other')),
  `enrollment_date` date NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`student_ID`, `student_name`, `gender`, `enrollment_date`, `course_ID`) VALUES
('SCT211-0255/2021', 'Ashraf Mohammed Hassan', 'Male', '2021-09-15', 'CS001'),
('SCT211-0256/2021', 'Ronny Mokaya Kerosi', 'Male', '2021-09-15', 'CS001'),
('SCT211-0257/2021', 'Nelson Irungu Mwangi', 'Male', '2021-09-15', 'SE001'),
('SCT211-0258/2022', 'Glen Ochieng', 'Male', '2022-09-15', 'IT001'),
('SCT211-0259/2022', 'Shem Opiyo Oyoo', 'Male', '2022-09-15', 'CS001'),
('SCT211-0260/2023', 'Caroline Wanjiru', 'Female', '2023-09-15', 'SE001'),
('SCT211-0261/2023', 'James Ndungu Mbugua', 'Male', '2023-09-15', 'IT001'),
('SCT211-0306/2021', 'Faith Atieno Akinyi', 'Female', '2021-01-23', 'BCT2101'),
('SCT211-0307/2021', 'Kevin Nderitu Waweru', 'Male', '2021-01-25', 'PMI2203'),
('SCT211-0308/2021', 'Margaret Nyambura Gitau', 'Female', '2021-01-26', 'CS001'),
('SCT211-0309/2021', 'Joseph Mwangi Muchiri', 'Male', '2021-01-27', 'BCT2101'),
('SCT211-0310/2021', 'Daniel Ouma Okoth', 'Male', '2021-01-29', 'CS001'),
('SCT211-0360/2023', 'Esther Alan Mungai', 'Female', '2023-09-15', 'IT001');

-- --------------------------------------------------------

--
-- Table structure for table `StudentUnitRegistration`
--

CREATE TABLE `StudentUnitRegistration` (
  `registration_ID` varchar(20) NOT NULL,
  `student_ID` varchar(20) DEFAULT NULL,
  `unit_ID` varchar(20) DEFAULT NULL,
  `registration_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `StudentUnitRegistration`
--

INSERT INTO `StudentUnitRegistration` (`registration_ID`, `student_ID`, `unit_ID`, `registration_date`) VALUES
('REG001', 'SCT211-0255/2021', 'UNIT001', '2021-09-20'),
('REG002', 'SCT211-0256/2021', 'UNIT002', '2021-09-21'),
('REG003', 'SCT211-0257/2021', 'UNIT005', '2021-09-22'),
('REG004', 'SCT211-0258/2022', 'UNIT003', '2022-09-20'),
('REG005', 'SCT211-0259/2022', 'UNIT001', '2022-09-21'),
('REG006', 'SCT211-0260/2023', 'UNIT006', '2023-09-20'),
('REG007', 'SCT211-0261/2023', 'UNIT004', '2023-09-21');

-- --------------------------------------------------------

--
-- Table structure for table `Unit`
--

CREATE TABLE `Unit` (
  `unit_ID` varchar(20) NOT NULL,
  `unit_code` varchar(20) NOT NULL,
  `unit_name` varchar(100) NOT NULL,
  `course_ID` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Unit`
--

INSERT INTO `Unit` (`unit_ID`, `unit_code`, `unit_name`, `course_ID`) VALUES
('UNIT001', 'ICS2101', 'Introduction to Computer Science', 'CS001'),
('UNIT002', 'ICS2202', 'Data Structures and Algorithms', 'CS001'),
('UNIT003', 'BCT2103', 'Introduction to IT', 'IT001'),
('UNIT004', 'BCT2201', 'Networking Basics', 'IT001'),
('UNIT005', 'ICS2301', 'Software Design', 'SE001'),
('UNIT006', 'ICS2302', 'Software Testing', 'SE001');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`course_ID`);

--
-- Indexes for table `Fees`
--
ALTER TABLE `Fees`
  ADD PRIMARY KEY (`fees_ID`),
  ADD KEY `course_ID` (`course_ID`),
  ADD KEY `idx_fees_student` (`student_ID`),
  ADD KEY `idx_fees_semester` (`semester_ID`);

--
-- Indexes for table `Results`
--
ALTER TABLE `Results`
  ADD PRIMARY KEY (`result_ID`),
  ADD KEY `idx_results_student` (`student_ID`),
  ADD KEY `idx_results_unit` (`unit_ID`);

--
-- Indexes for table `Semester`
--
ALTER TABLE `Semester`
  ADD PRIMARY KEY (`semester_ID`),
  ADD KEY `course_ID` (`course_ID`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`student_ID`),
  ADD KEY `idx_student_course` (`course_ID`);

--
-- Indexes for table `StudentUnitRegistration`
--
ALTER TABLE `StudentUnitRegistration`
  ADD PRIMARY KEY (`registration_ID`),
  ADD UNIQUE KEY `student_ID` (`student_ID`,`unit_ID`),
  ADD KEY `unit_ID` (`unit_ID`);

--
-- Indexes for table `Unit`
--
ALTER TABLE `Unit`
  ADD PRIMARY KEY (`unit_ID`),
  ADD UNIQUE KEY `unit_code` (`unit_code`),
  ADD KEY `idx_unit_course` (`course_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Fees`
--
ALTER TABLE `Fees`
  ADD CONSTRAINT `Fees_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `Student` (`student_ID`),
  ADD CONSTRAINT `Fees_ibfk_2` FOREIGN KEY (`course_ID`) REFERENCES `Course` (`course_ID`),
  ADD CONSTRAINT `Fees_ibfk_3` FOREIGN KEY (`semester_ID`) REFERENCES `Semester` (`semester_ID`);

--
-- Constraints for table `Results`
--
ALTER TABLE `Results`
  ADD CONSTRAINT `Results_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `Student` (`student_ID`),
  ADD CONSTRAINT `Results_ibfk_2` FOREIGN KEY (`unit_ID`) REFERENCES `Unit` (`unit_ID`);

--
-- Constraints for table `Semester`
--
ALTER TABLE `Semester`
  ADD CONSTRAINT `Semester_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `Course` (`course_ID`);

--
-- Constraints for table `Student`
--
ALTER TABLE `Student`
  ADD CONSTRAINT `Student_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `Course` (`course_ID`);

--
-- Constraints for table `StudentUnitRegistration`
--
ALTER TABLE `StudentUnitRegistration`
  ADD CONSTRAINT `StudentUnitRegistration_ibfk_1` FOREIGN KEY (`student_ID`) REFERENCES `Student` (`student_ID`),
  ADD CONSTRAINT `StudentUnitRegistration_ibfk_2` FOREIGN KEY (`unit_ID`) REFERENCES `Unit` (`unit_ID`);

--
-- Constraints for table `Unit`
--
ALTER TABLE `Unit`
  ADD CONSTRAINT `Unit_ibfk_1` FOREIGN KEY (`course_ID`) REFERENCES `Course` (`course_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
