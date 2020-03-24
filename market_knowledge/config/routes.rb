Rails.application.routes.draw do

  root "static_pages#home"
  get "/signin", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"

  get "/properties/filter", to: "properties#filter"
  get "properties/search", to: "properties#search"

  get "/leases/filter", to: "leases#filter"
  get "/leases/search", to: "leases#search"

  resources :users
  resources :properties do
    collection {post :import}
  end
  resources :leases do
    collection {post :import}
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
