require_relative "../spec_helper"

#Tests the features of the website that add a user to the databse.

#Checks that signup is accessible from /index and that mentee signup is inside.
describe "the signup page" do
    it "Sign-Up is accessible from the index page" do
        visit"/"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
    #Tests that an empty signup form wont submit for mentee.
    it "will not add a mentee with no details" do
        visit "/MenteeSignUpForm"
        click_button "Submit"
        expect(page).to have_content "Mentee Sign Up"
    end
    #Adds a mentee and tests that they are added to the database and have a profile.
    it "adds a mentee into the fields" do
        visit "/MenteeSignUpForm"
        add_test_user
        login_mentee
        visit"/MenteeDashboard"
        expect(page).to have_content "George Test"
        clear_database
    end
    
    #Checks that signup is accessible from "/" and that mentor signup is inside.
        it "Sign-Up is accessible from the index page" do
        visit"/"
        click_link "Sign-Up"
        expect(page).to have_content "Mentor"
    end
    
    #Tests that an empty signup form wont submit for mentor
    it "will not add a mentor with no details" do
        visit "/MentorSignUpForm"
        click_button "Submit"
        expect(page).to have_content "Mentor Sign Up"
    end
    
    #Adds a mentor and tests that they are added to the database and have a profile.
    it "adds a mentor into the fields" do
        add_test_mentor
        login_mentor
        visit"/MentorDashboard"
        expect(page).to have_content "Sam Mentor"
        clear_database
    end
    
  #Checks for invalid login error message for mentor.
        it "adds a mentor into the fields" do
        add_test_mentor
        login_mentee
        expect(page).to have_content "Username/Password combination incorrect"

        clear_database
    end
    
   #Checks for invalid login error message for mentee
        it "adds a mentee into the fields" do
        add_test_user
        login_mentor
        expect(page).to have_content "Username/Password combination incorrect"

        clear_database
 end 
    
   #Checks for correct information error message when loging in with empty username/password.
 it "adds empty username field" do
        add_test_user
        visit "/login"
        fill_in "username", with: ""
        fill_in "password", with: ""
        click_button "Submit"
        expect(page).to have_content "Please correct the information below"
        clear_database
 end 
    
      #Checks that adminMentor can login
        it "checks adminMentor Login" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: "1234"
        fill_in "password", with: "1234"
        click_button "Submit"
        expect(page).to have_content "Sam"
        clear_database
    end
      #Checks that adminMentor has error message when enterting empty username/password.
        it "checks loginAGain errors" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: ""
        fill_in "password", with: ""
        click_button "Submit"
        expect(page).to have_content "Please correct the information below"
        clear_database
    end
    
      #Checks that adminMentor has error message when inputing incorrect username/password.
        it "checks loginAGain errors for username/password" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: "1234"
        fill_in "password", with: "123"
        click_button "Submit"
        expect(page).to have_content "Username/Password combination incorrect"
        clear_database
    end    
end