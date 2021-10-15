Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#show'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  resources 'dashboard', only: :index

  post 'new_friend', to: 'friends#create'

  resources 'movies' do
    resources 'events', only: [:new, :create]
  end
end
