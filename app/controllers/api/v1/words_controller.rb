module Api
  module V1
    class WordsController < ApplicationController
      def show
        begin
          word = WordsApi::V1::Client.new.random_word
          render json: word
        rescue
          render json: {"status":"400", "error":"Bad Request"}
        end
      end
    end
  end
end
