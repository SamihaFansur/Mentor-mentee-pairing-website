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
  applicationNumber INTEGER,
  mentorAccept INTEGER,
  mentorMatch INTEGER,
  requestMentorMeeting INTEGER,
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
  menteeAccept INTEGER,
  menteeMatch INTEGER,
  activationToken INTEGER,
  profileStatus TEXT,
  suspendMentor INTEGER
);

CREATE TABLE requests (
  id INTEGER PRIMARY KEY,
  timeApplicationSent TEXT,
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
  activationToken INTEGER
);
