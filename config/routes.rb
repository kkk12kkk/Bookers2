Rails.application.routes.draw do
  get 'users/new'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'books/top'
  devise_for :users
  get '/top' => 'homes#top'
end
