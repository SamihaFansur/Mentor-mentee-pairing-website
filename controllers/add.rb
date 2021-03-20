#MENTEE
require "net/http"
get "/MenteeSignUpForm" do
  @mentees = Mentee.new
  erb :mentee_signup
end

post "/MenteeSignUpForm" do
  @mentees = Mentee.new
  @mentees.load(params)
  @error = nil

  if @mentees.valid?
      if @mentees.exist_signup?
        @error = "Username/email exists"
      else
        @mentees.save_changes
        send_mail(@mentees.email, 
          "Successful Sign up!", 
          "Hi "+@mentees.fname+" "+@mentees.lname+"!\n"+
          "Your username is: "+@mentees.username+"\n"+
          "Your email: "+@mentees.email+"\n"+
          "Please use these credentials to login into your mentee account \n"+
          "\n\n\nRegards\nTeam 6")
        redirect "/login"
      end
  end
  erb :mentee_signup
end


def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end

#MENTOR
get "/MentorSignUpForm" do
  @mentors = Mentor.new
  erb :mentor_signup
end

post "/MentorSignUpForm" do
  @mentors = Mentor.new
  @mentors.load(params)
  @error = nil

  if @mentors.valid?
      if @mentors.exist_signup?
        @error = "Username/email exists"
      else
        @mentors.save_changes
        send_mail(@mentors.email, 
          "Successful Sign up!", 
          "Hi "+@mentors.fname+" "+@mentors.lname+"!\n"+
          "Your username is: "+@mentors.username+"\n"+
          "Your email: "+@mentors.email+"\n"+
          "Please use these credentials to login into your mentor account \n"+
          "\n\n\nRegards\nTeam 6")
        redirect "/login"
      end
  end
  erb :mentor_signup
end

