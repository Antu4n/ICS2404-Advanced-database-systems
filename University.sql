-- Create Course table first as it's referenced by other tables
CREATE TABLE Course (
    course_ID VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

-- Create Student table with foreign key to Course
CREATE TABLE Student (
    student_ID VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    enrollment_date DATE NOT NULL,
    course_ID VARCHAR(20),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

-- Create Semester table with foreign key to Course
CREATE TABLE Semester (
    semester_ID VARCHAR(20) PRIMARY KEY,
    semester_number INT CHECK (semester_number IN (1, 2, 3)),
    year INT NOT NULL,
    course_ID VARCHAR(20),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

-- Create Unit table with foreign key to Course
CREATE TABLE Unit (
    unit_ID VARCHAR(20) PRIMARY KEY,
    unit_code VARCHAR(20) UNIQUE NOT NULL,
    unit_name VARCHAR(100) NOT NULL,
    course_ID VARCHAR(20),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID)
);

-- Create Results table with foreign keys to Student and Unit
CREATE TABLE Results (
    result_ID VARCHAR(20) PRIMARY KEY,
    student_ID VARCHAR(20),
    unit_ID VARCHAR(20),
    marks DECIMAL(5,2) CHECK (marks >= 0 AND marks <= 100),
    grade VARCHAR(2),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID),
    FOREIGN KEY (unit_ID) REFERENCES Unit(unit_ID)
);

-- Create Fees table with foreign keys to Student, Course, and Semester
CREATE TABLE Fees (
    fees_ID VARCHAR(20) PRIMARY KEY,
    student_ID VARCHAR(20),
    course_ID VARCHAR(20),
    semester_ID VARCHAR(20),
    fees_charged DECIMAL(10,2) NOT NULL,
    fees_paid DECIMAL(10,2) DEFAULT 0,
    fees_balance DECIMAL(10,2) GENERATED ALWAYS AS (fees_charged - fees_paid) STORED,
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID),
    FOREIGN KEY (course_ID) REFERENCES Course(course_ID),
    FOREIGN KEY (semester_ID) REFERENCES Semester(semester_ID)
);

-- Create junction table for Student-Unit many-to-many relationship
CREATE TABLE StudentUnitRegistration (
    registration_ID VARCHAR(20) PRIMARY KEY,
    student_ID VARCHAR(20),
    unit_ID VARCHAR(20),
    registration_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (student_ID) REFERENCES Student(student_ID),
    FOREIGN KEY (unit_ID) REFERENCES Unit(unit_ID),
    UNIQUE (student_ID, unit_ID)
);

-- Create indexes for frequently accessed columns
CREATE INDEX idx_student_course ON Student(course_ID);
CREATE INDEX idx_unit_course ON Unit(course_ID);
CREATE INDEX idx_results_student ON Results(student_ID);
CREATE INDEX idx_results_unit ON Results(unit_ID);
CREATE INDEX idx_fees_student ON Fees(student_ID);
CREATE INDEX idx_fees_semester ON Fees(semester_ID);

-- insert data into the tables
-- Insert data into Course table
INSERT INTO Course (course_ID, course_name) VALUES
('C001', 'Computer Science'),
('C002', 'Information Technology'),
('C003', 'Data Science');

-- Insert data into Student table
INSERT INTO Student (student_ID, student_name, gender, enrollment_date, course_ID) VALUES
('S001', 'Alice Johnson', 'Female', '2021-08-15', 'C001'),
('S002', 'Bob Smith', 'Male', '2022-01-20', 'C002'),
('S003', 'Charlie Brown', 'Other', '2023-06-10', 'C003');

-- Insert data into Semester table
INSERT INTO Semester (semester_ID, semester_number, year, course_ID) VALUES
('SEM001', 1, 2021, 'C001'),
('SEM002', 2, 2021, 'C001'),
('SEM003', 1, 2022, 'C002'),
('SEM004', 2, 2022, 'C002'),
('SEM005', 1, 2023, 'C003');

-- Insert data into Unit table
INSERT INTO Unit (unit_ID, unit_code, unit_name, course_ID) VALUES
('U001', 'CS101', 'Introduction to Programming', 'C001'),
('U002', 'CS102', 'Data Structures', 'C001'),
('U003', 'IT101', 'Networking Basics', 'C002'),
('U004', 'IT102', 'Cybersecurity', 'C002'),
('U005', 'DS101', 'Machine Learning', 'C003');

-- Insert data into Results table
INSERT INTO Results (result_ID, student_ID, unit_ID, marks, grade) VALUES
('R001', 'S001', 'U001', 85.00, 'A'),
('R002', 'S001', 'U002', 78.50, 'B'),
('R003', 'S002', 'U003', 92.00, 'A'),
('R004', 'S002', 'U004', 88.75, 'A'),
('R005', 'S003', 'U005', 73.25, 'B');

-- Insert data into Fees table
INSERT INTO Fees (fees_ID, student_ID, course_ID, semester_ID, fees_charged, fees_paid) VALUES
('F001', 'S001', 'C001', 'SEM001', 50000.00, 45000.00),
('F002', 'S002', 'C002', 'SEM003', 60000.00, 60000.00),
('F003', 'S003', 'C003', 'SEM005', 55000.00, 30000.00);

-- Insert data into StudentUnitRegistration table
INSERT INTO StudentUnitRegistration (registration_ID, student_ID, unit_ID, registration_date) VALUES
('REG001', 'S001', 'U001', '2021-08-16'),
('REG002', 'S001', 'U002', '2021-09-01'),
('REG003', 'S002', 'U003', '2022-01-21'),
('REG004', 'S002', 'U004', '2022-02-15'),
('REG005', 'S003', 'U005', '2023-06-11');


-- test to see the data is correctly inputted. 
SELECT * FROM Course, Student, Unit, studentunitregistration;

SELECT Student.student_name, Course.course_name
FROM Student
JOIN Course ON Student.course_ID = Course.course_ID;

SELECT * FROM fees, student;

SELECT Student.student_name, Unit.unit_name
FROM studentunitregistration
JOIN Student ON studentunitregistration.student_ID = Student.student_ID
JOIN Unit ON studentunitregistration.unit_ID = Unit.unit_ID
WHERE Unit.unit_name = 'Machine Learning';


-- Test case for recovery 1: begin a transaction and disconnect without committing..
START TRANSACTION;
SELECT * FROM fees;
UPDATE FEES
SET fees_paid  = fees_paid + 5000
WHERE fees.student_ID = 'S001';

SELECT * FROM fees WHERE student_ID = 'S001';

-- Test case 2: Explicit rollback
START TRANSACTION;

UPDATE FEES
SET fees_paid  = fees_paid + 1000
WHERE fees.student_ID = 'S002';

SELECT * FROM fees WHERE student_ID = 'S002';

--  rollback the transaction
ROLLBACK;

SELECT * FROM fees WHERE student_ID = 'S002';

-- Explicitly commit 
START TRANSACTION;

-- Simulate fee payment
UPDATE Fees
SET fees_paid = fees_paid + 2000
WHERE student_ID = 'S003';

-- Verify update before commit
SELECT * FROM Fees WHERE student_ID = 'S003';

-- Commit transaction
COMMIT;

-- Verify after commit (Expected: changes persisted)
SELECT * FROM Fees WHERE student_ID = 'S003';
-- End of Tests


-- DROP SOME TABLES TO SIMULATE ERROR.
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE student, unit, course;
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM student;








