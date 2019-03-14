Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/profile/:id', to: 'pages#profile', as: 'profile'

  resources :awards, except: [:show]

  resources :categories, only: [:show] do
    get 'meals/:id', to: 'meals#show', as: 'meal'
    get '/meals', to: 'meals#index', as: 'meals'
  end

  get '/meals', to: 'meals#index', as: 'all_meals'

  resources :restaurants do
    resources :meals
  end
end
