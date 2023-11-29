# Exempel på tentafrågor

## Queries

### 1

Nedan finner du ett schema för att hantera inlämningar i LearnPoint.

```
assignment(_course_, _name_, description, deadline)
submission(_id_, student, course, assignment, submission_time)
    (course, assignment) --> assignment.(course, name)
submitted_file(_submission_, _name_, size)
    submission --> submission.id
```

`assignment` har en kurskod, ett namn på inlämingsuppgiften, en beskrivning och en deadline som är ett timestamp.

`submission` har ett unikt id, ett id-nr till en student, en kurs som inlämningen hör till, och en timestamp när uppgiften lämnades in.

`submitted_file` beskriver inlämnade filer. Det finns ett id som kopplar den inlämnade filen till en specifik inlämning, ett filnamn och en storlek på filen.

Så här kan det exempelvis se ut:

| course      | name                     | description | deadline |
| ----------- | ------------------------ | ----------- | -------- |
| DEV23M_PP   | Konstruktion av API      | ...         | 1000     |
| FWK22G_PLU  | Hemsida för filmer       | ...         | 1200     |
| AIDEV21S_PP | Machine-learning med KNN | ...         | 1500     |

| id  | student | course     | assignment          | submission_time |
| --- | ------- | ---------- | ------------------- | --------------- |
| 0   | s1      | DEV23M_PP  | Konstruktion av API | 1000            |
| 1   | s2      | FWK22G_PLU | Hemsida för filmer  | 1200            |
| 2   | s1      | DEV23M_PP  | Konstruktion av API | 1400            |

| submission | name       | size |
| ---------- | ---------- | ---- |
| 0          | tasks.json | 999  |
| 0          | app.py     | 1337 |
| 1          | index.html | 1600 |
| 2          | tasks.json | 1000 |

a) Skriv en query som beräknar den totala storleken på filer som en student gjort över alla sina inlämningar. Student 1 har lämnat in filer med storleken 999 + 1337 + 1000. Student 2 har lämnat in filer i storleken 1600.

b) Hitta alla inlämningar till "Hemsida för filmer" i kursen FWK22G_PLU som saknar minst en av `movies.json` eller `style.css`.

### 2

Below is the schema for a database of users. Users can follow other users (and choose if they
should receive notifications of that users activity or not).

users(**username**, email)

follows(**follower**, **follows**, notifications)
follower --> users.username
follows --> users.username

a) Write an SQL query that lists the number of followers each user has. The result should
have three columns: username, email and total_followers. For full score, every user must be
in the result exactly once.

Hint: COUNT(X) will not count rows where column x is null.

b) Write an SQL query for finding all pairs of usernames A and B, where A follows B, but B
does not follow A.

c) Write an SQL query for finding the usernames of all followers of the user with username
'peter', and all followers of those followers (no duplicates).

Hint: Use WITH

## ER-diagram

### 1

Övningsuppgift på engelska i samma svårighetsgrad som på tentan:

Your task is to make an ER-diagram for the database of a gym company, managing their
facilities and their customer records.

The database should contain a set of current and past customers. Each customer has a name
and an email-address. Not every customer is a current member, and the database should keep
track of which customers are currently members, and when their membership expires.

Each gym facility has a city, an address and a name. Two facilities can have the same name,
but only if they are in different cities. Gym facilities can be established in any city across the
world (but you can assume cities have unique names).

The database should also keep a record of times when each customer has accessed any gym
facility. This may include multiple accesses from the same customer to the same facility at
different times.

### 2

Make an ER-diagram for a web application where users can register, join interest groups,
and post messages to these groups.

Users have unique user names, and groups have unique names. Users can be members of any
number of groups. The time each user joined a group should be recorded. Each group has an
owner, which is a user. Each post is posted in a group by a user. Posts contain text. Posts
are identified by their timestamp and the username of the user posting it. There is also a
special kind of post called a group link, these contain a link to a group in addition to the
normal parts of a post.

## Normalisering

### 1

| Patient_ID | Patient_Name | Patient_Address | Appointment_Date | Doctor_Name | Doctor_Specialization | Doctor_Phone |
| ---------- | ------------ | --------------- | ---------------- | ----------- | --------------------- | ------------ |
| 001        | John Doe     | 123 Oak St.     | 2023-01-15       | Dr. Smith   | Cardiology            | 555-0101     |
| 002        | Jane Smith   | 456 Maple Ave.  | 2023-01-20       | Dr. Jones   | Dermatology           | 555-0202     |
| 001        | John Doe     | 123 Oak St.     | 2023-02-10       | Dr. Smith   | Cardiology            | 555-0101     |

Studera tabellen ovan.

a) Vad för problem kan uppstå med strukturen ovan vid användning?

b) Hur skulle du förbättra strukturen?

## Views, constraints och triggers
Integriteten hos en databas kan förbättras med bland annat:
- Views: Virtuella tabeller som kan visa information som är överflödig att lagra i tabellerna
- SQL Constraints: Villkor på värdena i tabellernas kolumner
- Triggers: Automatiserade kontroller och uppdateringar

I allmänhet ska ovanstående metoder appliceras i fallande ordning. Om du exempelvis kan lösa ditt problem med en view behöver du ingen trigger. 

Din uppgift är att implementera en databas för ett telekomföretag och dess telefonabonnemang.

Nedan finns en beskrivning av databasen, men du har tillåtelse att dela upp databasen i hur många tabeller du vill. Det viktigaste är att lösningen blir så bra som möjligt.

Du får poängavdrag om din lösning använder en trigger där en constraint hade räckt, eller om den är onödigt komplicerad.

För triggers räcker det att specificera vilka åtgärder och tabeller den gäller, och PL/(pg)SQL
pseudokod för funktionen den utför.

Din uppgift: Databasen innehåller kunder och abonnemang. Varje kund kan ha
ett obegränsat antal abonnemang. Nedan är värden som bör finnas i databasen:
- En kund har ett unikt id-nummer och ett namn, en månadsfakturering och en boolean
  som anger om det är en privatkund (sant betyder att det är en privatkund). Annars är det en företagskund.
- En Prenumeration tillhör en kund och har ett unikt telefonnummer, en plan, en
  månadsavgift och ett saldo.

Implementera följande ytterligare begränsningar i din design. Sätt bokstäver i marginalen av
din kod som indikerar var varje begränsning är implementerad (eventuellt samma bokstav på
flera ställen):
- A: Varje plan måste vara en av 'prepaid', 'flatrate' eller 'corporate'.
- B: Saldo-värdet måste vara 0 om planen inte är 'prepaid'.
- C: Privatkunder kan inte ha 'corporate' planer (men icke-privatkunder kan fortfarande
  ha vilka planer som helst inklusive men inte begränsat till 'corporate').
- D: Den månatliga faktureringen för en kund måste vara summan av avgifterna för alla kundens
  nummer, och alla avgifter måste vara icke-negativa.
- E: Om en kund raderas ska dess anslutna abonnemang automatiskt raderas.
- F: Om den sista prenumerationen som tillhör en kund raderas, ska kunden
  automatiskt raderas.
