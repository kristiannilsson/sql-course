## Queries

a)

```
SELECT username, email, content
FROM users
JOIN messages ON users.username = messages.sender
WHERE receiver = 'admin' AND readtime IS NULL
ORDER BY sendtime;
```

b)

```
SELECT AVG(readtime ‐ sendtime)
FROM messages
WHERE readtime IS NOT NULL
```

c)

```
WITH ranked_messages AS(
    SELECT sender,
        receiver,
        COUNT(*) AS message_count, -- egentligen inte nödvändig, men hjälper att visualisera
        RANK() OVER (
            PARTITION BY sender
            ORDER BY COUNT(*) DESC
        ) as rnk
    FROM messages
    GROUP BY sender,
        receiver
)
SELECT sender,
    receiver
FROM ranked_messages
WHERE rnk = 1;
```

## Normalisering

a)
_update anomaly_ Exempelvis: Man kan uppdatera antalet credits på en kurs och databasen tillåter då konflikterande information.

_deletion anomaly_ Exempelvis: Om man tar bort alla betyg för kursen WD förlorar man information om hur många poäng den är på.

b)
student_id --> student_name

course_id --> credits

(student_id, course_id) --> grade


c)
students(\_student_id, student_name)

courses(\_course_id, credits)

grades(\_student_id, \_course_id, grade)


### Views, constraints och triggers
```
CREATE TABLE warehouses (address TEXT PRIMARY KEY);
CREATE TABLE shipment (
    warehouse TEXT
    item INT,
    quantity_change INT,
    time TIMESTAMP,
    PRIMARY KEY (warehouse, item, time), -- 5.
    FOREIGN KEY (warehouse) REFERENCES warehouses(adress) -- 4.
    CHECK quantity_change != 0 --6.
);
-- 2. Genom att ha denna som view säkerställer vi ett konsekvent lagersaldo
-- För full poäng på b räcker det med att endast ha skapat denna view.
-- 1. Med GROUP BY säkerställer man 1 också. Har man korrekt gjort en GROUP by
-- är det full poäng på 1.
CREATE VIEW inventory AS
SELECT warehouse,
    item,
    SUM(quantity_change) AS quantity
FROM shipment
GROUP BY warehouse,
    item;

-- 3. Pseudokod ger också full poäng.
CREATE OR REPLACE FUNCTION update_shipment_time()
RETURNS TRIGGER AS $$
BEGIN
    NEW.time = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_time
BEFORE UPDATE OF quantity_change ON shipment
FOR EACH ROW
EXECUTE FUNCTION update_shipment_time();
```

## ERD
Det spelar ingen roll om du sätter One-to-many eller One-or-zero-to-many då det beror på dina antaganden.
Det viktigaste är att du sätter rätt typ av relation (One-to-one, one-to-many eller kanske many-to-many) mellan varje tabell.
https://imgur.com/a/Sc8XjSB