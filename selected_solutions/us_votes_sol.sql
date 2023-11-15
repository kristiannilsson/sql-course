
CREATE TABLE state_votes (
state_code TEXT PRIMARY KEY,
biden_votes INTEGER,
trump_votes INTEGER,
electors INTEGER
);
-- Test data
INSERT INTO state_votes VALUES ('NV', 588252, 580605, 6);
INSERT INTO state_votes VALUES ('AZ', 3215969, 3051555, 11);
INSERT INTO state_votes VALUES ('GA', 2406774, 2429783, 16);
INSERT INTO state_votes VALUES ('PA', 3051555, 3215969, 20);
-- Slightly simplified data
INSERT INTO state_votes VALUES ('Red state_votes', 0, 1, 232);
INSERT INTO state_votes VALUES ('Blue state_votes', 1, 0, 253);

-- Lösning 1 med UNION
CREATE VIEW state_results AS
(SELECT state_code, 'Biden' AS candidate, electors
FROM state_votes
WHERE biden_votes > trump_votes)
UNION
(SELECT state_code, 'Trump', electors
FROM state_votes
WHERE trump_votes > biden_votes);

-- Lösning 2 med CASE
SELECT
    state_code,
    CASE
        WHEN trump_votes > biden_votes THEN 'Trump'
        WHEN biden_votes > trump_votes THEN 'Biden'
        ELSE 'Tie' -- Handle ties if needed
    END AS candidate,
    electors
FROM state_votes;

-- Totala rösterna
SELECT candidate, SUM(electors) as total
FROM state_results
GROUP BY candidate;

-- Lösning för den nya strukturen
WITH ranked_votes AS (
    SELECT
        state_code,
        candidate,
        RANK() OVER (PARTITION BY state_code ORDER BY votes DESC) AS rnk
    FROM state_votes
)
SELECT state, candidate, electors
FROM ranked_votes
WHERE rnk = 1;