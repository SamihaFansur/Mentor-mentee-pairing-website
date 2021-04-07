get "/MenteeDashboard" do
  redirect "/login" unless session[:logged_in] #If mentee logged in then display mentee dashbard, otherwise redirect to login page
  username = session[:mentees_username] #Logs user in
  #Gets the mentee information that corresponds to the username
  $mentees = Mentee.first(username: username) # '$' used to make it a global variable
  erb :mentee_dashboard
end

get "/MentorDashboard" do
  redirect "/login" unless session[:logged_in] #If mentee logged in then display mentee dashbard, otherwise redirect to login page
  username = session[:mentors_username] #Logs user in
  #Gets the mentor information that corresponds to the username
  $mentors = Mentor.first(username: username) # '$' used to make it a global variable
  erb :mentor_dashboard
end

get "/AdminDashboard" do
  redirect "/login" unless session[:logged_in] #If admin logged in then display admin dashbard, otherwise redirect to login page
  username = session[:admins_username] #Logs user in
  #Gets the admin information that corresponds to the username
  $admins = Admin.first(username: username) # '$' used to make it a global variable
  if $admins.activationToken == 0 #initially set to 0 so account activation email can be sent on the very first login only
    send_mail($admins.email, 
      "Successful Account Activation!", 
      "Hi "+$admins.fname+" "+$admins.lname+"!\n"+
      "You have successfully activated your admin account \n"+
      "Your username is: "+$admins.username+"\n"+
      "Your email: "+$admins.email+"\n"+
      "Please use these credentials to login into your admin account \n"+
      "\n\n\nRegards\nTeam 6")
    $admins.activationToken = 1 #changes value to 1 so activation email not sent again
    $admins.save_changes
  end
  erb :admin_dashboard
end

get "/AdminMentorDashboard" do
  redirect "/login" unless session[:logged_in] #If admin logged in then display dashbard, otherwise redirect to login page
  username = session[:mentors_username] #Logs user in
  #Gets the admin information that corresponds to the username
  $mentors = Mentor.first(username: username) # '$' used to make it a global variable
  if $mentors.activationToken != 1 #initially empty so account activation email can be sent on the very first login only
    send_mail($mentors.email, 
      "Successful Account Activation!", 
      "Hi "+$mentors.fname+" "+$mentors.lname+"!\n"+
      "You have successfully activated your admin account \n"+
      "Your username is: "+$mentors.username+"\n"+
      "Your email: "+$mentors.email+"\n"+
      "Please use these credentials to login into your admin account \n"+
      "\n\n\nRegards\nTeam 6")
    $mentors.activationToken = 1 #changes value to 1 so activation email not sent again
    $mentors.save_changes
  end
  erb :adminMentor_dashboard
end

def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("https://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end

get "/login" do
  #Creates a new instance of a Mentee when user logs in
  @mentees = Mentee.new
    
  #Creates a new instance of a Mentor when user logs in
  @mentors = Mentor.new
  
  #Creates a new instance of an Admin when user logs in
  @admins = Admin.new
  
  erb :login
end

get "/loginAgain" do
  #Creates a new instance of a Mentor when user logs in
  @mentors = Mentor.new
  
  erb :loginAgain
end

post '/login' do
  @mentees = Mentee.new
  @mentees.load(params) #Loads parameters
  
  @mentors = Mentor.new
  @mentors.load(params) #Loads parameters
  
  @admins = Admin.new
  @admins.load(params) #Loads parameters
  
  @error = nil #initializing variable
  
  #If mentee username and password match to the values in the database mentee logged in and redirected to mentee dashboard
  #if combination incorrect then displays error
  if @mentees.valid?
    if @mentees.exist_login?
      session[:logged_in] = true
      session[:mentees_username] = @mentees.username
      redirect "/MenteeDashboard"
    else
      @error = "Username/Password combination incorrect"
    end
  else
    @error = "Please correct the information below"
  end
  
  #If mentor username and password match to the values in the database mentor logged in and redirected to mentor dashboard
  #if combination incorrect then displays error
  if @mentors.valid?
    if @mentors.exist_login?
      session[:logged_in] = true
      session[:mentors_username] = @mentors.username
      redirect "/MentorDashboard"
    else
      @error = "Username/Password combination incorrect"
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
      redirect "/AdminLoginChoices" #redirects admins to a page incase admins are also mentors
    else
      @error = "Username/Password combination incorrect"
    end
  else
    @error = "Please correct the information below"
  end
  
  erb :login

end


post '/loginAgain' do
  @mentors = Mentor.new
  @mentors.load(params) #Loads parameters
 
  @error = nil #initializing variable
  
  #If mentor username and password match to the values in the database mentor logged in and redirected to mentor dashboard
  #if combination incorrect then displays error
  if @mentors.valid?
    if @mentors.exist_login?
      session[:logged_in] = true
      session[:mentors_username] = @mentors.username
      redirect "/AdminMentorDashboard"
    else
      @error = "Username/Password combination incorrect"
    end
  else
    @error = "Please correct the information below"
  end
  
  erb :login

end

get "/logout" do
  session.clear #Clears session when user logs out
  erb :logout
end

get "/AdminLoginChoices" do
  erb :adminLogin_choices
end