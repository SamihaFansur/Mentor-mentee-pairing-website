# A mentee record from the database
class mentee < Sequel::Model
  def name
    "#{fname} #{lname}"
  end

  def self.id_exists?(id)
    return false if id.nil? # check the id is exists
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if mentee[id].nil? # check the database has a record with this id

    true # all checks are right
  end

  def load(params)
    self.fname = params.fetch("fname", "").strip
    self.lname = params.fetch("lname", "").strip
    self.email = params.fetch("email", "").strip
    self.phoneNum = params.fetch("phoneNum", "").strip
    self.courseName = params.fetch("course", "").strip
    self.year = params.fetch("course_years", "").strip
    
  end
# mentees' imformation would be saved and displayed
  def validate
    super
    errors.add("fname", "cannot be empty") if !fname || fname.empty?
    errors.add("lname", "cannot be empty") if !lname || lname.empty?
    errors.add("email", "cannot be empty") if !email || email.empty?
    errors.add("phoneNum", "cannot be empty") if !phoneNum || phoneNum.empty?
    errors.add("courseName", "cannot be empty") if !courseName || courseName.empty?
    errors.add("year", "cannot be empty") if !year || year.empty?
    
end
# If mentees forget to finish all the questions, there has some warnings to them
