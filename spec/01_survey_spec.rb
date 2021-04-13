# Add another method that returns true or false depending on if the user has responded to this survey yet.

require 'spec_helper'

RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: "Engagement Survey") }

  it "has a name" do
    expect(subject.name).to eq("Engagement Survey")
  end

  it "can have questions added" do
    question = double(:question)
    subject.add_question(question)
    expect(subject.questions).to include(question)
  end

  it "can have responses added" do
    response = double(:response)
    subject.add_response(response)
    expect(subject.responses).to include(response)
  end

  context "find_response_by_email" do
    it "can find a response by the user's email address" do
      response = double(:response, email: "alice@example.com")
      subject.add_response(response)
      expect(subject.find_response_by_email("alice@example.com")).to eq(response)
    end

    it "returns nil when response is not found" do
      expect(subject.find_response_by_email("alice@example.com")).to eq(nil)
    end
  end

  context "has_responded?" do
    it "returns true when the user has responded" do
      response = double(:response, email: "alice@example.com")
      subject.add_response(response)
      expect(subject.has_responded?("alice@example.com")).to eq(true)
    end

    it "returns false when the user has not responded" do
      expect(subject.has_responded?("alice@example.com")).to eq(false)
    end
  end
end
