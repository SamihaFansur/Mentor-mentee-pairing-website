require "openssl"

# A mentor record from the database
class Mentor < Sequel::Model
  
  #Concatenates first and last name to create a full name
  def name
    "#{fname} #{lname}"
  end
  
  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.id_exists?(id)
   return false if id.nil? # check the id is not nil
   return false unless Validation.str_is_text?(id) # check the id is text
   return false if Mentor[id].nil? # check the database has a record with this id

   true # all checks are ok - the id exists
  end

  #Function called when logging in
  def load(params)
    self.fname = params.fetch("fname", "").strip
    self.lname = params.fetch("lname", "").strip
    self.email = params.fetch("email", "").strip
    self.phoneNum = params.fetch("phoneNum", "").strip
    self.username = params.fetch("username", "").strip
    self.password = params.fetch("password", "").strip
    self.jobTitle = params.fetch("jobTitle", "").strip
    self.courseName = params.fetch("courseName", "").strip
  end
  
  #Function called when editing profile. Second parameter displays the stored values from the databases
  def loadEdit(params)
    self.id = params.fetch("id", self.id).strip
    self.fname = params.fetch("fname", self.fname).strip
    self.lname = params.fetch("lname", self.lname).strip
    self.email = params.fetch("email", self.email).strip
    self.phoneNum = params.fetch("phoneNum", self.phoneNum).strip
    self.username = params.fetch("username", self.username).strip
    self.password = params.fetch("password", self.password).strip
    self.jobTitle = params.fetch("jobTitle").strip unless params.fetch("jobTitle").strip == ""
    self.courseName = params.fetch("courseName").strip unless params.fetch("courseName").strip == ""
    #Done the last bit since initially description is empty
    self.description = params.fetch("description").strip unless params.fetch("description").strip == ""
  end

  #Validates if username and password is empty
  def validate
    super
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
  
   #Checks if username/email already in the mentors database to prevent multiple sign ups
  def exist_signup?
    other_mentors = Mentor.first(username: username)
    mentors =  Mentor.first(email: email)
    !other_mentors.nil? ||  !mentors.nil?
  end
  
   #Checks if mentor already logged in; being called in login.rb controller
  def exist_login?
    other_user = Mentor.first(username: username)
    !other_user.nil? && other_user.password == password
  end
  
end
