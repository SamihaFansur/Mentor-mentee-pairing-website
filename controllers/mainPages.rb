get "/index" do
  erb :index
end

get "/contact" do
  erb :contact
end

get "/accessibility" do
  erb :accessibility
end

get "/SignUpChoices" do
  erb :signup_choices
end

get "/LoginPage" do
  # ... app code ...
  erb :login
end

get "/MenteeSignUpForm" do
  # ... app code ...
  erb :mentee_signup
end

post "/index" do
  puts params
  redirect "/index"

end

get "/MentorSignUpForm" do
  # ... app code ...
  erb :mentor_signup
end
