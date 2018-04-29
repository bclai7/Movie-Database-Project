Rails.application.routes.draw do
  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get  'register',  to: 'users#new' # GET method, displays form for user registration
  post 'register',  to: 'users#create' # POST route, creates user and adds to DB

  resources :users

end
