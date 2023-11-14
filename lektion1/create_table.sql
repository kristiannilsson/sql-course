CREATE TABLE users(username TEXT, password TEXT);
INSERT INTO users
VALUES ('Kristian', '123');
DROP TABLE users;
CREATE TABLE users(
    username TEXT,
    password TEXT NOT NULL,
    PRIMARY KEY (username)
);

INSERT INTO users VALUES ('thomas', '123');

SELECT * FROM employees;
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