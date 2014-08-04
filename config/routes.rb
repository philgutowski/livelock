Rails.application.routes.draw do
  resources :bookings, only: [:new, :create]
  root to: "bookings#new"
end
