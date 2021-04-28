post "/suspendMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor
  
  #Sets suspendMentor field to 1 to indicate account suspended if its not already suspended    
  if @mentors.suspendMentor != 1
    @mentors.suspendMentor = 1
    @mentors.save_changes
    #Sends mentor an email that their account has been suspended
    send_mail(@mentors.email, 
        "Mentor account suspended!", 
        "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
        "Your mentor account has been suspended due to violation of website guidelines."+
        "You will be able to use your account after 48 hours starting now.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
    Thread.new{
#         sleep(2*24*60*60) #2 days in seconds
        sleep(30) #-------------------------------DELETE LATER -S -------------------------------
        @mentors.suspendMentor = 0
        @mentors.save_changes
        #Sends mentor an email that their account has been unsuspended
        send_mail(@mentors.email, 
            "Mentor account Unsuspended!", 
            "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
            "Your mentor account has now been unsuspended.\n"+
            "You can now login using your mentor credentials"+
            "\n\nRegards\nTeam 6")
      }  
  else
      @error1 ="Account has already been suspended"
      redirect "/searchForAMentor?error=1"
  end
    
    redirect "/searchForAMentor"
end

post "/unsuspendMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor

  #Sets suspendMentor field to 0 to indicate account unsuspended if its already suspended
  if @mentors.suspendMentor == 1
    @mentors.suspendMentor = 0
    @mentors.save_changes
    #Sends mentor an email that their account has been unsuspended
    send_mail(@mentors.email, 
        "Mentor account Unsuspended!", 
        "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
        "Your mentor account has now been unsuspended.\n"+
        "You can now login using your mentor credentials"+
        "\n\nRegards\nTeam 6")
   else
      @error1 ="Account has already been unsuspended"
      redirect "/searchForAMentor?error=2"
  end
    
    redirect "/searchForAMentor"
end

post "/suspendMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  
  #Sets suspendMentee field to 1 to indicate account suspended if its not already suspended
  suspend_user(@mentees, @mentees.suspendMentee)
    
    redirect "/searchForAMentee"
end

post "/unsuspendMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  
  #Sets suspendMentee field to 0 to indicate account unsuspended if its suspended
  if @mentees.suspendMentee == 1
    @mentees.suspendMentee = 0
    @mentees.save_changes
    #Sends mentee an email that their account has been unsuspended
    send_mail(@mentees.email, 
        "Mentee account Unsuspended!", 
        "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
        "Your mentee account has now been unsuspended.\n"+
        "You can now login using your mentee credentials"+
        "\n\nRegards\nTeam 6")
   else
      @error1 ="Account has already been unsuspended"
      redirect "/searchForAMentee?error=2"
  end
    
    redirect "/searchForAMentee"
end

post "/blockMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  @error1 = nil #initializes variable-application sent error
  
  #Sets suspendMentee field to 1 to indicate account permanently suspended/blocked
  if @mentees.suspendMentee != 1
    @mentees.suspendMentee = 1
    @mentees.save_changes
    #Sends mentee an email that their account has been blocked
    send_mail(@mentees.email, 
        "Mentee account blocked!", 
        "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
        "Your mentee account has been blocked due to repeated violation of website guidelines.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
   else
      @error3 ="Account has already been blocked"
      redirect "/searchForAMentee?error=3"
  end
    
    redirect "/searchForAMentee"
end

post "/unblockMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  
  #Sets suspendMentee field to 0 to indicate account is unblocked
  if @mentees.suspendMentee == 1
    @mentees.suspendMentee = 0
    @mentees.save_changes
    #Sends mentee an email that their account has been unsuspended
    send_mail(@mentees.email, 
        "Mentee account Unblocked!", 
        "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
        "Your mentee account has now been unblocked.\n"+
        "You can now login using your mentee credentials"+
        "\n\nRegards\nTeam 6")
   else
      @error1 ="Account has already been unblocked"
      redirect "/searchForAMentee?error=4"
  end
    
    redirect "/searchForAMentee"
end

post "/blockMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor
  @error1 = nil #initializes variable-application sent error
  
  #Sets suspendMentor field to 1 to indicate account permanently suspended/blocked   
  if @mentors.suspendMentor != 1
    @mentors.suspendMentor = 1
    @mentors.save_changes
    #Sends mentor an email that their account has been suspended
    send_mail(@mentors.email, 
        "Mentor account suspended!", 
        "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
        "Your mentor account has been blocked due to repeated violation of website guidelines.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
  else
      @error1 ="Account has already been blocked"
      redirect "/searchForAMentor?error=3"
  end
    
    redirect "/searchForAMentor"
end

post "/unblockMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor

  #Sets suspendMentor field to 0 to indicate account unsuspended if its already suspended
  if @mentors.suspendMentor == 1
    @mentors.suspendMentor = 0
    @mentors.save_changes
    #Sends mentor an email that their account has been unsuspended
    send_mail(@mentors.email, 
        "Mentor account Unblocked!", 
        "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
        "Your mentor account has now been unblocked.\n"+
        "You can now login using your mentor credentials"+
        "\n\nRegards\nTeam 6")
   else
      @error1 ="Account has already been unblocked"
      redirect "/searchForAMentor?error=4"
  end
    
    redirect "/searchForAMentor"
end

def suspend_user(user, userField)
  if userField != 1
    if user.class == Mentee
      user.suspendMentee = 1
    elsif user.class = Mentor
      user.suspendMentor = 1
    end
    user.save_changes
    #Sends mentee an email that their account has been suspended
    send_mail(user.email, 
        "Account suspended!", 
        "Hi "+user.fname+" "+user.lname+" !\n"+
        "Your account has been suspended due to violation of website guidelines."+
        "You will be able to use your account after 48 hours starting now.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
        puts "USER sus"
    Thread.new{
  #         sleep(2*24*60*60) #2 days in seconds
        sleep(30) #-------------------------------DELETE LATER -S -------------------------------
        user.suspendMentee = 0
        user.save_changes
        #Sends mentee an email that their account has been unsuspended
        send_mail(user.email, 
            "Mentee account Unsuspended!", 
            "Hi "+user.fname+" "+user.lname+" !\n"+
            "Your mentee account has now been unsuspended.\n"+
            "You can now login using your mentee credentials"+
            "\n\nRegards\nTeam 6")
            puts "USER unsus after 30secs"
      } 
   else
      @error1 ="Account has already been suspended"
      if user.class == Mentee
        redirect "/searchForAMentee?error=1"
      elsif user.class = Mentor
        redirect "/searchForAMentor?error=1"
      end
  end
  
end