Rails.application.routes.draw do
  resources :sessions
  resources :tasks
  resources :users
  root :to => 'sessions#new'
end
