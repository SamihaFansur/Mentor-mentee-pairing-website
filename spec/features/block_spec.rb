require_relative "../spec_helper"


    
#checks that a user can be blocked

#admin

 #When mentee list is empty, empty list message is displayed
 describe "admin block page" do
  it "shows empty list message when no mentees" do
    login_admin
    click_link "Mentee List"
    expect(page).to have_content "Your search revealed no mentees."
    clear_database
  end
    
  #When the mentor list is empty, empty list message is displayed   
  it "shows empty list message when no mentors" do
    login_admin
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
   
   #Admin blocks a mentee on the mentee list
   #When the mentee attempts login, suspended message is displayed
   it "allows block of a valid mentee by admin" do
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Block"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
     
  #Admin blocks a mentor on the mentor list
  #When the mentor attempts login, suspended message is displayed     
  it "allows block of a valid mentor by admin" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Block"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
   
   #Tests that admin can block and unblock a mentee  
   #Admin blocks a mentee on the mentee list
   #Admin then unblocks mentee  
   it "allows block and unblock of a valid mentee" do
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    login_mentee
    expect(page).to have_content "George Test"
    clear_database
  end
  
  #Tests that admin can block and unblock a mentor  
  #Admin blocks a mentor on the mentor list
  #Admin then unblocks mentor    
  it "allows block and unblock of a valid mentor" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Block"
    click_button "Unblock"
    login_mentor
    expect(page).to have_content "Sam Mentor"
    clear_database
  end 
    
    #admin + mentor
  
  #When mentee list is empty, search displays no mentees revealed message   
  it "shows empty list message when no mentees" do
    add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    expect(page).to have_content "Your search revealed no mentees."
    clear_database
  end
  
  #When mentor list is empty, search displays no mentors revealed message   
  it "shows empty list message when no mentors" do
    login_admin
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
   
   #Admin mentor searches and blocks mentee
   #Attempted login by mentee displays suspended account message  
   it "allows block of a valid mentee by admin_mentor" do
    add_test_user
    add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_button "Block"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
    
  #Admin mentor searches and blocks mentor
  #Attempted login by mentor displays suspended account message   
  it "allows block of a valid mentor by admin_mentor" do
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
     
  #Tests that admin mentor can block and unblock a mentee  
  #Admin mentor blocks a mentee on the mentee list
  #Admin mentor then unblocks mentee
   it "allows block and unblock of a valid mentee" do
    add_test_user
   add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    login_mentee
    expect(page).to have_content "George Test"
    clear_database
  end
  
  #Tests that admin mentor can block and unblock a mentor  
  #Admin mentor blocks a mentor on the mentor list
  #Admin mentor then unblocks mentor   
  it "allows block and unblock of a valid mentor" do
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    click_button "Unblock"
    login_mentor
    expect(page).to have_content "Sam Mentor"
    clear_database
  end 
 
 #Tests if a matched mentee can be blocked
 #Mentor accepts mentee application and match
 #Admin blocks mentee which displays suspended message when mentee attempts login
 it "tests block of matched user" do
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
    click_button "Block"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end

 #Tests if a matched mentor can be blocked
 #Mentor accepts mentee application and match
 #Admin mentor blocks mentor which displays suspended message when mentor attempts login   
 it "checks block of matched mentor" do
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
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
 end

   #Tests if a matched mentee can be blocked and unblocked by an admin mentor
   it "allows block and unblock of a valid mentee" do
    add_test_user
   add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    login_mentee
    expect(page).to have_content "George Test"
    clear_database
  end
  
  #Tests if a matched mentee can be blocked and unblocked by an admin mentor
  it "allows block and unblock of a valid mentor" do
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    click_button "Unblock"
    login_mentor
    expect(page).to have_content "Sam Mentor"
    clear_database
  end

 #Checks that a mentor that is matched with a mentee can be blocked
 it "checks block of mentor by admin thats matched" do
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
    click_link "Mentor List"
    click_button "Block"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
  end

 #Checks that an admin mentor can block a mentor that is matched to a mentee
 it "tests admin_mentor can block matched mentor" do
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
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
 end

 #Checks that an admin can block a mentor that is matched
 it "tests admin can block matched mentor" do
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
    click_link "Mentor List"
    click_button "Block"
    login_mentor
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
  
  #Presents a message notifying the admin mentor that the mentor account is already blocked
  it "tests block of mentor that is already blocked" do
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_button "Block"
    click_button "Block"
    expect(page).to have_content "Account has already been blocked"
    clear_database
  end

#Presents a message notifying the admin mentor that the mentee account is already blocked
it "tests block of mentee that is already blocked" do
    add_test_user
    add_test_mentor
    login_mentor
    add_test_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_button "Block"
    click_button "Block"

    expect(page).to have_content "Account has already been blocked"
    clear_database
  end

   #Presents a message notifying the admin mentor that the mentee account is already unblocked
   it "tests unblock of mentee that is already unblocked" do
    add_test_user
    login_admin
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    click_button "Unblock"
    expect(page).to have_content "Account has already been unblocked"
    clear_database
  end
  
  #Presents a message notifying the admin mentor that the mentor account is already unblocked
  it "tests unblock of mentor that is already unblocked" do
    add_test_mentor
    login_mentor
    login_admin
    click_link "Mentor List"
    click_button "Block"
    click_button "Unblock"
    click_button "Unblock"
    expect(page).to have_content "Account has already been unblocked"
    clear_database
  end 

 #Checks that an admin mentor can block a mentee that they are matched to
 it "tests block of matched user from admin mentor" do
  clear_database
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
    login_admin
    click_link "Mentee List"
    click_button "Block"
    login_mentee
    expect(page).to have_content "Your account is suspended"
    clear_database
  end

        clear_database
end