require_relative "../spec_helper"

RSpec.describe Mentor do
    #checks that name returns correctly from database
  describe "#name" do
    it "returns the mentor's full name" do
      mentor = described_class.new(fname: "test", lname: "test")
      expect(mentor.name).to eq("test test")
    end
  end
#checks that email returns correctly from database
 describe "#email" do
    it "returns the mentor's email" do
      mentor = described_class.new(email: "test@gmail.com")
      expect(mentor.email).to eq("test@gmail.com")
    end
  end
#checks that phoneNum returns correctly from database
      describe "#phoneNum" do
    it "returns the mentor's full phoneNum" do
      mentor = described_class.new(phoneNum: "123456789")
      expect(mentor.phoneNum).to eq("123456789")
    end
  end
#checks that username returns correctly from database
      describe "#username" do
    it "returns the mentor's username" do
      mentor = described_class.new(username: "1234")
      expect(mentor.username).to eq("1234")
    end
  end
#checks that password returns correctly from database
      describe "#password" do
    it "returns the mentor's password" do
      mentor = described_class.new(password: "1234")
      expect(mentor.password).to eq("1234")
    end
  end
end