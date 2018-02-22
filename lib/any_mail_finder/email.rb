module AnyMailFinder
  class Email < Base
    API_PATH = '/validate.json'
    attr_accessor :email

    def initialize(email = nil)
      @email = email
    end

    def validate
      options = { email: email }
      post path, options
    end

    private

    def path
      API_HOST + API_PATH
    end

  end
end
