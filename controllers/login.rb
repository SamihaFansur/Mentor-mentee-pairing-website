get "/MenteeDashboard" do
  redirect "/login" unless session[:logged_in]
  username = session[:mentees_username]
  @mentees = Mentee.first(username: username)
  erb :mentee_dashboard
end

get "/MentorDashboard" do
  redirect "/login" unless session[:logged_in]
  username = session[:mentors_username]
  @mentors = Mentor.first(username: username)
  erb :mentor_dashboard
end

get "/login" do
  @mentees = Mentee.new
  
  @mentors = Mentor.new
  erb :login
end

post '/login' do
  @mentees = Mentee.new
  @mentees.load(params)
  
  @mentors = Mentor.new
  @mentors.load(params)
  
  @error = nil

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

  erb :login
end

get "/logout" do
  session.clear
  erb :logout
end
