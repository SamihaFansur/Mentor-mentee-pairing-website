get "/" do
  redirect "/login" unless session[:logged_in]
  erb :dashboard
end

get "/login" do
  @mentees = Mentee.new
  
  @mentors = Mentee.new
  erb :login
end

post '/login' do
  @mentees = Mentee.new
  @mentees.load(params)
  
  @mentors = Mentor.new
  @mentors.load(params)
  
  @error = nil

  if @mentees.valid?
    if @mentees.exist?
      session[:logged_in] = true
      redirect "/"
    else
      @error = "Username/Password combination incorrect"
    end
  else
    @error = "Please correct the information below"
  end
  
  if @mentors.valid?
    if @mentors.exist?
      session[:logged_in] = true
      redirect "/"
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
