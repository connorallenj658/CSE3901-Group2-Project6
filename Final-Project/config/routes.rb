Rails.application.routes.draw do
  # Root Path
  root "home#index"

  # Devise for User Authentication
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # Custom Routes for Courses (if needed)
  resources :courses, only: [:index, :show, :create, :update, :destroy]

  # User Management (excluding `new` and `create` since Devise handles sign-up)
  resources :users, except: [:new, :create]

  # Nested Resources for Presentations and Evaluations
  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end

  resources :users, only: [:index]


  # Catch-all route for Home
  get "home/index"
end