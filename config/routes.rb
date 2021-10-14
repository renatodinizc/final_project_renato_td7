Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :freelancers
  devise_for :contractors

  resources :contractors, only: [:show]
  resources :freelancers, only: [:show, :edit, :update]

  resources :projects, only: [:show, :new, :create, :edit, :update, :destroy] do
    get 'search', on: :collection
  end
end
