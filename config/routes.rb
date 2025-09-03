Rails.application.routes.draw do
  root to: 'homes#top'
  get'home/about', to: 'homes#about', as: 'about'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update, :create]
  resources :books
  get 'top' => 'books#top'
  delete 'users/:id' => 'users#destroy', as: 'destroy_user'
end
