**Setup Guide:**

*~note: all commands are surrounded by speech marks, remove these when runnning the command~*

**Getting to the project directory:**
- From the terminal, use "cd project" to access the project directory
  e.g. "cd ~workspace/project"


**For the databases:**
- In the terminal, use "cd db" to access the database directory
- Enter the following commands into the terminal (in order):
 "sqlite3 production.sqlite3"
 ".read tables.sql"
 ".schema"
 "ctrl+z" to exit sqlite form
 "select  * from tableName" where tableName is the table name in tables.sql which can be seen using a ".schema" command
        e.g. "select * from mentees;"
  "delete * from tableName" where tableName is the table name in tables.sql which can be seen using a ".schema" command
        e.g "delete * from requests;"
- To exit the directory use "cd .." to return  
  
  
**Running the webapplication:**  
- Install gems by typing "bundle install" in the terminal
- Type in "ruby app.rb" to start up the website on the webserver
- in your browser, in a new tab type https://oberon-aurora-4567.codio.io/ in the codio terminal
    and the portNumber is the port number displayed in the terminal once you run app.rb, also change "oberon-aurora" to the codio box name in your terminal.
- In the terminal press "CTRL+C" in the terminal to stop the webserver
**Make sure the requests table is empty before you run the webserver**


**Log In:**
To log in to our website use the following username and password combinations 

Username: Password:

mentee1 mentee1

mentee2 mentee2

mentor1 mentor1

mentor2 mentor2

**Running Rspec tests:**
-To run the tests make sure you're in the project directory and run "rspec spec/features/test-file" or "rspec spec/unit/test-file" where "test-file" is the test you want to run e.g. "edit_spec.rb"
-To run the entire library of tests the command “rspec” will do this. “Rspec spec” can also be used for this purpose. 
-The tests will make changes to the database so the tests should be returned to their previous state after running all of the tests. This is done using “git checkout db/testing.sqlite3” 
