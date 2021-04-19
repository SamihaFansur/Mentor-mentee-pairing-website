get "/search" do
  #New variable to enable mentees to search for mentors based on course name
  @courseName_search = params.fetch("courseName_search", "").strip
  
  #This error corresponds to the /addApplication route, this is to prevent
  #the error from being discarded when page is redirected to search
  @error1 = true if params.fetch("error", "") == "1"
  @error2 = true if params.fetch("error", "") == "2"
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
    @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).where(Sequel.like(:profileStatus, "0"))
             else
               Mentor.order(:courseName).where(Sequel.ilike(:courseName, "%#{@courseName_search}%")) #ilike used to make search case insensitive
             end

  erb :mentor_search
end

post "/addApplication" do
  @error1 = nil #initializes variable-application sent error
  @error2 = nil #initializes variable-mentor matched error
  @requests = Request.new #creates a new instance of requests
  #The params are from buttons in the mentor_search.erb, they correspond to the mentee sending the request
  #and the mentor being requested
  @requests.load(params[:menteeID].to_s, params[:mentorID].to_s)
  @mentors = Mentor.first(id: params[:mentorID]) #Creates a new instance based on mentor id of mentor being requested
  @mentees = Mentee.first(id: params[:menteeID]) #Creates a new instance based on mentee id of mentee
  
  #If application exists throws error and redirects to below URL(line 34)
  #else saves changes by updating the requests table and sending the mentor an email
  if @requests.exist_application?
    @error1 = "Application already sent"
    redirect "/search?error=1"
  else
    if @mentees.applicationNumber == "1" && @mentees.mentorMatch == 0
      @requests.timePassed = Time.new
      @requests.save_changes
      
      #Parallel thread deletes mentee application and sets applicationNumber to 1 after 14 days.
      #Email sent to mentee that the mentor didn't respond
      Thread.new{
#         sleep(14*24*60*60) #14 days in seconds
        sleep(30) #-------------------------------DELETE LATER -S -------------------------------
        @requests.delete
        @requests.save_changes
        
        @mentees.applicationNumber = "1"
        @mentees.save_changes
        send_mail(@mentees.email, 
            "No response from mentor", 
            "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
            "The mentor you had requested hasn't responded to your application.\n"+
            "Please login into your mentee account to send another application to a mentor.\n"+
            "\n\nRegards\nTeam 6")
      }

      #Mentee used up 1 application for time being, so sets to 0
      @mentees.applicationNumber = "0"
      @mentees.save_changes

      #Sends an email to mentor that a mentee sent them an application
      send_mail(@mentors.email, 
            "You have a new mentee application!", 
            "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
            "You have a new mentee application. Please login into your mentor account and view your mentee applications \n"+
            "\n\nRegards\nTeam 6")
    else
      @error2 = "You already have a mentor"
      redirect "/search?error=2"
    end   
  end
  
    redirect "/search"
end

#A method to send customised email, this is used in the /addApplication route
def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end

##################################SEARCH FOR A MENTOR IN A LIST OF ALL MENTORS###############################################
get "/searchForAMentor" do
  #New variable to enable mentees to search for mentors based on course name
  @userName_search = params.fetch("userName_search", "").strip
  
  #This error corresponds to the /addApplication route, this is to prevent
  #the error from being discarded when page is redirected to search
  @error = true if params.fetch("error", "") == "1"
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
  @mentors = if @userName_search.empty?
               Mentor.order(:username).all
             else
               Mentor.order(:username).where(Sequel.ilike(:username, "%#{@userName_search}%")) #ilike used to make search case insensitive
             end

  erb :admin_search_mentors
end

##################################SEARCH FOR A MENTEE IN A LIST OF ALL MENTEES#####################################################
get "/searchForAMentee" do
  #New variable to enable mentees to search for mentors based on course name
  @userName_search = params.fetch("userName_search", "").strip
  
  #This error corresponds to the /addApplication route, this is to prevent
  #the error from being discarded when page is redirected to search
  @error = true if params.fetch("error", "") == "1"
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
  

  @mentees = if @userName_search.empty?
               Mentee.order(:username).all
             else
               Mentee.order(:username).where(Sequel.ilike(:username, "%#{@userName_search}%")) #ilike used to make search case insensitive
             end

  erb :admin_search_mentees
end

##########################################################SUSPEND MENTOR############################################################
post "/suspendMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor
  
  #Sets suspendMentor field to 1 to indicate account suspended if not already 1
  if @mentors.suspendMentor != 1
    @mentors.suspendMentor = 1
    @mentors.save_changes
    #Sends mentor an email that their account has been suspended
    send_mail(@mentors.email, 
        "Mentor account suspended!", 
        "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
        "Your mentor account has been suspended due to violation of website guidelines.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
  end
    
    redirect "/searchForAMentor"
end

##########################################################UNSUSPEND MENTOR############################################################
post "/unsuspendMentor" do
  @mentors = Mentor.first(id: params[:mentorID]) #creates a new instance of mentor
  
  #Sets suspendMentor field to 0 to indicate account unsuspended if its already 1
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
  end
    
    redirect "/searchForAMentor"
end

##########################################################SUSPEND MENTEE############################################################
post "/suspendMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  
  #Sets suspendMentee field to 1 to indicate account suspended if not already 1
  if @mentees.suspendMentee != 1
    @mentees.suspendMentee = 1
    @mentees.save_changes
    #Sends mentee an email that their account has been suspended
    send_mail(@mentees.email, 
        "Mentee account suspended!", 
        "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
        "Your mentee account has been suspended due to violation of website guidelines.\n"+
        "If you think we have made a mistake, please contact our admins using our contact form!"+
        "\n\nRegards\nTeam 6")
  end
    
    redirect "/searchForAMentee"
end

##########################################################UNSUSPEND MENTEE############################################################
post "/unsuspendMentee" do
  @mentees = Mentee.first(id: params[:menteeID]) #creates a new instance of mentee
  
  #Sets suspendMentee field to 0 to indicate account unsuspended if its already 1
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
  end
    
    redirect "/searchForAMentee"
end