CREATE TABLE mentees (
    /*id INTEGER PRIMARY KEY,*/
    username TEXT PRIMARY KEY,
    password TEXT,
    fname TEXT,
    lname TEXT,
    email TEXT,
    phoneNum INTEGER,
    courseName TEXT,
    cyear INTEGER
);

CREATE TABLE mentors (
    username TEXT PRIMARY KEY,
    password TEXT,
    fname TEXT,
    lname TEXT,
    email TEXT,
    phoneNum INTEGER,
    jobTitle TEXT,
    industry TEXT
);

