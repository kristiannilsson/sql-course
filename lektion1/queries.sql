-- * väljer alla kolumner
SELECT *
FROM employees;

-- välja specifika kolumner
SELECT first_name,
    last_name,
    salary
FROM employees;

-- väljer baserad på villkoret i WHERE
-- lön under 7000 OCH job_id ska vara 9
-- sorterar sedan på first_name
SELECT *
FROM employees
WHERE salary < 7000
    AND job_id = 9
ORDER BY first_name;

-- skapar en view som du kan kolla på senare.
CREATE VIEW monthly_salary AS (
    SELECT first_name,
        last_name,
        salary * 12 AS yearly_salary
    FROM employees
);
-- du kan nu behandla viewen som en tabell.
SELECT * FROM monthly_salary;

-- IS NULL väljer alla nullvärden.
SELECT * FROM employees WHERE phone_number IS NULL;

-- DISTINCT väljer alla unika rader.
SELECT DISTINCT job_id FROM employees ORDER BY job_id;

-- LIKE matchar en sträng delvis. Här matchar vi alla strängar som börjar på S.
SELECT * FROM employees WHERE first_name LIKE 'S%';

-- Jämföra datum
SELECT * FROM employees WHERE hire_date > '1998-02-27';

/*
 1. SELECT *
 2. SELECT olika kolumner
 3. WHERE
 4. AND OR
 5. AS
 6. ORDER BY
 7. IS NOT NULL
 8. DISTINCT
 9. LIKE
 10. VIEW
*/