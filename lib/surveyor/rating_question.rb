module Surveyor
  class RatingQuestion < Question
    def valid_answer?(answer)
      answer.between?(1, 5)
    end
  end
end
