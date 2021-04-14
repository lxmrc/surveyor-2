require 'spec_helper'

RSpec.describe Surveyor::Answer do
  let(:question) { double(:question, title: "Do you like your job?") }
  subject { described_class.new(question: question, value: "It's okay.") }

  it "has a question" do
    expect(subject.question).to eq(question)
  end

  it "can't be created without a question" do
    expect { Surveyor::Answer.new }.to raise_error(ArgumentError)
  end

  it "can have an answer" do
    expect(subject.value).to eq("It's okay.")
  end
end
