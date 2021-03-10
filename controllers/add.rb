get "/MenteeSignUpForm" do
  @mentees = Mentee.new
  erb :mentee_signup
end

post "/MenteeSignUpForm" do
  @mentees = Mentee.new
  @mentees.load(params)

  if @mentees.valid?
    @mentees.save_changes
    redirect "/index"
  end

  erb :mentee_signup
end


