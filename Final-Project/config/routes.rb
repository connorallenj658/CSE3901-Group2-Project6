Rails.application.routes.draw do
  # Root Path
  root "courses#index"

  # Devise for User Authentication
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  
  # Custom Routes for Courses (if needed)
  # resources :courses, only: [:index, :show, :new, :create, :update, :destroy] 
  # get "courses/:id/edit", to: "courses#edit", as: "edit_course"
  resources :courses, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :presentations, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :evaluations, only: [:new, :create, :index, :destroy]
    end
    resources :enrollments, only: [:create, :destroy]
  end

  #get "/courses/:id", to: "courses#show"
  # get "courses/:id/edit", to: "courses#edit", as: "edit_course"

  delete 'course_enrollment_path', to: 'enrollment#destroy', as: 'enrollment'

  get 'courses/:id/roster', to: 'courses#roster', as: 'course_roster'
  delete 'remove_user/:user_id', to: 'courses#remove_user', as: 'remove_user'

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