class Api::V1::InstrumentalsController < ApplicationController
  def show
    begin
      query = params[:q]
      instrumental = DeezerApi::V1::Client.new(query).search

      if instrumental["data"].any?
        render json: instrumental
      else
        render json: {"status":"404", "error":"Instrumental Not Found"}
      end
    rescue
      render json: {"status":"400", "error":"Bad Request"}
    end
  end

  def create
    instrumental = DeezerApi::V1::Client.new(instrumental_params)

    if instrumental.save
      render json: {"status":"201", "message": "created"}
    else
      render json: {"status":"422", "message": "unprocessable entity"}
    end
  end

  private

  def instrumental_params
    params.require(:instrumental).permit(:title, :track)
  end
end
