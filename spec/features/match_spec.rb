require_relative "../spec_helper"


    
#checks that a mentee can be matched

describe "match page" do
context "with an empty database" do
       
  it "tests for a mentee/mentor match" do

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
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
      it "tests for a mentee/mentor match when already have mentor" do

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
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    visit "/MentorSignUpForm"
    fill_in "fname", with: "Sam"
    fill_in "lname", with: "Mentor"
    fill_in "email", with: "arb21eg@sheffield.ac.uk"
    fill_in "phoneNum", with: "+44 7721851137"
    fill_in "username", with: "12345"
    fill_in "password", with: "12345"
    select "Aerospace Engineering with a Year in North America (Meng)", :from => "courseName"
    select "Account Collector", :from => "jobTitle"
    click_button "Submit"        
    visit "/login" 
    fill_in "username", with: "12345"
    fill_in "password", with: "12345"
    click_button "Submit"      
    login_mentee
    visit "/search?error=2" 
    expect(page).to have_content "You already have a mentor"
    clear_database
  end
      it "checks report of mentee can be dismissed" do

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
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    login_mentor  
    click_link "My Mentee"
    click_button "Report Mentee"
    select "Public Shaming", :from => "caption"
    fill_in "Description:", with: "spam"
    click_button "Submit"
    login_admin
    click_link "Reports"
    click_button "Dismiss"
    expect(page).to have_content "No mentor has reported their mentee yet!"
    
    clear_database
  end
      it "tests for a mentee/mentor reject application" do

    add_test_mentor
    add_test_user
    login_mentor       
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor  
    click_link "View mentee applications"
    click_button "Reject application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    expect(page).to have_content "There are no pending applications"
    clear_database
  end

  it "tests for a mentee/mentor meeting request" do

    add_test_mentor
    add_test_user
    login_mentee
      login_mentor        
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_mentor  
    click_link "View mentee applications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    visit "/MenteeDashboard"
    click_link "My Mentor"
    click_button "Request Mentor Meeting"
    expect(page).to have_content "Sam Mentor"
    login_mentor  
    clear_database
  end
 it "tests for a mentee/mentor match" do

    add_test_mentor
    add_test_user
    login_mentor    
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    visit "/MenteeDashboard"
    expect(page).to have_content "George"
    clear_database
  end
it "tests for a mentee/mentor match" do

    add_test_mentor
    add_test_user
    login_mentor    
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    login_mentor  
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
  it "tests for a mentee/mentor match using admin mentor account" do

    add_test_mentor
    add_test_user
    login_mentor    
    login_mentee
    visit "/search"
    fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
    click_button "Submit"
    click_button "Send application" 
    login_admin_mentor  
    visit "/menteeApplications"
    click_button "Accept application"
    login_mentee
    visit "/MenteeDashboard"
    click_link "View mentor applications"
    click_button "Match"
    visit "/MenteeDashboard"
    click_link "My Mentor"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
end
end