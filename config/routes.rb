Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'login', to: 'pages#login'
  get 'register', to: 'pages#register'
end
