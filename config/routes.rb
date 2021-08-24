Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # handle log in and log out
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  
  # Handle sign up by implementing a POST /signup route
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'


  get '/recipes', to: 'recipes#show'
  post '/recipes', to: 'recipes#create'
end
