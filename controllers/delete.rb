post "/deleteMentee" do
  id = params["id"]  #new variable to search the id of corresponding mentee to be deleted, id gotten from delete button being pressed
  #Gets the request where mentee id is the id of the mentor being deleted, to delete mentor applications corresponding to mentees' id
  request = Request.where(menteeID: id)
  mentee = Mentee[id]
  mentee.delete
  request.delete #removes application from databse
  
  #If mentee deletes own profile then profile deleted, mentee sent email, mentee logged out and redirected to index page
  #if an admin deletes mentee profile, mentee notified through email. If mentee matched, then matched mentor sent email about
  #their mentees account deletion
  if session[:mentees_username]  #if mentee deletes their profile themselves
    delete_account_email(mentee, "mentee")
    mentee_deleted_reset_all_users_fields(mentee, mentee.mentorMatch)
    session.clear
    redirect "/"
  elsif session[:admins_username]  #if admin deletes mentee profile
    admin_delete_account_email(mentee, "mentee")
    mentee_deleted_reset_all_users_fields(mentee, mentee.mentorMatch)
    redirect "/searchForAMentee"
  end
end

post "/deleteMentor" do
  id = params["id"]  #new variable to search the id of corresponding mentor to be deleted, id gotten from delete button being pressed
  request = Request.where(mentorID: id) #To delete mentor applications corresponding to mentors' id
  mentor = Mentor[id]
  mentor.delete
  request.delete #removes application from databse
  
  #If mentor deletes own profile then profile deleted, mentor sent email, mentor logged out and redirected to index page
  #if an admin deletes mentor profile, mentor notified through email.  If mentor matched, then matched mentee sent email about
  #their mentors account deletion
  if session[:admins_username] #if admin deletes mentor profile
    admin_delete_account_email(mentor, "mentor")
    mentor_deleted_reset_all_users_fields(mentor, mentor.menteeMatch)
    redirect "/searchForAMentor"
  elsif session[:mentors_username] #if mentor deletes their profile themselves
    delete_account_email(mentor, "mentor")
    mentor_deleted_reset_all_users_fields(mentor, mentor.menteeMatch)
    session.clear
    redirect "/"
  end
end

post "/deleteAdmin" do
  id = params["id"]  #new variable to search the id of corresponding admin to be deleted, id gotten from delete button being pressed
  
  #Profile deleted, admin sent email, logged out and redirected to index page
  admin = Admin[id]
  admin.delete
  delete_account_email(admin, "admin")
  session.clear
  redirect "/"
end

#Method takes user and type of user as its parameters
def delete_account_email(user, type)
  send_mail(user.email, 
        "Sorry to see you go!", 
        "Hi "+user.fname+" "+user.lname+"!\n"+
        "Your "+type+" account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
end

#Method takes user and type of user as its parameters
def admin_delete_account_email(user, type)
  send_mail(user.email, 
          "Sorry to see you go!", 
          "Hi "+user.fname+" "+user.lname+"!\n"+
          "Your "+type+" account has been successfully deleted by an admin.\n"+
          "If you think there has been a mistake please contact an admin using our contact form."+
          "\n\n\nRegards\nTeam 6")
end

#Method takes user deleting, matched user, and the action the matched user can perform
def matched_user_deleted(userDeleting, matchedUser, action) 
  send_mail(matchedUser.email, 
          "Your "+userDeleting+" has deleted their account!", 
          "Hi "+matchedUser.fname+" "+matchedUser.lname+"!\n"+
          "Your "+userDeleting+" has deleted their account. You can now "+action+" other "+userDeleting+" requests.\n"+
          "\n\n\nRegards\nTeam 6")
end

#Method takes the mentee(created on line 5), and id of the matched mentor as its parameters
def mentee_deleted_reset_all_users_fields(user, matchedUserID)
  #If mentee has a matched mentor, sends mentor an email about mentee account deletion, deletes any request a mentee has sent,
  #sets mentor profile to public, and resets menteeMatch & menteeAccept field to 0
  if matchedUserID != 0
    mentor = Mentor.first(id: matchedUserID) #Gets the mentor who is matched to the mentee based on mentor id, id is the 2nd parameter of the method
    
    report_all = Report.where(mentorID: mentor.id)
    report_all.each do |report|
      report.delete
    end
    
    #Sends matched mentor an email
    matched_user_deleted("mentee", mentor, "accept")
    mentor.profileStatus = 1 #profile made public
    mentor.menteeAccept = 0
    mentor.menteeMatch = 0
    mentor.save_changes      
  end
end

#Method takes the mentor(created on line 27), and id of the matched mentee as its parameters
def mentor_deleted_reset_all_users_fields(user, matchedUserID)
  #If mentor has a matched mentee, sends mentee an email about mentor account deletion, deletes any request sent to the mentor, 
  #sets mentee applicationNumber to 1, and resets mentorMatch & menteeAccept field to 0
  if matchedUserID != 0
    mentee = Mentee.first(id: matchedUserID)
    
    report_all = Report.where(mentorID: mentee.mentorMatch)
    report_all.each do |report|
      report.delete
    end
    
    #Sends matched mentee an email
    matched_user_deleted("mentor", mentee, "send")
    mentee.applicationNumber = 1
    mentee.mentorAccept = 0
    mentee.mentorMatch = 0
    mentee.save_changes      
  end
end