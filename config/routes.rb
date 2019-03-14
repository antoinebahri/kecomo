Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :awards, except: [:show]

  resources :categories, only: [:show] do
  end

  get '/meals', to: 'meals#index', as: 'meals_path'

  resources :restaurants do
    resources :meals
  end
end
