post "/deleteMentee" do
  id = params["id"]  #new variable to search the id of corresponding mentee to be deleted
  request = Request.where(menteeID: id) #To delete mentor applications corresponding to mentees' id
    
  #If mentee deletes own profile then profile deleted, mentee sent email, logged out and redirected to index page
  #if an admin deletes mentee profile, mentee notified through email
  mentee = Mentee[id]
  mentee.delete
  request.delete #removes mentor application from databse
  if session[:mentees_username]  #if mentee deletes their profile themselves
    #Sends mentee email
    delete_account_email(mentee, "mentee")
    mentee_deleted_reset_all_users_fields(mentee, mentee.mentorMatch)
    session.clear
    redirect "/"
  elsif session[:admins_username]  #if admin deletes mentee profile
    admin_delete_account_email(mentee, "mentee")
    mentee_deleted_reset_all_users_fields(mentee, mentee.mentorMatch)
    redirect "searchForAMentee"
  end
end

post "/deleteMentor" do
  id = params["id"]  #new variable to search the id of corresponding mentor to be deleted
  request = Request.where(mentorID: id) #To delete mentor applications corresponding to mentors' id
  
  #If mentor deletes own profile then profile deleted, mentor sent email, logged out and redirected to index page
  #if an admin deletes mentor profile, mentor notified through email
  mentor = Mentor[id]
  mentor.delete
  request.delete #removes mentee application from databse
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
  id = params["id"]  #new variable to search the id of corresponding admin to be deleted
  
  #If admin deletes own profile then profile deleted, admin sent email, logged out and redirected to index page
  admin = Admin[id]
  admin.delete
  delete_account_email(admin, "admin")
  session.clear
  redirect "/"
  
end

def delete_account_email(user, type)
  send_mail(user.email, 
        "Sorry to see you go!", 
        "Hi "+user.fname+" "+user.lname+"!\n"+
        "Your "+type+" account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
end

def admin_delete_account_email(user, type)
  send_mail(user.email, 
          "Sorry to see you go!", 
          "Hi "+user.fname+" "+user.lname+"!\n"+
          "Your "+type+" account has been successfully deleted by an admin.\n"+
          "If you think there has been a mistake please contact an admin using our contact form."+
          "\n\n\nRegards\nTeam 6")
end

def matched_user_deleted(userDeleting, matchedUser, action) 
  send_mail(matchedUser.email, 
          "Your "+userDeleting+" has deleted their account!", 
          "Hi "+matchedUser.fname+" "+matchedUser.lname+"!\n"+
          "Your "+userDeleting+" has deleted their account. You can now "+action+" other "+userDeleting+" requests.\n"+
          "\n\n\nRegards\nTeam 6")
end

#If mentee has a matched mentor, sends mentor an email about mentee account deletion, 
#sets profile to public, and resets menteeMatch field to 0
def mentee_deleted_reset_all_users_fields(user, matchedUserID)
  if matchedUserID != 0
    mentor = Mentor.first(id: matchedUserID)
    
    report_all = Report.where(mentorID: mentor.id)
    report_all.each do |report|
      report.delete
    end
    
    #Sends matched mentor an email
    matched_user_deleted("mentee", mentor, "accept")
    mentor.profileStatus = 1
    mentor.menteeAccept = 0
    mentor.menteeMatch = 0
    mentor.save_changes      
  end
end

#If mentor has a matched mentee, sends mentee an email about mentor account deletion, 
#sets applicationNumber to 1, and resets mentorMatch field to 0
def mentor_deleted_reset_all_users_fields(user, matchedUserID)
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