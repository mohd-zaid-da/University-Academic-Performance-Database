# University Student Performance Database

A MySQL project analyzing student academic performance using joins, CTEs, and
window functions (`RANK`, `PERCENT_RANK`, `NTILE`) to identify top performers,
at-risk students, and attendance-performance correlation.

## Schema

5 tables with foreign key relationships:

- **Students** — student_id, name, gender, department, semester, admission_year
- **Subjects** — subject_id, subject_name, credits
- **Enrollments** — links students to subjects
- **Attendance** — attendance % per student per subject
- **Exams** — marks scored per student per subject, with exam date

## Files

| File | Description |
|---|---|
| `schema.sql` | Table definitions with primary/foreign keys |
| `seed_data.sql` | Sample data (5 students, 4 subjects) |
| `queries.sql` | 12 analysis queries, from basic aggregation to window functions |

## How to run

```bash
mysql -u root -p < schema.sql
mysql -u root -p < seed_data.sql
mysql -u root -p universitydb < queries.sql
```

## Key queries

- **Performance ranking** — `RANK()` and `PERCENT_RANK()` to rank students by average marks
- **Risk segmentation** — `NTILE(5)` to bucket students into performance quintiles, then a CTE to flag the bottom group
- **Attendance correlation** — joins attendance against exam marks to check whether low attendance tracks with low scores
- **Department & semester breakdowns** — average marks by department; top student per semester via `PARTITION BY`

## Sample insight

In this dataset, the lowest-performing quintile of students also had the
lowest average attendance (60%), versus 90%+ attendance among top performers
— a basic but real early-warning signal worth tracking at scale.

## Tech stack

MySQL 8.0
