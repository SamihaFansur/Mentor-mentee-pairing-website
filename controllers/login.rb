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

get "/login" do
  #Creates a new instance of a Mentee when user logs in
  @mentees = Mentee.new
    
  #Creates a new instance of a Mentor when user logs in
  @mentors = Mentor.new
  erb :login
end

post '/login' do
  @mentees = Mentee.new
  @mentees.load(params) #Loads parameters
  
  @mentors = Mentor.new
  @mentors.load(params) #Loads parameters
  
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

end

get "/logout" do
  session.clear #Clears session when user logs out
  erb :logout
end
