CREATE TABLE mentees (
    id INTEGER PRIMARY KEY,
    fname TEXT,
    lname TEXT,
    email TEXT,
    phoneNum INTEGER,
    courseName TEXT,
    cyear INTEGER,
);

INSERT INTO mentees VALUES();

SELECT * FROM mentees WHERE id = 1;

DELETE FROM mentees WHERE position = "";
