Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :awards, except: [:show]

  resources :categories, only: [:show] do
    get '/meals', to: 'meals#index'
  end

  get '/meals/:id', to: 'meals#show', as: 'meal_path'
  get '/meals', to: 'meals#index', as: 'meals_path'

  resources :restaurants do
    resources :meals
  end
end
