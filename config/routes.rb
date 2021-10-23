Rails.application.routes.draw do
  devise_for :users
  resources :enquetes
  resources :teams, only: [:index, :show]
  root to: "home#index"
end
