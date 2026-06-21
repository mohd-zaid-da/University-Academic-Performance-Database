-- ============================================================
-- University Student Performance Database — Analysis Queries
-- Run after schema.sql and seed_data.sql
-- ============================================================

USE universitydb;

-- ------------------------------------------------------------
-- 1. Average marks per student
-- ------------------------------------------------------------
SELECT
    student_id,
    AVG(marks) AS avg_marks
FROM Exams
GROUP BY student_id;

-- ------------------------------------------------------------
-- 2. Top performing students (highest average marks first)
-- ------------------------------------------------------------
SELECT
    student_id,
    AVG(marks) AS avg_marks
FROM Exams
GROUP BY student_id
ORDER BY avg_marks DESC
LIMIT 5;

-- ------------------------------------------------------------
-- 3. Average marks per subject
-- ------------------------------------------------------------
SELECT
    s.subject_name,
    AVG(e.marks) AS avg_marks
FROM Exams e
JOIN Subjects s ON e.subject_id = s.subject_id
GROUP BY s.subject_name;

-- ------------------------------------------------------------
-- 4. Rank students by average marks (window function: RANK)
-- ------------------------------------------------------------
SELECT
    student_id,
    AVG(marks) AS avg_marks,
    RANK() OVER (ORDER BY AVG(marks) DESC) AS student_rank
FROM Exams
GROUP BY student_id;

-- ------------------------------------------------------------
-- 5. Percentile rank of each student (window function: PERCENT_RANK)
-- ------------------------------------------------------------
SELECT
    student_id,
    AVG(marks) AS avg_marks,
    PERCENT_RANK() OVER (ORDER BY AVG(marks)) AS percentile_rank
FROM Exams
GROUP BY student_id;

-- ------------------------------------------------------------
-- 6. Bucket students into 5 performance groups (window function: NTILE)
--    and pull out the lowest-performing group
-- ------------------------------------------------------------
WITH StudentPerformance AS (
    SELECT
        student_id,
        AVG(marks) AS avg_marks,
        NTILE(5) OVER (ORDER BY AVG(marks)) AS performance_group
    FROM Exams
    GROUP BY student_id
)
SELECT *
FROM StudentPerformance
WHERE performance_group = 1;

-- ------------------------------------------------------------
-- 7. Average attendance of the bottom-performing group
--    (CTE + subquery combo — an early-warning indicator)
-- ------------------------------------------------------------
WITH BottomStudents AS (
    SELECT student_id
    FROM (
        SELECT
            student_id,
            NTILE(5) OVER (ORDER BY AVG(marks)) AS grp
        FROM Exams
        GROUP BY student_id
    ) x
    WHERE grp = 1
)
SELECT AVG(attendance_percent) AS bottom_group_avg_attendance
FROM Attendance
WHERE student_id IN (SELECT student_id FROM BottomStudents);

-- ------------------------------------------------------------
-- 8. Students who failed a subject (marks < 40)
-- ------------------------------------------------------------
SELECT
    student_id,
    COUNT(*) AS failed_subjects
FROM Exams
WHERE marks < 40
GROUP BY student_id;

-- ------------------------------------------------------------
-- 9. Number of subjects each student is enrolled in
-- ------------------------------------------------------------
SELECT
    student_id,
    COUNT(subject_id) AS subjects_taken
FROM Enrollments
GROUP BY student_id;

-- ------------------------------------------------------------
-- 10. Average marks per department
-- ------------------------------------------------------------
SELECT
    department,
    AVG(marks) AS dept_avg
FROM Students s
JOIN Exams e ON s.student_id = e.student_id
GROUP BY department;

-- ------------------------------------------------------------
-- 11. Combined attendance vs. marks per student
--     (useful for spotting attendance-performance correlation)
-- ------------------------------------------------------------
SELECT
    s.student_name,
    AVG(a.attendance_percent) AS attendance,
    AVG(e.marks) AS marks
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
JOIN Exams e ON s.student_id = e.student_id
GROUP BY s.student_name;

-- ------------------------------------------------------------
-- 12. Top student per semester (window function: RANK + PARTITION BY)
-- ------------------------------------------------------------
WITH RankedStudents AS (
    SELECT
        semester,
        student_name,
        AVG(marks) AS avg_marks,
        RANK() OVER (PARTITION BY semester ORDER BY AVG(marks) DESC) AS rank_no
    FROM Students s
    JOIN Exams e ON s.student_id = e.student_id
    GROUP BY semester, student_name
)
SELECT *
FROM RankedStudents
WHERE rank_no = 1;
