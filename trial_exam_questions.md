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

users(__username__, email)

follows(__follower__, __follows__, notifications)
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


## Views, constraints och triggers
