get "/search" do
  #New variable to enable mentees to search for mentors based on course name
  @courseName_search = params.fetch("courseName_search", "").strip
  
  #This error corresponds to the /addApplication route, this is to prevent
  #the error from being discarded when page is redirected to search
  @error = true if params.fetch("error", "") == "1"
  
  #If no course name is being searched, it displays the list of all mentors in alphabetical order 
  #else it searches through the course name field in the mentors table and displays mentors' whose 
  #course name contains the course name being searched
  @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).all
             else
               Mentor.order(:courseName).where(Sequel.ilike(:courseName, "%#{@courseName_search}%")) #ilike used to make search case insensitive
             end

  erb :mentor_search
end

post "/addApplication" do
  @error = nil #initializes variable
  @requests = Request.new #creates a new instance of requests
  #The params are from buttons in the mentor_search.erb, they correspond to the mentee sending the request
  #and the mentor being requested
  @requests.load(params[:menteeID].to_s, params[:mentorID].to_s)
  @mentors = Mentor.first(id: params[:mentorID]) #Creates a new instance based on mentor id of mentor being requested
  
  #If application exists throws error and redirects to below URL(line 33)
  #else saves changes by updating the requests table and sending the mentor an email
  if @requests.exist_application?
    @error = "Application already sent"
    redirect "/search?error=1"
  else
    @requests.timePassed = Time.new
    @requests.save_changes
    #Sends an email to mentor that a mentee sent them an application
    send_mail(@mentors.email, 
          "You have a new mentee application!", 
          "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
          "You have a new mentee application. Please login into your mentor account and view your mentee applications \n"+
          "\n\nRegards\nTeam 6")
   
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





########################################################################################
get "/searchID" do
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

############################################################################################################
get "/searchIDAgain" do
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