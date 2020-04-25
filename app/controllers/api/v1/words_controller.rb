class Api::V1::WordsController < ApplicationController
  def show
    word = WordsApi::V1::Client.new.random_words
    render json: word
  end
end
