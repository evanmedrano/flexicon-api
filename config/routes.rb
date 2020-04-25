Rails.application.routes.draw do
  devise_for :users,
  controllers: { :omniauth_callbacks => 'omniauth_callbacks' }

  namespace :api do
    namespace :v1 do
      resource :instrumentals, only: [:show]
      resource :words, only: [:show]
    end
  end

end
