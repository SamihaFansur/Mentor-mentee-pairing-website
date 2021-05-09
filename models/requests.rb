require "openssl"
require "time"
# A application record from the database
class Request < Sequel::Model 
  #Loads the params from the requests table
  def load(menteeID, mentorID)
    #Assigns each field from the table to a variable in order to be called upon later
    #.strip is used to remove any accidental whitespaces
    self.mentorID = mentorID
    self.menteeID = menteeID
  end
  
  #Checks if application already sent to prevent multiple submissions
  def exist_application?
    time_now = Time.new
    #Goes through all the records in requests table and returns true if mentee has sent a request
    request_existing = Request.first(menteeID:menteeID)
    if request_existing
      return true
    end
    return false
  end
    
end
