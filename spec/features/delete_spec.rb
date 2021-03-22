require_relative "../spec_helper"

describe "the delete page" do
  it "allows deletion of a valid mentee" do
    add_test_user
    visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit"
    visit "/editMentee?id=1"
    click_button "Delete"
    visit "/editMentee?id=1"
    expect(page).to have_content "Unknown mentee"
    clear_database
  end
end