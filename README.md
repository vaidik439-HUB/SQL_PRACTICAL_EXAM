# SQL_PRACTICAL_EXAM
# Student Performance Management System

## 📌 Project Overview

The **Student Performance Management System** is a MySQL database project designed to manage student information, departments, faculty, courses, enrollments, attendance, and academic grades.

This project demonstrates essential SQL concepts, including database creation, table relationships, data manipulation, joins, subqueries, aggregate functions, date functions, string functions, and conditional statements.

## 🎯 Objectives

- Manage student and faculty records.
- Organize departments and courses.
- Track student enrollments and attendance.
- Store and analyze student grades.
- Identify students with low attendance or marks.
- Generate department-wise and course-wise reports.
- Practice SQL queries for real-world database management.

## 🛠️ Technologies Used

- **Database:** MySQL
- **Language:** SQL
- **Concepts:** DDL, DML, DQL, Joins, Subqueries, Aggregate Functions, Date Functions, String Functions, and CASE Statements.

## 🗂️ Database Structure

The database name is `student_performance_db`.

It contains the following seven tables:

| Table | Description |
|---|---|
| `Departments` | Stores department information. |
| `Students` | Stores student details and admission information. |
| `Faculty` | Stores faculty details and experience. |
| `Courses` | Stores course information and assigned faculty. |
| `Enrollments` | Records student course enrollments. |
| `Attendance` | Tracks attendance status and dates. |
| `Grades` | Stores student marks for courses. |

## 🔗 Database Relationships

- A department can have multiple students.
- A department can have multiple faculty members.
- A faculty member can teach multiple courses.
- Students can enroll in multiple courses.
- Courses can have multiple enrolled students.
- Students can have multiple attendance records.
- Students can receive grades for different courses.

### Entity Relationship Overview

```text
Departments
    |
    |---- Students
    |
    |---- Faculty
              |
              |---- Courses
                        |
                        |---- Enrollments ---- Students
                        |
                        |---- Attendance ----- Students
                        |
                        |---- Grades --------- Students
````

## ✨ Features

### 1. Student Management

* Add student records.

* Update contact information.

* Delete student records.

* Display students alphabetically.

* Find students by department.

### 2. Faculty and Course Management

* Maintain faculty information.

* Assign faculty members to courses.

* Identify faculty members without assigned courses.

* Find courses taught by experienced faculty.

### 3. Enrollment Management

* Record student course enrollments.

* Prevent duplicate enrollment in the same course.

* Identify students who are not enrolled in any course.

### 4. Attendance Analysis

* Store Present, Absent, and Late attendance statuses.

* Calculate attendance percentages.

* Identify students with attendance below 75%.

* Categorize students based on attendance performance.

* Calculate average attendance across students.

### 5. Grade Analysis

* Store marks obtained by students.

* Display students ranked by marks.

* Calculate average marks for each course.

* Identify maximum and minimum marks.

* Classify student performance using conditional statements.

### 6. Reporting and Analytics

* Count students in each department.

* Display course and faculty information.

* Find students scoring above the overall average.

* Identify students with both low attendance and low marks.

* Generate reports using SQL joins and subqueries.

## 🧠 SQL Concepts Demonstrated

| SQL Concept         | Purpose                                                            |
| ------------------- | ------------------------------------------------------------------ |
| `CREATE DATABASE`   | Creates the database.                                              |
| `CREATE TABLE`      | Defines database tables.                                           |
| `INSERT INTO`       | Adds records.                                                      |
| `UPDATE`            | Modifies existing records.                                         |
| `DELETE`            | Removes records.                                                   |
| `SELECT`            | Retrieves information.                                             |
| `WHERE`             | Filters records.                                                   |
| `ORDER BY`          | Sorts results.                                                     |
| `GROUP BY`          | Groups records for analysis.                                       |
| `HAVING`            | Filters grouped results.                                           |
| `INNER JOIN`        | Retrieves matching records.                                        |
| `LEFT JOIN`         | Includes all records from the left table.                          |
| `RIGHT JOIN`        | Includes all records from the right table.                         |
| `UNION`             | Combines query results.                                            |
| Subqueries          | Uses one query inside another.                                     |
| Aggregate Functions | Uses `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`.            |
| Date Functions      | Uses `MONTH()`, `MONTHNAME()`, `CURDATE()`, and `TIMESTAMPDIFF()`. |
| String Functions    | Uses `UPPER()` and `TRIM()`.                                       |
| `COALESCE()`        | Handles missing values.                                            |
| `CASE`              | Categorizes performance and attendance.                            |

## 🚀 How to Run the Project

1. Install MySQL Server and a MySQL client, such as MySQL Workbench.

2. Open the SQL project file.

3. Execute the database creation and table creation statements.

4. Insert the sample records.

5. Execute the update and delete statements.

6. Run the SELECT queries to view reports and analyze results.

Note: Execute the SQL statements in the provided order because some queries depend on tables and sample data created earlier in the script.

## 📊 Sample Analysis

The project can answer questions such as:

* Which students belong to the Computer Science department?

* Who are the top-performing students?

* Which students have attendance below 75%?

* Which courses have the highest average marks?

* Which faculty members are not assigned to any course?

* Which students have no enrollments?

* What is the average attendance percentage?

* Which students need academic improvement?

## 🎓 Learning Outcomes

After completing this project, students can understand:

* Relational database design.

* Primary keys and foreign keys.

* Referential integrity and cascading operations.

* CRUD operations.

* SQL joins and subqueries.

* Aggregate calculations and grouping.

* Conditional logic and data categorization.

* Academic data reporting and analysis.

## 🔮 Future Enhancements

* Develop a web-based dashboard.

* Add student and faculty login systems.

* Create automated report generation.

* Introduce semester-wise grade tracking.

* Add course-wise attendance summaries.

* Build graphical performance analytics.

* Integrate Python for advanced data analysis.

## 👨‍💻 Project Information

* Project Name: Student Performance Management System

* Domain: Database Management System (DBMS)

* Database: MySQL

* Project Type: Academic SQL Project

* Purpose: Learning and demonstrating relational database operations.

## 📄 Conclusion

The Student Performance Management System provides a structured way to manage and analyze academic information using MySQL. It combines student records, departments, faculty, courses, attendance, and grades in a relational database.

The project offers practical experience with SQL fundamentals and intermediate querying techniques while demonstrating how databases can support academic administration and student performance analysis.

If you find this project useful, consider giving the repository a ⭐ on GitHub.
