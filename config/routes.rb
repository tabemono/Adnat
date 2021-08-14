Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'logout'  =>  'sessions#destroy', :as => 'logout'
  get "login" => 'sessions#new', :as => 'login'
  get 'signup' => 'users#new', :as => 'signup'
  get 'welcome' => 'sessions#welcome', :as => "welcome"
  get 'profile' => 'sessions#profile', :as => "profile"
  put 'leave/:id' => 'users#leave_organization', :as => "leave_organization"
  put 'join/:id' => 'users#join_organization', :as => "join_organization"

  root :to => "sessions#profile"

  resources :users
  resources :sessions
  resources :organizations
  resources :shifts

end
