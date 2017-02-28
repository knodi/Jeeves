Rails.application.routes.draw do
  resources :events, only: [:index, :new]
  get 'events/respeak', to: 'events#respeak'
  root 'devices#index'
end
