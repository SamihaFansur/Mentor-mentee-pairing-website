get "/MenteeDashboard" do
  redirect "/login" unless session[:logged_in] #If mentee logged in then display mentee dashbard, otherwise redirect to login page
  username = session[:mentees_username] #Logs user in
  #Gets the mentee information that corresponds to the username
  $mentees = Mentee.first(username: username) # '$' used to make it a global variable
  
  #Initializing fields
  if $mentees.applicationNumber == nil 
    $mentees.applicationNumber  = 1  #Mentee can only request 1 mentor every 2 weeks
  end
  
  if $mentees.mentorMatch == nil
    $mentees.mentorMatch = 0
  end
  
  if $mentees.mentorAccept == nil
    $mentees.mentorAccept = 0
  end
  
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
  
  #Initializing fields
  if $mentors.menteeMatch == nil
    $mentors.menteeMatch = 0
  end
  
  if $mentors.menteeAccept == nil
    $mentors.menteeAccept = 0
  end
  
  if $mentors.reportMentee == nil
    $mentors.reportMentee = 0
  end
  
  if $mentors.profileStatus == nil
    $mentors.profileStatus = 1 #Sets profile status to public
  end
  $mentors.save_changes
  erb :mentor_dashboard
end

get "/AdminDashboard" do
  redirect "/login" unless session[:logged_in] #If admin logged in then display admin dashboard, otherwise redirect to login page
  username = session[:admins_username] #Logs user in
  #Gets the admin information that corresponds to the username
  $admins = Admin.first(username: username) # '$' used to make it a global variable
  admin_activation_email($admins, "Admin")
  erb :admin_dashboard
end

get "/AdminMentorDashboard" do
  redirect "/login" unless session[:logged_in] #If adminMentor logged in then display adminMentor dashbard, otherwise redirect to login page
  username = session[:mentors_username] #Logs user in
  #Gets the user information that corresponds to the username
  $mentors = Mentor.first(username: username) # '$' used to make it a global variable
  admin_activation_email($mentors, "Admin + Mentor")
  $user = "user" #New variable so user is redirected to appropriate page after editing a mentor profile
  
  #Initializing fields
  if $mentors.menteeMatch == nil
    $mentors.menteeMatch = 0
  end
  
  if $mentors.menteeAccept == nil
    $mentors.menteeAccept = 0
  end
  
  if $mentors.reportMentee == nil
    $mentors.reportMentee = 0
  end
  
  if $mentors.profileStatus == nil
    $mentors.profileStatus = 1 #Sets profile status to public
  end
  $mentors.save_changes
  erb :adminMentor_dashboard
end

post '/login' do
  new_mentee_instance
  @mentees.load(params)
  
  new_mentor_instance
  @mentors.load(params)
  
  new_admin_instance
  @admins.load(params)
  
  @suspend_check = false #To check if account is not suspended
  
  #If username and password match to the values in the database, user logged in and redirected to appropriate dashboard
  #if combination incorrect then displays error. If admin credentials correct, user direct to another page, incase
  #admin is also a mentor.
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
  @mentors.load(params)
 
  @suspend_check = false
  
  #If mentor username and password match to the values in the database. Mentor logged in and redirected to adminMentor dashboard
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

#Sends account activation email for admin and adminMentor accounts only. Method takes in users, and account type as prameters.
def admin_activation_email(user, accountType)
  if user.activationToken != 1 #initially not 1 so account activation email can be sent on the very first login only
    send_mail(user.email, 
      "Successful Account Activation!", 
      "Hi "+user.fname+" "+user.lname+"!\n"+
      "You have successfully activated your "+accountType+" account \n"+
      "Your username is: "+user.username+"\n"+
      "Your password: "+user.password+"\n"+
      "Your email: "+user.email+"\n"+
      "Please use these credentials to login into your "+accountType+" account. \n"+
      "\n\n\nRegards\nTeam 6")
    user.activationToken = 1 #changes value to 1 so activation email not sent again
    user.save_changes
  end
end
