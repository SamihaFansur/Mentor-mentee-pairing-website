#Mentee uses this route to send mentor applications
get "/applications" do
  @menteeIDList = [] #List to store mentee
  IDList = Request.where(mentorID: $mentors.id) #Finds the request where it finds the specified mentor ID
  IDList.each do |id|
    mentee = Mentee.first(id: id.menteeID)
    @menteeIDList.push(mentee) unless mentee.nil?
  end
  erb :mentee_applications
end

post "/match" do    
  #When mentor accepts mentee request, mentorMatch field updated to value of mentor ID in the mentees table
  Mentee.where(id: params[:menteeID]).update(:mentorMatch => $mentors.id)
  
  #When mentor accepts mentee request, menteeMatch field updated to value of mentee ID in the mentors table
  Mentor.where(id: $mentors.id).update(:menteeMatch => params[:menteeID])
  
  #Deletes the all requests a mentor has from the table after mentor accepts a mentee request
  Request.where(mentorID: $mentors.id).delete
  redirect "/MentorDashboard"
end

get "/myMentor" do
  #List to store the mentor matched to a mentee
  @mentorMatchedList = []
  #Finds the ID of the mentor that is equal to the value stored in the mentorMatch column in the mentees table
  MentorIDList = Mentor.where(id: $mentees.mentorMatch)
  MentorIDList.each do |id|
    @mentorMatchedList.push(Mentor.first(id: id.id)) #Stores the mentor record found in the list to be displayed
  end
  
  erb :myMentor
end

get "/myMentee" do
  #List to store the mentee matched to a mentor
 @menteeMatchedList = []
  #Finds the ID of the mentee that is equal to the value stored in the menteeMatch column in the mentors table
  MenteeIDList = Mentee.where(id: $mentors.menteeMatch)
  MenteeIDList.each do |id|
    @menteeMatchedList.push(Mentee.first(id: id.id)) #Stores the mentor record found in the list to be displayed
  end
  
  erb :myMentee
end