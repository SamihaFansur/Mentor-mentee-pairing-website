require "openssl"
require "time"
# A application record from the database
class Report < Sequel::Model   
  def load(params)
    #Assigns each field from the table to a variable in order to be called upon later
    #.strip is used to remove any accidental whitespaces
    self.mentorID = params.fetch("mentorID", "").strip
    self.caption = params.fetch("caption", "").strip
    self.description = params.fetch("description", "").strip
  end
end
