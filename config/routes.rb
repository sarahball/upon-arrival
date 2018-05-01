Rails.application.routes.draw do
  get '/:departure_id/:destination_id', controller: :destinations, action: :show
  root 'landing#index'
end
