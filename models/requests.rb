require "openssl"

# A application record from the database
class Request < Sequel::Model
  def load(menteeID, mentorID)
    self.mentorID = mentorID
    self.menteeID = menteeID
  end
  
  def exist_application?
    other_request = Request.first(menteeID: menteeID)
    !other_request.nil? && other_request.mentorID == mentorID
  end
end