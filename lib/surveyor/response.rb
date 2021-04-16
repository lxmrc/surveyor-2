module Surveyor
  class Response
    attr_reader :email, :answers

    def initialize(email: nil)
      @email = email
      @answers = []
    end

    def add_answer(answer)
      raise ArgumentError, "answer should be an instance of Surveyor::Answer" unless answer.is_a? Surveyor::Answer
      @answers << answer
    end
  end
end
