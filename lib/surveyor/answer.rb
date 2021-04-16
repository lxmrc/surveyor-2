module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question:, value: nil)
      raise ArgumentError, "question should be an instance of Surveyor::Question" unless question.is_a? Surveyor::Question
      @question = question
      @value = value
    end
  end
end
