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
  FOREIGN KEY (mentorAccept) REFERENCES mentors(id),
  FOREIGN KEY (mentorMatch) REFERENCES mentors(id),
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
  FOREIGN KEY (menteeAccept) REFERENCES mentees(id),
  FOREIGN KEY (menteeMatch) REFERENCES mentees(id),
  activationToken INTEGER,
  profileStatus TEXT,
  reportMentee INTEGER,
  suspendMentor INTEGER
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

CREATE TABLE requests (
  id INTEGER PRIMARY KEY,
  timeApplicationSent TEXT,
  FOREIGN KEY(menteeID) REFERENCES mentees(id),
  FOREIGN KEY(mentorID) REFERENCES mentors(id)
);

CREATE TABLE reports (
  id INTEGER PRIMARY KEY,
  timeReportSent TEXT,
  caption TEXT,
  description TEXT,
  FOREIGN KEY(mentorID) REFERENCES mentors(id)
);