-- ============================================================
-- University Student Performance Database — Schema
-- Database: universitydb
-- ============================================================

CREATE DATABASE IF NOT EXISTS universitydb;
USE universitydb;

-- ------------------------------------------------------------
-- Students: core student records
-- ------------------------------------------------------------
CREATE TABLE Students (
    student_id      INT PRIMARY KEY,
    student_name    VARCHAR(100),
    gender          VARCHAR(10),
    department      VARCHAR(50),
    semester        INT,
    admission_year  INT
);

-- ------------------------------------------------------------
-- Subjects: course catalog
-- ------------------------------------------------------------
CREATE TABLE Subjects (
    subject_id      INT PRIMARY KEY,
    subject_name    VARCHAR(100),
    credits         INT
);

-- ------------------------------------------------------------
-- Enrollments: which students are enrolled in which subjects
-- ------------------------------------------------------------
CREATE TABLE Enrollments (
    enrollment_id   INT PRIMARY KEY,
    student_id      INT,
    subject_id      INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- ------------------------------------------------------------
-- Attendance: per-subject attendance percentage per student
-- ------------------------------------------------------------
CREATE TABLE Attendance (
    attendance_id       INT PRIMARY KEY,
    student_id          INT,
    subject_id          INT,
    attendance_percent  DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- ------------------------------------------------------------
-- Exams: marks scored by students per subject
-- ------------------------------------------------------------
CREATE TABLE Exams (
    exam_id      INT PRIMARY KEY,
    student_id   INT,
    subject_id   INT,
    marks        INT,
    exam_date    DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);
