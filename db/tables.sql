CREATE TABLE mentees (
  id INTEGER PRIMARY KEY,
  username TEXT,
  password TEXT,
  fname TEXT,
  lname TEXT,
  email TEXT,
  phoneNum TEXT,
  courseName TEXT,
  faculty TEXT,
  cyear INTEGER,
  description TEXT,
  mentorMatch INTEGER,
  suspendMentee INTEGER
);

CREATE TABLE mentors (
  id INTEGER PRIMARY KEY,
  username TEXT,
  password TEXT,
  fname TEXT,
  lname TEXT,
  email TEXT,
  phoneNum TEXT,
  jobTitle TEXT,
  courseName TEXT,
  description TEXT,
  menteeMatch INTEGER,
  activationToken INTEGER,
  profileStatus TEXT,
  suspendMentor INTEGER
);

CREATE TABLE requests (
  id INTEGER PRIMARY KEY,
  timePassed TEXT,
  menteeID INTEGER,
  mentorID INTEGER
);

CREATE TABLE admins (
  id INTEGER PRIMARY KEY,
  username TEXT,
  password TEXT,
  fname TEXT,
  lname TEXT,
  email TEXT,
  phoneNum TEXT,
  description TEXT,
  activationToken INTEGER,
  suspendAdmin INTEGER
);
