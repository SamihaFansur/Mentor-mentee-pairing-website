#MENTEE
get "/editMentee" do
  id = params["id"]
  @mentees = Mentee[id] if Mentee.id_exists?(id)
  erb :mentee_edit_info
end

post "/editMentee" do
  id = params["id"]

  if Mentee.id_exists?(id)
    @mentees = Mentee[id]
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
  id = params["id"]
  @mentors = Mentor[id] if Mentor.id_exists?(id)
  erb :mentor_edit_info
end

post "/editMentor" do
  id = params["id"]

  if Mentor.id_exists?(id)
    @mentors = Mentor[id]
    @mentors.loadEdit(params)

    if @mentors.valid?
      @mentors.save_changes
      redirect "/MentorDashboard"
    end
  end

  erb :mentor_edit_info
end
