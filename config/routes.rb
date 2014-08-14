Rails.application.routes.draw do
  resources :bookings, only: [:new, :create]
  resources :costs, only: [:create]
  root to: "bookings#new"
end
