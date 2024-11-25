Rails.application.routes.draw do
  # Root Path
  root "courses#index"

  # Devise for User Authentication
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # Custom Routes for Courses (if needed)
  # resources :courses, only: [:index, :show, :new, :create, :update, :destroy] 
  # get "courses/:id/edit", to: "courses#edit", as: "edit_course"
  resources :courses do
    resources :presentations do
      resources :evaluations, only: [:new, :create, :index]
    end
  end

  #get "/courses/:id", to: "courses#show"
  # get "courses/:id/edit", to: "courses#edit", as: "edit_course"

  # User Management (excluding `new` and `create` since Devise handles sign-up)
  resources :users, except: [:new, :create]

  resources :users, only: [:index]

  # Catch-all route for Home
  get "courses/index"

  resources :courses do
    member do
      post :enroll
    end
  end
end