CREATE TABLE mentors (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    phone_number INTEGER,
    background TEXT,
    department TEXT,
);

INSERT INTO mentors VALUES();

SELECT * FROM mentors WHERE id = 1;

DELETE FROM mentors WHERE position = "";
