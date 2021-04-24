require_relative "../spec_helper"


    
#checks that a mentee can be edited
#
#
#tests that error message shows up when a nil mentee is attempted to be edited
describe "the mentee edit page" do
  it "shows an error when trying to load an invalid mentee" do
    visit "/editMentee?id=1000000"
    expect(page).to have_no_xpath('a')
  end
       
  it "allows editing of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
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
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
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
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
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
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
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
    
  it "shows an error when trying to load an invalid mentee" do
    visit "/editMentor?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
    
    it "allows editing of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
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
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
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
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
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
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
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
    
  it "shows an error when trying to load an invalid mentee" do
    visit "/editAdmin?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
    
    it "allows editing of a valid mentor" do
    
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "admin2"
    clear_database
  end
#checks that mentor edit is submitted and displayed
  it "allows a mentor record to be changed" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "New"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "admin2"
    click_button "Submit"
    clear_database
  end
    
#checks that an empty data field can be submitted for mentor
  it "will save empty data field" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: ""
    click_button "Submit"
    visit "/AdminDashboard"
    expect(page).to have_content "admin2"
    visit "/AdminDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "admin2"
    click_button "Submit"
    clear_database
  end
    
    #description for admin can be changed
  it "description can be changed for Admin" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
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
    
  it "shows an error when trying to load an invalid mentee" do
    visit "/editAdmin?id=1000000"
    expect(page).to have_no_xpath('a')
  end    
    
    it "allows editing of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"    
    click_button "Submit" 
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"    
    click_button "Submit"  
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "Sam"
    clear_database
  end
#checks that mentor edit is submitted and displayed
  it "allows a mentor record to be changed" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"    
    click_button "Submit" 
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"    
    click_button "Submit"
    visit "/AdminMentorDashboard"
    click_link "Edit Profile"
    fill_in "fname", with: "New"
    click_button "Submit"
    visit "/AdminMentorDashboard"
    expect(page).to have_content "New"
    clear_database
  end
    
#checks that an empty data field can be submitted for mentor
  it "will save empty data field" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"    
    click_button "Submit" 
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"    
    click_button "Submit"
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
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"    
    click_button "Submit" 
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"    
    click_button "Submit"
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
        clear_database
end   

    
    clear_database
end