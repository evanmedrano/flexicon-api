module DeezerApi
  module V1
    class Client
      include HTTParty
      require 'cgi'

      base_uri 'https://api.deezer.com'

      def initialize(params)
        @params = params
      end

      def search
       self.class.get(
        '/search',
        query: {
          q: "#{CGI.escape(params)} instrumental"
        })
      end

      def save
        if Instrumental.new(title: title, track: track).valid?
          Instrumental.create(title: title, track: track)
          true
        else
          false
        end
      end

      private

      attr_reader :params

      def title
        params["title"]
      end

      def track
        params["track"]
      end
    end
  end
end
