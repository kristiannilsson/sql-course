-- players(_name_, level, money)
--   money >= 0
CREATE TABLE players (
  name TEXT PRIMARY KEY,
  level INTEGER NOT NULL,
  money INTEGER NOT NULL,
  CHECK (money >= 0)
);
-- items(_id_, itemname, value)
--   value >= 0
CREATE TABLE items(
  id INTEGER PRIMARY KEY,
  itemname TEXT NOT NULL,
  value INTEGER NOT NULL,
  CHECK (value >= 0)
);
-- equippable(_id_, equipslot)
--  id -> items.id
CREATE TABLE equippable(
  id INTEGER PRIMARY KEY,
  equipslot TEXT NOT NULL,
  FOREIGN KEY (id) REFERENCES items,
  -- Same as items(id)
  -- This is just required to be able to refer to both id and equipslot
  --   it has no effect on what you can add to this table since id is already PK
  UNIQUE (id, equipslot)
);
-- player_inventory(_player_, _item_)
--   item -> items.id
--   player -> players.name
CREATE TABLE player_inventory(
  player TEXT,
  item INTEGER,
  PRIMARY KEY (item, player),
  FOREIGN KEY (item) REFERENCES items,
  FOREIGN KEY (player) REFERENCES players
);
-- equipped(_player_, item, _equipslot_)
--   (item, equipslot) -> equippable(id, equipslot)
--   player -> players.name
CREATE TABLE equipped (
  player TEXT,
  item INTEGER,
  equipslot TEXT,
  PRIMARY KEY (player, equipslot),
  FOREIGN KEY (item, equipslot) REFERENCES equippable(id, equipslot),
  FOREIGN KEY (player) REFERENCES players
);
-- Inserts
INSERT INTO items
VALUES (0, 'Java Direkt med Swing', 542);
INSERT INTO items
VALUES (1, 'Databaser: Den kompletta boken', 495);
INSERT INTO items
VALUES (2, 'Vorpal sword', 10000);
INSERT INTO items
VALUES (3, 'Ugnsvantar', 999);
INSERT INTO equippable
VALUES (1, 'weapon');
INSERT INTO equippable
VALUES (2, 'weapon');
INSERT INTO equippable
VALUES (3, 'gloves');
INSERT INTO players
VALUES ('kristian', 100, 50000);
INSERT INTO players
VALUES ('thomas', 2, 0);
INSERT INTO player_inventory
VALUES ('kristian', 1);
INSERT INTO player_inventory
VALUES ('kristian', 3);
INSERT INTO player_inventory
VALUES ('thomas', 1);
INSERT INTO equipped
VALUES ('kristian', 2, 'weapon');
INSERT INTO equipped
VALUES ('thomas', 3, 'gloves');
-- Failing inserts
-- INSERT INTO equipped VALUES ('kristian', 0, 'gloves');
-- INSERT INTO equipped VALUES ('kristian', 1, 'gloves');
-- INSERT INTO equipped VALUES ('kristian', 1, 'weapon');
-- INSERT INTO players VALUES ('kristian', 0, 0);
-- Query 1
SELECT itemname
FROM player_inventory,
  items
WHERE item = id
  AND player = 'kristian';
-- 2
SELECT AVG(value) AS average_value
FROM items;
-- 3
SELECT id,
  COUNT(player) AS owners
FROM items
  LEFT OUTER JOIN player_inventory ON item = id
GROUP BY id;
-- 4
WITH Weapons AS (
  -- Create a "helper table" with all equipped weapons
  SELECT player,
    itemname
  FROM equipped,
    items
  WHERE item = id
    AND equipslot = 'weapon'
)
SELECT name,
  COALESCE(itemname, 'Nothing') -- Add players with no weapons
FROM players
  LEFT OUTER JOIN Weapons ON player = name;
-- 5
SELECT itemname
FROM items,
  equipped,
  players
WHERE id = item
  AND name = player
  AND level > 75
  AND value > 500;
-- 6
WITH Everything AS (
  SELECT item,
    player
  FROM player_inventory
  UNION ALL
  SELECT item,
    player
  FROM equipped
)
SELECT player,
  SUM(value) AS total
FROM Everything,
  items
WHERE id = item
GROUP BY player;
-- 7
-- This is for testing that the query works
-- INSERT INTO equipped VALUES ('thomas', 	1, 'weapon');
SELECT *
FROM player_inventory,
  equippable
WHERE item = id
  AND player = 'thomas'
  AND equipslot NOT IN (
    SELECT equipSlot
    FROM equipped
    WHERE player = 'thomas'
  );