module AnyMailFinder
  module Configuration
    class Base

      def default_email_api_reponse
        @default_email_api_reponse
      end

      def default_email_api_reponse=(default_email_api_reponse)
        @default_email_api_reponse = default_email_api_reponse
      end

      def api_key
        @api_key
      end

      def api_key=(api_key)
        @api_key = api_key
      end
    end
  end
end
