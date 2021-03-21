#MENTEE
post "/deleteMentee" do
  id = params["id"]

  if Mentee.id_exists?(id)
    mentee = Mentee[id]
    mentee.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentee_account
end

#MENTOR
post "/deleteMentor" do
  id = params["id"]

  if Mentor.id_exists?(id)
    mentor = Mentor[id]
    mentor.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentor_account
end