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
  end
end
