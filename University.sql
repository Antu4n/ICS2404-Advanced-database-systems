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
