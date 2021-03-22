###############################MENTEE######################################
post "/deleteMentee" do
  id = params["id"]  #new variable to search the id of corresponding mentee to be deleted
  
 #If id requested exists then deletes the profile, logs mentee out and redirects to index page
  if Mentee.id_exists?(id)
    mentee = Mentee[id]
    mentee.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentee_account
end

###############################MENTOR######################################
post "/deleteMentor" do
  id = params["id"]  #new variable to search the id of corresponding mentor to be deleted
  
 #If id requested exists then deletes the profile, logs mentor out and redirects to index page
  if Mentor.id_exists?(id)
    mentor = Mentor[id]
    mentor.delete
    session.clear
    redirect "/index"
  end

  erb :delete_mentor_account
end