#MENTEE
get "/MenteeSignUpForm" do
  @mentees = Mentee.new
  erb :mentee_signup
end

post "/MenteeSignUpForm" do
  @mentees = Mentee.new
  @mentees.load(params)
  @error = nil

  if @mentees.valid?
      if @mentees.exist_signup?
        @error = "User exists"
      else
        @mentees.save_changes
        redirect "/index"
      end
  end
  erb :mentee_signup
end

#MENTOR
get "/MentorSignUpForm" do
  @mentors = Mentor.new
  erb :mentor_signup
end

post "/MentorSignUpForm" do
  @mentors = Mentor.new
  @mentors.load(params)
  @error = nil

  if @mentors.valid?
      if @mentors.exist_signup?
        @error = "User exists"
      else
        @mentors.save_changes
        redirect "/index"
      end
  end
  erb :mentor_signup
end

