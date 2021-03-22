require_relative "../spec_helper"

describe "the signup page" do
    it "is accessible from the search page" do
        visit"/index"
        click_link "Sign Up"
        expect(page).to have_content "Mentee"
    end
    
    it "will not add a mentee with no details" do
        visit "/MenteeSignUpForm"
        click_button "Submit"
        expect(page).to have_content "Mentee Sign Up"
    end
    
    it "adds a player into the fields" do
        visit "/MenteeSignUpForm"
        add_test_user
        click_button "Submit"
        expect(page).to have_content "Login"

        clear_database
    end
end
