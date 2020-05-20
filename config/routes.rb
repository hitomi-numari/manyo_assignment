Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root :to => 'tasks#index'
  resources :tasks
end
