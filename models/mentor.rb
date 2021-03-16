require "openssl"

# A mentor record from the database
class Mentor < Sequel::Model
  def name
    "#{fname} #{lname}"
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

  def validate
    super
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
  
  def exist_signup?
    other_mentees = Mentor.first(username: username)
    mentees =  Mentor.first(email: email)
    !other_mentees.nil? ||  !mentees.nil?
  end
  
  def exist_login?
    other_user = Mentor.first(username: username)
    !other_user.nil? && other_user.password == password
  end
  
end
