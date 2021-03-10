get "/" do
  redirect "/login" unless session[:logged_in]
  erb :index
end

get "/login" do
  @mentees = Mentee.new
  erb :login
end

post '/login' do
  @mentees = Mentee.new
  @mentees.load(params)
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

  erb :login
end

get "/logout" do
  session.clear
  erb :logout
end