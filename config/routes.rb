Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  root 'posts#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :posts, only: %i[index create destroy show]
  resources :comments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
