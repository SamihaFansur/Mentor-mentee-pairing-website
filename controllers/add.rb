require "net/http"

get "/MenteeSignUpForm" do
  @mentees = Mentee.new
  erb :mentee_signup
end

post "/MenteeSignUpForm" do
  @mentees = Mentee.new
  sign_up(@mentees)
  
  erb :mentee_signup
end

get "/MentorSignUpForm" do
  @mentors = Mentor.new
  erb :mentor_signup
end

post "/MentorSignUpForm" do
  @mentors = Mentor.new
  sign_up(@mentors)
  
  erb :mentor_signup
end

def sign_up(user)
  user.load(params)
  @error = nil

  if user.valid?
      if user.exist_signup?
        @error = "Username/email exists"
      else
        user.save_changes
        #Sends an email to mentor that the sign up was successful
        send_mail(user.email, 
          "Successful Sign up!", 
          "Hi "+user.fname+" "+user.lname+"!\n"+
          "Your username is: "+user.username+"\n"+
          "You password: "+ user.password+"\n"+
          "Your email: "+user.email+"\n"+
          "Please use these credentials to login into your account and activate your account \n"+
          "\n\n\nRegards\nTeam 6")
        redirect "/login"
      end
  end
end

def send_mail(email, subject, body)
  response = Net::HTTP.post_form(URI("https://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
  response.is_a? Net::HTTPSuccess
end