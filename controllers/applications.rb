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
  #Gets mentee and mentor record based on their id, id gotten from match button
  $mentees = Mentee.first(id: $mentees.id)
  mentor = Mentor.first(id: params[:mentorID])
  
  $mentees.mentorAccept = mentor.id #Set mentorAccept to the id of the mentor the mentee is accepting
  $mentees.save_changes

  #If both mentor and mentee have accepted the each others request both will be matched and both users notified of match but
  #if the mentee only has accepted the application then the mentor is notified through email
  if mentor.menteeAccept == $mentees.id && $mentees.mentorAccept == mentor.id
    both_users_have_accepted($mentees.id, params[:mentorID], $mentees, mentor)
  else
    send_mail(mentor.email, 
      "A mentee wants you to be their mentor!", 
      "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
      $mentees.fname+" "+$mentees.lname+" has accepted the application for you to be their mentor.\n"+
      "To accept "+$mentees.fname+" "+$mentees.lname+" as your mentee. Please login into your account an accept the application.\n"+
      "\n\n\nRegards\nTeam 6")
    
    send_mail($mentees.email, 
      "You have successfully accepted the mentor application", 
      "Hi "+$mentees.fname+" "+$mentees.lname+"!\n"+
      "You have successfully accepted "+mentor.fname+" "+mentor.lname+" to be your mentor.\n"+
      "\n\n\nRegards\nTeam 6")
  end
    
  redirect "/MenteeDashboard"
end

#Mentor accepts mentee
post "/matchWithMentee" do   
  #Gets mentee and mentor record based on their id, id gotten from match button
  $mentors = Mentor.first(id: $mentors.id)
  mentee = Mentee.first(id: params[:menteeID])
  
  $mentors.menteeAccept = mentee.id #Set menteeAccept to the id of the mentee the mentor is accepting
  $mentors.save_changes  
  
  #If both mentor and mentee have accepted the each others request both will be matched and both users notified of match but
  #if the mentor only has accepted the application then the mentee is notified through email
  if $mentors.menteeAccept == mentee.id && mentee.mentorAccept == $mentors.id
    both_users_have_accepted(params[:menteeID], $mentors.id, mentee, $mentors)
  else
    send_mail(mentee.email, 
      "A mentor has accepted your application for you to be their mentee!", 
      "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
      $mentors.fname+" "+$mentors.lname+" has accepted the application for you to be their mentee.\n"+
      "To accept "+$mentors.fname+" "+$mentors.lname+" as your mentor. Please login into your account and accept the application.\n"+
      "\n\n\nRegards\nTeam 6")
    
    send_mail($mentors.email, 
      "You have successfully accepted the mentee application", 
      "Hi "+$mentors.fname+" "+$mentors.lname+"!\n"+
      "You have successfully accepted "+mentee.fname+" "+mentee.lname+"'s application to be your mentee.\n"+
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
  #Deletes the request where the mentee and mentor id match the id gotten from the reject button
  Request.where(mentorID: $mentors.id, menteeID: params[:menteeID]).delete
  mentee = Mentee.first(id: params[:menteeID]) #Gets the existing mentee based on id
  
  reset_user_fields_application_unsent_or_rejected(mentee, $mentors)
  
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
  #Deletes the request where the mentee and mentor id match the id gotten from the unsend button
  Request.where(menteeID: $mentees.id, mentorID: params[:mentorID]).delete
  mentor = Mentor.first(id: params[:mentorID]) #Gets the existing mentor based on id
  
  reset_user_fields_application_unsent_or_rejected($mentees, mentor)
  
  #Sends an email to mentor that the mentee unsent their application
   send_mail(mentor.email, 
    "Mentee application withdrawn!", 
    "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
    "A mentee has withdrawn their application.\n"+
    "\n\n\nRegards\nTeam 6")
  
  redirect "/sentMentorApplications"
end

#Mentee views their matched mentor
get "/myMentor" do  
  applications("mentorMatched", Mentor, id: $mentees.mentorMatch)
  erb :myMentor
end

#Mentor views their matched mentee
get "/myMentee" do
  headers_common_pages
  applications("menteeMatched", Mentee, id: $mentors.menteeMatch)
  
  #Used for reporting matched mentees
  mentor = Mentor.first(id: $mentors.id)
  @mentor_report = mentor.reportMentee #Used to enable/disable report button
  
  erb :myMentee
end

#Route for the admin to view pending mentee applications
get "/PendingMenteeApplications" do
  headers_common_pages
  
  @requests = Request.order(:timeApplicationSent).all.reverse #All records in Requests table with most recent on top
  @menteesInfo = [] #Stores mentee details from each report
  @mentorsInfo = [] #Stores mentor details from each report
  @requests.each do |request|
    mentee = Mentee.first(id: request.menteeID) #Gets the mentee based on the id stored in the menteeID in request table
    mentor = Mentor.first(id: request.mentorID) #Gets the mentor based on the id stored in the mentorID in request table
    
    @menteesInfo.push([mentee.id, mentee.name, mentee.email]) #Mentee information
    @mentorsInfo.push([mentor.id, mentor.name, mentor.email]) #Mentor information
  end

  erb :pending_mentee_requests
end

#Mentee requests their mentor for a meeting
post "/requestMentorMeeting" do
  mentee_requesting = Mentee.first(id: $mentees.id)
  mentor_requested = Mentor.first(id: mentee_requesting.mentorMatch) #Gets the mentor based on the values stored in mentorMatch in mentees table
  
  send_mail(mentor_requested.email,
            "Your mentee "+mentee_requesting.fname+" "+mentee_requesting.lname+" is requesting a meeting",
            "Please email your mentee to schedule a mentor meeting.\n"+
            "\n\n\nRegards\nTeam 6")
  
  $mentee_req = mentee_requesting.requestMentorMeeting #Variable created so button can be enables/disables through the erb file
  $mentee_req = 1 #Meeting request sent
  mentee_requesting.requestMentorMeeting = $mentee_req #so field is updated in the the mentees table
  mentee_requesting.save_changes
  
  Thread.new{
            sleep(24*60*60) #Button enabled after a day
#             sleep(15) #Button enabled after 15 secs, use when running rspec tests
            $mentee_req = 0 #resets so mentee can request mentor for a meeting again
            mentee_requesting.requestMentorMeeting = $mentee_req
            mentee_requesting.save_changes
      }
  
  redirect "/myMentor"
end


#Method takes in user viewing the page(1st parameter), the class it has to search through(2nd parameter) to find records
#based on the userParamsUsed(3rd parameter)
def applications(user, classUsed, userParamsUsed)
  @usersIDList = [] #Stores all records found
  listOfIDs = classUsed.where(userParamsUsed) #Gets all records in the class specified which match the userParamsUsed
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
    @usersIDList.push(allUsers) unless user.nil?
  end
end

#Method takes in the mentee and the mentor as its parameters
def reset_user_fields_application_unsent_or_rejected(menteeUser, mentorUser)
  #If either user has accepted the application but the other user has unsent/rejected the applciation resets appropriate field values
  if mentorUser.menteeAccept == menteeUser.id || menteeUser.mentorAccept == mentorUser.id
    mentorUser.menteeAccept = 0
    mentorUser.save_changes
  end
  
  menteeUser.applicationNumber = 1 #Mentee can now send a mentor an application
  menteeUser.mentorAccept = 0 #Resets field if mentee has already accepted the request
  menteeUser.save_changes
end

#Method takes in the id of mentee, id of mentor, mentee profile and mentor profile as its parameters
def both_users_have_accepted(menteeIDParams, mentorIDParams, menteeUser, mentorUser)
  #If both users have accepted the applciation, updates menteeMatch and mentorMatch fields to the id of mentor accepting and
  #the id of mentee accepting the request in respective fields
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

  mentorUser.profileStatus = 0 #mentor profile made private
  mentorUser.save_changes

  menteeUser.applicationNumber = 0 #mentee can't send more applications
  menteeUser.save_changes
  
  #Sends both users emails of them being paired
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