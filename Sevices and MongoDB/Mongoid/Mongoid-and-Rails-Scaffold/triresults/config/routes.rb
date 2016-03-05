Rails.application.routes.draw do
  resources :racers
  resources :racers do
    post "entries" => "racers#create_entry"
  end
end
