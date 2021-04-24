require "openssl"
require "time"
# A application record from the database
class Report < Sequel::Model 
  #Loads the params from the requests table
#   def load(caption, description, mentorID)
#     self.mentorID = mentorID
#     self.caption = caption
#     self.description = description
#   end
  
  def load(params)
    self.mentorID = params.fetch("mentorID", "").strip
    self.caption = params.fetch("caption", "").strip
    self.description = params.fetch("description", "").strip
  end
    
end
