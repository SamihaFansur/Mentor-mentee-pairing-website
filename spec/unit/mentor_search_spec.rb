require_relative "../spec_helper"

#tests the mentor search with an empty database
RSpec.describe "Mentors App" do
  describe "GET /search" do
    context "when the database is empty" do
      it "says the database is empty" do
        get "/search"
        expect(last_response.body).to include("Your search revealed no mentors")
      end
    end


  end
end