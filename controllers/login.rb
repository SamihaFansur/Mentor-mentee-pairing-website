get "/MenteeDashboard" do
  redirect "/login" unless session[:logged_in] #If mentee logged in then display mentee dashbard, otherwise redirect to login page
  username = session[:mentees_username] #Logs user in
  #Gets the mentee information that corresponds to the username
  $mentees = Mentee.first(username: username) # '$' used to make it a global variable
  
  #Initializing the field value for applicationNumber 
  #So that mentee can only request 1 mentor every 2 weeks
  if $mentees.applicationNumber == nil 
    $mentees.applicationNumber  = 1
  end
  
  #Initializing mentorMatch field in mentees table
  if $mentees.mentorMatch == nil
    $mentees.mentorMatch = 0
  end
  
  #Initializing mentorAccept field in mentees table
  if $mentees.mentorAccept == nil
    $mentees.mentorAccept = 0
  end
  
  #Initializing requestMentorMeeting field in mentees table
  if $mentees.requestMentorMeeting == nil
    $mentees.requestMentorMeeting = 0
  end
  
  $mentees.save_changes
  
  erb :mentee_dashboard
end

get "/MentorDashboard" do
  redirect "/login" unless session[:logged_in] #If mentee logged in then display mentee dashbard, otherwise redirect to login page
  username = session[:mentors_username] #Logs user in
  #Gets the mentor information that corresponds to the username
  $mentors = Mentor.first(username: username) # '$' used to make it a global variable
  
  #initializing the profileStatus field to 0
  if $mentors.profileStatus != "1"
    $mentors.profileStatus = "0"
  end
  
  #Initializing menteeMatch field in mentors table
  if $mentors.menteeMatch == nil
    $mentors.menteeMatch = 0
  end
  
  #Initializing menteeAccept field in mentors table
  if $mentors.menteeAccept == nil
    $mentors.menteeAccept = 0
  end
  
  #Initializing reportMentee field in mentors table
  if $mentors.reportMentee == nil
    $mentors.reportMentee = 0
  end
  
  $mentors.save_changes
  
  erb :mentor_dashboard
end

get "/AdminDashboard" do
  redirect "/login" unless session[:logged_in] #If admin logged in then display admin dashbard, otherwise redirect to login page
  username = session[:admins_username] #Logs user in
  #Gets the admin information that corresponds to the username
  $admins = Admin.first(username: username) # '$' used to make it a global variable
  admin_activation_email($admins)
  erb :admin_dashboard
end

get "/AdminMentorDashboard" do
  redirect "/login" unless session[:logged_in] #If admin logged in then display dashbard, otherwise redirect to login page
  username = session[:mentors_username] #Logs user in
  #Gets the admin information that corresponds to the username
  $mentors = Mentor.first(username: username) # '$' used to make it a global variable
  admin_activation_email($mentors)
  erb :adminMentor_dashboard
end

get "/login" do
  new_mentee_instance
  new_mentor_instance
  new_admin_instance
  
  erb :login
end

get "/loginAgain" do
  new_mentor_instance  
  erb :loginAgain
end

post '/login' do
  new_mentee_instance
  @mentees.load(params) #Loads parameters
  
  new_mentor_instance
  @mentors.load(params) #Loads parameters
  
  new_admin_instance
  @admins.load(params) #Loads parameters
  
  @suspend_check = false
  
  #If mentor username and password match to the values in the database mentor logged in and redirected to mentor dashboard
  #if combination incorrect then displays error
  if @mentees.valid?
    if @mentees.exist_login? && @mentees.account_suspended?.to_s == "false"
      session[:logged_in] = true
      session[:mentees_username] = @mentees.username
      redirect "/MenteeDashboard"
    else
      if @mentees.account_suspended?.to_s == "true"
        @suspend_check = true
      else
        @error = "Username/Password combination incorrect"
      end
    end
  else
    @error = "Please correct the information below"
  end
  
  #If mentor username and password match to the values in the database mentor logged in and redirected to mentor dashboard
  #if combination incorrect then displays error
  if @mentors.valid?
    if @mentors.exist_login? && @mentors.account_suspended?.to_s == "false"
      session[:logged_in] = true
      session[:mentors_username] = @mentors.username
      redirect "/MentorDashboard"
    else
      if @mentors.account_suspended?.to_s == "true"
        @suspend_check = true
      else
        @error = "Username/Password combination incorrect"
      end
    end
  else
    @error = "Please correct the information below"
  end
  
  #If admin username and password match to the values in the database admin logged in and redirected to admin dashboard
  #if combination incorrect then displays error
  if @admins.valid?
    if @admins.exist_login?
      session[:logged_in] = true
      session[:admins_username] = @admins.username
      redirect "/AdminLoginChoices"
    end
  else
    @error = "Please correct the information below"
  end
  
  @error = "Your account is suspended" if @suspend_check
  erb :login

end


post '/loginAgain' do
  new_mentor_instance
  @mentors.load(params) #Loads parameters
 
  @error = nil #initializing variable
  @suspend_check = false
  
  #If mentor username and password match to the values in the database mentor logged in and redirected to mentor dashboard
  #if combination incorrect then displays error
   if @mentors.valid?
    if @mentors.exist_login? && @mentors.account_suspended?.to_s == "false"
      session[:logged_in] = true
      session[:mentors_username] = @mentors.username
      redirect "/AdminMentorDashboard"
    else
      if @mentors.account_suspended?.to_s == "true"
        @suspend_check = true
      else
        @error = "Username/Password combination incorrect"
      end
    end
  else
    @error = "Please correct the information below"
  end
  
  @error = "Your account is suspended" if @suspend_check
  erb :loginAgain

end

def admin_activation_email(user)
  if user.activationToken != 1 #initially not 1 so account activation email can be sent on the very first login only
    send_mail(user.email, 
      "Successful Account Activation!", 
      "Hi "+user.fname+" "+user.lname+"!\n"+
      "You have successfully activated your admin account \n"+
      "Your username is: "+user.username+"\n"+
      "Your email: "+user.email+"\n"+
      "Please use these credentials to login into your admin account. \n"+
      "\n\n\nRegards\nTeam 6")
    user.activationToken = 1 #changes value to 1 so activation email not sent again
    user.save_changes
  end
end
