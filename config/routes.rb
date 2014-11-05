Rails.application.routes.draw do
  resources :bookings, only: [:new, :create, :show]
  resources :costs, only: [:create]
  resources :errors, only: [:create]
  resources :welcome, only: [:show]
  root to: "welcome#show"
end
