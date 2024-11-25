Rails.application.routes.draw do
  # Root Path
  root "courses#index"

  # Devise for User Authentication
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # Custom Routes for Courses (if needed)
  resources :courses, only: [:index, :show, :new, :create, :update, :destroy]
  
  get 'courses/:id/roster', to: 'courses#roster', as: 'course_roster'
  delete 'remove_user/:user_id', to: 'courses#remove_user', as: 'remove_user'

  # User Management (excluding `new` and `create` since Devise handles sign-up)
  resources :users, except: [:new, :create]

  # Nested Resources for Presentations and Evaluations
  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end

  resources :users, only: [:index]

  # Catch-all route for Home
  get "courses/index"
end