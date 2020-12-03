Rails.application.routes.draw do
  #get 'properties/index'
  #get 'properties/show'
  #get 'properties/edit'
  #get 'properties/create'
  #get 'properties/update'
  #get 'properties/new'
  get 'home/index'
  resources :properties do
    resources :pictures, :reservations
  end
  resources :reservations
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
