CREATE TABLE users (username TEXT PRIMARY KEY, password TEXT);
INSERT INTO users
VALUES ('kristian', '123');
DROP TABLE users;
CREATE TABLE students (email TEXT, name TEXT, PRIMARY KEY (email));
INSERT INTO students
VALUES ('kristian.nilsson@consid.se', 'kristian');
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
CREATE TABLE grades (
    student TEXT REFERENCES students(email),
    course TEXT,
    grade TEXT,
    PRIMARY KEY (student, course)
)
DROP TABLE grades;
INSERT INTO grades
VALUES (
        'kristian.nilsson@consid.se',
        'dev23m_pp',
        'vg'
    )
SELECT * FROM grades;
    /*
     students(_email_, name)
     courses(_code_, name, yh_points)
     grades(_student_, _course_, grade)
     student --> students.email
     course --> courses.code
     
     1. skapa en table users (prata om casing)
     2. sätt in värden med INSERT INTO
     3. DROP TABLE users
     4. PRIMARY KEY
     5. NULLS och NOT NULL
     6. SELECT *
     7. FOREIGN KEY
     
     
     */