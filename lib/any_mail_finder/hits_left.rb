module AnyMailFinder
  class HitsLeft < Base
    API_PATH = '/account/hits_left.json'.freeze

    def execute
      data = get path, {}
    end

    private

    def path
      API_HOST + API_PATH
    end
  end
end
