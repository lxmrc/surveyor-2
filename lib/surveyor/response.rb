module Surveyor
  class Response
    attr_reader :email

    def initialize(email: nil)
      @email = email
    end
  end
end
