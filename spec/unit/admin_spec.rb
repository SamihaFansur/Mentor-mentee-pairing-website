require_relative "../spec_helper"

RSpec.describe Admin do
    #checks that name returns correctly from database
  describe "#name" do
    it "returns the admin's full name" do
      admin = described_class.new(fname: "test", lname: "test")
      expect(admin.name).to eq("test test")
    end
  end
#checks that email returns correctly from database
 describe "#email" do
    it "returns the admin's email" do
      admin = described_class.new(email: "test@gmail.com")
      expect(admin.email).to eq("test@gmail.com")
    end
  end
#checks that phoneNum returns correctly from database
      describe "#phoneNum" do
    it "returns the admin's full phoneNum" do
      admin = described_class.new(phoneNum: "123456789")
      expect(admin.phoneNum).to eq("123456789")
    end
  end
#checks that username returns correctly from database
      describe "#username" do
    it "returns the admin's username" do
      admin = described_class.new(username: "1234")
      expect(admin.username).to eq("1234")
    end
  end
#checks that password returns correctly from database
      describe "#password" do
    it "returns the admin's password" do
      admin = described_class.new(password: "1234")
      expect(admin.password).to eq("1234")
    end
  end
#checks that password returns correctly from database
      describe "#description" do
    it "returns the admin's description" do
      admin = described_class.new(description: "1234")
      expect(admin.description).to eq("1234")
    end
  end
#checks that password returns correctly from database
      describe "#password" do
    it "returns the admin's activationToken" do
      admin = described_class.new(activationToken: 1)
      expect(admin.activationToken).to eq(1)
    end
  end




end