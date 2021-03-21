#MENTEE
post "/deleteMentee" do
  username = params["username"]

  if Mentee.username_exists?(username)
    mentee = Mentee[username]
    mentee.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentee_account
end

#MENTOR
post "/deleteMentor" do
  username = params["id"]

  if Mentor.id_exists?(username)
    mentor = Mentor[username]
    mentor.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentor_account
end