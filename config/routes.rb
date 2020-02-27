Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cars do
      resources :bookings, only: [:create, :new, :index, :show, :destroy]
  end
  resources :bookings, only: [:index, :destroy] do 
    resources :reviews, only: [:create]
  end
end
