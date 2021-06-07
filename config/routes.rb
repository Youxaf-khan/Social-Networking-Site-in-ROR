Rails.application.routes.draw do
  root to:  'posts#index'

  devise_for  :users

  resources :posts do
  resources :comments
  end

  get '/search', to: 'posts#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
