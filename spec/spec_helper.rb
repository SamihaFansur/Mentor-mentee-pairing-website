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

# add a test player
def add_test_user
  visit "/MenteeSignUpForm"
  fill_in "fname", with: "George"
  fill_in "lname", with: "Test"
  fill_in "email", with: "samiha.fansur.2002@gmail.com"
  fill_in "phoneNum", with: "+44 7721851137"
  fill_in "username", with: "123"
    
  select "Accounting and Financial Management (BA)", :from => "courseName"
    
  select "1", :from => "cyear"
      
  click_button "Submit"
end

  def name
    "#{fname} #{lname}"
  end


# clear out the database
def clear_database
  DB.from("mentees").delete
end

# ensure we're always starting from a clean database
clear_database
