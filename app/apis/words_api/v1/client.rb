module WordsApi
  module V1
    class Client
      include HTTParty
      base_uri 'https://wordsapiv1.p.rapidapi.com/words'
      SECRET_KEY = ENV['WORDS_API_SECRET']

      def random_words
        self.class.get('/?random=true', headers: {
          'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
          'X-RapidAPI-Key': SECRET_KEY
        })
      end
    end
  end
end
