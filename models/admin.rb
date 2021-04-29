require "openssl"

# An admin record from the database
class Admin < Sequel::Model
  
  #Concatenates first and last name to create a full name
  def name
    "#{fname} #{lname}"
  end
  
  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.id_exists?(id)
   if id.nil? || !Validation.str_is_text?(id) || Mentee[id].nil?
     return false
   end
   # check the id is not nil
   # check the id is text
   # check the database has a record with this id
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
    self.activationToken = params.fetch("activationToken", "").strip
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
    #Done the last bit since initially description is empty
    self.description = params.fetch("description").strip unless params.fetch("description").strip == "" || params.fetch("description").nil?
  end

  #Validates if username and password is empty
  def validate
    super
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
    
  #Checks if username/email already in any database to prevent multiple sign ups
  def exist_signup?
    other_mentors = Mentor.first(username: username)
    mentors =  Mentor.first(email: email)
    mentor_exist = !other_mentors.nil? ||  !mentors.nil?
    
    other_mentees = Mentee.first(username: username)
    mentees =  Mentee.first(email: email)
    mentee_exist = !other_mentees.nil? ||  !mentees.nil?
    
    other_admins = Admin.first(username: username)
    admins =  Admin.first(email: email)
    admin_exist = !other_admins.nil? ||  !admins.nil?
    
    mentor_exist || mentee_exist || admin_exist
  end
  
  #Checks if admin already logged in; being called in login.rb controller
  def exist_login?
    other_admins = Admin.first(username: username)
    !other_admins.nil? && other_admins.password == password
  end
  
end
