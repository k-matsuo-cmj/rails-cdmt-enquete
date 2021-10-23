Rails.application.routes.draw do
  devise_for :users
  resources :teams, only: [:index, :show]
  root to: "home#index"
end
