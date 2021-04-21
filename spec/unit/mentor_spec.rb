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
#checks that coursename returns correctly from database
      describe "#courseName" do
    it "returns the mentee's courseName" do
      mentee = described_class.new(courseName: "Architecture")
      expect(mentee.courseName).to eq("Architecture")
    end
  end
#checks that faculty returns correctly from database
      describe "#jobTitle" do
    it "returns the mentor's jobTitle" do
      mentor = described_class.new(jobTitle: "Engineer")
      expect(mentor.jobTitle).to eq("Engineer")
    end
  end

#checks that description returns correctly from database
      describe "#description" do
    it "returns the mentee's description" do
      mentor = described_class.new(description: "hello")
      expect(mentor.description).to eq("hello")
    end
  end

#checks that menteeAccept returns correctly from database
      describe "#menteeAccept" do
    it "returns the mentor's menteeAccept" do
      mentor = described_class.new(menteeAccept: 1)
      expect(mentor.menteeAccept).to eq(1)
    end
  end
#checks that menteeMatch returns correctly from database
      describe "#menteeMatch" do
    it "returns the mentor's menteeMatch" do
      mentor = described_class.new(menteeMatch: 1)
      expect(mentor.menteeMatch).to eq(1)
    end
  end
#checks that profileStatus returns correctly from database
      describe "#profileStatus" do
    it "returns the mentor's profileStatus" do
      mentor = described_class.new(profileStatus: "1")
      expect(mentor.profileStatus).to eq("1")
    end
  end
#checks that suspendMentor returns correctly from database
      describe "#suspendMentor" do
    it "returns the mentor's suspendMentor" do
      mentor = described_class.new(suspendMentor: 1)
      expect(mentor.suspendMentor).to eq(1)
    end
  end
end

