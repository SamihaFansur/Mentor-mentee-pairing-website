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
  end

  def validate
    super
    errors.add("username", "cannot be empty") if username.empty?
    errors.add("password", "cannot be empty") if password.empty?
  end
  
  def exist?
    other_mentors = Mentor.first(username: username)
    !other_mentors.nil? && other_mentors.password == password
  end
  
end
