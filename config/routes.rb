Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'comments/create'
  get 'comments/destroy'
  root 'posts#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :posts
  resources :comments
  resources :friend_requests, only: %i[index create destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
