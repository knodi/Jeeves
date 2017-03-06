Rails.application.routes.draw do
  devise_for :users
  resources :device, only: [:index] do
    resources :events, only: [:index, :new] do
      get 'respeak', to: 'events#respeak'
    end
  end
  root 'devices#index'
end
