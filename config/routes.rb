Rails.application.routes.draw do
  devise_for :users
  root to: 'leaderboard#index'
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'

  resources :games, only: [:new, :create]
  resources :history, only: :index, path: 'your-history'
end
