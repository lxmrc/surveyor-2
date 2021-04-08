module Surveyor
  class Question
    attr_reader :title

    def initialize(title: nil)
      @title = title
    end
  end
end
