require_relative "../spec_helper"
#tests that error message shows up when a nil mentee is attempted to be edited
describe "the edit page" do
  it "shows an error when trying to load an invalid mentee" do
    visit "/editMentee?id=1000000"
    expect(page).to have_no_xpath('a')
  end
#checks that a mentee can be edited
  it "allows editing of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    visit "/editMentee?id=1"
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
    visit "/editMentee?id=1"
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
    visit "/editMentee?id=1"
    fill_in "fname", with: ""
    click_button "Submit"
    visit"/MenteeDashboard"
    expect(page).to have_content "Test"
    clear_database
  end
    
    
    
    
    #checks that a mentor can be edited
    it "allows editing of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    visit "/editMentor?id=1"
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
    visit "/editMentor?id=1"
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
    visit "/editMentor?id=1"
    fill_in "fname", with: ""
    click_button "Submit"
    visit"/MentorDashboard"
    expect(page).to have_content "Mentor"
    clear_database
  end
    clear_database
end