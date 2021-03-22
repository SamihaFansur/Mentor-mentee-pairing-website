require "openssl"

# A application record from the database
class Request < Sequel::Model
  #Loads the params from the requests table
  def load(menteeID, mentorID)
    self.mentorID = mentorID
    self.menteeID = menteeID
  end
  
  #Checks if application already sent to prevent multiple submissions
  def exist_application?
    other_request = Request.where(menteeID: menteeID)
    other_request.each do |requestVar|
     return true if requestVar.mentorID == mentorID
    end
    return false
  end
end