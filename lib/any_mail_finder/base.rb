require 'json'
require "breaker"
module AnyMailFinder
  class Base
    include HTTParty
    API_HOST = 'https://api.anymailfinder.com/v4.0'

    def get(url, options = {})
      options[:apikey] = AnyMailFinder.configuration.api_key
      begin
        response = self.class.get(url, options)
        data = JSON.parse response.body, {symbolize_names: true}
        case response.code
          when 200
            return RecursiveOpenStruct.new(data)
          else
            raise AnyMailFinder::Error, data[:errors][:user]
        end
      rescue Errno::ECONNREFUSED => e
        raise AnyMailFinder::Error, e.message
      rescue HTTParty::Error => e
        raise AnyMailFinder::Error, e.message
      rescue => e
        raise AnyMailFinder::Error, e.message
      end
    end

  end
end
