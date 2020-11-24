Rails.application.routes.draw do
  get 'maps/index'
  devise_for :users

  get 'home/about' => 'homes#about'
  root 'homes#top'

  resources :maps, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :recruitments do
    collection do
      get 'search'
    end
  resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show] do
    member do
      get 'mypage_show'
      get 'mypage_edit'
      patch 'mypage_update'
      get 'out'
      patch 'quit'
      get 'following'
      get 'followers'
    end
  end
end
