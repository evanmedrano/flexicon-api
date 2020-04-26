module WordsApi
  module V1
    class Client
      include HTTParty
      base_uri 'https://wordsapiv1.p.rapidapi.com/words'

      def random_word
        self.class.get('/?random=true', headers: {
          'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
          'X-RapidAPI-Key': ENV['WORDS_API_SECRET']
        })
      end
    end
  end
end
