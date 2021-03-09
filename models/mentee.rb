# A mentee record from the database
class Mentee < Sequel::Model
  def name
    "#{fname} #{lname}"
  end

  # "self.method" is how we define a class-level method in Ruby (in the same way
  # we'd use "static" in Java, e.g., public static void classMethod(...))
  def self.id_exists?(id)
    return false if id.nil? # check the id is not nil
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if Mentee[id].nil? # check the database has a record with this id

    true # all checks are ok - the id exists
  end

  def load(params)
    self.fname = params.fetch("fname", "").strip
    self.lname = params.fetch("lname", "").strip
    self.email = params.fetch("email", "").strip
    self.phoneNum = params.fetch("phoneNum", "").strip
    self.courseName = params.fetch("courseName", "").strip
    self.cyear = params.fetch("cyear", "").strip
  end

  def validate
    super
    errors.add("fname", "cannot be empty") if !fname || fname.empty?
    errors.add("lname", "cannot be empty") if !lname || lname.empty?
    errors.add("email", "cannot be empty") if !email || email.empty?
    errors.add("phoneNum", "cannot be empty") if !phoneNum || phoneNum.nil?
    errors.add("courseName", "cannot be empty") if !courseName || courseName.empty?
    errors.add("cyear", "cannot be empty") if !cyear || cyear.nil?

  end
end
