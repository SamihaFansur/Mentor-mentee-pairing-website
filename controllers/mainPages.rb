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

get "/MenteeSignUpForm" do
  erb :mentee_signup
end

post "/" do #homepage
  redirect "/"
end

get "/MentorSignUpForm" do
  erb :mentor_signup
end

get "/AdminHelp" do
  headers_common_pages
  erb :admin_help
end

post "/AdminHelp" do
  headers_common_pages
end

get "/logout" do
  session.clear #Clears session when user logs out
  erb :logout
end

get "/AdminLoginChoices" do #Asks an admin if they are also a mentor
  erb :adminLogin_choices
end

not_found do #Custom error page, if user types in a wrong URL
  erb :wrong_route
end

def headers_common_pages
  #If user already logged in then displays appropriate header for profiles which are logged 
  #in else displays headers for non-logged in users
  if session[:logged_in]
    if session[:admins_username]
      if session[:mentors_username]
        @header = erb :"common/header_adminMentorA"
      else
        @header = erb :"common/header_adminA"
      end
    elsif session[:mentees_username] 
      @header = erb :"common/header_menteeA"
    elsif session[:mentors_username] 
      @header = erb :"common/header_mentorA"
    end
  else 
    @header = erb :"common/headerB"
  end
end