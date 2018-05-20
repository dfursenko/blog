Rails.application.routes.draw do
  resources :technologies
  root 'home#index'
  get  'home/index'
end
