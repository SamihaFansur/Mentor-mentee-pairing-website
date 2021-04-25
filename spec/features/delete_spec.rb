require_relative "../spec_helper"
#tests for deleting mentee
describe "the delete page" do
  it "allows deletion of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    visit"/MenteeDashboard"
    click_link "Edit Profile"
    click_button "Delete" 
    expect(page).to have_content "one-to-one mentoring program"
    clear_database
  end
    #tests for deleting mentor
   it "allows deletion of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    visit"/MentorDashboard"
    click_link "Edit Profile"
    click_button "Delete"
    expect(page).to have_content "one-to-one mentoring program"
    clear_database
  end
    
   it "tests for a mentor delete by admin" do
  clear_database
    add_test_mentor
    add_test_user
    visit "/login" 
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"      
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
 it "tests for a mentee delete by admin " do
 clear_database
    add_test_mentor
    add_test_user
    visit "/login" 
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"      
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
 end
        
   it "tests for a mentor delete by admin mentor" do
  clear_database
    add_test_mentor
    add_test_user
    visit "/login" 
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"      
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"   
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
 it "tests for a mentee delete by admin mentor" do
 clear_database
    add_test_mentor
    add_test_user
    visit "/login" 
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"      
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"   
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

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
   
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"   
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

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
   
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"   
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

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
   
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

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
   
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
    clear_database
end