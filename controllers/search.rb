get "/search" do
  #New variable to enable mentees to search for mentors based on course name
  @courseName_search = params.fetch("courseName_search", "").strip
  
  errors
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
    @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).where(Sequel.like(:profileStatus, "0"))
             else
               Mentor.order(:courseName).where(Sequel.like(:profileStatus, "0")).where(Sequel.ilike(:courseName, "%#{@courseName_search}%")) #ilike used to make search case insensitive
             end

  erb :mentor_search
end

post "/addApplication" do
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
    if @mentees.applicationNumber == 1 && @mentees.mentorMatch == 0
      @requests.timeApplicationSent = Time.new
      @requests.save_changes
      
      #Parallel thread deletes mentee application and sets applicationNumber to 1 after 14 days.
      #Email sent to mentee that the mentor didn't respond
      Thread.new{
#         sleep(14*24*60*60) #14 days in seconds
        sleep(300) #-------------------------------DELETE LATER -S -------------------------------
        @requests.delete
        @requests.save_changes
        
        @mentees.applicationNumber = 1
        @mentees.save_changes
        send_mail(@mentees.email, 
            "No response from mentor", 
            "Hi "+@mentees.fname+" "+@mentees.lname+" !\n"+
            "The mentor you had requested hasn't responded to your application.\n"+
            "Please login into your mentee account to send another application to a mentor.\n"+
            "\n\nRegards\nTeam 6")
      }

      #Mentee used up 1 application for time being, so sets to 0
      @mentees.applicationNumber = 0
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

#Search for a mentor in a list of all mentors
get "/searchForAMentor" do
  headers_common_pages    
  admin_user_search("mentor", @userName_search, "userName_search")

  erb :admin_search_mentors
end

#Search for a mentee in a list of all mentees
get "/searchForAMentee" do
  headers_common_pages    
  admin_user_search("mentee", @userName_search, "userName_search")

  erb :admin_search_mentees
end

def admin_user_search(user, varName, searchField)
  #New variable to enable mentees to search for mentors based on course name
  varName = params.fetch(searchField, "").strip
  errors  
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
  if user == "mentee"
    @searchedUser = new_mentee_instance
    userClass = Mentee
  elsif user == "mentor"
    @searchedUser = new_mentor_instance
    userClass = Mentor
  end
  
  @searchedUser = if varName.empty?
                   userClass.order(:username).all
                 else
                   userClass.order(:username).where(Sequel.ilike(:username, "%#{varName}%")) #ilike used to make search case insensitive
                 end
end

def errors
  #notice after press the button
  @error1 = true if params.fetch("error", "") == "1"
  @error2 = true if params.fetch("error", "") == "2"
  @error3 = true if params.fetch("error", "") == "3"
  @error4 = true if params.fetch("error", "") == "4"
end