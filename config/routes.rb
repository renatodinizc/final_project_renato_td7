Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :freelancers
  devise_for :contractors

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index show]
    end
  end

  resources :contractors, only: [:show]
  resources :freelancers, only: [:show, :edit, :update] do
    get 'my_projects', on: :collection
  end

  resources :projects, shallow: true do
    get 'search', on: :collection
    get 'close', on: :member
    get 'finish', on: :member
    resources :proposals do
      post 'accept', on: :member
      post 'deny', on: :member
      post 'forfeit', on: :member
      post 'archive', on: :member
      resource :feedback, only: [:new, :create]
      resources :chats do
        get 'create_new_chat_window', on: :collection
      end
    end
  end
end
