require_relative "../spec_helper"

describe "the edit page" do
  it "shows an error when trying to load an invalid player" do
    visit "/editMentee?id=1000000"
    expect(page).to have_content "Unknown mentee"
  end

  it "allows editing of a valid player" do
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

  it "allows a player record to be changed" do
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
    
    
    
    
    
    it "allows editing of a valid player" do
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

  it "allows a player record to be changed" do
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
end