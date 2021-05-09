require_relative "../spec_helper"

#tests the search features on the website

#tests the mentor search when it is empty
describe "the search page" do
  context "with an empty database" do
    it "says the database is empty" do
      clear_database
      add_test_user
      login_mentee
      visit "/search"
      fill_in "searchForMentor", with: "123"
      expect(page).to have_content "Your search revealed no mentors"
      clear_database  
    end
      #tests that paired users can be searched for by faculty    
      it "checks the mentor has been sent an application" do
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
      click_link "View sent mentor applications"
      click_button "Match"
      login_admin
      click_link "Paired Mentees"
      select "Faculty of Arts and Humanities", :from => "searchForMentee" 
      click_button "Submit" 
      expect(page).to have_content "0"
      clear_database
      end   
 #checks if applciaitons are empty        
   it "checks the mentor has been sent an application" do
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
      visit "/MentorDashboard"
      visit "/menteeApplications"
      expect(page).to have_content "George"
      
      clear_database
    end   
      
#tests the mentor search when there is only
  context "with one record in the database" do
    it "lists the mentors" do     
      clear_database
      add_test_mentor
      login_mentor
      visit "/index"
      add_test_user
      login_mentee
      visit "/search"
      expect(page).to have_content "Sam Mentor"
      clear_database
    end
#checks that mentor doesnt appear when wrong course is entered
    it "does not list the mentor when a different courseName is searched for" do
      clear_database 
      add_test_mentor
      add_test_user
      login_mentor  
      login_mentee
      visit "/search"
      fill_in "searchForMentor", with: "Architecture (BA)"
      click_button "Submit"
      expect(page).to have_content "Your search revealed no mentors"
      clear_database
    end
#checks that mentor appears when wrong course is entered
    it "lists the mentor when their courseName is searched for" do
      clear_database
      add_test_mentor
      add_test_user
      login_mentor 
      login_mentee
      visit "/search"
      fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
      click_button "Submit"
      expect(page).to have_content "Sam Mentor"
      clear_database
    end


    
     #checks if applciaitons are empty        
   it "checks that unsend applicaiton is working" do
 clear_database
      add_test_mentor
      add_test_user
      login_mentor     
      login_mentee
      visit "/search"
      fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
      click_button "Submit"
      click_button "Send application"      
      click_link "Dashboard"
      click_link "View sent mentor applications"
      click_button "Unsend Application"  
      click_link "Dashboard"
      click_link "View sent mentor applications"

      expect(page).to have_content "There are no pending applications"
      
      clear_database
    end 
       it "checks the mentor has been sent an application" do
 clear_database
      add_test_mentor
      add_test_user
      login_mentor     
      login_mentee
      visit "/search"
      fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
      click_button "Submit"
      click_button "Send application" 
      sleep(101)
      login_mentor
      visit "/MentorDashboard"
      visit "/menteeApplications"
      expect(page).to have_content "Application"
      
      clear_database     
      end   
    end
  end   
end