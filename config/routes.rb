Rails.application.routes.draw do
   get "/", to: "tasks#index", as: 'tasks'
   post "/", to: "tasks#create"



  resources :tasks, except: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
