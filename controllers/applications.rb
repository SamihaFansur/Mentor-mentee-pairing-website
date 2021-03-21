get "/applications" do
  @menteeIDList = []
  IDList = Request.where(mentorID: $mentors.id)
  IDList.each do |id|
    @menteeIDList.push(Mentee.first(id: id.menteeID))
  end
  
  erb :mentee_applications
end

post "/match" do  
#   puts (Mentee.where(id: params[:menteeID])).sql
#   puts (Mentor.where(id: $mentors.id).update(:menteeMatch => params[:mentee])).sql
#   puts (Request.where(mentorID: $mentors.id).delete).sql
  
  Mentee.where(id: params[:menteeID]).update(:mentorMatch => $mentors.id)
  Mentor.where(id: $mentors.id).update(:menteeMatch => params[:menteeID])
  
  Request.where(mentorID: $mentors.id).delete
  redirect "/MentorDashboard"
end