CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255),
    department_id INT,
    admission_date DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL
);

CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    experience_years INT DEFAULT 0,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL
);

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id) ON DELETE SET NULL
);

CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

INSERT INTO Departments (department_name) VALUES
('Computer Science'),
('Information Technology'),
('Mechanical Engineering');

INSERT INTO Faculty (name, email, phone_number, experience_years, department_id) VALUES
('Dr. Alan Turing', 'alan@univ.edu', '9876543210', 8, 1),
('Prof. Ada Lovelace', 'ada@univ.edu', '9876543211', 3, 1),
('Dr. John von Neumann', 'john@univ.edu', NULL, 10, 2),
('Prof. Unassigned Faculty', NULL, '9876543213', 2, 3);

INSERT INTO Students (name, dob, gender, email, phone_number, address, department_id, admission_date) VALUES
('Alice Johnson', '2002-05-14', 'Female', 'alice@mail.com', '9123456780', '123 Main St', 1, '2021-08-01'),
('Bob Smith', '2001-11-20', 'Male', NULL, '9123456781', '456 Oak St', 1, '2020-08-01'),
('Charlie Brown', '2003-01-10', 'Male', 'charlie@mail.com', '9123456782', '789 Pine St', 2, '2022-08-01'),
('David Miller', '2002-09-15', 'Male', 'david@mail.com', '9123456783', '321 Maple St', 1, '2021-08-01'),
('Eva Green', '2001-03-30', 'Female', NULL, '9123456784', '654 Elm St', NULL, '2023-08-01');

INSERT INTO Courses (course_name, faculty_id) VALUES
('Database Systems', 1),
('Algorithms', 2),
('Web Development', 3),
('Quantum Computing', NULL);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2021-08-10'),
(1, 2, '2021-08-10'),
(2, 1, '2020-08-10'),
(3, 3, '2022-08-10'),
(4, 1, '2021-08-10');

INSERT INTO Attendance (student_id, course_id, attendance_date, status) VALUES
(1, 1, '2024-09-01', 'Present'),
(1, 1, '2024-09-02', 'Present'),
(1, 1, '2024-09-03', 'Present'),
(2, 1, '2024-09-01', 'Absent'),
(2, 1, '2024-09-02', 'Absent'),
(3, 3, '2024-09-01', 'Present'),
(4, 1, '2024-09-01', 'Absent');

INSERT INTO Grades (student_id, course_id, marks_obtained) VALUES
(1, 1, 95.50),
(1, 2, 88.00),
(2, 1, 45.00),
(3, 3, 78.50),
(4, 1, 92.00);

INSERT INTO Students (name, dob, gender, email, phone_number, address, department_id, admission_date)
VALUES ('Frank Wright', '2002-12-05', 'Male', 'frank@mail.com', '9123456785', '999 Cedar St', 1, '2021-08-01');

INSERT INTO Faculty (name, email, phone_number, experience_years, department_id)
VALUES ('Dr. Grace Hopper', 'grace@univ.edu', '9876543214', 12, 1);

INSERT INTO Courses (course_name, faculty_id)
VALUES ('Operating Systems', 5);

INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (6, 5, '2021-08-10');

UPDATE Students 
SET phone_number = '9998887770', email = 'alice_new@mail.com' 
WHERE student_id = 1;

DELETE FROM Students 
WHERE student_id = 5;

SELECT s.* 
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

SELECT s.student_id, s.name, g.marks_obtained 
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
ORDER BY g.marks_obtained DESC
LIMIT 10;

SELECT s.student_id, s.name, 
       (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)) AS attendance_percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name
HAVING attendance_percentage < 75;

SELECT DISTINCT s.student_id, s.name 
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
JOIN (
    SELECT student_id, 
           (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(attendance_id)) AS att_pct
    FROM Attendance
    GROUP BY student_id
) att ON s.student_id = att.student_id
WHERE att.att_pct < 50 AND g.marks_obtained < 50;

SELECT DISTINCT s.student_id, s.name 
FROM Students s
LEFT JOIN Grades g ON s.student_id = g.student_id
LEFT JOIN (
    SELECT student_id, 
           (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(attendance_id)) AS att_pct
    FROM Attendance
    GROUP BY student_id
) att ON s.student_id = att.student_id
WHERE g.marks_obtained > 90 OR att.att_pct = 100;

SELECT f.* 
FROM Faculty f
LEFT JOIN Courses c ON f.faculty_id = c.faculty_id
WHERE c.course_id IS NULL;

SELECT * FROM Students 
ORDER BY name ASC;

SELECT d.department_name, COUNT(s.student_id) AS student_count
FROM Departments d
LEFT JOIN Students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;

SELECT c.course_name, AVG(g.marks_obtained) AS avg_marks
FROM Courses c
JOIN Grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name;

SELECT AVG(att_pct) AS overall_avg_attendance
FROM (
    SELECT student_id, 
           (SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(attendance_id)) AS att_pct
    FROM Attendance
    GROUP BY student_id
) AS student_att;

SELECT c.course_name, 
       MAX(g.marks_obtained) AS max_marks, 
       MIN(g.marks_obtained) AS min_marks
FROM Courses c
JOIN Grades g ON c.course_id = g.course_id
GROUP BY c.course_id, c.course_name;

SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Departments d
LEFT JOIN Students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;

SELECT c.course_name, f.name AS faculty_name 
FROM Courses c
JOIN Faculty f ON c.faculty_id = f.faculty_id;

SELECT s.student_id, s.name AS student_name, d.department_name
FROM Students s
INNER JOIN Departments d ON s.department_id = d.department_id;

SELECT s.student_id, s.name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

SELECT c.course_id, c.course_name
FROM Faculty f
RIGHT JOIN Courses c ON f.faculty_id = c.faculty_id
WHERE f.faculty_id IS NULL;

SELECT s.student_id, s.name, g.grade_id
FROM Students s
LEFT JOIN Grades g ON s.student_id = g.student_id
WHERE g.grade_id IS NULL
UNION
SELECT s.student_id, s.name, g.grade_id
FROM Students s
RIGHT JOIN Grades g ON s.student_id = g.student_id
WHERE s.student_id IS NULL;

SELECT DISTINCT s.student_id, s.name, g.marks_obtained
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
WHERE g.marks_obtained > (SELECT AVG(marks_obtained) FROM Grades);

SELECT course_name 
FROM Courses 
WHERE faculty_id IN (
    SELECT faculty_id 
    FROM Faculty 
    WHERE experience_years >= 5
);

SELECT student_id, name 
FROM Students 
WHERE student_id IN (
    SELECT student_id 
    FROM Attendance 
    WHERE status = 'Absent' 
    GROUP BY student_id 
    HAVING COUNT(attendance_id) > 10
);

SELECT attendance_id, attendance_date, 
       MONTH(attendance_date) AS attendance_month, 
       MONTHNAME(attendance_date) AS month_name 
FROM Attendance;

SELECT student_id, name, admission_date, 
       TIMESTAMPDIFF(YEAR, admission_date, CURDATE()) AS years_since_admission 
FROM Students;

SELECT attendance_id, 
       DATE_FORMAT(attendance_date, '%d-%m-%Y') AS formatted_attendance_date 
FROM Attendance;

SELECT faculty_id, UPPER(name) AS upper_faculty_name 
FROM Faculty;

SELECT student_id, TRIM(name) AS trimmed_student_name 
FROM Students;

SELECT student_id, name, 
       COALESCE(email, 'Email Not Provided') AS email_status 
FROM Students;

SELECT s.student_id, s.name, g.marks_obtained,
       CASE 
           WHEN g.marks_obtained > 90 THEN 'Excellent'
           WHEN g.marks_obtained BETWEEN 75 AND 90 THEN 'Good'
           ELSE 'Needs Improvement'
       END AS performance_level
FROM Students s
JOIN Grades g ON s.student_id = g.student_id;

SELECT s.student_id, s.name,
       (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)) AS attendance_percentage,
       CASE 
           WHEN (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)) > 80 THEN 'Regular'
           WHEN (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)) BETWEEN 50 AND 80 THEN 'Irregular'
           ELSE 'Defaulter'
       END AS attendance_category
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name;
