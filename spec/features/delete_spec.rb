require_relative "../spec_helper"
#tests for deleting mentee
describe "the delete page" do
  it "allows deletion of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    visit"/MenteeDashboard"
    click_link "Edit Profile"
    click_button "Delete" 
    expect(page).to have_content "one-to-one mentoring program"
    clear_database
  end
    #tests for deleting mentor
   it "allows deletion of a valid mentor" do
    add_test_mentor
    visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
    visit"/MentorDashboard"
    click_link "Edit Profile"
    click_button "Delete"
    expect(page).to have_content "one-to-one mentoring program"
    clear_database
  end
    clear_database
end