Rails.application.routes.draw do
  # get 'users', to: 'users#index'
  # get 'users/:id', to: 'users#index'
  get 'comments/create'
  get 'comments/destroy'
  root 'posts#index'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :posts
  resources :users, only: [:index, :show, :edit, :update]
  resources :comments
  resources :friend_requests, only: %i[index create destroy]
  resources :likes, only: [:create,:destroy]
  resources :friendships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
