module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(name: nil)
      @name = name
      @questions = []
      @responses = []
    end

    def add_question(question)
      @questions << question
    end

    def add_response(response)
      @responses << response
    end

    def find_user_response(email)
      @responses.find { |response| response.email == email }
    end

    def user_responded?(email)
      !find_user_response(email).nil?
    end

    def low_answers(question)
      answers(question).select { |answer| answer.value < 3 }
    end

    def neutral_answers(question)
      answers(question).select { |answer| answer.value == 3 }
    end

    def high_answers(question)
      answers(question).select { |answer| answer.value > 3 }
    end

    def answer_breakdown(question)
      breakdown = answers(question).group_by(&:value).transform_values!(&:count)
      breakdown.each_with_object("") do |(rating, frequency), output|
        output << "#{rating}: #{frequency}\n"
      end
    end

    private

    def answers(question = nil)
      @responses.each_with_object([]) do |response, answers|
        selected = question ? response.answers.select { |answer| answer.question == question } : response.answers
        answers.concat(selected)
      end
    end
  end
end
