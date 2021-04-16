###############################MENTEE######################################
post "/deleteMentee" do
  id = params["id"]  #new variable to search the id of corresponding mentee to be deleted
  
 #If id requested exists then deletes the profile, logs mentee out and redirects to index page
  if Mentee.id_exists?(id)
    mentee = Mentee[id]
    mentee.delete
    if session[:mentees_username] 
      session.clear
      redirect "/index"
    elsif session[:admins_username] 
      redirect "searchForAMentee"
    end
  end
end

###############################MENTOR######################################
post "/deleteMentor" do
  id = params["id"]  #new variable to search the id of corresponding mentor to be deleted
  
 #If id requested exists then deletes the profile, logs mentor out and redirects to index page
  if Mentor.id_exists?(id)
    mentor = Mentor[id]
    mentor.delete
    session.clear
    if session[:admins_username] 
      redirect "/searchForAMentor"
    elsif session[:mentors_username] 
      session.clear
      redirect "/index"
    end
  end
end

###############################ADMIN######################################
post "/deleteAdmin" do
  id = params["id"]  #new variable to search the id of corresponding admin to be deleted
  
 #If id requested exists then deletes the profile, logs admin out and redirects to index page
  if Admin.id_exists?(id)
    admin = Admin[id]
    admin.delete
    session.clear
    redirect "/index"
  end
end