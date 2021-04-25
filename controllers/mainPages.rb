get "/" do
  headers_common_pages
  erb :index
end

get "/contact" do
  headers_common_pages  
  erb :contact
end

get "/accessibility" do
  headers_common_pages  
  erb :accessibility
end

get "/SignUpChoices" do
  erb :signup_choices #Leads to a page which asks user to sign up as either mentee or as a mentor
end

get "/LoginPage" do
  erb :login
end

get "/MenteeSignUpForm" do
  erb :mentee_signup
end

post "/" do
  redirect "/"
end

get "/MentorSignUpForm" do
  erb :mentor_signup
end

get "/AdminHelp" do
  @header = erb:"common/headerB"
  erb :admin_help
end

post "/AdminHelp" do
  @header = erb:"common/headerB"
  erb :admin_help
end


get "/MentorSchedule" do
  @header = erb:"common/header_mentorA"
  erb :mentor_schedule
end

post "/MentorSchedule" do
  @header = erb:"common/header_mentorA"
  erb :mentor_schedule
end


get "/MenteeSchedule" do
 @header = erb:"common/header_menteeA"
  erb :mentee_schedule
end

post "/MenteeSchedule" do
 @header = erb:"common/header_mentorA"
  erb :mentee_schedule
end

def headers_common_pages
  #If user already logged in then displays a header for profiles which are logged 
  #in else displays headers for non-logged in users
  if session[:logged_in]
    if session[:admins_username]
      if session[:mentors_username]
        @header = erb:"common/header_adminMentorA"
      else
        @header = erb:"common/header_adminA"
      end
    elsif session[:mentees_username] 
      @header = erb:"common/header_menteeA"
    elsif session[:mentors_username] 
      @header = erb:"common/header_mentorA"
    end
  else 
    @header = erb:"common/headerB"
  end
  
end