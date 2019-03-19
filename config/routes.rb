Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  get '/profile', to: 'pages#profile', as: 'profile'

  resources :awards, except: [:show]

  resources :categories, only: [:show] do
    collection do
      get 'map'
    end
    get '/map', to: 'meals#map'
    resources :meals, only: [:show, :index] do
      resources :awards, only: [:new, :create]
    end
  end

  get '/meals', to: 'meals#index', as: 'all_meals'
  resources :meals, only: [:index] do
    resources :awards, only: [:new,:create]
  end

  resources :restaurants do
    get '/map', to: 'restaurants#map'
    resources :meals do
      resources :awards, only: [:new, :create, :edit, :patch]
    end
  end

end
