Rails.application.routes.draw do
  root 'products#index'

  get '/products/capture', to: 'products#capture'

  resources :products, only: :index
end
