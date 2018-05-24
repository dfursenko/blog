Rails.application.routes.draw do
  root 'home#index'
  get  'home/index'
  get  'home/about'
  resources :categories
  resources :articles do
    resources :comments
  end
  resources :tags
end
