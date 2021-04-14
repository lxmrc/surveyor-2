require 'spec_helper'

RSpec.describe Surveyor::Answer do
  let(:question) { Surveyor::Question.new(title: "Do you like your job?") }
  subject { described_class.new(question: question, value: "It's okay.") }

  it "has a question" do
    expect(subject.question).to eq(question)
    expect(subject.question).to be_a(Surveyor::Question)
  end

  it "can't be created without a question" do
    expect { Surveyor::Answer.new }.to raise_error(ArgumentError)
  end

  it "question must be an instance of Surveyor::Question" do
    expect { Surveyor::Answer.new(question: "Can a question just be a string?") }.to raise_error(ArgumentError)
  end

  it "can have an answer" do
    expect(subject.value).to eq("It's okay.")
  end
end
