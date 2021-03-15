require_relative "../spec_helper"

RSpec.describe Mentor do
  describe "#name" do
    it "returns the mentee's full name" do
      mentor = described_class.new(fname: "test", lname: "test")
      expect(mentor.name).to eq("test test")
    end
  end


end