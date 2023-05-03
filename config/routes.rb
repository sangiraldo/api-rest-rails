Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/auth/login', to: 'authentication#login'
  get '/api/v1/restaurants/bookings/all', to: 'api/v1/bookings#all'
  get '/api/v1/restaurants/city/:city', to: 'api/v1/restaurants#city'
  get '/api/v1/restaurants/search/:search', to: 'api/v1/restaurants#search_restaurant'

  namespace :api do 
    namespace :v1 do 
      resources :restaurants do 
        resources :bookings  
      end
      resources :users 
    end
  end
end
