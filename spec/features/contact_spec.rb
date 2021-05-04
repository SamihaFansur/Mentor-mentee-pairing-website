require_relative "../spec_helper"


    

#tests that error message shows up when a nil mentee is attempted to be edited
describe "the contact page" do
  
  #error message displayed when contact form not filled in  
  it "shows an error when form not filled in" do
    visit "/"
    click_link "Contact Us"
    expect(page).to have_content "Contact"
  end
  
  #correctly filled out form displays no error message  
  it "sends an email" do
    visit "/"
    click_link "Contact Us"
    fill_in "Enter your name...", with: "Euan"
    fill_in "E-mail:", with: "arb20eg@sheffield.ac.uk"
    fill_in "Comments:", with: "hello"
    click_button "Submit"
    expect(page).to have_no_xpath('a')
    clear_database
  end
    clear_database
end