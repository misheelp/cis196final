Rails.application.routes.draw do
  resources :orders
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/items/:id/buy', to: 'orders#add'
  get '/cart', to: 'orders#cart'
  delete '/order/:item_id', to: 'orders#delete'
  get '/checkout', to: 'orders#checkout'
  get '/myorders', to: 'orders#myorders'
end
