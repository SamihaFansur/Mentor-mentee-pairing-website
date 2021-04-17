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
    send_mail(mentee.email, 
        "Sorry to see you go!", 
        "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
        "Your mentee account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
    session.clear
    redirect "/index"
  elsif session[:admins_username]  #if admin deletes mentee profile
    send_mail(mentee.email, 
        "Sorry to see you go!", 
        "Hi "+mentee.fname+" "+mentee.lname+"!\n"+
        "Your mentee account has been successfully deleted by an admin.\n"+
        "If you think there has been a mistake please contact an admin using our contact form."+
        "\n\n\nRegards\nTeam 6")
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
    redirect "/searchForAMentor"
  elsif session[:mentors_username] #if mentor deletes their profile themselves
  send_mail(mentor.email, 
        "Sorry to see you go!", 
        "Hi "+mentor.fname+" "+mentor.lname+"!\n"+
        "Your mentor account has been successfully deleted.\n"+
        "\n\n\nRegards\nTeam 6")
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
