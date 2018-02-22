module AnyMailFinder
  class Health < Base
    API_PATH = '/emails.json'
    attr_accessor :email

    def initialize(email = nil)
      @email = email
    end

    def execute
      if AnyMailFinder.configuration.default_email_api_reponse.present?
        return RecursiveOpenStruct.new(AnyMailFinder.configuration.default_email_api_reponse)
      end
      options = {address: email}
      data = get path, options
    end

    private

    def path
      API_HOST + API_PATH
    end

  end
end
