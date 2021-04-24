require_relative "../spec_helper"

RSpec.describe Request do
    #checks that name returns correctly from database
  describe "#menteeID" do
    it "returns the requests's full menteeID" do
      requests = described_class.new(menteeID: 1)
      expect(requests.menteeID).to eq(1)
    end
  end
#checks that timeApplicationSent returns correctly from database
 describe "#timeApplicationSent" do
    it "returns the requests's timeApplicationSent" do
      requests = described_class.new(timeApplicationSent: "1000")
      expect(requests.timeApplicationSent).to eq("1000")
    end
  end
#checks that phoneNum returns correctly from database
      describe "#mentorID" do
    it "returns the requests's full phoneNum" do
      requests = described_class.new(mentorID: 1)
      expect(requests.mentorID).to eq(1)
    end
  end
end