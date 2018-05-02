Rails.application.routes.draw do
  namespace :destination do
    resources :cards
  end
  get '/:departure_id✈️:destination_id', controller: :destinations, action: :show, as: :destination
  root 'landing#index'
end
