Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :awards, except: [:show]

  resources :categories, only: [:show] do
    get '/meals', to: 'meals#index'
  end

  resources :restaurants do
    resources :meals
  end
end
