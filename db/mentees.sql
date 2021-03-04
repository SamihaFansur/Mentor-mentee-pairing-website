CREATE TABLE mentees (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    email TEXT,
    phone_number INTEGER,
    course TEXT,
    course_year TEXT,
    university TEXT,
);

INSERT INTO mentees VALUES();

SELECT * FROM mentees WHERE id = 1;

DELETE FROM mentees WHERE position = "";
