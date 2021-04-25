require_relative "../spec_helper"


    
#checks that a user can be suspended
#
#
#tests that error message shows up when a nil mentee is attempted to be edited

describe "admin block page" do
    #admin 
  it "shows empty list message when no mentors" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentee List"
    expect(page).to have_content "Your search revealed no mentees."
    clear_database
  end
       
  it "allows block of a valid mentee" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
    
   it "shows empty list message when no mentors" do
    add_test_user
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentee List"
    click_button "Block"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
       
  it "allows block of a valid mentee" do
    add_test_mentor
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
    click_button "Block"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
   it "allows block and unblock of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "George Test"
    clear_database
  end
       
  it "allows block and unblock of a valid mentor" do
    add_test_mentor
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
    click_button "Block"
    click_button "Unblock"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end 
    
    #admin + mentor
    
it "shows empty list message when no mentors" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    click_link "Mentee List"
    expect(page).to have_content "Your search revealed no mentees."
    clear_database
  end
       
  it "allows block of a valid mentee" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
    
   it "shows empty list message when no mentors" do
    add_test_user
    add_test_mentor
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    click_link "Mentee List"
    click_button "Block"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
       
  it "allows block of a valid mentee" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    add_test_mentor
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    click_link "Mentor List"
    click_button "Block"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Your account is suspended"
    clear_database
  end
   it "allows block and unblock of a valid mentee" do
    add_test_user
   add_test_mentor
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    click_link "Mentee List"
    click_button "Block"
    click_button "Unblock"
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    expect(page).to have_content "George Test"
    clear_database
  end
       
  it "allows block and unblock of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    add_test_mentor
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    click_link "Mentor List"
    click_button "Block"
    click_button "Unblock"
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    expect(page).to have_content "Sam Mentor"
    clear_database
  end 
        clear_database
end