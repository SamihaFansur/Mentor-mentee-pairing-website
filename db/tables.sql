CREATE TABLE mentees (
    username TEXT PRIMARY KEY,
    password TEXT,
    fname TEXT,
    lname TEXT,
    email TEXT,
    phoneNum TEXT,
    courseName TEXT,
    cyear INTEGER
);

CREATE TABLE mentors (
    username TEXT PRIMARY KEY,
    password TEXT,
    fname TEXT,
    lname TEXT,
    email TEXT,
    phoneNum TEXT,
    jobTitle TEXT,
    courseName TEXT
);

