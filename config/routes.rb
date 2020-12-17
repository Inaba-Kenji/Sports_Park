Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }


  root 'homes#top'

  get 'maps/index'
  get 'home/about' => 'homes#about'
  post 'home/guest_sign_in', to: 'homes#new_guest'

  resources :maps, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :recruitments do
    collection do
      get 'search'
      get 'text_search'
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
