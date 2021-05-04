require_relative "../spec_helper"
  
#checks that a mentee can be edited
#tests that error message shows up when a nil mentee is attempted to be edited

describe "the mentee edit page" do
    #displays an error if there are no mentee
  it "shows an error when trying to load an invalid mentee" do
    visit "/editMentee?id=1000000"
    expect(page).to have_no_xpath('a')
  end
      
    #login as a mentee and edit the mentee information in person 
  it "allows editing of a valid mentee" do
    add_test_user
    login_mentee
    visit "/MenteeDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/MenteeDashboard"
    expect(page).to have_content "George Test"
    clear_database
  end
#checks that mentee edit is submitted and displayed
  it "allows a mentee record to be changed" do
    add_test_user
     login_mentee
    visit "/MenteeDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/MenteeDashboard"
    expect(page).to have_content "New"
    clear_database
  end
#checks that an empty data field can be submitted for mentee
  it "will save empty data field" do
    add_test_user
    visit "/login"
     login_mentee
    visit "/MenteeDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: ""
    click_button "Submit"
    visit"/MenteeDashboard"
    expect(page).to have_content "Test"
    clear_database
  end
    
    #checks that an description for mentee can be edited
  it "description can be edited" do
    add_test_user
    login_mentee

    visit "/MenteeDashboard"
    click_link "Edit Profile"
    fill_in "description", with: "hello"
    click_button "Submit"
    visit"/MenteeDashboard"
    expect(page).to have_content "hello"
    clear_database
  end
end  
    
    
    
#checks that a mentor can be edited
describe "the mentor edit page" do
    
    #displays an error if there are no mentor
  it "shows an error when trying to load an invalid mentor" do
    visit "/editMentor?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
    #login as a mentor and edit the mentor information in person 
    it "allows editing of a valid mentor" do
    add_test_mentor
    login_mentor
    visit"/MentorDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/MentorDashboard"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end
#checks that mentor edit is submitted and displayed
  it "allows a mentor record to be changed" do
    add_test_mentor
    login_mentor
    visit"/MentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/MentorDashboard"
    expect(page).to have_content "New"
    clear_database
  end
#checks that an empty data field can be submitted for mentor
  it "will save empty data field" do
    add_test_mentor
    login_mentor
    visit "/MentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: ""
    click_button "Submit"
    visit"/MentorDashboard"
    expect(page).to have_content "Mentor"
    clear_database
  end

#checks that the description for mentor can be changed
  it "description for mentor can be changed" do
    add_test_mentor
    login_mentor
    visit"/MentorDashboard"
    click_link "Edit Profile"
    fill_in "description", with: "hello"
    click_button "Submit"
    visit"/MentorDashboard"
    expect(page).to have_content "hello"
    clear_database
  end
    
    
#checks that a admin can be edited
describe "the admin edit page" do
    
    #displays an error if there are no admin 
  it "shows an error when trying to load an invalid admin" do
    visit "/editAdmin?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
    #login as an admin and edit the admin information in person 
    it "allows editing of a valid admin" do
    
    login_admin
    visit "/AdminDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "admin1"
    clear_database
  end
#checks that admin edit is submitted and displayed
  it "allows an admin record to be changed" do
    login_admin
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "New"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "admin1"
    click_button "Submit"
    clear_database
  end
    
#checks that an empty data field can be submitted for admin
  it "will save empty data field" do
    login_admin
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: ""
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "admin1"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "admin1"
    click_button "Submit"
    clear_database
  end
    
    #description for admin can be changed
  it "description can be changed for Admin" do
    login_admin
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "description", with: "hello"
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "hello"   
    visit "/AdminDashboard"
    click_link "Edit Profile" 
    fill_in "description", with: ""
    click_button "Submit"
    clear_database
  end   
    
end
    
 #checks that a admin+mentor can be edited
describe "the admin edit page" do
  #displays an error if there are no admin mentor  
  it "shows an error when trying to load an invalid admin mentor" do
    visit "/editAdmin?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
  #login as an admin mentor and edit the admin mentor information in person     
    it "allows editing of a valid admin mentor" do
    
    add_test_mentor
    login_mentor
    login_admin 
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "Sam"
    clear_database
  end
#checks that admin mentor edit is submitted and displayed
  it "allows an admin mentor record to be changed" do
    add_test_mentor
    login_mentor
    login_admin 
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "New"
    clear_database
  end
    
#checks that an empty data field can be submitted for admin mentor
  it "will save empty data field" do
    add_test_mentor
    login_mentor
    login_admin 
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: ""
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "Mentor"
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "Sam"
    click_button "Submit"
    clear_database
  end
    
#checks that description for adminMentor can be changed
  it "description can be changed for adminMentor" do
    clear_database
    add_test_mentor
    login_mentor
    login_admin 
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    fill_in "description", with: "hello"
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "hello"
    click_link "Edit Profile"
    fill_in "description", with: ""
    click_button "Submit"
    clear_database
  end
#admin could edit all mentors' information    
    it "allows editing of a valid mentor from mentor list" do
    clear_database
    add_test_mentor
    login_mentor
    login_admin 
    click_link "Mentor List"
    click_link "Edit Profile"
    fill_in "Description:", with: "hello"
    click_button "Submit"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "hello"
    clear_database
  end
#admin could edit all mentees' information    
    it "allows editing of a valid mentee from mentee list" do
    clear_database
    add_test_user
    login_mentor
    login_admin 
    click_link "Mentee List"
    click_link "Edit Profile"
    fill_in "Description:", with: "hello"
    click_button "Submit"
    login_mentee
    expect(page).to have_content "hello"
    clear_database
  end
#admin mentor could edit all mentors' information    
    it "allows editing of a valid mentor from mentor list by admin/mentor" do
    clear_database
    add_test_mentor
    login_mentor
    login_admin_mentor
    click_link "Mentor List"
    click_link "Edit Profile"
    fill_in "Description:", with: "hello"
    click_button "Submit"
    login_mentor
    expect(page).to have_content "hello"
    clear_database
  end
#admin mentor could edit all mentees' information
    it "allows editing of a valid mentee from mentee list by admin/mentor" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentor
    login_admin_mentor
    click_link "Mentee List"
    click_link "Edit Profile"
    fill_in "Description:", with: "hello"
    click_button "Submit"
    login_mentee
    expect(page).to have_content "hello"
    clear_database
  end

#mentee could edit mentee information then back to the mentee dashboard    
it "tests editMentee from mentee acount" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentee
    visit "/editMentee"
    expect(page).to have_content "Mentee Dashboard"
    clear_database
  end
#mentor could not edit mentee information so that return to mentor dashboard 
it "tests editMentee from mentor acount" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentor
    visit "/editMentee"
    expect(page).to have_content "Mentor Dashboard"
    clear_database
  end
#admin could edit mentee information then back to the admin dashboard
it "tests editMentee from admin acount" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin
    visit "/editMentee"
    expect(page).to have_content "Admin Dashboard"
    clear_database
  end
#admin mentor could edit mentee information then back to the admin mentor dashboard
it "tests editMentee from adminMentor acount" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin_mentor
    visit "/editMentee"
    expect(page).to have_content "Admin + Mentor Dashboard"
    clear_database
  end

#editMentor
#mentee could not edit mentor information so that return to the mentee dashboard
it "tests editMentor from mentee account" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentee
    visit "/editMentor"
    expect(page).to have_content "Mentee Dashboard"
    clear_database
  end
#mentor could edit mentor information then back to the mentor dashboard
it "tests editMentor from mentor account" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentor
    visit "/editMentor"
    expect(page).to have_content "Mentor Dashboard"
    clear_database
  end
#admin could edit mentor information then back to the admin dashboard
it "tests editMentor from admin account" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin
    visit "/editMentor"
    expect(page).to have_content "Admin Dashboard"
    clear_database
  end
#admin mentor could edit mentor information then back to the admin mentor dashboard
it "tests editMentor from adminMentor account" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin_mentor
    visit "/editMentor"
    expect(page).to have_content "Admin + Mentor Dashboard"
    clear_database
  end
#editAdmin
#mentee could not edit admin information so that return to the mentee dashboard
it "tests editAdmin from mentee account" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentee
    visit "/editAdmin"
    expect(page).to have_content "Mentee Dashboard"
    clear_database
  end
#mentor could not edit admin information so that return to the mentor dashboard
it "tests editAdmin from mentor account" do
    clear_database
    add_test_user
    add_test_mentor
    login_mentor
    visit "/editAdmin"
    expect(page).to have_content "Mentor Dashboard"
    clear_database
  end
#admin could edit admin information then back to the admin dashboard
it "tests editAdmin from admin account" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin
    visit "/editAdmin"
    expect(page).to have_content "Admin Dashboard"
    clear_database
  end
#admin mentor could edit admin information then back to the admin mentor dashboard
it "tests editAdmin from adminMentor account" do
    clear_database
    add_test_user
    add_test_mentor
    login_admin_mentor
    visit "/editAdmin"
    expect(page).to have_content "Admin + Mentor Dashboard"
    clear_database
  end
end   

    
    clear_database
end