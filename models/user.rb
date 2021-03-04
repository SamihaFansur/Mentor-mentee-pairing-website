# A mentee record from the database
class mentee < Sequel::Model
  def name
    "#{first_name} #{surname}"
  end

  def self.id_exists?(id)
    return false if id.nil? # check the id is exists
    return false unless Validation.str_is_integer?(id) # check the id is an integer
    return false if mentee[id].nil? # check the database has a record with this id

    true # all checks are right
  end

  def load(params)
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.email = params.fetch("email", "").strip
    self.phone_number = params.fetch("phone_number", "").strip
    self.course = params.fetch("course", "").strip
    self.course_years = params.fetch("course_years", "").strip
    self.university = params.fetch("university", "").strip
    
  end
# mentees' imformation would be saved and displayed
  def validate
    super
    errors.add("first_name", "cannot be empty") if !first_name || first_name.empty?
    errors.add("surname", "cannot be empty") if !surname || surname.empty?
    errors.add("email", "cannot be empty") if !email || email.empty?
    errors.add("phone_number", "cannot be empty") if !phone_number || phone_number.empty?
    errors.add("course", "cannot be empty") if !course || course.empty?
    errors.add("course_years", "cannot be empty") if !course_years || course_years.empty?
    errors.add("university", "cannot be empty") if !university || university.empty?
    
end
# If mentees forget to finish all the questions, there has some warnings to them
