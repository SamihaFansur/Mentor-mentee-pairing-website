require_relative "../spec_helper"


RSpec.describe "Mentors App" do
  describe "GET /search" do
    context "when the database is empty" do
      it "says the database is empty" do
        get "/search"
        expect(last_response.body).to include("No Mentors!")
      end
    end


  end
end