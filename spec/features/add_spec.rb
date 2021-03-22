require_relative "../spec_helper"
#checks that signup is accessible from /index and that mentee signup is inside
describe "the signup page" do
    it "is accessible from the search page" do
        visit"/index"
        click_link "Sign Up"
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
        visit "/login"
        fill_in "username", with: "123"
        fill_in "password", with: "123"
        click_button "Submit"
        visit"/MenteeDashboard"
        expect(page).to have_content "George Test"
        clear_database
    end
    
    
    
    #checks that signup is accessible from /index and that mentor signup is inside
        it "is accessible from the search page" do
        visit"/index"
        click_link "Sign Up"
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
        visit "/login"
        fill_in "username", with: "1234"
        fill_in "password", with: "1234"
        click_button "Submit"
        visit"/MentorDashboard"
        expect(page).to have_content "Sam Mentor"
        clear_database
    end
    
    
end