Rails.application.routes.draw do
  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'join-us',
    registration: 'register'
  },
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resource :profile, only: [:edit, :update]

  get '🐣:username', to: 'public_profiles#show', as: :public_profile

  get '/:departure_id✈️:destination_id', to: 'destinations#show', as: :destination

  root 'landing#index'
end
