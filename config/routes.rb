Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :tasks do
    collection do
      get 'search'
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]


