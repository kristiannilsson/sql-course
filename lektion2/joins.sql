-- 1. INNER JOIN
-- https://www.w3schools.com/sql/sql_join_inner.asp
-- Inner join kombinerar två tabeller baserat på ett villkor.
-- I det här fallet slås rader samman där category_id från products är samma som category_id i categories.
SELECT *
FROM products
    INNER JOIN categories ON products.category_id = categories.category_id;
-- Nedan väljer vi också vilka kolumner vi vill ha. Oftast vill du inte ha alla kolumner i en sammanslagning.
SELECT product_name,
    category_name
FROM products
    INNER JOIN categories ON products.category_id = categories.category_id;
-- 2. LEFT JOIN
-- https://www.w3schools.com/sql/sql_join_left.asp
-- Om vi behöver behålla alla rader i den vänstra kolumnen kan vi använda LEFT JOIN.
-- Rader som inte matchas i högra tabellen fylls med NULL.
SELECT *
FROM products
    LEFT JOIN categories ON products.category_id = categories.category_id;
-- 3. NATURAL JOIN
-- https://www.w3resource.com/sql/joins/natural-join.php
-- NATURAL JOIN joinar på kolumner med samma namn i de båda tabellerna.
-- Problemet är att tabeller kan ha samma namn på två kolumner - utan att de har någonting att göra med varandra.
-- Exempelvis, om en tabell båda har kolumnen "name" kommer de att joinas med NATURAL JOIN.
SELECT *
FROM products
    NATURAL JOIN categories;
-- 4. USING
-- USING använder de bra grejerna från NATURAL JOIN. Här får du specifiera vilka kolumner som ska matchas i USING.
-- Mer koncist än att skriva ON. Kan bara joina tabeller med samma namn.
SELECT *
FROM products
    INNER JOIN categories USING(category_id);
-- Här joinar vi kolumner med olika namn.
SELECT *
FROM products
    LEFT JOIN categories ON products.category_id = categories.id;
-- 5. UNION
-- https://www.w3schools.com/sql/sql_union.asp
-- Med union kan vi slå ihop raderna i olika tabeller.
SELECT company_name,
    contact_name
FROM suppliers
UNION
SELECT company_name,
    contact_name
FROM customers;
-- Union tar bara med de unika raderna.
/*
 1. INNER JOIN Products och categories
 2. LEFT JOIN Orders och customers
 3. NATURAL JOIN - den minst naturliga joinen
 4. USING
 5. UNION customers och suppliers
*/