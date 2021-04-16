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
      cache_answers
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
      answers(question)
        .group_by(&:value)
        .transform_values!(&:count)
        .collect do |(value, count)|
          "#{value}: #{count}\n"
        end.join
    end

    private

    def cache_answers
      @answers = @responses.map(&:answers).flatten
    end

    def answers(question)
      @answers.select { |answer| answer.question == question }
    end
  end
end
