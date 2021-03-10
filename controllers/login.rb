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
  puts "check 1"

  if @mentees.valid?
      puts "check 2"
    if @mentees.exist?
      session[:logged_in] = true
      redirect "/"
      puts "check 3"
    else
      puts "check 4"
      @error = "Username/Password combination incorrect"
    end
  else
      puts "check 5"
    @error = "Please correct the information below"
  end

  erb :login
end