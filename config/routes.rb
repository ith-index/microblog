Rails.application.routes.draw do
  root 'pages#home'
  get '/dashboard', to: 'pages#dashboard'

  get '/log-in', to: 'sessions#new'
  post '/log-in', to: 'sessions#create'
  delete '/log-out', to: 'sessions#destroy'

  get '/sign-up', to: 'users#new'
  resources :users, except: :new

  resources :follows, only: [:create, :destroy]

  resources :posts, only: [:create, :destroy]

  get '*path', to: 'pages#fourZeroFour'
end
