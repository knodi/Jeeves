Rails.application.routes.draw do
  resources :devices, :events
  root 'devices#index'
end
