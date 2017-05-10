Rails.application.routes.draw do

  resources :users, except: %i(destroy, index)

  get '/profile' => 'users#show'

  resources :sessions, only: [:new, :create, :destroy, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#show'

  resources :tours do
    resources :schedules do
      resources :bookings
    end
  end


end
