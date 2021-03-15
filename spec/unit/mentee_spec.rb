require_relative "../spec_helper"

RSpec.describe Mentee do
  describe "#name" do
    it "returns the mentee's full name" do
      mentee = described_class.new(fname: "test", lname: "test")
      expect(mentee.name).to eq("test test")
    end
  end


end