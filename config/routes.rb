Rails.application.routes.draw do
  scope module: 'api', path: 'api' do
    scope module: 'v1', path: 'v1' do
      devise_for :users,
      path: '',
      path_names: {
        'sign_in': 'login',
        'sign_out': 'logout',
        'registration': 'signup'
      },
      controllers: {
        omniauth_callbacks: 'api/v1/omniauth_callbacks',
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      resources :instrumentals, only: [:index, :show, :create]
      resources :instrumental_likes, only: [:index, :create, :destroy]
      resource :words, only: [:show]
    end
  end
end
