Rails.application.routes.draw do
  resources :users
  resources :categories
  resources :articles do
    resources :comments
  end
  resources :tags
  # get  'home/index', to: '/'
  get  'home/about'
  root 'home#index'
end
