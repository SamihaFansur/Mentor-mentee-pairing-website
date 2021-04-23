###############################MENTEE######################################
get "/editMentee" do
  id = $mentees.id #new variable to search the id of corresponding mentee profile to be edited
  
  #If error displayed in the post editMentee route next line called
  @error = true if params.fetch("error", "") == "1"
  
  #If id requested exists then calls the edit mentee form
  @mentees = Mentee[id] if Mentee.id_exists?(id)
  if session[:mentees_username] 
    erb :mentee_edit_info
  elsif session[:admins_username] 
    erb :admin_mentee_edit_info
  end
end

post "/editMentee" do
  id = params["id"] #variable to search the id of corresponding mentee profile being edited
  
  #If mentee id exists and field values are valid then saves changes and redirects to mentee dashboard
  if Mentee.id_exists?(id)
    @mentees = Mentee[id]
    old_email = @mentees.email #original email
    @mentees.loadEdit(params) #potentially new params
    mentee_check = Mentee.new #New instance of Mentee
    mentee_check.email = params[:email] #New mentee is given a potentially new email

    #Checks if the potentially new email already exists and checks if original email and the potentially new email are the same or not
    #If potentially new email exists and there is a new email entered show an error
    if mentee_check.exist_signup? && old_email != mentee_check.email
      redirect "/editMentee?id=#{id}&error=1"
    else
      @mentees.save_changes
      if session[:mentees_username] 
        redirect "/MenteeDashboard"
      elsif session[:admins_username] 
        redirect "/searchForAMentee"
      end
    end
  end

end

###############################MENTOR######################################
get "/editMentor" do
  id = params["id"] #new variable to search the id of corresponding mentor profile to be edited
  
  #If error displayed in the post editMentor route next line called
  @error = true if params.fetch("error", "") == "1"
  
  #If id requested exists then calls the edit mentor form
  @mentors = Mentor[id] if Mentor.id_exists?(id)
  if session[:admins_username] 
    erb :admin_mentor_edit_info
  elsif session[:mentors_username] 
    erb :mentor_edit_info
  end
end

post "/editMentor" do
  id = params["id"] #variable to search the id of corresponding mentor profile being edited
  
  #If mentor id exists and field values are valid then saves changes and redirects to mentor dashboard
  if Mentor.id_exists?(id)
    @mentors = Mentor[id]
    old_email = @mentors.email #original email
    @mentors.loadEdit(params) #potentially new params
    mentor_check = Mentor.new #New instance of Mentor
    mentor_check.email = params[:email] #New mentor is given a potentially new email

    #Checks if the potentially new email already exists and checks if original email and the potentially new email are the same or not
    #If potentially new email exists and there is a new email entered show an error
    if mentor_check.exist_signup? && old_email != mentor_check.email
      redirect "/editMentor?id=#{id}&error=1"
    else
      @mentors.save_changes
      if session[:admins_username] 
        redirect "/searchForAMentor"
      elsif session[:mentors_username] 
        redirect "/MentorDashboard"
      end
    end
  end

end








###############################TIMAABLE######################################
get "/editMentorA" do
  id = params["id"] #new variable to search the id of corresponding mentor profile to be edited
  
  #If error displayed in the post editMentor route next line called
  @error = true if params.fetch("error", "") == "1"
  
  #If id requested exists then calls the edit mentor form
  @mentors = Mentor[id] if Mentor.id_exists?(id)
  if session[:admins_username] 
    erb :mentor_task
  elsif session[:mentors_username] 
    erb :mentor_task
  end
end

post "/editMentorA" do
  id = params["id"] #variable to search the id of corresponding mentor profile being edited
  
  #If mentor id exists and field values are valid then saves changes and redirects to mentor dashboard
  if Mentor.id_exists?(id)
    @mentors = Mentor[id]
    old_email = @mentors.email #original email
    @mentors.loadEdit(params) #potentially new params
    mentor_check = Mentor.new #New instance of Mentor
    mentor_check.email = params[:email] #New mentor is given a potentially new email

    #Checks if the potentially new email already exists and checks if original email and the potentially new email are the same or not
    #If potentially new email exists and there is a new email entered show an error
    if mentor_check.exist_signup? && old_email != mentor_check.email
      redirect "/editMentorA?id=#{id}&error=1"
    else
      @mentors.save_changes
      if session[:admins_username] 
        redirect "/searchForAMentor"
      elsif session[:mentors_username] 
        redirect "/MentorDashboard"
      end
    end
  end

end


get "/editMenteeA" do
  id = $mentees.id #new variable to search the id of corresponding mentee profile to be edited
  
  #If error displayed in the post editMentee route next line called
  @error = true if params.fetch("error", "") == "1"
  
  #If id requested exists then calls the edit mentee form
  @mentees = Mentee[id] if Mentee.id_exists?(id)
  if session[:mentees_username] 
    erb :mentee_task
  elsif session[:admins_username] 
    erb :mentee_task
  end
end

post "/editMenteeA" do
  id = params["id"] #variable to search the id of corresponding mentee profile being edited
  
  #If mentee id exists and field values are valid then saves changes and redirects to mentee dashboard
  if Mentee.id_exists?(id)
    @mentees = Mentee[id]
    old_email = @mentees.email #original email
    @mentees.loadEdit(params) #potentially new params
    mentee_check = Mentee.new #New instance of Mentee
    mentee_check.email = params[:email] #New mentee is given a potentially new email

    #Checks if the potentially new email already exists and checks if original email and the potentially new email are the same or not
    #If potentially new email exists and there is a new email entered show an error
    if mentee_check.exist_signup? && old_email != mentee_check.email
      redirect "/editMentee?id=#{id}&error=1"
    else
      @mentees.save_changes
      if session[:mentees_username] 
        redirect "/MenteeDashboard"
      elsif session[:admins_username] 
        redirect "/searchForAMentee"
      end
    end
  end

end










###############################ADMIN######################################
get "/editAdmin" do
  id = params["id"] #new variable to search the id of corresponding admin profile to be edited
  
  #If error displayed in the post editAdmin route next line called
  @error = true if params.fetch("error", "") == "1"
  
  #If id requested exists then calls the edit mentor form
  @admins = Admin[id] if Admin.id_exists?(id)
  erb :admin_edit_info
end

post "/editAdmin" do
  id = params["id"] #variable to search the id of corresponding admin profile being edited
  
  #If admin id exists and field values are valid then saves changes and redirects to admin dashboard
  if Admin.id_exists?(id)
    @admins = Admin[id]
    old_email = @admins.email #original email
    @admins.loadEdit(params) #potentially new params
    admin_check = Admin.new #New instance of Admin
    admin_check.email = params[:email] #New admin is given a potentially new email

    #Checks if the potentially new email already exists and checks if original email and the potentially new email are the same or not
    #If potentially new email exists and there is a new email entered show an error
    if admin_check.exist_signup? && old_email != admin_check.email
      redirect "/editAdmin?id=#{id}&error=1"
    else
      @admins.save_changes
      if session[:admins_username] 
        redirect "/AdminDashboard"
      end
    end
  end

end

