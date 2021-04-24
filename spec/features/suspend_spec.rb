require_relative "../spec_helper"


    
#checks that a user can be suspended
#
#
#tests that error message shows up when a nil mentee is attempted to be edited

describe "admin suspend page" do
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
       
  it "allows editing of a valid mentee" do
    visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
    click_link "Mentor List"
    expect(page).to have_content "Your search revealed no mentors."
    clear_database
  end
end