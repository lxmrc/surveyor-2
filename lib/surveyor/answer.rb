module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question, answer)
      @question = question
      @value = answer
    end
  end
end
