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
#checks that coursename returns correctly from database
      describe "#courseName" do
    it "returns the mentee's courseName" do
      mentee = described_class.new(courseName: "Architecture")
      expect(mentee.courseName).to eq("Architecture")
    end
  end
#checks that faculty returns correctly from database
      describe "#faculty" do
    it "returns the mentee's faculty" do
      mentee = described_class.new(faculty: "Engineering")
      expect(mentee.faculty).to eq("Engineering")
    end
  end
#checks that cyear returns correctly from database
      describe "#cyear" do
    it "returns the mentee's cyear" do
      mentee = described_class.new(cyear: 3)
      expect(mentee.cyear).to eq(3)
    end
  end
#checks that description returns correctly from database
      describe "#description" do
    it "returns the mentee's description" do
      mentee = described_class.new(description: "hello")
      expect(mentee.description).to eq("hello")
    end
  end
#checks that applicationNumber returns correctly from database
      describe "#applicationNumber" do
    it "returns the mentee's applicationNumber" do
      mentee = described_class.new(applicationNumber: "1234")
      expect(mentee.applicationNumber).to eq("1234")
    end
  end
#checks that mentorAccept returns correctly from database
      describe "#mentorAccept" do
    it "returns the mentee's mentorAccept" do
      mentee = described_class.new(mentorAccept: 1)
      expect(mentee.mentorAccept).to eq(1)
    end
  end
#checks that mentorMatch returns correctly from database
      describe "#mentorMatch" do
    it "returns the mentee's mentorMatch" do
      mentee = described_class.new(mentorMatch: 1)
      expect(mentee.mentorMatch).to eq(1)
    end
  end
#checks that requestMentorMeeting returns correctly from database
      describe "#requestMentorMeeting" do
    it "returns the mentee's requestMentorMeeting" do
      mentee = described_class.new(requestMentorMeeting: 1)
      expect(mentee.requestMentorMeeting).to eq(1)
    end
  end
#checks that suspendMentee returns correctly from database
      describe "#suspendMentee" do
    it "returns the mentee's suspendMentee" do
      mentee = described_class.new(suspendMentee: 1)
      expect(mentee.suspendMentee).to eq(1)
    end
  end


end
