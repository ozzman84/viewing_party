Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#show'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
end
