require "openssl"
require "time"
# A application record from the database
class Request < Sequel::Model 
#   TIME_IN_TWO_WEEKS = 14*24*60*60
    TIME_IN_TWO_WEEKS = 20
  #Loads the params from the requests table
  def load(menteeID, mentorID)
    self.mentorID = mentorID
    self.menteeID = menteeID
  end
  
  #Checks if application already sent to prevent multiple submissions
  def exist_application?
    time_now = Time.new
    #Goes through all the records in requests table and returns true if mentor id is present
    other_request = Request.where(menteeID: menteeID)
    other_request.each do |requestVar|
       time_sent = Time.parse(requestVar.timePassed)
  #        puts time_now - time_sent >= TIME_IN_TWO_WEEKS
       if time_now - time_sent >= TIME_IN_TWO_WEEKS
         requestVar.delete
         return false
       else 
         return true
       end
    end
    return false
  end
    
end
