Rails.application.routes.draw do
  # devise_for :users,
  # controllers: { :omniauth_callbacks => 'omniauth_callbacks' }

  namespace :api do
    namespace :v1 do
      devise_for :users,
      controllers: { :omniauth_callbacks => 'api/v1/omniauth_callbacks' }

      resources :instrumentals, only: [:index, :show, :create]
      resource :words, only: [:show]
    end
  end

end
