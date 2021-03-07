get "/SignUpForm" do
  @mentees = Mentee.new
  erb :signup
end

post "/SignUpForm" do
  @mentees = Mentee.new
  @mentees.load(params)

  if @mentees.valid?
    @mentees.save_changes
    redirect "/index"
  end

  erb :signup
end


