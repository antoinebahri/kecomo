Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :awards, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :restaurants, only: [:index, :new, :show, :edit, :create, :update, :destroy]

  resources :restaurants do
    resources :meals, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
