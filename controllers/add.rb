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
        send_mail(@mentees.email, "Successful Sign up!", @mentees.username)
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
        send_mail(@mentors.email, "Successful Sign up!", @mentors.username)
        redirect "/login"
      end
  end
  erb :mentor_signup
end

