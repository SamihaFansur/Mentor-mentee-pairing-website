require_relative "../spec_helper"

describe "the delete page" do
  it "allows deletion of a valid mentee" do
    add_test_mentee
    visit "/editMentee?username=123"
    click_button "Submit"
    expect(page).to have_content "one-to-one mentoring program"
  end
end