Rails.application.routes.draw do
  resources :homes
  root to: 'home#new'
  post  '/home/new' => 'home#create'
  post  '/' => 'home#create'
  get  '/home/new' => 'home#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
