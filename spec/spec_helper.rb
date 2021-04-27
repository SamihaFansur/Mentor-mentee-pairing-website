# Configure coverage logging
require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end
SimpleCov.coverage_dir "coverage"

# Ensure we use the test database
ENV["APP_ENV"] = "testing"

# load the app
require_relative "../app"

# Configure Capybara
require "capybara/rspec"
Capybara.app = Sinatra::Application

# Configure RSpec
def app
  Sinatra::Application
end
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

# add a test mentee
def add_test_user
  visit "/MenteeSignUpForm"
  fill_in "fname", with: "George"
  fill_in "lname", with: "Test"
  fill_in "email", with: "arb20eg@sheffield.ac.uk"
  fill_in "phoneNum", with: "+44 7721851137"
  fill_in "username", with: "123"
  fill_in "password", with: "123"
    
  select "Accounting and Financial Management (BA)", :from => "courseName"
    
  select "1", :from => "cyear"
    
  select "Faculty of Science", :from => "faculty"
    
  click_button "Submit"
end

# add a test mentor
def add_test_mentor
  visit "/MentorSignUpForm"
  fill_in "fname", with: "Sam"
  fill_in "lname", with: "Mentor"
  fill_in "email", with: "arb21eg@sheffield.ac.uk"
  fill_in "phoneNum", with: "+44 7721851137"
  fill_in "username", with: "1234"
  fill_in "password", with: "1234"
    
  select "Accounting and Financial Management (BA)", :from => "courseName"
    
  select "Actor", :from => "jobTitle"
      
  click_button "Submit"
end

  def name
    "#{fname} #{lname}"
  end


# clear out the database
def clear_database
  DB.from("mentees").delete
  DB.from("mentors").delete
  DB.from("requests").delete
  DB.from("reports").delete
end


#login methods for each test username
def login_mentee
visit "/login"
    fill_in "username", with: "123"
    fill_in "password", with: "123"
    click_button "Submit" 
end

def login_mentor
 visit "/login"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
end

def login_admin
visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "No"
end

def login_admin_mentor
 visit "/login"
    fill_in "username", with: "admin2"
    fill_in "password", with: "S.F"
    click_button "Submit"
    click_link "Yes"
    fill_in "username", with: "1234"
    fill_in "password", with: "1234"
    click_button "Submit"
end



# ensure we're always starting from a clean database
clear_database
