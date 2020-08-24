Rails.application.routes.draw do
  devise_for :users
  root to: 'football_teams#index'

  get 'football_teams', to: "football_teams#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
