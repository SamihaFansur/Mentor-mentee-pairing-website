#MENTEE
get "/MenteeSignUpForm" do
  @mentees = Mentee.new
  erb :mentee_signup
end

post "/MenteeSignUpForm" do
  @mentees = Mentee.new
  @mentees.load(params)

  if @mentees.valid?
          puts "test 1"
      if @mentees.exist?
      else
      puts "test 2"
        @mentees.save_changes
        redirect "/index"
      end
  end
    puts "test 3"
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

  if @mentors.valid?
    @mentors.save_changes
    redirect "/index"
  end

  erb :mentor_signup
end


