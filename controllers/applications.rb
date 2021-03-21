get "/applications" do
  @menteeIDList = []
  IDList = Request.where(mentorID: $mentors.id)
  IDList.each do |id|
    mentee = Mentee.first(id: id.menteeID)
    @menteeIDList.push(mentee) unless mentee.nil?
  end
  erb :mentee_applications
end

post "/match" do    
  Mentee.where(id: params[:menteeID]).update(:mentorMatch => $mentors.id)
  Mentor.where(id: $mentors.id).update(:menteeMatch => params[:menteeID])
  
  Request.where(mentorID: $mentors.id).delete
  redirect "/MentorDashboard"
end

get "/myMentor" do
  @mentorMatchedList = []
  MentorIDList = Request.where(menteeID: $mentees.id)
  MentorIDList.each do |id|
    @mentorMatchedList.push(Mentor.first(id: id.mentorID))
  end
  
  erb :myMentor
end

get "/myMentee" do
 @menteeMatchedList = []
  MenteeIDList = Request.where(mentorID: $mentors.id)
  MenteeIDList.each do |id|
    @menteeMatchedList.push(Mentee.first(id: id.menteeID))
  end
  
  erb :myMentee
end