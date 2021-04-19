require "net/http"

###############################MENTEE######################################
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
    send_mail(mentee.email, 
        "Sorry to see you go!", 
        "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
        "Your mentee account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
    if mentee.mentorMatch != 0
      mentor = Mentor.first(id: mentee.mentorMatch)
      #Sends matched mentor an email
      send_mail(mentor.email, 
          "Your mentee has deleted their account!", 
          "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
          "Your mentee has deleted their account. You can now accept other mentee requests.\n"+
          "\n\n\nRegards\nTeam 6")
      mentor.profileStatus = 0
      mentor.menteeMatch = 0
      mentor.save_changes      
    end
    session.clear
    redirect "/index"
  elsif session[:admins_username]  #if admin deletes mentee profile
    #Sends mentee email
    send_mail(mentee.email, 
        "Sorry to see you go!", 
        "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
        "Your mentee account has been successfully deleted by an admin.\n"+
        "If you think there has been a mistake please contact an admin using our contact form."+
        "\n\n\nRegards\nTeam 6")
    #If mentee has a matched mentor, sends mentor an email about mentee account deletion, 
    #sets profile to public, and resets menteeMatch field to 0
    if mentee.mentorMatch != 0
      mentor = Mentor.first(id: mentee.mentorMatch)
      #Sends matched mentor an email
      send_mail(mentor.email, 
          "Your mentee has deleted their account!", 
          "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
          "Your mentee has deleted their account. You can now accept other mentee requests.\n"+
          "\n\n\nRegards\nTeam 6")
      mentor.profileStatus = 0
      mentor.menteeMatch = 0
      mentor.save_changes      
    end
    redirect "searchForAMentee"
  end
end

###############################MENTOR######################################
post "/deleteMentor" do
  id = params["id"]  #new variable to search the id of corresponding mentor to be deleted
  request = Request.where(mentorID: id) #To delete mentor applications corresponding to mentors' id
  
  #If mentor deletes own profile then profile deleted, mentor sent email, logged out and redirected to index page
  #if an admin deletes mentor profile, mentor notified through email
  mentor = Mentor[id]
  mentor.delete
  request.delete #removes mentee application from databse
  if session[:admins_username] #if admin deletes mentor profile
    send_mail(mentor.email, 
          "Sorry to see you go!", 
          "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
          "Your mentor account has been successfully deleted by an admin.\n"+
          "If you think there has been a mistake please contact an admin using our contact form."+
          "\n\n\nRegards\nTeam 6")
    #If mentor has a matched mentee, sends mentee an email about mentor account deletion, 
    #sets applicationNumber to 1, and resets mentorMatch field to 0
    if mentor.menteeMatch != 0
      mentee = Mentee.first(id: mentor.menteeMatch)
      #Sends matched mentee an email
      send_mail(mentee.email, 
          "Your mentor has deleted their account!", 
          "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
          "Your mentor has deleted their account. You can now send other mentor requests.\n"+
          "\n\n\nRegards\nTeam 6")
      mentee.applicationNumber = 1
      mentee.mentorMatch = 0
      mentee.save_changes      
    end
    redirect "/searchForAMentor"
  elsif session[:mentors_username] #if mentor deletes their profile themselves
    send_mail(mentor.email, 
          "Sorry to see you go!", 
          "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
          "Your mentor account has been successfully deleted.\n"+
          "\n\n\nRegards\nTeam 6")
    #If mentor has a matched mentee, sends mentee an email about mentor account deletion, 
    #sets applicationNumber to 1, and resets mentorMatch field to 0
    if mentor.menteeMatch != 0
      mentee = Mentee.first(id: mentor.menteeMatch)
      #Sends matched mentee an email
      send_mail(mentee.email, 
          "Your mentor has deleted their account!", 
          "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
          "Your mentor has deleted their account. You can now send other mentor requests.\n"+
          "\n\n\nRegards\nTeam 6")
      mentee.applicationNumber = 1
      mentee.mentorMatch = 0
      mentee.save_changes      
    end
    session.clear
    redirect "/index"
  end
    
end

###############################ADMIN######################################
post "/deleteAdmin" do
  id = params["id"]  #new variable to search the id of corresponding admin to be deleted
  
  #If admin deletes own profile then profile deleted, admin sent email, logged out and redirected to index page
  admin = Admin[id]
  admin.delete
  send_mail(admin.email, 
        "Sorry to see you go!", 
        "Hi "+admin.fname+" "+admin.lname+"!\n"+
        "Your admin account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
  session.clear
  redirect "/index"
  
end


def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("https://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end
