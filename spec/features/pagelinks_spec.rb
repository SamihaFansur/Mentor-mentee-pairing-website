require_relative "../spec_helper"

#page links tests from /index
describe "the page links" do
    #through navigation go to sign up page
    it "sign up is accessible from the index page" do
        visit"/"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
        
    #through navigation go to login page
    it "Login is accessible from the index page" do
        visit"/"
        click_link "Login"
        expect(page).to have_content "Don't have an account?"
    end
    
    #through navigation go to contact admin
    it "Contact Us is accessible from the index page" do
        visit"/"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the index page" do
        visit"/"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end

    #through footer go to contact admin 
    it "Contact is accessible from the index page" do
        visit"/"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #through footer go to view accessibility 
    it "Accessibility is accessible from the index page" do   
        visit"/"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end  
    
    
#page links tests from /login  

    #through navigation go to view our program introduction
    it "Our Program is accessible from the login page" do
        visit"/login"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    #through navigation go to contact admin
    it "Contact Us is accessible from the login page" do
        visit"/login"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    
    #through navigation go to login
    it "Login is accessible from the login page" do
        visit"/login"
        click_link "Login"
        expect(page).to have_content "Don't have an account?"
    end    

    #through navigation go to sign up choosing as a mentor or a mentee
   it "Sign-Up is accessible from the login page" do
         visit"/login"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
        end
    
    #through footer go to contact admin 
    it "Contact is accessible from the login page" do
        visit"/login"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #through navigation go to view accessibility
    it "Accessibility is accessible from the login page" do   
        visit"/login"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 


    
#page links tests from /contact  

    #through navigation go to sign up choosing as a mentor or a mentee
    it "Sign-Up is accessible from the contact page" do
        visit"/contact"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
        
    #through navigation go to view our program introduction
    it "Our Program is accessible from the contact page" do
        visit"/contact"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    #through navigation go to contact admin
    it "Contact Us is accessible from the contact page" do
        visit"/contact"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end

    #through navigation go to login
    it "Login is accessible from the contact page" do
        visit"/contact"
        click_link "Login"
        expect(page).to have_content "Don't have an account?"
    end  

    #through footer go to contact admin
    it "Contact is accessible from the contact page" do
        visit"/contact"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #through footer go to view accessibility
    it "Accessibility is accessible from the contact page" do   
        visit"/contact"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 
    
#page links tests from /SignUpChoices 

    #through navigation go to sign up choosing as a mentor or a mentee
    it "Sign-Up is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
        
    #through navigation go to view our program introduction
    it "Our Program is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    
    #through navigation go to contact admin 
    it "Contact Us is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
       
     #through footer go to contact admin 
    it "Contact is accessible from the SignUpChoices page" do
        visit"/SignUpChoices"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #through footer go to contact admin  
    it "Accessibility is accessible from the SignUpChoices page" do   
        visit"/SignUpChoices"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 
  
       
#page links tests from /MentorDashboard
    
    #through navigation go to contact admin 
    it "Contact Us is accessible from the MentorDashboard page" do
        visit"/MentorDashboard"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
           
    #through navigation go to log out 
    it "Logout is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor
        click_link "Dashboard"
        click_link "Logout"
        expect(page).to have_content "Logged out"
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the MentorDashboard page" do
        visit"/MentorDashboard"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end 
    
    #through navigation go to mentor dashboard
    it "Dashboard is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor   
        visit"/MentorDashboard"
        click_link "Dashboard"
        expect(page).to have_content "Mentor Dashboard"
    end 
    
    #checks the link in the mentor dashboard could work
   it "View mentee applications is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor   
        visit"/MentorDashboard"
        click_link "View mentee applications"
        expect(page).to have_content "Mentee Applications"
    end 
    #checks the link in the mentor dashboard could work
    it "Edit Profile is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor  
        visit"/MentorDashboard"
        click_link "Edit Profile"
        expect(page).to have_content "Edit your information"
    end 
    #checks the link in the mentor dashboard could work
    it "My Mentee is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor   
        visit"/MentorDashboard"
        click_link "My Mentee"
        expect(page).to have_content "Details of your current mentee"
    end 
    
    #through footer go to contact admin  
    it "Contact is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor  
        visit"/MentorDashboard"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #through footer go to view accessibility  
    it "Accessibility is accessible from the MentorDashboard page" do
        add_test_mentor
        login_mentor      
        visit"/MentorDashboard"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 
    
#page links tests from /MenteeDashboard
    
    #through navigation go to contact admin 
     it "Contact Us is accessible from the MenteeDashboard page" do
        visit"/MenteeDashboard"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
         clear_database   
    end
           
    #through navigation go to log out 
    it "Logout is accessible from the MenteeDashboard page" do
        add_test_user
        login_mentee
        visit"/MenteeDashboard"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the MenteeDashboard page" do
        visit"/MenteeDashboard"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #through navigation go to mentee dashboard
    it "Dashboard is accessible from the MenteeDashboard page" do
        add_test_user
        login_mentee 
        visit"/MenteeDashboard"
        click_link "Dashboard"
        expect(page).to have_content "Mentee Dashboard"
        clear_database   
    end 
    #checks the link in the mentee dashboard could work
    it "Find a mentor is accessible from the MenteeDashboard page" do
        add_test_user
         login_mentee
        visit"/MenteeDashboard"
        click_link "Find a mentor"
        expect(page).to have_content "Search for a Mentor"
        clear_database   
    end 
    #checks the link in the mentee dashboard could work
    it "Edit Profile is accessible from the MenteeDashboard page" do
        add_test_user
        visit "/login"
        login_mentee 
        visit"/MenteeDashboard"
        click_link "Edit Profile"
        expect(page).to have_content "Edit your information"
        clear_database   
    end 
    #checks the link in the mentee dashboard could work
    it "My Mentor is accessible from the MenteeDashboard page" do
        add_test_user
         login_mentee 
        visit"/MenteeDashboard"
        click_link "My Mentor"
        expect(page).to have_content "Details of your current mentor"
        clear_database   
    end 
       
    #through footer go to contact admin  
    it "Contact is accessible from the MenteeDashboard page" do
        add_test_user
        login_mentee   
        visit"/MenteeDashboard"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
        clear_database   
    end
    
    #through footer go to view accessibility 
    it "Accessibility is accessible from the MenteeDashboard page" do
        add_test_user
        login_mentee  
        visit"/MenteeDashboard"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

#page links tests from /AdminDashboard
    
    #through navigation go to contact admin 
     it "Contact Us is accessible from the AdminDashboard page" do
        visit"/AdminDashboard"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
        clear_database   
    end
           
    #through navigation go to log out 
    it "Logout is accessible from the AdminDashboard page" do
        
        login_admin
        visit"/AdminDashboard"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the AdminDashboard page" do
        visit"/AdminDashboard"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #through navigation go to admin dashboard
    it "Dashboard is accessible from the AdminDashboard page" do
        login_admin  
        visit"/AdminDashboard"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 
    #checks the link in the admin dashboard could work
    it "Mentor List is accessible from the AdminDashboard page" do
        login_admin 
        visit"/AdminDashboard"
        click_link "Mentor List"
        expect(page).to have_content "Your search revealed no mentors"
        clear_database   
    end 
    #checks the link in the admin dashboard could work
    it "Edit Profile is accessible from the AdminDashboard page" do
        login_admin
        visit"/AdminDashboard"
        click_link "Edit Profile"
        expect(page).to have_content "Edit your information"
        clear_database   
    end 
    #checks the link in the admin dashboard could work
    it "Mentee List is accessible from the AdminDashboard page" do
        login_admin
        visit"/AdminDashboard"
        click_link "Mentee List"
        expect(page).to have_content "Your search revealed no mentees"
        clear_database   
    end 
       
    #through footer go to contact admin  
    it "Contact is accessible from the AdminDashboard page" do
        login_admin 
        visit"/AdminDashboard"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
        clear_database   
    end
    
    #through footer go to view accessibility 
    it "Accessibility is accessible from the AdminDashboard page" do
        login_admin
        visit"/AdminDashboard"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

    #checks the link in the admin dashboard could work
    it "Pending Mentee Applications is accessible from the AdminDashboard page" do
        login_admin
        visit"/AdminDashboard"
        click_link "Pending Mentee Applications"
        expect(page).to have_content "Pending Mentee Requests"
        clear_database   
    end
    #checks the link in the admin dashboard could work
    it "Paired Mentees is accessible from the AdminDashboard page" do
        login_admin
        visit"/AdminDashboard"
        click_link "Paired Mentees"
        expect(page).to have_content "Search for a Paired Mentee"
        clear_database   
    end 


 #page links tests from /PendingMenteeApplications
    
    #through navigation go to logout
    it "Logout is accessible from the PendingMenteeApplications page" do        
        login_admin
        visit"/PendingMenteeApplications"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the PendingMenteeApplications page" do
        login_admin
        visit"/PendingMenteeApplications"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #through navigation go to admin dashboard
    it "Dashboard is accessible from the PendingMenteeApplications page" do
        login_admin 
        visit"/PendingMenteeApplications"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 

    #through footer go to view accessibility
     it "Accessibility is accessible from the PendingMenteeApplications page" do
        visit "/login"
         #enter the admin's username and password 
        fill_in "username", with: "admin2"
        fill_in "password", with: "S.F"
        click_button "Submit"
         #through dashboard go to PendingMenteeApplications
        visit"/PendingMenteeApplications"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

 #page links tests from /PairedMentees
            
    #through navigation go to logout 
    it "Logout is accessible from the PairedMentees page" do    
        login_admin
        visit"/PairedMentees"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #through navigation go to view our program introduction
    it "Our Program is accessible from the PairedMentees page" do
        login_admin
        visit"/PairedMentees"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #through navigation go to admin dashboard
    it "Dashboard is accessible from the PairedMentees page" do
        login_admin 
        visit"/PairedMentees"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 

    #through footer go to view accessibility
    it "Accessibility is accessible from the PairedMentees page" do
        login_admin
        visit"/PairedMentees"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

#page links tests from PairedMentees
    #enter the PairedMentees page then through navigation go to logout
    it "Logout is accessible from the PairedMentees page" do
        
        login_admin_mentor
        visit"/PairedMentees"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #enter the PairedMentees page then through navigation go to our program
    it "Our Program is accessible from the PairedMentees page" do
        login_admin_mentor
        visit"/PairedMentees"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #enter the PairedMentees page then through navigation go to dashboard
    it "Dashboard is accessible from the PairedMentees page" do
        login_admin_mentor 
        visit"/PairedMentees"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 

    #enter the PairedMentees page then through footer go to view accessibility
     it "Accessibility is accessible from the PairedMentees page" do
        login_admin_mentor
        visit"/PairedMentees"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

 #page links tests from /searchForAMentee
    #enter the searchForAMentee page then through navigation go to logout
    it "Logout is accessible from the searchForAMentee page" do
        login_admin
        visit"/searchForAMentee"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
     #enter the searchForAMentee page then through navigation go to our program
    it "Our Program is accessible from the searchForAMentee page" do
        login_admin
        visit"/searchForAMentee"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
     #enter the searchForAMentee page then through navigation go to dashboard
     it "Dashboard is accessible from the searchForAMentee page" do
        login_admin  
        visit"/searchForAMentee"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 

     #enter the searchForAMentee page then through footer go to view accessibility
     it "Accessibility is accessible from the searchForAMentee page" do
        login_admin
        visit"/searchForAMentee"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

#page links tests from /searchForAMentor
           
    #enter the searchForAMentor page then through navigation go to logout
    it "Logged out is accessible from the searchForAMentor page" do        
        login_admin
        visit"/searchForAMentor"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end

    #enter the searchForAMentor page then through navigation go to our program
    it "Our Program is accessible from the searchForAMentor page" do
        login_admin
        visit"/searchForAMentor"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #enter the searchForAMentor page then through navigation go to dashboard
    it "Dashboard is accessible from the searchForAMentor page" do
        login_admin
        visit"/searchForAMentor"
        click_link "Dashboard"
        expect(page).to have_content "Admin Dashboard"
        clear_database   
    end 

    #enter the searchForAMentor page then through footer go to view accessibility
    it "Accessibility is accessible from the searchForAMentor page" do
        login_admin  
        visit"/searchForAMentor"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end 

#page links tests from /AdminDashboard
    
    #login as an admin to view the admin dashboard and check the information in the admin dashboard
     it "My Mentor Schedule should not in the AdminDashboard page" do
        login_admin   
        visit"/AdminDashboard"
        expect(page).not_to have_content "My Mentor Schedule"
        clear_database   
    end 
        
    #enter the AdminMentorDashboard page then through navigation go to logout
    it "Logout is accessible from the AdminMentorDashboard page" do
        add_test_mentor
        login_admin_mentor
        visit"/AdminMentorDashboard"
        click_link "Logout"
        expect(page).to have_content "Logged out"
        clear_database   
    end
    
    #enter the AdminMentorDashboard page then through navigation go to our program
    it "Our Program is accessible from the AdminMentorDashboard page" do
        visit"/AdminMentorDashboard"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
        clear_database   
    end 
    
    #enter the AdminMentorDashboard page then through navigation go to dashboard
    it "Dashboard is accessible from the AdminMentorDashboard page" do
        add_test_mentor
        login_admin_mentor 
        visit"/AdminMentorDashboard"
        click_link "Dashboard"
        expect(page).to have_content "Admin + Mentor Dashboard"
        clear_database   
    end 
    #checks the link in the admin mentor dashboard could work
    it "Mentor List is accessible from the AdminMentorDashboard page" do
        clear_database 
        add_test_mentor
        login_admin_mentor   
        visit"/AdminMentorDashboard"
        click_link "Mentor List"
        expect(page).to have_content "Mentor List"
        clear_database   
    end 
    #checks the link in the admin mentor dashboard could work
    it "Edit Profile is accessible from the AdminMentorDashboard page" do
        add_test_mentor
        visit "/login"
        login_admin_mentor
        visit"/AdminMentorDashboard"
        click_link "Edit Profile"
        expect(page).to have_content "Edit your information"
        clear_database   
    end 
    #checks the link in the admin mentor dashboard could work
    it "Mentee List is accessible from the AdminMentorDashboard page" do
        clear_database         
        add_test_mentor
        login_admin_mentor
        visit"/AdminMentorDashboard"
        click_link "Mentee List"
        expect(page).to have_content "Mentee List"
        clear_database   
    end 
       
    #enter the AdminMentorDashboard page then through footer go to view accessibility
     it "Accessibility is accessible from the AdminMentorDashboard page" do
        add_test_mentor
        login_admin_mentor
        visit"/AdminMentorDashboard"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
        clear_database   
    end
    
    #view the AdminMentorDashboard and check the information in the AdminMentorDashboard
     it "My Mentor Schedule should not appear in the AdminMentorDashboard page" do
       add_test_mentor
        login_admin_mentor 
        visit"/AdminMentorDashboard"
        expect(page).not_to have_content "My Mentor Schedule"
        clear_database   
    end
    #checks the link in the admin mentor dashboard could work
     it "My Mentee is accessible from the AdminMentorDashboard page" do
        add_test_mentor
        login_admin_mentor 
        visit"/AdminMentorDashboard"
        click_link "My Mentee"
        expect(page).to have_content "Details of your current mentee"
        clear_database   
    end 

     

#test buttons and links 
describe "the page links" do
    

 #page links tests from /login  

    #enter the Login page then through navigation go to our program
    it "Our Program is accessible from the login page" do
        visit "/"
        click_link "Login"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    #enter the Login page then through navigation go to contact admin 
    it "Contact Us is accessible from the login page" do
         visit "/"
        click_link "Login"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
    
    #enter the Login page then check the content in the Login page 
    it "Login is accessible from the login page" do
         visit "/"
        click_link "Login"
        click_link "Login"
        expect(page).to have_content "Don't have an account?"
    end    

    #enter the Login page then through navigation go to sign up page 
    it "Sign-Up is accessible from the login page" do
        visit "/"
        click_link "Login"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
        end
    
    #enter the Login page then through footer go to contact admin 
    it "Contact is accessible from the login page" do
         visit "/"
        click_link "Login"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #enter the Login page then through footer go to view accessibility
    it "Accessibility is accessible from the login page" do   
         visit "/"
        click_link "Login"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 


    
 #page links tests from /contact  

    #enter the Contact Us page then through navigation go to sign up page
    it "Sign-Up is accessible from the contact page" do
        visit "/"
        click_link "Contact Us"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
        
    #enter the Contact Us page then through navigation go to our program
    it "Our Program is accessible from the contact page" do
        visit "/"
        click_link "Contact Us"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    #enter the Contact Us page then check the content of contact page 
    it "Contact Us is accessible from the contact page" do
        visit "/"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end

    #enter the Contact Us page then through navigation go to login
    it "Login is accessible from the contact page" do
        visit "/"
        click_link "Contact Us"
        click_link "Login"
        expect(page).to have_content "Don't have an account?"
    end  

    #enter the Contact Us page then through footer go to contact
    it "Contact is accessible from the contact page" do
        visit "/"
        click_link "Contact Us"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    
    #enter the Contact Us page then through footer go to view accessibility
    it "Accessibility is accessible from the contact page" do   
        visit "/"
        click_link "Contact Us"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 
    
 #page links tests from /SignUpChoices 

    #enter the SignUpChoices page then check the content of sign up page
    it "is accessible from the SignUpChoices page" do
        visit "/"  
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
        
    #enter the SignUpChoices page then through navigation go to our program
    it "Our Program is accessible from the SignUpChoices page" do
        visit "/"  
        click_link "Sign-Up"
        click_link "Our Program"
        expect(page).to have_content "one-to-one mentoring program"
    end
    
    #enter the SignUpChoices page then through navigation go to contact admin 
    it "Contact Us is accessible from the SignUpChoices page" do
        visit "/"  
        click_link "Sign-Up"
        click_link "Contact Us"
        expect(page).to have_content "Contact Admin:"
    end
       
     #enter the SignUpChoices page then through footer go to contact 
    it "Contact is accessible from the SignUpChoices page" do
        visit "/"  
        click_link "Sign-Up"
        click_link "Contact"
        expect(page).to have_content "Contact Admin:"
    end 
    #enter the SignUpChoices page then through footer go to view accessibility
    it "Accessibility is accessible from the SignUpChoices page" do   
        visit "/"  
        click_link "Sign-Up"
        click_link "Accessibility"
        expect(page).to have_content "Everyone using this website"
    end 
    #checks the link in the SignUpChoices page could work
    it "Mentee is accessible from the SignUpChoices page" do   
        visit "/"  
        click_link "Sign-Up"
        click_link "Mentee"
        expect(page).to have_content "Mentee Sign Up"
    end
    #checks the link in the SignUpChoices page could work
    it "Mentor is accessible from the SignUpChoices page" do   
        visit "/"  
        click_link "Sign-Up"
        click_link "Mentor"
        expect(page).to have_content "Mentor Sign Up"
    end 
end
clear_database    
    
end