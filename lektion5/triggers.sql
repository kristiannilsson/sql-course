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

-- Vi ändrar logiken till att omfatta endast en uppdatering på telefonnummer.

-- Vi kör RETURN NULL för att förhindra en uppdatering
