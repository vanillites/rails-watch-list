Rails.application.routes.draw do
  get 'lists/home'
  get 'lists/index'
  get 'lists/show'
  get 'lists/create'
  get 'lists/new'

  root 'lists#home'
  resources :lists, only: %i[home index show create new] do
    resources :bookmarks, only: %i[new create]
  end

  resources :bookmarks, only: %i[destroy]
end
