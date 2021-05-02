#Mentee searches for a mentor and sends them an application
get "/search" do
  #Param fetched is the input from the user in the search box
  @courseName_search = params.fetch("courseName_search", "").strip
  
  #Displays appropriate error if mentee has already sent in an application or if mentee already has a mentor
  errors_page
  
  #If search box empty then list all unmatched(public) mentor profiles in alphabetical order of course name 
  #if search box has content, search through the course name field in the mentors table and display mentors matching the
  #search criteria entered who are unmatched
  @mentors =  if @courseName_search.empty?
               Mentor.order(:courseName).where(Sequel.like(:profileStatus, 1))
              else
               Mentor.order(:courseName).where(Sequel.like(:profileStatus, 1)).where(Sequel.ilike(:courseName, "%#{@courseName_search}%")) #ilike used to make search case insensitive
              end
  erb :mentor_search
end

#Mentee sent a mentor an application
post "/addApplication" do
  @requests = Request.new #creates a new instance of requests
  #The params are from buttons in the mentor_search.erb, they correspond to the mentee sending the request
  #and the mentor being requested
  @requests.load(params[:menteeID].to_s, params[:mentorID].to_s)
  @mentors = Mentor.first(id: params[:mentorID]) #Creates a new instance based on mentor id of mentor being requested
  @mentees = Mentee.first(id: params[:menteeID]) #Creates a new instance based on mentee id of mentee
  
  #If application exists redirects to below URL(line 33)
  #else saves changes by updating the requests table and sending the mentor an email
  if @requests.exist_application?
    redirect "/search?error=1"
  else
    #If mentee hasn't sent an application already, mentee application sent to mentor
    #else if mentee already has a mentor redirects to below URL (line 69)
    if @mentees.applicationNumber == 1 && @mentees.mentorMatch == 0
      @requests.timeApplicationSent = Time.new
      @requests.save_changes
      
      #Parallel thread deletes mentee application and sets applicationNumber to 1 after 14 days. So mentee can request another mentor
      Thread.new{
#         sleep(14*24*60*60) #14 days in seconds
        sleep(180) #3 mins, use when running rspec tests
        @requests.delete #deletes mentee request if its still pending
        @requests.save_changes
        
        @mentees.applicationNumber = 1 #Mentee can send an application to another mentor
        @mentees.save_changes
        #Email sent to mentee that the mentor didn't respond
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
      redirect "/search?error=2"
    end   
  end
  
    redirect "/search"
end

#Admin searches for a mentor in a list of all mentors
get "/searchForAMentor" do
  headers_common_pages    
  admin_user_search("mentor", @userName_search, "userName_search")
  erb :admin_search_mentors
end

#Admin searches for a mentee in a list of all mentees
get "/searchForAMentee" do
  headers_common_pages    
  admin_user_search("mentee", @userName_search, "userName_search")
  erb :admin_search_mentees
end

#Lists all paired mentees, so an admin can search for paired mentees within a faculty
get "/PairedMentees" do
  headers_common_pages
  
  #New variable to enable admins to search for mentees based on faculty
  @faculty_search = params.fetch("faculty_search", "").strip
  
  #If no faculty is being searched, it displays the list of all paired mentees in alphabetical order 
  #else it searches through the faculty field in the mentees table and displays paired mentees' whose 
  #faculty is being searched
    @mentees = if @faculty_search.empty? 
                 Mentee.order(:faculty).where(~Sequel.like(:mentorMatch, 0)) #Displays mentees where they have a mentor matched
               else
                 Mentee.order(:faculty).where(~Sequel.like(:mentorMatch, 0)).where(Sequel.ilike(:faculty, "%#{@faculty_search}%")) #ilike used to make search case insensitive
               end
    
    @menteesList = [] #Stores mentee details
    @mentors = [] #Stores matched mentor details

    @mentees.each do |mentee|
      #Gets mentor based on mentor id, which is stored in the mentorMatch field in the mentees table
      mentor = Mentor.first(id: mentee.mentorMatch)
      
      @menteesList.push([mentee.name, mentee.email, mentee.faculty]) #Mentee information
      @mentors.push([mentor.name, mentor.email]) #Mentor information
    end
  erb :paired_mentees
end

#Method takes type of user, variable name to be set, and the search criteria for the search as its parameters
def admin_user_search(user, varName, searchField)
  #New variable to enable admins to search for users based on username
  varName = params.fetch(searchField, "").strip
  #Displays errors if user already suspendes/unsuspended/blocked or unblocked
  errors_page
  
  #If no username is being searched, it displays the list of all requested users in alphabetical order 
  #else it searches through the username field in the appropriate user table and displays users' whose 
  #username contains the username being searched
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

def errors_page
  #error pages to redirect to
  @error1 = true if params.fetch("error", "") == "1"
  @error2 = true if params.fetch("error", "") == "2"
  @error3 = true if params.fetch("error", "") == "3"
  @error4 = true if params.fetch("error", "") == "4"
end