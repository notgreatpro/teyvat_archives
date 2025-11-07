# config/routes.rb
Rails.application.routes.draw do
  # Root path
  root "characters#index"
  
  # RESTful resources
  resources :characters, only: [:index, :show]
  resources :regions, only: [:index, :show]
  resources :visions, only: [:index, :show]
  resources :weapon_types, only: [:index, :show]
  resources :affiliations, only: [:index, :show]
  
  # Static pages
  get "/about", to: "pages#about"
  
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
