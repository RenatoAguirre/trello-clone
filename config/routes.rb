Rails.application.routes.draw do
  get 'teams/index'
  get 'teams/show'
  get 'teams/new'
  get 'teams/create'
  get 'teams/join'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'

  resources :states
  resources :tasks
  resources :boards do 
    resources :states, only: [:create, :new, :show, :index, :edit, :destroy] do
      resources :tasks, only: [:create, :new, :show, :index, :edit, :destroy]
    end
  end
  # config/routes.rb
  resources :teams do
    post 'join', on: :member
  end

end
