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