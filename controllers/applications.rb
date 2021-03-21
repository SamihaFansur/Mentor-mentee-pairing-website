get "/applications" do
  @menteeIDList = []
  IDList = Request.where(mentorID: $mentors.id)
  IDList.each do |id|
    @menteeIDList.push(Mentee.first(id: id.menteeID))
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
  MIDList = Request.where(menteeID: $mentees.id)
  puts MIDList
  MIDList.each do |id|
    @mentorMatchedList.push(Mentor.first(id: id.mentorID))
  end
  
  erb :myMentor
end