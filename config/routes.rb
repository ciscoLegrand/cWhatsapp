Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/dashboard'

  match 'send_message', to: 'pages#send_welcome', via: [:get, :post], as: :send_welcome
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
