require "openssl"
require "time"
# A application record from the database
class Report < Sequel::Model   
  def load(params)
    self.mentorID = params.fetch("mentorID", "").strip
    self.caption = params.fetch("caption", "").strip
    self.description = params.fetch("description", "").strip
  end
    
end
