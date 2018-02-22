module AnyMailFinder
  class Health < Base
    API_PATH = '/health.json'

    def execute
      get path, {}
    end

    private

    def path
      API_HOST + API_PATH
    end

  end
end
