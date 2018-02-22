module AnyMailFinder
  class Domain < Base
    API_PATH = '/domains/check.json'.freeze
    attr_accessor :domain

    def initialize(domain = nil)
      @domain = domain
    end

    def validate
      options = { domain: domain }
      post path, options
    end

    private

    def path
      API_HOST + API_PATH
    end
  end
end
