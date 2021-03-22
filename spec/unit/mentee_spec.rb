require_relative "../spec_helper"

RSpec.describe Mentee do
 #checks that name returns correctly from database
  describe "#name" do
    it "returns the mentee's full name" do
      mentee = described_class.new(fname: "test", lname: "test")
      expect(mentee.name).to eq("test test")
    end
  end
 #checks that email returns correctly from database  
  describe "#email" do
    it "returns the mentee's email" do
      mentee = described_class.new(email: "test@gmail.com")
      expect(mentee.email).to eq("test@gmail.com")
    end
  end
#checks that phoneNum returns correctly from database
      describe "#phoneNum" do
    it "returns the mentee's full phoneNum" do
      mentee = described_class.new(phoneNum: "123456789")
      expect(mentee.phoneNum).to eq("123456789")
    end
  end
#checks that username returns correctly from database
      describe "#username" do
    it "returns the mentee's username" do
      mentee = described_class.new(username: "1234")
      expect(mentee.username).to eq("1234")
    end
  end
#checks that password returns correctly from database
      describe "#password" do
    it "returns the mentee's password" do
      mentee = described_class.new(password: "1234")
      expect(mentee.password).to eq("1234")
    end
  end

end