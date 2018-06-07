Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :categories
  resources :articles do
    resources :comments
  end
  resources :tags
  # get  'home/index', to: '/'
  get  'home/about'
  root 'home#index'

  get "/profile/:id(.:format)", to: "users#profile", as: 'user_profile'
  get "/profile/edit/:id(.:format)", to: "users#profile_edit", as: 'user_profile_edit'
  patch "/profile/update/:id(.:format)", to: "users#profile_update", as: 'user_profile_update'
end
