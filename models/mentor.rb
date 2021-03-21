require "openssl"

# A mentor record from the database
class Mentor < Sequel::Model
  def name
    "#{fname} #{lname}"
  end
  
  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.id_exists?(id)
   return false if id.nil? # check the username is not nil
   return false unless Validation.str_is_text?(id) # check the username is text
   return false if Mentor[id].nil? # check the database has a record with this username

   true # all checks are ok - the username exists
  end

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
    self.description = params.fetch("description").strip
  end

  def validate
    super
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
  
  def exist_signup?
    other_mentors = Mentor.first(username: username)
    mentors =  Mentor.first(email: email)
    !other_mentors.nil? ||  !mentors.nil?
  end
  
  def exist_login?
    other_user = Mentor.first(username: username)
    !other_user.nil? && other_user.password == password
  end
  
end
