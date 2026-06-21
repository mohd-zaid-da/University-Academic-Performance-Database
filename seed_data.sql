-- ============================================================
-- University Student Performance Database — Sample Data
-- Run after schema.sql
-- ============================================================

USE universitydb;

INSERT INTO Students VALUES
(1, 'Aman',  'Male',   'CSE', 5, 2022),
(2, 'Sara',  'Female', 'CSE', 5, 2022),
(3, 'Ali',   'Male',   'ECE', 5, 2022),
(4, 'Priya', 'Female', 'IT',  5, 2022),
(5, 'Rahul', 'Male',   'CSE', 5, 2022);

INSERT INTO Subjects VALUES
(101, 'DBMS',               4),
(102, 'Operating System',   4),
(103, 'Computer Networks',  3),
(104, 'Machine Learning',   4);

INSERT INTO Enrollments VALUES
(1, 1, 101),
(2, 1, 102),
(3, 2, 101),
(4, 2, 103),
(5, 3, 101),
(6, 4, 104),
(7, 5, 102);

INSERT INTO Attendance VALUES
(1, 1, 101, 92),
(2, 1, 102, 88),
(3, 2, 101, 95),
(4, 2, 103, 90),
(5, 3, 101, 65),
(6, 4, 104, 70),
(7, 5, 102, 60);

INSERT INTO Exams VALUES
(1, 1, 101, 85, '2025-05-10'),
(2, 1, 102, 80, '2025-05-10'),
(3, 2, 101, 91, '2025-05-10'),
(4, 2, 103, 89, '2025-05-10'),
(5, 3, 101, 55, '2025-05-10'),
(6, 4, 104, 58, '2025-05-10'),
(7, 5, 102, 50, '2025-05-10');
