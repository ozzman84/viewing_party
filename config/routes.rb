Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#show'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  resource :users, only: :create
  get 'dashboard', controller: :users, action: :show
  get 'sign_up', controller: :users, action: :new

  resources :friends, only: :create

  resources :events, only: %i[new create]

  resources :movies, only: :index

  scope :movies do
    resource :details, only: :show
  end
end
