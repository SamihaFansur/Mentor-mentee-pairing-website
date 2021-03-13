get "/index" do
  @header = nil
#   @logged_in = session[:logged_in]
#   puts session[:logged_in]
  if session[:logged_in]
    puts "check 1"
    if session[:mentees_username] 
      puts "mentee logged in"
      @header = erb:"common/header_menteeA"
    else
      puts "mentor logged in"
      @header = erb:"common/header_mentorA"
    end
  else 
    puts "check 2"
    @header = erb:"common/headerB"
  end
  erb :index
end

get "/contact" do
   @header = nil
  if session[:logged_in]
    puts "check 1"
    if session[:mentees_username] 
      puts "mentee logged in"
      @header = erb:"common/header_menteeA"
    else
      puts "mentor logged in"
      @header = erb:"common/header_mentorA"
    end
  else 
    puts "check 2"
    @header = erb:"common/headerB"
  end
  erb :contact
end

get "/accessibility" do
   @header = nil
  if session[:logged_in]
    puts "check 1"
    if session[:mentees_username] 
      puts "mentee logged in"
      @header = erb:"common/header_menteeA"
    else
      puts "mentor logged in"
      @header = erb:"common/header_mentorA"
    end
  else 
    puts "check 2"
    @header = erb:"common/headerB"
  end
  erb :accessibility
end

get "/SignUpChoices" do
  erb :signup_choices
end

get "/LoginPage" do
  erb :login
end

get "/MenteeSignUpForm" do
  erb :mentee_signup
end

post "/index" do
  puts params
  redirect "/index"

end

get "/MentorSignUpForm" do
  erb :mentor_signup
end
