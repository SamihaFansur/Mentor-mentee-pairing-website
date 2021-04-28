require_relative "../spec_helper"
#tests for deleting mentee
describe "the delete page" do
  it "allows deletion of a valid mentee" do
    add_test_user
    login_mentee
    visit"/MenteeDashboard"
    click_link "Edit Profile"
    click_button "Delete" 
    expect(page).to have_content "one-to-one mentoring program"
    clear_database
  end
    #tests for deleting mentor
   it "allows deletion of a valid mentor" do
    add_test_mentor
    login_mentor
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
    login_mentee     
    login_admin
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentee
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
 it "tests for a mentee delete by admin " do
 clear_database
    add_test_mentor
    add_test_user
    login_mentor     
    login_admin
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentor
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
 end
        
   it "tests for a mentor delete by admin mentor" do
  clear_database
    add_test_mentor
    add_test_user
    login_mentee      
    login_admin_mentor
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentee
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
 it "tests for a mentee delete by admin mentor" do
 clear_database
    add_test_mentor
    add_test_user
    login_mentor    
    login_admin_mentor  
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentor
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
 end
    
    it "tests for a mentee/mentor match deletion of mentor" do
  clear_database
    add_test_mentor
    add_test_user
    login_mentor     
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"  
    login_admin_mentor  
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentor
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
        it "tests for a mentee/mentor match deletion of mentee " do
  clear_database
    add_test_mentor
    add_test_user
    login_mentor      
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    login_admin_mentor
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentee
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
        it "tests for a mentee/mentor match deletion of mentor by admin/mentor" do
  clear_database
    add_test_mentor
    add_test_user
    login_mentor    
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match" 
    login_admin
    click_link "Mentor List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentor
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
        it "tests for a mentee/mentor match deletion of mentee by admin/mentor" do
  clear_database
    add_test_mentor
    add_test_user
    login_mentor    
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match" 
    login_admin
    click_link "Mentee List"
    click_link "Edit Profile"
    click_button "Delete"
    login_mentee
    expect(page).to have_content "Username/Password combination incorrect"

    clear_database
  end
     
    clear_database
end