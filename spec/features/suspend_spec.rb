require_relative "../spec_helper"
    
#checks that a user can be suspended
#tests that error message shows up when a nil mentee is attempted to be edited

describe "admin suspend page" do
  #check if the mentee list is empty
  it "tests for an empty mentee list" do
    login_admin
    click_link "Mentee List"
    expect(page).to have_content "Your search revealed no mentees."
    clear_database
  end
    
  #check if the mentor list is empty    
  it "tests for an empty mentor list" do
    login_admin
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
    
   # check if admin could suspend the mentee
   it "tests that a mentee can be suspended" do 
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Suspend"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
    
    # check if admin could suspend the mentor
  it "tests that a mentor can be suspeded" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Suspend"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
   
   #check if the admin could unsuspend a suspended mentee 
   it "tests that a mentee can be unsuspended" do
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Suspend"
    click_button "Unsuspend"
    login_mentee
    expect(page).to have_content "George Test"
    clear_database
  end
    
    #check if the admin could unsuspend a suspended mentor
  it "tests that a mentor can be unsuspended" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Suspend"
    click_button "Unsuspend"
    login_mentor
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
    
   #check if the matched mentee could be suspended
   it "tests that matched mentee can be suspended" do
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
    login_admin
    click_link "Mentee List"
    click_button "Suspend"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
   
  #checks that the suspend action can only be done once on a mentor
  it "allows suspend of a valid mentor but not twice" do
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_button "Suspend"
    click_button "Suspend"
    expect(page).to have_content "Account has already been suspended"
    clear_database
  end
    
    #checks if the suspend action could only be done once on a mentee
   it "allows suspend of a valid mentee but not twice" do
    add_test_user
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_button "Suspend"
    click_button "Suspend"
    expect(page).to have_content "Account has already been suspended"
    clear_database
  end
    
    #checks that the unsuspend action could only be done once on a mentee
   it "tests that mentee cant be unsuspended twice" do
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Suspend"
    click_button "Unsuspend"
    click_button "Unsuspend"
    expect(page).to have_content "Account has already been unsuspended"
    clear_database
  end
  
    #checks that the unsuspend action could only be done once on a mentor
  it "tests that mentor cant be unsuspended twice" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Suspend"
    click_button "Unsuspend"
    click_button "Unsuspend"
    expect(page).to have_content "Account has already been unsuspended"
    clear_database
  end
    
    #check if the mentee account is unsuspended automatically after sleep period 
   it "tests that mentee is unsupended after amount of time" do
    add_test_user
    login_admin
    click_link "Mentee List"
    #Press the bottom to suspend the mentee
    click_button "Suspend"
    #sleep for 31 seconds
    sleep(31)
    #automatically unsupend the mentee and login
    login_mentee
    #view mentee dashboard 
    expect(page).to have_content "George Test"
    clear_database
  end
    
    #check if the mentor account is unsuspended automatically after sleep period 
  it "tests that mentor is unsuspended after amount of time" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Suspend"
    #waits for 31 seconds, the time for suspension to run out
    sleep(31)
    login_mentor
    expect(page).to have_content "Sam Mentor"
    clear_database
  end 

# final test as deleting admin breaks other tests if it goes before them
   it "tests for deleting admin" do
    clear_database   
    login_admin  
    click_link "Edit Profile"
    click_button "Delete"
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    expect(page).to have_content "Username/Password combination incorrect"
    clear_database
  end
 clear_database
end