Rails.application.routes.draw do
  resources :races
  resources :racers do
    post "entries" => "racers#create_entry"
  end
end
