require 'json'
require "breaker"
module AnyMailFinder
  class Base
    include HTTParty
    API_HOST = 'https://api.anymailfinder.com/v4.0'

    def get(url, options = {})
      request('get', url, options)
    end

    def post(url, options = {})
      request('post', url, options)
    end

    private

    def request(request_type, url, options)
      begin
      response = HTTParty.public_send(
        request_type,
        url,
        headers: AnyMailFinder.configuration.headers,
        data_key(request_type).to_sym => options,
      )
      data = JSON.parse response.body, { symbolize_names: true }
      return RecursiveOpenStruct.new(data)
      rescue Errno::ECONNREFUSED => e
        raise AnyMailFinder::Error, e.message
      rescue HTTParty::Error => e
        raise AnyMailFinder::Error, e.message
      rescue => e
        raise AnyMailFinder::Error, e.message
      end
    end

    def data_key(request_type)
      request_type == "post" ? 'body' : 'query'
    end

  end
end
