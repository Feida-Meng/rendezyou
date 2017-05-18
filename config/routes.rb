Rails.application.routes.draw do

  resources :users, except: %i(destroy, index)

  get '/profile' => 'users#show'

  resources :sessions, only: [:new, :create, :destroy]

  root 'pages#show'

  resources :tours do
    resources :schedules do
      resources :bookings
    end
    resources :reviews
    get '/tourpoints/edit' => 'tourpoints#groupedit'
    resources :tourpoints do

    end

  end

end
