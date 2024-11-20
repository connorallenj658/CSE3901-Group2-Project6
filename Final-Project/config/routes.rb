Rails.application.routes.draw do
  root "presentations#index"

  resources :presentations do
    resources :evaluations, only: [:new, :create, :index]
  end
end

