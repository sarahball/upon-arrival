Rails.application.routes.draw do
  devise_for :users, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'join-us',
    registration: 'register'
  }

  namespace :destination do
    resources :cards
  end

  get '/:departure_id✈️:destination_id', controller: :destinations, action: :show, as: :destination

  root 'landing#index'
end
