Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post "/game", to: "games#create"
  post "/move", to: "games#update"

end
