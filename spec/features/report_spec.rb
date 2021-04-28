require_relative "../spec_helper"
  
#checks that a mentor can send reports

describe "mentor report" do
context "a mentee" do      
  it "tests the mentors can report their mentee" do
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
    click_button "View"
    expect(page).to have_content "spam"
    
    clear_database
  end  
end
    clear_database
end