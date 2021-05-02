post "/suspendMentor" do
  #Gets the mentor based on mentor id, which it gets from the suspend mentor button that is pressed
  @mentors = Mentor.first(id: params[:mentorID])
  suspend_user(@mentors, @mentors.suspendMentor)
    
  redirect "/searchForAMentor"
end

#Admins use this route to unsuspend a mentor if the mentor was suspended incorrectly
post "/unsuspendMentor" do
  #Gets the mentor based on mentor id, which it gets from the unsuspend mentor button that is pressed
  @mentors = Mentor.first(id: params[:mentorID])
  unsuspend_user(@mentors, @mentors.suspendMentor)
    
  redirect "/searchForAMentor"
end

post "/suspendMentee" do
  #Gets the mentee based on mentee id, which it gets from the suspend mentee button that is pressed
  @mentees = Mentee.first(id: params[:menteeID])
  suspend_user(@mentees, @mentees.suspendMentee)
    
  redirect "/searchForAMentee"
end

#Admins use this route to unsuspend a mentee if the mentee was suspended incorrectly
post "/unsuspendMentee" do
  #Gets the mentee based on mentee id, which it gets from the unsuspend mentee button that is pressed
  @mentees = Mentee.first(id: params[:menteeID])
  unsuspend_user(@mentees, @mentees.suspendMentee)
    
  redirect "/searchForAMentee"
end

post "/blockMentor" do
  #Gets the mentor based on mentor id, which it gets from the block mentor button that is pressed
  @mentors = Mentor.first(id: params[:mentorID])
  block_user(@mentors, @mentors.suspendMentor)
    
  redirect "/searchForAMentor"
end

post "/unblockMentor" do
  #Gets the mentor based on mentor id, which it gets from the unblock mentor button that is pressed
  @mentors = Mentor.first(id: params[:mentorID])
  unblock_user(@mentors, @mentors.suspendMentor)
    
  redirect "/searchForAMentor"
end

post "/blockMentee" do
  #Gets the mentee based on mentee id, which it gets from the block mentee button that is pressed
  @mentees = Mentee.first(id: params[:menteeID])
  block_user(@mentees, @mentees.suspendMentee)
    
  redirect "/searchForAMentee"
end

post "/unblockMentee" do
  #Gets the mentee based on mentee id, which it gets from the unsuspend mentee button that is pressed
  @mentees = Mentee.first(id: params[:menteeID])
  unblock_user(@mentees, @mentees.suspendMentee)
    
  redirect "/searchForAMentee"
end

#Method takes type of user and field to change(field which indicates user is suspended) as its parameters
def suspend_user(user, suspendUserField)
  #Sets suspendUserField to 1 to indicate user is suspended
  if suspendUserField != 1
    if user.class == Mentee
      user.suspendMentee = 1
    elsif user.class == Mentor
      user.suspendMentor = 1
    end
    user.save_changes
    #Sends user an email that their account has been suspended
    send_mail(user.email, 
        "Account suspended!", 
        "Hi "+user.fname+" "+user.lname+" !\n"+
        "Your account has been suspended due to violation of website guidelines. "+
        "You will be able to use your account after 48 hours starting now.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
    #User account unsuspended after 2 days, user notified through email of account unsuspension
    Thread.new{
  #         sleep(2*24*60*60) #2 days in seconds
        sleep(30) #30 seconds for running rspec tests
        if user.class == Mentee
          user.suspendMentee = 0
        elsif user.class == Mentor
          user.suspendMentor = 0
        end
        user.save_changes
        send_mail(user.email, 
            "Account Unsuspended!", 
            "Hi "+user.fname+" "+user.lname+" !\n"+
            "Your account has now been unsuspended.\n"+
            "You can now login using your credentials"+
            "\n\nRegards\nTeam 6")
      } 
   else
    #If account already suspended shows admin relevant message
    if user.class == Mentee
      redirect "/searchForAMentee?error=1"
    elsif user.class == Mentor
      redirect "/searchForAMentor?error=1"
    end
  end
end

#Method takes type of user and field to change(field which indicates user is unsuspended) as its parameters
def unsuspend_user(user, unsuspendUserField)
  #Sets unsuspendUserField to 0 to indicate user is unsuspended
  if unsuspendUserField == 1
    if user.class == Mentee
      user.suspendMentee = 0
    elsif user.class == Mentor
      user.suspendMentor = 0
    end
    user.save_changes
    #Sends user an email that their account has been unsuspended
    send_mail(user.email, 
        "Account Unsuspended!", 
        "Hi "+user.fname+" "+user.lname+" !\n"+
        "Your account has now been unsuspended. We are sorry for any inconvenience caused.\n"+
        "You can now login using your credentials"+
        "\n\nRegards\nTeam 6")
   else
    #If account already unsuspended shows admin relevant message
    if user.class == Mentee
      redirect "/searchForAMentee?error=2"
    elsif user.class == Mentor
      redirect "/searchForAMentor?error=2"
    end
  end
end

#Method takes type of user and field to change(field which indicates user is blocked) as its parameters
def block_user(user, blockUserField)
  #Sets blockUserField field to 1 to indicate account permanently suspended/blocked   
  if blockUserField != 1
   if user.class == Mentee
      user.suspendMentee = 1
    elsif user.class == Mentor
      user.suspendMentor = 1
    end
    user.save_changes
    #Sends user an email that their account has been permanently suspended/blocked
    send_mail(user.email, 
        "Account blocked!", 
        "Hi "+user.fname+" "+user.lname+" !\n"+
        "Your account has been blocked due to repeated violation of website guidelines.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
  else
    #If account already blocked shows admin relevant message
    if user.class == Mentee
      redirect "/searchForAMentee?error=3"
    elsif user.class == Mentor
      redirect "/searchForAMentor?error=3"
    end
  end
end

#Method takes type of user and field to change(field which indicates user is unblocked) as its parameters
def unblock_user(user, unblockUserField)
  #Sets blockUserField field to 0 to indicate account permanently unsuspended/unblocked
  if unblockUserField == 1
    if user.class == Mentee
      user.suspendMentee = 0
    elsif user.class == Mentor
      user.suspendMentor = 0
    end
    user.save_changes
    #Sends user an email that their account has been permanently unsuspended/unblocked
    send_mail(user.email, 
        "Account Unblocked!", 
        "Hi "+user.fname+" "+user.lname+" !\n"+
        "Your account has now been unblocked.\n"+
        "You can now login using your credentials"+
        "\n\nRegards\nTeam 6")
   else
    #If account already unblocked shows admin relevant message
    if user.class == Mentee
      redirect "/searchForAMentee?error=4"
    elsif user.class == Mentor
      redirect "/searchForAMentor?error=4"
    end
  end
end