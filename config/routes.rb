Rails.application.routes.draw do
  root 'products#index'

  get '/products/capture', to: 'products#capture'

  resources :products, only: %i[index show] do
    resources :prices, only: :index
  end

  namespace :api do
    resource :registration, only: :create, controller: :registration
    resources :products, only: %i[index create]
  end
end
