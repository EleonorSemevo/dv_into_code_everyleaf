Rails.application.routes.draw do

  resources :users

  get "/", to: "tasks#index", as: 'tasks'
  post "/", to: "tasks#create"

  get 'sessions/new'
  resources :sessions, only: [:new, :create, :show, :destroy]
  resources :tasks, except: [:index]

  #admin routes
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
