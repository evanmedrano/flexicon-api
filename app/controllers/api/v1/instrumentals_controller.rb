class Api::V1::InstrumentalsController < ApplicationController
  def show
    query = params[:q]
    instrumental = DeezerApi::V1::Client.new(query).search
    render json: instrumental
  end
end
