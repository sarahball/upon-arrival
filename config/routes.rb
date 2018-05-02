Rails.application.routes.draw do
  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'join-us',
    registration: 'register'
  },
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get '/:departure_id✈️:destination_id', controller: :destinations, action: :show, as: :destination

  root 'landing#index'
end
