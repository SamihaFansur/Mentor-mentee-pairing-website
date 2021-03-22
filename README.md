Setup Guide:

~note: all commands are surrounded by speech marks, remove these when runnning the command~

Getting to the project directory:
-From the terminal, use "cd project" to access the project directory
  e.g. "cd ~workspace/project"


For the databases:
-In the terminal, use "cd db" to access the database directory
-Enter the following commands into the terminal (in order):
  "sqlite3 production.sqlite3"
  ".read tables.sql"
  ".schema"
  "ctrl+z" to exit sqlite form
  "select  * from tableName" where tableName is the table name in tables.sql which can be seen using a ".schema" command
        e.g. "select * from mentees;"
  "delete * from tableName" where tableName is the table name in tables.sql which can be seen using a ".schema" command
        e.g "delete * from requests;"
-To exit the directory use "cd .." to return

Running the webapplication:
-Install gems by typing "bundle install" in the terminal
-Type in "ruby app.rb" to start up the website on the webserver
 Press "CTRL+C" in the terminal to stop the webserver
-in your browser, in a new tab type https://box-name-portNumber.codio.io/index where the "box-name" is the two part name in the codio terminal
    and the portNumber is the port number displayed in the terminal once you run app.rb
**Make sure the requests table is empty before you run the webserver**

Running Rspec tests:
-To run the tests make sure you're in the project directory and run "rspec spec/features/test-file" or "rspec spec/unit/test-file" where "test-file" is the test you want to run e.g. "edit_spec.rb"