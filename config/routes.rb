Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users

  resources :posts do
    resources :comments
  end

  get :search, to: 'posts#search'
  # TODO: check difference bw these
  # get '/search', to: 'posts#search'
end
