require "openssl"

# A mentee record from the database
class Mentee < Sequel::Model
  def name
    "#{fname} #{lname}"
  end

  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.username_exists?(username)
   return false if username.nil? # check the username is not nil
   return false unless Validation.str_is_text?(username) # check the username is text
   return false if Mentee[username].nil? # check the database has a record with this username

   true # all checks are ok - the username exists
  end

  def load(params)
    self.fname = params.fetch("fname", "").strip
    self.lname = params.fetch("lname", "").strip
    self.email = params.fetch("email", "").strip
    self.phoneNum = params.fetch("phoneNum", "").strip
    self.courseName = params.fetch("courseName", "").strip
    self.cyear = params.fetch("cyear", "").strip
    self.username = params.fetch("username", "").strip
    self.password = params.fetch("password", "").strip
  end

  def validate
    super
    #errors.add("fname", "cannot be empty") if !fname || fname.empty?
    #errors.add("lname", "cannot be empty") if !lname || lname.empty?
    #errors.add("email", "cannot be empty") if !email || email.empty?
    #errors.add("phoneNum", "cannot be empty") if !phoneNum || phoneNum.nil?
    #errors.add("courseName", "cannot be empty") if !courseName || courseName.empty?
    #errors.add("cyear", "cannot be empty") if !cyear || cyear.nil?
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
  
  def exist_signup?
    other_mentees = Mentee.first(username: username)
    mentees =  Mentee.first(email: email)
    !other_mentees.nil? ||  !mentees.nil?
  end
  
  def exist_login?
    other_user = Mentee.first(username: username)
    !other_user.nil? && other_user.password == password
  end
end
