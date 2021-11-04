Rails.application.routes.draw do
  devise_for :users
  resources :enquetes, except: [:index]
  resources :replies, only: [:show, :edit, :update]
  resources :teams, only: [:index, :show]
  root to: "home#index"
end
