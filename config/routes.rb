Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :project_teams
      resources :user_teams
      resources :user_historicals
      resources :tasks
      resources :projects
      resources :rules
      resources :teams
      resources :departments
      resources :roles
    end
  end

  get 'home', to: 'home#index'
  root to: 'home#index'
end
