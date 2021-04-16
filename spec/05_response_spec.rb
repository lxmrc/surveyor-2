require "spec_helper"

RSpec.describe Surveyor::Response do
  subject { described_class.new(email: "respondent@example.com") }

  it "has an email" do
    expect(subject.email).to eq("respondent@example.com")
  end

  it "can have answers added" do
    answer = Surveyor::Answer.new(question: Surveyor::Question.new)
    subject.add_answer(answer)
    expect(subject.answers).to include(answer)
  end
end
