-- Skapar tabellen users med kolumnerna username och password.
-- users och password har datatypen TEXT.
CREATE TABLE users(username TEXT, password TEXT);
-- Sätter in värdena Kristian och 123 i users, 
-- värdena förekommer i samma ordning som kolumner
INSERT INTO users
VALUES ('Kristian', '123');
-- Vi tar bort tabellen users. Finns ingen undo.
DROP TABLE users;
CREATE TABLE users(
    username TEXT,
    password TEXT NOT NULL,
    -- password kan nu inte vara null
    PRIMARY KEY (username) --username blir nu primary key
);
INSERT INTO users
VALUES ('thomas', '123');
SELECT *
FROM employees;
-- Väljer alla rader från employees
-- stjärnan innebär att det är alla kolumner som väljs.
CREATE TABLE students(email TEXT, name TEXT, PRIMARY KEY (email));
CREATE TABLE courses(
    code TEXT,
    name TEXT,
    yh_points NUMERIC,
    PRIMARY KEY (code)
); --Numeric tillåter dig att ha decimaler, annars fungerar INTEGER bra.
CREATE TABLE grades(
    student TEXT,
    course TEXT,
    grade TEXT,
    PRIMARY KEY (student, course),
    FOREIGN KEY (student) REFERENCES students(email),
    FOREIGN KEY (course) REFERENCES courses(code)
);
/*
 students(_email_, name)
 courses(_code_, name, yh_points)
 grades(_student_, _course_, grade)
 student --> students.email
 course --> courses.code
 I grades finns det två primary keys då en student kan ha flera betyg.
 Men bara ett betyg i en kurs.
 
 1. skapa en table users (prata om casing)
 2. sätt in värden med INSERT INTO
 3. DROP TABLE users
 4. PRIMARY KEY
 5. NULLS och NOT NULL
 6. SELECT *
 7. FOREIGN KEY
 
 
 */