Rails.application.routes.draw do
  devise_for :users
  root to: 'football_teams#index'

  resources :football_teams, only: [:index, :create]
  resources :football_scores, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
