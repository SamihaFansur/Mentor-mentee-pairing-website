#Mentor uses this route to accept 1 mentee application
get "/menteeApplications" do
  headers_common_pages
  applications("mentee", Request, mentorID: $mentors.id)
  
  erb :mentee_applications
end

#Mentee uses this route to view sent mentor applications
get "/sentMentorApplications" do
  applications("mentor", Request, menteeID: $mentees.id)
  
  erb :sent_mentor_applications
end

#Mentee accepts mentor
post "/matchWithMentor" do
  #When mentee accepts application, sets mentorAccept to the id of the mentor they are accepting
  $mentees = Mentee.first(id: $mentees.id)
  mentor = Mentor.first(id: params[:mentorID])
  
  $mentees.mentorAccept = mentor.id
  $mentees.save_changes

  #If both mentor and mentee have accepted the each others request both will be matched and both users notified of match but
  #if the mentee only has accepted the application then the mentor is notified
  if mentor.menteeAccept == $mentees.id && $mentees.mentorAccept == mentor.id
    both_users_have_accepted($mentees.id, params[:mentorID], $mentees, mentor)
  else
    send_mail(mentor.email, 
      "A mentee wants you to be their mentor!", 
      "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
      $mentees.fname+" "+$mentees.lname+" has accepted the application for you to be their mentor.\n"+
      "To accept "+$mentees.fname+" "+$mentees.lname+"as your mentee. Please login into your account an accept the application.\n"+
      "\n\n\nRegards\nTeam 6")
    
    send_mail($mentees.email, 
      "You have successfully accepted the mentor application", 
      "Hi "+$mentees.fname+" "+$mentees.lname+"!\n"+
      "You have successfully accepted"+mentor.fname+" "+mentor.lname+" to be your mentor.\n"+
      "\n\n\nRegards\nTeam 6")
  end
    
  redirect "/MenteeDashboard"

end

#Mentor accepts mentee
post "/matchWithMentee" do   
  #When mentor accepts application, sets menteeAccept to the id of the mentee they are accepting
  $mentors = Mentor.first(id: $mentors.id)
  mentee = Mentee.first(id: params[:menteeID])
  
  $mentors.menteeAccept = mentee.id
  $mentors.save_changes  
  
  #If both mentor and mentee have accepted the each others request both will be matched and both users notified of match but
  #if the mentee only has accepted the application then the mentor is notified
  if $mentors.menteeAccept == mentee.id && mentee.mentorAccept == $mentors.id
    both_users_have_accepted(params[:menteeID], $mentors.id, mentee, $mentors)
  else
    send_mail(mentee.email, 
      "A mentor has accepted your application for you to be their mentee!", 
      "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
      $mentors.fname+" "+$mentors.lname+" has accepted the application for you to be their mentee.\n"+
      "To accept "+$mentors.fname+" "+$mentors.lname+"as your mentor. Please login into your account an accept the application.\n"+
      "\n\n\nRegards\nTeam 6")
    
    send_mail($mentors.email, 
      "You have successfully accepted the mentee application", 
      "Hi "+$mentors.fname+" "+$mentors.lname+"!\n"+
      "You have successfully accepted"+mentee.fname+" "+mentee.lname+"'s application to be your mentee.\n"+
      "\n\n\nRegards\nTeam 6")
  end
  
  if session[:admins_username]
    if session[:mentors_username]
      redirect "/AdminMentorDashboard"
    end
  elsif session[:mentors_username]
    redirect "/MentorDashboard"
  end
  
end

#Mentor rejects a mentee application
post "/rejectMentee" do   
  #Deletes the corresponding request the mentee has made from the table
  Request.where(mentorID: $mentors.id, menteeID: params[:menteeID]).delete
  mentee = Mentee.first(id: params[:menteeID]) #Gets the existing mentee based on id
  mentor = Mentor.first(id: $mentors.id) #Gets the existing mentor based on id
  
  reset_mentee_fields_application_unsent_or_rejected(mentee, mentor)
  
  #Sends an email to mentee that their application was rejected
  send_mail(mentee.email, 
    "Application Rejected!", 
    "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
    "Your mentor application has been rejected. To send another application login into your account.\n"+
    "\n\n\nRegards\nTeam 6")
  
  redirect "/menteeApplications"
end

#Mentee unsends their mentor application
post "/unsend" do     
  #Deletes the corresponding request a mentee has made from the table
  Request.where(menteeID: $mentees.id, mentorID: params[:mentorID]).delete
  mentor = Mentor.first(id: params[:mentorID]) #Gets the existing mentor based on id
  
  reset_mentee_fields_application_unsent_or_rejected($mentees, mentor)
  
  #Sends an email to mentor that the mentee unsent their application
   send_mail(mentor.email, 
    "Mentee application withdrawn!", 
    "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
    "A mentee has withdrawn their application.\n"+
    "\n\n\nRegards\nTeam 6")
  
  redirect "/sentMentorApplications"
end

get "/myMentor" do  
  applications("mentorMatched", Mentor, id: $mentees.mentorMatch)
  
  erb :myMentor
end

get "/myMentee" do
  headers_common_pages
  
  applications("menteeMatched", Mentee, id: $mentors.menteeMatch)
  
  #Used for reporting mentees
  mentor = Mentor.first(id: $mentors.id)
  @mentor_report = mentor.reportMentee
  
  erb :myMentee
end

#Route for the admin to view pending mentee applications
get "/PendingMenteeApplications" do
  headers_common_pages
  
  @requests = Request.order(:timeApplicationSent).all.reverse #All records in Requests table with most recent on top
  @menteesInfo = []
  @mentorsInfo = []
  @requests.each do |request|
    mentee = Mentee.first(id: request.menteeID)
    mentor = Mentor.first(id: request.mentorID)
    
    @menteesInfo.push([mentee.id, mentee.name, mentee.email]) #Mentee information
    @mentorsInfo.push([mentor.id, mentor.name, mentor.email]) #Mentor information
  end

  erb :pending_mentee_requests
  
end

post "/requestMentorMeeting" do
  mentee_requesting = Mentee.first(id: $mentees.id)
  mentor_requested = Mentor.first(id: mentee_requesting.mentorMatch)
  
  send_mail(mentor_requested.email,
            "Your mentee "+mentee_requesting.fname+" "+mentee_requesting.lname+" is requesting a meeting",
            "Please email your mentee to schedule a mentor meeting.\n"+
            "\n\n\nRegards\nTeam 6")
  
  $mentee_req = mentee_requesting.requestMentorMeeting
  $mentee_req = 1 #already sent
  mentee_requesting.requestMentorMeeting = $mentee_req #so field is updated in the the mentees table
  mentee_requesting.save_changes
  
  Thread.new{
#             sleep(24*60*60) #Button enabled after a day
            sleep(15) #----------------delete later -S----------------
            $mentee_req = 0 #resets so mentee can request mentor for a meeting again
            mentee_requesting.requestMentorMeeting = $mentee_req
            mentee_requesting.save_changes
      }
  
  redirect "/myMentor"
end

def applications(user, classUsed, userParamsUsed)
  @usersIDList = []
  listOfIDs = classUsed.where(userParamsUsed) #Finds the request where it finds the specified mentee ID
  listOfIDs.each do |id|
    if user == "mentee"
      allUsers = Mentee.first(id: id.menteeID)
    elsif user == "menteeMatched"
      allUsers = Mentee.first(id: id.id)
    elsif user == "mentor"
      allUsers = Mentor.first(id: id.mentorID)
    elsif user == "mentorMatched"
      allUsers = Mentor.first(id: id.id)
    end
    allUsers
    @usersIDList.push(allUsers) unless user.nil?
  end
end

def reset_mentee_fields_application_unsent_or_rejected(menteeUser, mentorUser)
  if mentorUser.menteeAccept == menteeUser.id || menteeUser.mentorAccept == mentorUser.id
    mentorUser.menteeAccept = 0
    mentorUser.save_changes
  end
  
  menteeUser.applicationNumber = 1 #Mentee can now send a mentor an application
  menteeUser.mentorAccept = 0 #Resets field if mentee has already accepted the request
  menteeUser.save_changes
end

def both_users_have_accepted(menteeIDParams, mentorIDParams, menteeUser, mentorUser)
  Mentor.where(id: mentorIDParams).update(:menteeMatch => menteeIDParams)
  Mentee.where(id: menteeIDParams).update(:mentorMatch =>mentorIDParams)
  
  #Gets all the requests sent to the mentor being matched, and resets field values for mentees with
  #whom the mentor isn't being matched
  req_all = Request.where(mentorID: mentorIDParams).all
    req_all.each do |req|
      other_mentees = Mentee.first(id: req.menteeID)
      if other_mentees.id != menteeUser.id
        other_mentees.applicationNumber = 1
        other_mentees.mentorAccept = 0
        other_mentees.save_changes
      end
    end
  
  Request.where(mentorID: mentorUser.id).delete #Deletes all records from requests table based on the id of the mentor being matched

  mentorUser.profileStatus = "1" #mentor profile made private
  mentorUser.save_changes

  menteeUser.applicationNumber = 0 #mentee can't send more applications
  menteeUser.save_changes
  
  send_mail(menteeUser.email, 
      "You have been paired with a mentor!", 
      "Hi "+menteeUser.fname+" "+menteeUser.lname+"!\n"+
      "Your new mentor is: "+mentorUser.fname+" "+mentorUser.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")

    send_mail(mentorUser.email, 
      "You have been paired with a mentee!", 
      "Hi "+mentorUser.fname+" "+mentorUser.lname+"!\n"+
      "Your new mentee is: "+menteeUser.fname+" "+menteeUser.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")
end