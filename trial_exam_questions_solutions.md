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
| 001        | John Doe     | 123 Oak St.     |
| 002        | Jane Smith   | 456 Maple Ave.  |
| 001        | John Doe     | 123 Oak St.     |

Doctors
| Doctor_Name | Doctor_Specialization | Doctor_Phone |
| ----------- | --------------------- | ------------ |
| Dr. Smith   | Cardiology            | 555-0101     |
| Dr. Jones   | Dermatology           | 555-0202     |
| Dr. Smith   | Cardiology            | 555-0101     |

Appointments
| Patient_ID | Appointment_Date | Doctor_Name |
| ---------- | ---------------- | ----------- |
| 001        | 2023-01-15       | Dr. Smith   |
| 002        | 2023-01-20       | Dr. Jones   |
| 001        | 2023-02-10       | Dr. Smith   |