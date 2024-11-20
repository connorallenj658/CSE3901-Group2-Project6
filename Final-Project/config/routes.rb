Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  devise_for :users

  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end
end
