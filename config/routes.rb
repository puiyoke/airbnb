# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  root "welcome#index"

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"

  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"

  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "users/edit" => "users#edit"

  post  "users/edit"   => "users#update"

  get "users/show" => "users#show"

  get "users/reservations" => "users#reservations"

  get "listings/new" => "listings#new"

  post "listings/new" => "listings#create"

  get "listings/list" => "listings#search"

  get "listings/:id" => "listings#show"

  get "listings/:id/reservation" => "listings#reservation"

  post "listings/:id/reservation" => "listings#reserve"

  get "listings/:id/verify" => "listings#verify"

  get "listings/:id/edit" => "listings#edit"

  post "listings/:id/edit"  => "listings#update"

  get 'braintree/:id' => 'braintree#new'
  
  post 'braintree/checkout'

end


