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

    def find_response_by_email(email)
      @responses.find { |response| response.email == email }
    end

    def has_responded?(email)
      !find_response_by_email(email).nil?
    end
  end
end
