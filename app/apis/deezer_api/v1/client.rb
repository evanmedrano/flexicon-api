module DeezerApi
  module V1
    class Client
      include HTTParty
      require 'cgi'

      base_uri 'https://api.deezer.com'

      def initialize(query)
        @query = query
      end

      def search
        self.class.get(
          '/search',
          query: {
            q: "#{CGI.escape(query)} instrumental"
          })
      end

      private

      attr_reader :query
    end
  end
end
