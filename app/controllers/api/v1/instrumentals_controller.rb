module Api::V1
  class InstrumentalsController < ApplicationController
    before_action :set_instrumental, only: [:show]

    def index
      instrumentals = Instrumental.all.order("id ASC")

      render json: instrumentals
    end

    def show
      begin
        instrumental = @instrumental || DeezerApi::V1::Client.new(params[:id]).search

        if instrumental_persisted? || search_yield_any_results?(instrumental)
          render json: instrumental
        else
          render json: {"status":"404", "error":"No luck finding the beat"}
        end
      rescue
        render json: {"status":"400", "error":"Bad Request"}
      end
    end

    def create
      instrumental = DeezerApi::V1::Client.new(instrumental_params)

      if instrumental.save
        render json: instrumental, status: :created
      else
        render json: {"status":"422", "message": "unprocessable entity"}
      end
    end

    private

    def set_instrumental
      @instrumental = Instrumental.find_by(id: params[:id])
    end

    def instrumental_persisted?
      !@instrumental.nil? && @instrumental.is_a?(Instrumental)
    end

    def search_yield_any_results?(instrumental)
      instrumental["data"].any?
    end

    def instrumental_params
      params.require(:instrumental).permit(:title, :track)
    end
  end
end
