Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'

  #REGISTER
  get  'register',  to: 'users#new' # GET method, displays form for user registration
  post 'register',  to: 'users#create' # POST route, creates user and adds to DB

  # LOGIN
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :movies

end
