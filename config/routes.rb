Rails.application.routes.draw do
  devise_for :users
  resources :events, only: [:index, :new]
  get 'events/respeak', to: 'events#respeak'
  root 'devices#index'
end
