get "/editMentee" do
  headers_common_pages
  prevent_url_hopping
  errors_page #Error if email already exists in the entire database
  
  id = params["id"] #new variable to search the id of corresponding mentee profile to be edited, id gotten from link/button clicked
  
  #If id requested exists then calls the edit mentee form based on user session
  @mentees = Mentee[id] if Mentee.id_exists?(id)
  if session[:mentees_username] 
    erb :mentee_edit_info
  elsif session[:admins_username] 
    erb :admin_mentee_edit_info
  end
end

post "/editMentee" do
  id = params["id"] #new variable to search the id of corresponding mentee profile to be edited, id gotten from link/button clicked
  
  #If mentee id exists and field values are valid then saves changes and redirects apprporiately based on users' session
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

get "/editMentor" do
  headers_common_pages
  prevent_url_hopping
  errors_page #Error if email already exists in the entire database
  
  id = params["id"] #new variable to search the id of corresponding mentor profile to be edited, id gotten from link/button clicked
  
  #If id requested exists then calls the edit mentor form based on user session
  @mentors = Mentor[id] if Mentor.id_exists?(id)
  if session[:admins_username] 
    if session[:mentors_username]
      erb :mentor_edit_info
    else
      erb :admin_mentor_edit_info
    end
  elsif session[:mentors_username] 
    erb :mentor_edit_info
  end
end

post "/editMentor" do
  id = params["id"] #new variable to search the id of corresponding mentor profile to be edited, id gotten from link/button clicked
  
  #If mentor id exists and field values are valid then saves changes and redirects apprporiately based on users' session
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
        if $user == "user"
          redirect "/AdminMentorDashboard"
        elsif $user == "adminUser"
          redirect "searchForAMentor"
        end
      elsif session[:mentors_username] 
        redirect "/MentorDashboard"
      end
    end
  end

end

get "/editAdmin" do 
  headers_common_pages
  prevent_url_hopping
  errors_page #Error if email already exists in the entire database
  
  id = params["id"] #new variable to search the id of corresponding admin profile to be edited, id gotten from link clicked
  
  #If id requested exists then calls the edit admin form
  @admins = Admin[id] if Admin.id_exists?(id)
  erb :admin_edit_info
end

post "/editAdmin" do
  id = params["id"] #new variable to search the id of corresponding admin profile to be edited, id gotten from link clicked
  
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

def prevent_url_hopping
  #Checks if the request has come directly from a user dashboard to stop users from manually changing the link and accessing other users edit pages
  #redirects users according to their session
  if request.referer.nil?
      if session[:mentees_username]
          redirect "/MenteeDashboard"
      elsif session[:admins_username] 
          if session[:mentors_username] 
              redirect "/AdminMentorDashboard"
          else
              redirect "/AdminDashboard"
          end
      elsif session[:mentors_username]
          redirect "/MentorDashboard"
      end
  end
end