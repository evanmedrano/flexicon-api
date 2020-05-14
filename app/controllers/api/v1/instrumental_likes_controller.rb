module Api::V1
  class InstrumentalLikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_instrumental_like, only: [:destroy]
    before_action :liked_by_current_user?, only: [:destroy]

    def index
      instrumentals =
        Instrumental.joins(:instrumental_likes).where(
          instrumental_likes: { user: current_user }
        )

      render json: instrumentals
    end

    def create
      instrumental_like = InstrumentalLike.new(instrumental_like_params)

      if instrumental_like.save
        render json: { status: 201, message: 'Created' }, status: :created
      else
        render json: { status: 422, message: 'Unprocessable Entity' },
               status: :unprocessable_entity
      end
    end

    def destroy
      if @instrumental_like.destroy
        render json: { status: 200, message: 'Deleted' }, status: :ok
      end
    end

    private

    def instrumental_like_params
      params.require(:instrumental_like).permit(:instrumental_id, :user_id)
    end

    def set_instrumental_like
      @instrumental_like = InstrumentalLike.find_by(id: params[:id])
    end

    def liked_by_current_user?
      if @instrumental_like.user != current_user
        render json: { status: 401, message: 'Unauthorized' },
          status: :unauthorized
      end
    end
  end
end
