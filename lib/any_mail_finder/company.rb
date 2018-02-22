module AnyMailFinder
  class Company < Base
    API_PATH = "/search/company.json".freeze
    ACCEPTABLE_KEYS = [
      :domain,
      :company_name,
    ].freeze

    attr_accessor :options
    attr_accessor *ACCEPTABLE_KEYS
    def initialize(options = {})
      self.options = options.with_indifferent_access
      ACCEPTABLE_KEYS.each do |key|
        self.public_send("#{key}=", options[key])
      end
    end

    def find_emails
      post path, query_params
    end

    private

    def query_params
      ACCEPTABLE_KEYS.inject({}) { |hash, key| hash.merge!(key => options[key]) }
    end

    def path
      API_HOST + API_PATH
    end
  end
end
