SELECT *
FROM employees;

SELECT first_name,
    last_name,
    salary
FROM employees;

SELECT *
FROM employees
WHERE salary < 7000
    AND job_id = 9
ORDER BY first_name;

CREATE VIEW monthly_salary AS (
    SELECT first_name,
        last_name,
        salary * 12 AS yearly_salary
    FROM employees
);

SELECT * FROM monthly_salary;

SELECT * FROM employees WHERE phone_number IS NULL;

SELECT DISTINCT job_id FROM employees ORDER BY job_id;

SELECT * FROM employees WHERE first_name LIKE 'S%';

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