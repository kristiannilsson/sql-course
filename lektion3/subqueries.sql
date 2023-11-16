-- DROP TABLE my_table CASCADE tar bort tabellen och alla beroenden.
-- 1. DELETE
-- https://www.w3schools.com/sql/sql_delete.asp
-- Tar bort rader baserat på ett villkor.
DELETE FROM employees
WHERE employee_id = 103;
-- Kan inte ta bort rader som andra tabeller är beroende av
DELETE FROM products
WHERE product_id = 22;
-- 2. UPDATE
-- https://www.w3schools.com/sql/sql_update.asp
-- UPDATE ändrar värdet i en rad beroende på ett villkor
UPDATE employees
SET phone_number = '123-123-123' -- SET anger vilken kolumn som ska ändras
WHERE first_name = 'Lex';
-- Ett exempel till där vi uppdaterar från ett gammalt telefonnummer.
UPDATE employees
SET phone_number = '123-123-123'
WHERE phone_number = '515.123.4569';
-- 3. WITH
-- https://www.geeksforgeeks.org/sql-with-clause/
-- WITH sparar temporärt en view i databasen.
-- Användbart om du endast behöver en tabell under runtime.
WITH highly_paid_employees AS (
    SELECT *
    FROM employees
    WHERE salary > 8000
)
SELECT *
FROM highly_paid_employees;
-- Subqueries
-- https://www.w3resource.com/sql/subqueries/understanding-sql-subqueries.php
-- Vi börjar med att välja det genomsnittliga värdet på databasen, bara för att visa.
SELECT AVG(salary)
FROM employees;
-- Eftersom ovanstående query endast returnerar ett enda värde kan den användas i en WHERE.
SELECT *
FROM employees
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
    );
-- 4. Window-functions
-- https://mode.com/sql-tutorial/sql-window-functions/
-- Windowfunctions är funktioner som använder information från andra rader än sin egen.
-- RANK() exempelvis rangordnar raden baserat på ett villkor som specifieras i OVER().
-- Här har vi ORDER BY som villkor för rangordningen.
SELECT first_name,
    last_name,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    )
FROM employees;
-- Här rangordnar vi på ett annat villkor.
SELECT first_name,
    last_name,
    salary,
    RANK() OVER (
        ORDER BY first_name DESC
    )
FROM employees;
-- Med PARTITION BY kan vi skapa en rangordning per department_id.
SELECT first_name,
    last_name,
    salary,
    department_id,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_ranking
FROM employees;

-- LIMIT kan användas för att begränsa antalet rader som en query returnerar.
SELECT *
FROM employees
LIMIT 10;
/*
 1. DELETE
 2. UPDATE
 3. subqueries WITH
 4. RANK() med ORDER BY och PARTITION BY
 */