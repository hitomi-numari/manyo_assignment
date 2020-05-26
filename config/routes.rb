Rails.application.routes.draw do
  resources :sessions
  resources :tasks
  resources :users
  namespace :admin do
   resources :users
 end
  root :to => 'sessions#new'
end
