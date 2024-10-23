-- Creating the university_db database
CREATE DATABASE university_db;

-- Creating the students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(20)
);

-- Creating the courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER
);

-- Creating the enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);

-- Inserting sample data into the students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
    ('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
    ('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
    ('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
    ('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
    ('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
    ('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- Inserting sample data into the courses table
INSERT INTO courses (course_name, credits)
VALUES
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- Inserting sample data into the enrollment table
INSERT INTO enrollment (student_id, course_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

-- Query 1: Insert a new student record
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Shaimon', 22, 'alshaimon152@gmail.com', 78, 80, NULL);

-- Query 2: Retrieve names of students enrolled in 'Next.js' course
SELECT DISTINCT student.student_name
FROM students student
JOIN enrollment enrollment ON student.student_id = enrollment.student_id
JOIN courses course ON enrollment.course_id = course.course_id
WHERE course.course_name = 'Next.js';

-- Query 3: Update status of student with highest total mark to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- Query 4: Delete courses with no enrolled students
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollment
);

-- Query 5: Retrieve student names with LIMIT and OFFSET
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve course names and number of enrolled students
SELECT course.course_name, COUNT(enrollment.student_id) AS students_enrolled
FROM courses course
LEFT JOIN enrollment enrollment ON course.course_id = enrollment.course_id
GROUP BY course.course_name;

-- Query 7: Calculate and display average age of all students
SELECT ROUND(AVG(age)::numeric, 2) AS average_age
FROM students;

-- Query 8: Retrieve names of students with 'example.com' in their email
SELECT student_name
FROM students
WHERE email LIKE '%example.com';
