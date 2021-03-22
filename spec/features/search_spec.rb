require_relative "../spec_helper"

describe "the search page" do
  context "with an empty database" do
    it "says the database is empty" do
      visit "/search"
      expect(page).to have_content "Your search revealed no mentors"
    end
  end

  context "with one record in the database" do
    it "lists the player" do
      add_test_mentor
      add_test_user
      visit "/login"
      fill_in "username", with: "123"
      fill_in "password", with: "123"
      click_button "Submit"
      visit "/search"
      expect(page).to have_content "George Test"
      clear_database
    end

    it "does not list the mentor when a different club is searched for" do
      add_test_mentor
      add_test_user
      fill_in "username", with: "123"
      fill_in "password", with: "123"
      click_button "Submit"
      visit "/search"
      fill_in "searchForMentor", with: "Architecture (BA)"
      click_button "Submit"
      expect(page).to have_content "Your search revealed no mentors"
      clear_database
    end

    it "lists the mentor when their jobTitle is searched for" do
      add_test_mentor
      add_test_user
      fill_in "username", with: "123"
      fill_in "password", with: "123"
      click_button "Submit"
      visit "/search"
      fill_in "searchForMentor", with: "Accounting and Financial Management (BA)"
      click_button "Submit"
      expect(page).to have_content "George Test"
      clear_database
    end
  end
end