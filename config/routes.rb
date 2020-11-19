Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'football_scores#index'

  resources :football_teams, only: [:index, :create]
  resources :football_scores do
    resources :football_reviews, only: [:new, :create]
  end

  get 'about', to: "pages#about"

end
