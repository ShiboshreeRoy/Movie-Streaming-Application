Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  root "home#index"
  
  # Main content routes
  resources :home, only: [:index]
  resources :movies, only: [:index, :show]
  resources :tv_shows, only: [:index, :show]
  resources :genres, only: [:show]
  resources :users, only: [:show, :edit, :update]
  
  # Additional routes for user features
  resources :user_favorites, only: [:create, :destroy]
  resources :user_movie_ratings, only: [:create]
  
  # Search route
  get '/search', to: 'search#search'
  
  # Admin namespace
  namespace :admin do
    resources :movies
    resources :tv_shows
  end
  
  # Admin dashboard
  get '/admin', to: 'admin#index', as: 'admin'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
