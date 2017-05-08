Rails.application.routes.draw do

  # get 'sessions/new'
  #
  # get 'sessions/create'
  #
  # get 'sessions/destroy'


  resources :users, except: %i(destroy, show)

  get '/profile' => 'users#show'

  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'tours#index'

  resources :tours do
    resources :schedules do
      resources :bookings
    end
  end


end
