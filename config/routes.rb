Rails.application.routes.draw do
  root 'flights#index'
  resources :flights, only: [:index]
  resources :bookings, only: [:create, :show]
  get '/book', to: 'bookings#new', as: 'new_booking'
  post '/order/:booking_id', to: 'bookings#order' ,as: 'order'
end
