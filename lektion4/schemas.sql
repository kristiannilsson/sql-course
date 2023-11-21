-- SCHEMAS
-- https://www.postgresql.org/docs/current/sql-createschema.html
-- Skapar en ny tabell i public. Detta för att public ligger i search_path per default.
CREATE TABLE users (username TEXT, password TEXT) -- Skapar ett nytt schema auth. Här kan vi lägga nya tabeller.
CREATE SCHEMA auth;
-- Skapar en ny table i schemat auth. När du skriver auth.users kallas det ett okvalificerat namn.
CREATE TABLE auth.users (username TEXT, password TEXT);
-- Här visar du search_path. Just nu är den $user$ och public.
-- Det betyder att databasen letar i public och $user$ om du inte anger ett schema i din query.
-- $user$ är schemat med samma namn som din användare (i ert fall postgres)
SHOW search_path;
-- Nu sätts search_path till auth för din session.
SET search_path TO auth;
-- Nu kommer den här ge ett error.
SELECT *
FROM courses;
-- Sätter default search_path, en session kan överskriva denna.
ALTER DATABASE postgres
SET search_path TO auth;
-- check ger en constraint på ditt värde. Pengar måste vara mer än 0
CREATE TABLE player_money(
    username TEXT,
    "money" INTEGER,
    CHECK (money > 0)
);
-- Ger fel
INSERT INTO player_money
VALUES ('kristian', -1);
-- UNIQUE säkerställer att värdet i kolumnen är unikt - även om det inte är en primary key
CREATE TABLE student_info (id TEXT PRIMARY KEY, email TEXT UNIQUE);
INSERT INTO student_info
VALUES (1, '123@example.com')
INSERT INTO student_info
VALUES (2, '123@example.com')
    /*
     1. CHECK
     2. UNIQUE
     3. schemas (CREATE SCHEMA, DROP SCHEMA CASCADE)
     4. qualified names
     5. SHOW search_path;
     6. SET search_path TO 
     7. ALTER DATABASE <database_name> SET search_path TO schema1,schema2;
     */