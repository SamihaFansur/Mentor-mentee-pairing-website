#Mentor uses this route to accept 1 mentee application
get "/menteeApplications" do
  @menteeIDList = [] #List to store mentee
  IDList = Request.where(mentorID: $mentors.id).order(:timeApplicationSent).reverse #Finds the request where it finds the specified mentor ID with most recent on top
  IDList.each do |id|
    mentee = Mentee.first(id: id.menteeID)
    @menteeIDList.push(mentee) unless mentee.nil?
  end
  erb :mentee_applications
end

#Mentee uses this route to view sent mentor applications
get "/sentMentorApplications" do
  @mentorIDList = [] #List to store mentors
  IDList = Request.where(menteeID: $mentees.id) #Finds the request where it finds the specified mentee ID
  IDList.each do |id|
    mentor = Mentor.first(id: id.mentorID)
    @mentorIDList.push(mentor) unless mentor.nil?
  end
  erb :sent_mentor_applications
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

#Mentee accepts mentor
post "/matchWithMentor" do
  #When mentee accepts application, sets mentorAccept to the id of the mentor they are accepting
  $mentees = Mentee.first(id: $mentees.id)
  mentor = Mentor.first(id: params[:mentorID])
  
  $mentees.mentorAccept = mentor.id
  $mentees.save_changes
  
  reqS = Request.where(mentorID: params[:mentorID]).all
  
  #If both mentor and mentee have accepted the each others request both will be matched and both users notified of match but
  #if the mentee only has accepted the application then the mentor is notified
  if mentor.menteeAccept == $mentees.id && $mentees.mentorAccept == mentor.id
    
    
    Mentor.where(id: params[:mentorID]).update(:menteeMatch => $mentees.id)

    Mentee.where(id: $mentees.id).update(:mentorMatch => params[:mentorID])

    #Gets all the requests sent to the mentor being matched, and resets field values for mentees with
    #whom the mentor isn't being matched
    req_all = Request.where(mentorID: params[:mentorID]).all
    req_all.each do |req|
      other_mentees = Mentee.first(id: req.menteeID)
      if other_mentees.id != $mentees.id
        other_mentees.applicationNumber = 1
        other_mentees.mentorAccept = 0
        other_mentees.save_changes
      end
    end
        
    Request.where(mentorID: mentor.id).delete #Deletes all records from requests table based on the id of the mentor being matched

    mentor.profileStatus = "1" #mentor profile made private
    mentor.save_changes

    $mentees.applicationNumber = 0 #mentee can't send more applications
    $mentees.save_changes

    send_mail($mentees.email, 
      "You have been paired with a mentor!", 
      "Hi "+$mentees.fname+" "+$mentees.lname+"!\n"+
      "Your new mentor is: "+mentor.fname+" "+mentor.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")

    send_mail(mentor.email, 
      "You have been paired with a mentee!", 
      "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
      "Your new mentee is: "+$mentees.fname+" "+$mentees.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")

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
    Mentee.where(id: params[:menteeID]).update(:mentorMatch => $mentors.id)

    Mentor.where(id: $mentors.id).update(:menteeMatch => params[:menteeID])
    
    #Gets all the requests sent to the mentor being matched, and resets field values for mentees with
    #whom the mentor isn't being matched
    reqS = Request.where(mentorID: $mentors.id).all
    reqS.each do |req|
      other_mentees = Mentee.first(id: req.menteeID)
      if other_mentees.id != mentee.id
        other_mentees.applicationNumber = 1
        other_mentees.mentorAccept = 0
        other_mentees.save_changes
      end
    end
    
    Request.where(mentorID: $mentors.id).delete #Deletes all records from requests table based on the id of the mentor being matched

    $mentors.profileStatus = "1" #mentor profile made private
    $mentors.save_changes

    mentee.applicationNumber = 0 #mentee can't send more applications
    mentee.save_changes
    
    send_mail($mentors.email, 
      "You have been paired with a mentee!", 
      "Hi "+$mentors.fname+" "+$mentors.lname+"!\n"+
      "Your new mentee is: "+mentee.fname+" "+mentee.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")

    send_mail(mentee.email, 
      "You have been paired with a mentor!", 
      "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
      "Your new mentor is: "+$mentors.fname+" "+$mentors.lname+".\n"+
      "Please login into your account for more details.\n"+
      "\n\n\nRegards\nTeam 6")

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
    
  redirect "/MentorDashboard"
end

#Mentor rejects a mentee application
post "/rejectMentee" do   
  #Deletes the corresponding request the mentee has made from the table
  Request.where(mentorID: $mentors.id, menteeID: params[:menteeID]).delete
  
  mentee = Mentee.first(id: params[:menteeID]) #Gets the existing mentee based on id
  mentor = Mentor.first(id: $mentors.id) #Gets the existing mentor based on id
  
  if mentor.menteeAccept == mentee.id || mentee.mentorAccept == mentor.id
    mentor.menteeAccept = 0
    mentor.save_changes
  end
  
  mentee.applicationNumber = 1 #Mentee can now send a mentor an application
  mentee.mentorAccept = 0 #Resets field if mentee has already accepted the request
  mentee.save_changes
  
  #Sends an email to mentee that their application was rejected
  send_mail(mentee.email, 
    "Rejected application!", 
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
  
  if mentor.menteeAccept == $mentees.id || $mentees.mentorAccept == mentor.id
    mentor.menteeAccept = 0
    mentor.save_changes
  end
  
  $mentees.applicationNumber = 1 #Mentee can now send a mentor an application
  $mentees.mentorAccept = 0 #Resets field if mentee has already accepted the request
  $mentees.save_changes
  
  #Sends an email to mentor that the mentee unsent their application
   send_mail(mentor.email, 
    "Withdrawn mentee application!", 
    "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
    "A mentee has withdrawn their application.\n"+
    "\n\n\nRegards\nTeam 6")
  
  redirect "/sentMentorApplications"
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



#Route for the admin to view pending mentee applications
get "/PendingMenteeApplications" do
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

#Lists all paired mentees, so an admin can search for paired mentees within a faculty
get "/PairedMentees" do
  #New variable to enable admins to search for mentees based on faculty
  @faculty_search = params.fetch("faculty_search", "").strip
  
  #If no faculty is being searched, it displays the list of all paired mentees in alphabetical order 
  #else it searches through the faculty field in the mentees table and displays paired mentees' whose 
  #faculty is being searched
    @mentees = if @faculty_search.empty? 
                 Mentee.order(:faculty).where(~Sequel.like(:mentorMatch, 0)) #Displays mentees where they have a mentor matched
               else
                 Mentee.order(:faculty).where(Sequel.ilike(:faculty, "%#{@faculty_search}%")) #ilike used to make search case insensitive
               end
    
    @menteesList = []
    @mentors = []
    @mentees.each do |mentee|
      mentee = Mentee.first(id: mentee.id)
      mentor = Mentor.first(id: mentee.mentorMatch)
      
      @menteesList.push([mentee.name, mentee.email, mentee.faculty]) #Mentee information
      @mentors.push([mentor.name, mentor.email]) #Mentor information
      
    end

  erb :paired_mentees
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
  mentee_requesting.requestMentorMeeting = $mentee_req #so field is updated in the t
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








