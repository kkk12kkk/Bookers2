Rails.application.routes.draw do
  root to: 'homes#top'

  resources :users, only: [:new, :index, :show]
  resources :users, only: [:show, :edit, :update]
  post 'users' => 'users#create'
  get 'users/edit'
  get 'books/top'
  devise_for :users
  get '/top' => 'homes#top'
  delete 'users/:id' => 'users#destroy', as: 'destroy_user'
end
