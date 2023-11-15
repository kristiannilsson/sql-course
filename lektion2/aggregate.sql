-- Summerar hur många produkter som har skickats varje orde
SELECT SUM(quantity)
FROM order_details;
-- Returnerar största värdet från unit_price, MIN() tar det minsta värdet
SELECT MAX(unit_price)
FROM order_details;
-- GROUP BY delar upp SUM() i per order.
-- Vi får nu SUM(quanity) per order.
SELECT order_id,
    SUM(quantity)
FROM order_details
GROUP BY order_id;
-- Du kan filtrera bort rader innan du summerar dem med WHERE
SELECT order_id,
    SUM(unit_price)
FROM order_details
WHERE unit_price > 250
GROUP BY order_id;
-- Om du vill filtrera resultatet efter du summerat använder du HAVING
SELECT order_id,
    SUM(unit_price * quantity)
FROM order_details
GROUP BY order_id
HAVING SUM(unit_price * quantity) > 100;
-- ROUND avrundar unit_price till heltal
SELECT order_id,
    ROUND(unit_price)
FROM order_details;
-- COALESCE() ger ett fallback-value. De som saknar region får istället NY.
SELECT first_name,
    COALESCE(region, 'NY')
FROM employees;
/*
 1. SUM() med GROUP BY
 2. COUNT()
 3. MAX(), MIN(), AVG()
 4. HAVING
 5. HAVING vs WHERE
 6. ROUND()
 7. COALESCE
 */