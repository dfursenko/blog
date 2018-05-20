Rails.application.routes.draw do
  resources :technologies
  root 'technologies#index'
  get  'home/index'
end
