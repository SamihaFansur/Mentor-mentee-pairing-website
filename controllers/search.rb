get "/search" do
  @courseName_search = params.fetch("courseName_search", "").strip
  @error = true if params.fetch("error", "") == "1"
  
  @mentors = if @courseName_search.empty?
               Mentor.order(:courseName).all
             else
               Mentor.order(:courseName).where(Sequel.ilike(:courseName, "%#{@courseName_search}%"))
             end

  erb :mentor_search
end

post "/addApplication" do
  @error = nil
  @requests = Request.new
  @requests.load(params[:menteeID].to_s, params[:mentorID].to_s)
  @mentors = Mentor.first(id: params[:mentorID])
  puts @mentors
  puts @mentors.fname
  puts @mentors.lname
  puts @mentors.email
  puts @mentors.phoneNum
  puts @mentors.courseName
  puts @mentors.jobTitle
  puts @mentors.id
  
  puts @requests.exist_application?
  
  if @requests.exist_application?
    @error = "Application already sent"
    redirect "/search?error=1"
  else
    @requests.save_changes
     send_mail(@mentors.email, 
          "You have a new mentee application!", 
          "Hi "+@mentors.fname+" "+@mentors.lname+" !\n"+
          "You have a new mentee application. Please login into your mentor account and view mentee applications \n"+
          "\n\n\nRegards\nTeam 6")
  end
    redirect "/search"
end
  

def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end