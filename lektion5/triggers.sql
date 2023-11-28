-- Lägger till en ny kolumn i employees
ALTER TABLE employees
ADD updated_on TIMESTAMP;
-- Uppdaterar alla värden i kolumnen
UPDATE employees
SET updated_on = NOW()
WHERE TRUE;

/* Syntax för en trigger
 CREATE TRIGGER trigger_name 
 {BEFORE | AFTER} { event }
 ON table_name
 [FOR [EACH] { ROW | STATEMENT }]
 EXECUTE PROCEDURE trigger_function 
 */
CREATE TRIGGER update_employee_timestamp_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE PROCEDURE update_employee_timestamp()

-- Trigger kan skapas på UPDATE, DELETE eller INSERT

/* Syntax för en funktion 
 CREATE FUNCTION trigger_function() 
 RETURNS TRIGGER 
 LANGUAGE PLPGSQL
 AS $$
 BEGIN
 -- trigger logic
 END;
 $$*/
-- Vi skapar nu en funktion som uppdaterar updated_on
CREATE OR REPLACE FUNCTION update_employee_timestamp()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
    NEW.updated_on = NOW();
    RETURN NEW;
END;
$$

-- Vi kör RETURN NULL för att förhindra en uppdatering
CREATE OR REPLACE FUNCTION update_employee_timestamp()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
    RETURN NULL;
END;
$$
-- Vi ändrar logiken till att omfatta endast en uppdatering på telefonnummer.
CREATE OR REPLACE FUNCTION update_employee_timestamp()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
    IF OLD.phone_number != NEW.phone_number THEN
        NEW.updated_on = NOW();
        RETURN NEW;
    END IF;
    RETURN NEW;
END;
$$

UPDATE employees
SET salary = 20000
WHERE first_name = 'Michael';