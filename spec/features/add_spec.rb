require_relative "../spec_helper"
#checks that signup is accessible from /index and that mentee signup is inside
describe "the signup page" do
    it "Sign-Up is accessible from the index page" do
        visit"/"
        click_link "Sign-Up"
        expect(page).to have_content "Mentee"
    end
    #tests that an empty signup form wont submit for mentee
    it "will not add a mentee with no details" do
        visit "/MenteeSignUpForm"
        click_button "Submit"
        expect(page).to have_content "Mentee Sign Up"
    end
    #adds a mentee and tests that they are added
    it "adds a mentee into the fields" do
        visit "/MenteeSignUpForm"
        add_test_user
        login_mentee
        visit"/MenteeDashboard"
        expect(page).to have_content "George Test"
        clear_database
    end
    
    
    
    #checks that signup is accessible from /index and that mentor signup is inside
        it "Sign-Up is accessible from the index page" do
        visit"/"
        click_link "Sign-Up"
        expect(page).to have_content "Mentor"
    end
    #tests that an empty signup form wont submit for mentor
    it "will not add a mentor with no details" do
        visit "/MentorSignUpForm"
        click_button "Submit"
        expect(page).to have_content "Mentor Sign Up"
    end
    #adds a mentor and tests that they are added
    it "adds a mentor into the fields" do
        add_test_mentor
        login_mentor
        visit"/MentorDashboard"
        expect(page).to have_content "Sam Mentor"
        clear_database
    end
  #checks for invalid login for mentor
        it "adds a mentor into the fields" do
        add_test_mentor
        login_mentee
        expect(page).to have_content "Username/Password combination incorrect"

        clear_database
    end
    
    
   #checks for invalid login for mentee
        it "adds a mentee into the fields" do
        add_test_user
        login_mentor
        expect(page).to have_content "Username/Password combination incorrect"

        clear_database
 end 
    
   #checks for correct information error message
 it "adds empty username field" do
        add_test_user
        visit "/login"
        fill_in "username", with: ""
        fill_in "password", with: ""
        click_button "Submit"
        expect(page).to have_content "Please correct the information below"

        clear_database
 end 
    
      #checks that adminMentor can login
        it "checks adminMentor Login" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: "1234"
        fill_in "password", with: "1234"
        click_button "Submit"
        expect(page).to have_content "Sam"

        clear_database
    end
      #checks that adminMentor has error message
        it "checks loginAGain errors" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: ""
        fill_in "password", with: ""
        click_button "Submit"
        expect(page).to have_content "Please correct the information below"

        clear_database
    end
    
      #checks that adminMentor has error message
        it "checks loginAGain errors for username/password" do
        add_test_mentor
        visit "/loginAgain"
        fill_in "username", with: "1234"
        fill_in "password", with: "123"
        click_button "Submit"
        expect(page).to have_content "Username/Password combination incorrect"

        clear_database
    end
    
    
    clear_database
end