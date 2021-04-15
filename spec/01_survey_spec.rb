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

  context "find_user_response" do
    it "can find a response by the user's email address" do
      response = double(:response, email: "alice@example.com")
      subject.add_response(response)
      expect(subject.find_user_response("alice@example.com")).to eq(response)
    end

    it "returns nil when response is not found" do
      expect(subject.find_user_response("alice@example.com")).to eq(nil)
    end
  end

  context "user_responded?" do
    it "returns true when the user has responded" do
      response = double(:response, email: "alice@example.com")
      subject.add_response(response)
      expect(subject.user_responded?("alice@example.com")).to eq(true)
    end

    it "returns false when the user has not responded" do
      expect(subject.user_responded?("alice@example.com")).to eq(false)
    end
  end

  context "finding answers" do
    let(:question1) { Surveyor::RatingQuestion.new }
    let(:question2) { Surveyor::RatingQuestion.new }

    before do
      subject.add_question(question1)
      [1, 2, 3, 3, 3, 4, 4, 5, 5, 5].each do |rating|
        response = Surveyor::Response.new
        answer = Surveyor::Answer.new(question: question1, value: rating)
        response.add_answer(answer)
        subject.add_response(response)
      end

      subject.add_question(question2)
      [1, 1, 2, 2, 3, 3, 4, 4, 4, 5].each do |rating|
        response = Surveyor::Response.new
        answer = Surveyor::Answer.new(question: question2, value: rating)
        response.add_answer(answer)
        subject.add_response(response)
      end
    end

    context "low_answers" do
      it "finds the low answers for a question" do
        expect(subject.low_answers(question1).count).to eq(2)
      end

      it "finds the low answers for a different question" do
        expect(subject.low_answers(question2).count).to eq(4)
      end
    end

    context "neutral_answers" do
      it "finds the neutral answers for a question" do
        expect(subject.neutral_answers(question1).count).to eq(3)
      end

      it "finds the neutral answers for a different question" do
        expect(subject.neutral_answers(question2).count).to eq(2)
      end
    end

    context "high_answers" do
      it "finds the high answers for a question" do
        expect(subject.high_answers(question1).count).to eq(5)
      end

      it "finds the high answers for a different question" do
        expect(subject.high_answers(question2).count).to eq(4)
      end
    end

    context "answer_breakdown" do
      it "provides a breakdown of the answers for a question" do
        breakdown = <<~BREAKDOWN
          1: 1
          2: 1
          3: 3
          4: 2
          5: 3
        BREAKDOWN
        expect(subject.answer_breakdown(question1)).to eq(breakdown)
      end

      it "provides a breakdown of the answers for a different question" do
        breakdown = <<~BREAKDOWN
          1: 2
          2: 2
          3: 2
          4: 3
          5: 1
        BREAKDOWN
        expect(subject.answer_breakdown(question2)).to eq(breakdown)
      end
    end
  end
end
