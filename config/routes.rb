Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  get '/profile/:id', to: 'pages#profile', as: 'profile'

  resources :awards, except: [:show, :edit, :patch]

  resources :categories, only: [:show] do
    resources :meals, only: [:show, :index] do
      resources :awards, only: [:new, :create]
    end
  end

  get '/meals', to: 'meals#index', as: 'all_meals'
  resources :meals, only: [:index] do
    resources :awards, only: [:new,:create]
  end

  resources :restaurants do
    resources :meals do
      resources :awards, only: [:new, :create]
    end
  end
end
