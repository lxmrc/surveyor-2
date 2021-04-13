module Surveyor
  class Response
    attr_reader :email, :answers

    def initialize(email: nil)
      @email = email
      @answers = []
    end

    def add_answer(answer)
      @answers << answer
    end
  end
end
