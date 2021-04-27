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

#Admin can search for a mentor is a list of all mentors
get "/searchForAMentor" do
   @header = nil
  
  if session[:admins_username]
    if session[:mentors_username]
      @header = erb:"common/header_adminMentorA"
    else
      @header = erb:"common/header_adminA"
    end
  end

  
  #New variable to enable mentees to search for mentors based on course name
  @userName_search = params.fetch("userName_search", "").strip
  #notice after press the button
  @error1 = true if params.fetch("error", "") == "1"
  @error2 = true if params.fetch("error", "") == "2"
  @error3 = true if params.fetch("error", "") == "3"
  @error4 = true if params.fetch("error", "") == "4"  
  
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

#Admin can search for a mentee is a list of all mentees
get "/searchForAMentee" do
   @header = nil
  
  if session[:admins_username]
    if session[:mentors_username]
      @header = erb:"common/header_adminMentorA"
    else
      @header = erb:"common/header_adminA"
    end
  end
  
  @userName_search = params.fetch("userName_search", "").strip
  @mentees = if @userName_search.empty?
             Mentee.order(:username).all
            else
             Mentee.order(:username).where(Sequel.ilike(:username, "%#{@userName_search}%"))
            end
 

  erb :admin_search_mentees
end

# def search_based_on_specific_field(varName, fieldName, user)
#   #New variable to enable mentees to search for mentors based on course name
#   varName = params.fetch(fieldName, "").strip
  
#   @error1 = true if params.fetch("error", "") == "1"
#   @error2 = true if params.fetch("error", "") == "2"
#   @error3 = true if params.fetch("error", "") == "3"
#   @error4 = true if params.fetch("error", "") == "4"
  
#   if user == "mentee"
#     userClass = Mentee
#   elsif user == "mentor"
#     userClass = Mentor
#   end
#   puts userClass
  
#   if user == "mentee"
#     puts "1"
#     new_mentee_instance
#     puts "-----"
#   elsif user == "mentor"
#     new_mentor_instance
#   end
  
#   #If no course name is being searched, it displays the list of all mentors in alphabetical order 
#   #else it searches through the course name field in the mentors table and displays mentors' whose 
#   #course name contains the course name being searched
#   user = if varName.empty?
#                userClass.order(:username).all
#              else
#                userClass.order(:username).where(Sequel.ilike(:username, "%#{varName}%")) #ilike used to make search case insensitive
#              end
# puts user

# end