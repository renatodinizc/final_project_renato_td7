Rails.application.routes.draw do
  root to: 'home#index'

  resources :projects, only: [:show, :new, :create, :edit, :update, :destroy]
end