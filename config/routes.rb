Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :freelancers
  devise_for :contractors

 

  resources :contractors, only: [:show]
  resources :freelancers, only: [:show, :edit, :update] do
    get 'my_projects', on: :collection
  end

  resources :projects, shallow: true do
    get 'search', on: :collection
    resources :proposals do
      post 'accept', on: :member
      post 'deny', on: :member
      resources :chats
    end
  end
end
