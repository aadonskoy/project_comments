Rails.application.routes.draw do
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "projects#index"

  resources :projects, except: [ :new, :destroy ] do
    patch :update_status, on: :member

    resources :comments, only: :create
  end
end
