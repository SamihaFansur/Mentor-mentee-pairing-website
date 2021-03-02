CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    gender TEXT,
    country TEXT,
    position TEXT,
    signal TEXT,
    criteria TEXT,
);

INSERT INTO users VALUES();

SELECT * FROM users WHERE id = 1;

UPDATE users SET signal = "mentors" WHERE position = "";
UPDATE users SET signal = "mentees" WHERE position = "";

DELETE FROM users WHERE position = "";
