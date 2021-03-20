#MENTEE
get "/editMentee" do
  username = params["username"]
  @mentees = Mentee[username] if Mentee.username_exists?(username)
  erb :mentee_edit_info
end

post "/editMentee" do
  username = params["username"]

  if Mentee.username_exists?(username)
    @mentees = Mentee[username]
    @mentees.loadEdit(params)

    if @mentees.valid?
      @mentees.save_changes
      redirect "/MenteeDashboard"
    end
  end

  erb :mentee_edit_info
end

#MENTOR
get "/editMentor" do
  username = params["username"]
  @mentors = Mentor[username] if Mentor.username_exists?(username)
  erb :mentor_edit_info
end

post "/editMentor" do
  username = params["username"]

  if Mentor.username_exists?(username)
    @mentors = Mentor[username]
    @mentors.loadEdit(params)

    if @mentors.valid?
      @mentors.save_changes
      redirect "/MentorDashboard"
    end
  end

  erb :mentor_edit_info
end
