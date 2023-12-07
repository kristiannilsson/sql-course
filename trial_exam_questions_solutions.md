# Exempellösningar på tentafrågor

## Queries

### 1

a)

```
SELECT student, SUM(COALESCE(filesize,0))
FROM submission LEFT JOIN submitted_file ON submission=idnr
GROUP BY student;
```

b)

```
-- alla inlämningar som har både movies.json och style.css
WITH correct_files AS (
    SELECT submission AS correct_submission
    FROM submittedfile
    WHERE filename = 'movies.json'
        OR filename = 'style.css'
    GROUP BY submission
    HAVING COUNT(*) >= 2
)
SELECT *
FROM submission
    LEFT JOIN correct_files ON correct_submission = idnr
WHERE correct_submission IS NULL --Filtrerar bort alla rader inlämningar som inte har båda filerna inlämnade
    AND course = "FWK22G_PLU"
    AND assignment = "Hemsida för filmer";
```

### 2

a)

```
SELECT username, email, COUNT(follower) AS total_followers
FROM users LEFT OUTER JOIN Follows ON username=follows
GROUP BY username, email
```

b)

```
SELECT f1.follower, f1.follows
FROM follows AS f1
LEFT JOIN follows AS f2 ON f1.follower = f2.follows AND f1.follows = f2.follower
WHERE f2.follower IS NULL;
```

c)

```
WITH peter_followers AS (
    SELECT follower AS follows_peter
    FROM follows
    WHERE follows = 'peter'
)
SELECT follower
FROM follows
    INNER JOIN peter_followers ON follows_peter = follows
UNION
SELECT follows_peter
FROM peter_followers;
```

## ER-diagram

### 1

https://imgur.com/a/Xuz1Zp7

Alla attribut i accessed är primary keys.

### 2

https://imgur.com/a/wsCp0k5

## Normalisering

### 1

| Patient_ID | Patient_Name | Patient_Address | Appointment_Date | Doctor_Name | Doctor_Specialization | Doctor_Phone |
| ---------- | ------------ | --------------- | ---------------- | ----------- | --------------------- | ------------ |
| 001        | John Doe     | 123 Oak St.     | 2023-01-15       | Dr. Smith   | Cardiology            | 555-0101     |
| 002        | Jane Smith   | 456 Maple Ave.  | 2023-01-20       | Dr. Jones   | Dermatology           | 555-0202     |
| 001        | John Doe     | 123 Oak St.     | 2023-02-10       | Dr. Smith   | Cardiology            | 555-0101     |

Studera tabellen ovan. Anta att läkarnas namn är unika.

a) Det finns en _update anomaly_ i att du kan uppdatera patientnamnet på en rad och på så sätt få konflikterande information.
Det finns en _deletion anomaly_ då om du tar bort bokningen för Jane Smith går hennes adress förlorad. Det finns även överflödig information i bland annat läkarens telefonnummer.

b) Hur skulle du förbättra strukturen?

Patients
| Patient_ID | Patient_Name | Patient_Address |
| ---------- | ------------ | --------------- |
| 001 | John Doe | 123 Oak St. |
| 002 | Jane Smith | 456 Maple Ave. |
| 001 | John Doe | 123 Oak St. |

Doctors
| Doctor_Name | Doctor_Specialization | Doctor_Phone |
| ----------- | --------------------- | ------------ |
| Dr. Smith | Cardiology | 555-0101 |
| Dr. Jones | Dermatology | 555-0202 |
| Dr. Smith | Cardiology | 555-0101 |

Appointments
| Patient_ID | Appointment_Date | Doctor_Name |
| ---------- | ---------------- | ----------- |
| 001 | 2023-01-15 | Dr. Smith |
| 002 | 2023-01-20 | Dr. Jones |
| 001 | 2023-02-10 | Dr. Smith |

### 2

a) _Deletion anomaly_: Om du har bort Jane Smith från tabellen kommer information om avdelningen Marketing att gå förlorad.
_Update anomaly_: Om du uppdaterar platsen för avdelningen sales på en rad får du motsägande information.

b) Name är beroende av EmployeedID. DepartmentLocation och DepartmentPhone är beroende av Department.

c) Vi gör oss av med beroenden som inte är beroende av hela nyckeln:

Employees
| EmployeeID | Name | Department |
|------------|-------------|--------------|
| 123 | John Doe | Sales |
| 456 | Jane Smith | Marketing |
| 789 | Alex Brown | Sales |

Departments
| Department | DepartmentLocation | DepartmentPhone |
|--------------|--------------------|-----------------|
| Sales | Building A | 555-0102 |
| Marketing | Building B | 555-0304 |
| Sales | Building A | 555-0102 |

## Views, Triggers och Constraints

### 1

```
CREATE TABLE customers(
    id INT PRIMARY KEY,
    -- Any numeric type is OK
    name TEXT,
    is_private BOOLEAN,
    UNIQUE (id, is_private) -- c - Not needed for full points
);
CREATE TABLE subscriptions (
    number INT PRIMARY KEY,
    customer INT,
    is_private BOOLEAN,
    -- c
    plan TEXT,
    fee INT,
    balance INT,
    FOREIGN KEY (customer, is_private) -- c
    REFERENCES Customers(id, is_private) ON DELETE CASCADE,
    -- e
    CHECK (plan IN ('prepaid', 'corporate', 'flatrate')),
    -- a
    CHECK (
        plan = 'prepaid'
        OR balance = 0
    ),
    -- b
    CHECK (
        plan != 'corporate'
        OR NOT is_private
    ),
    -- c
    CHECK (fee >= 0) -- d
);
CREATE VIEW customer_view AS -- d
SELECT id,
    name,
    customers.is_private,
    SUM(fee)
FROM Customers
    JOIN Subscriptions ON id = customer
GROUP BY id,
    name,
    Customers.is_private;
CREATE FUNCTION deleteEmpty() RETURNS trigger AS $$ BEGIN IF NOT EXISTS (
    SELECT *
    FROM Subscriptions
    WHERE customer = OLD.customer
) THEN
DELETE FROM Customers
WHERE id = OLD.customer;
END IF;
RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER deleteEmpty -- f
AFTER DELETE ON Subscriptions FOR EACH ROW EXECUTE PROCEDURE deleteEmpty();
```

### 2

```
CREATE TABLE registration (
    student TEXT,
    course TEXT,
    PRIMARY KEY (student, course)
);
CREATE TABLE assignment (
    course TEXT,
    name TEXT,
    description TEXT,
    deadline TIMESTAMP,
    PRIMARY KEY (course, name)
);
CREATE TABLE submission (
    idnr SERIAL PRIMARY KEY --a),
    student TEXT,
    course TEXT,
    assignment TEXT,
    stime INT,
    FOREIGN KEY (course, assignment) REFERENCES Assignment(course, name),
    FOREIGN KEY (course, student) REFERENCES Registration(course, student) -- b) ,
    UNIQUE (student, stime) -- f)
);
CREATE TABLE submitted_fileTable (
    submission INT,
    filename TEXT,
    contents TEXT,
    FOREIGN KEY (submission) REFERENCES Submission ON DELETE CASCADE -- d),
    PRIMARY KEY (submission, filename)
);
CREATE VIEW submitted_file AS
SELECT *,
    length(contents) AS filesize
FROM submitted_fileTable;
CREATE FUNCTION update_submission_timestamp() RETURNS trigger AS $$ BEGIN NEW.submission_time = NOW() RETURN NEW
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER deleteEmpty -- e
BEFORE
UPDATE ON Subscriptions FOR EACH ROW EXECUTE PROCEDURE update_submission_timestamp();
```
