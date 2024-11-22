Rails.application.routes.draw do
  
  root "home#index"
  get '/show', to: 'users#show'
  get '/show/:id', to:'users#show'
  get '/users', to:'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  get 'users/edit'
  get '/edit_user_path', to: 'users#edit'

  devise_for :users

  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end
end