Rails.application.routes.draw do
  
  root "home#index"
  get "courses/show"
  get "courses/index"
  get "courses/create"
  get "courses/destroy"
  get "courses/update"
  get "home/index"

  devise_for :users

  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end
end
