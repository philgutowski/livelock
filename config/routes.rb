Rails.application.routes.draw do
  resources :bookings, only: [:new, :create]
  resources :charges
  root to: "bookings#new"
end
