require_relative "../spec_helper"


    
#checks that a mentee can be edited
#
#
#tests that error message shows up when a nil mentee is attempted to be edited
describe "applications page" do
context "with an empty database" do
    it "says the database is empty" do
      clear_database
      add_test_user
      visit "/login"
      fill_in "username", with: "123"
      fill_in "password", with: "123"
      click_button "Submit"
      visit "/search"
      fill_in "searchForMentor", with: "123"
      expect(page).to have_content "Your search revealed no mentors"
      clear_database  
    end
       
  it "tests for a mentee/mentor match" do
  clear_database
      add_test_mentor
      add_test_user
      visit "/login" 
      fill_in "username", with: "1234"
      fill_in "password", with: "1234"
      click_button "Submit"      
      visit "/login" 
      fill_in "username", with: "123"
      fill_in "password", with: "123"
      click_button "Submit"
      visit "/search"
      fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
      click_button "Submit"
      click_button "Send application" 
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    visit "/menteeApplications"

    click_button "Accept application"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
end
    clear_database
end