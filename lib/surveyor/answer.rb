module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question:, value: nil)
      @question = question
      @value = value
    end
  end
end
