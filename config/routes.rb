Rails.application.routes.draw do

  # get 'sessions/new'
  #
  # get 'sessions/create'
  #
  # get 'sessions/destroy'


  resources :users #,except; %i(destroy)
  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :tours do
    resources :bookings, except: %i(index )
  # end


end
