Rails.application.routes.draw do
  devise_for :users

  get 'home/about' => 'homes#about'
  root 'homes#top'

  resources :recruitments
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show, :index]
  resources :users, only: [:index, :show] do
    member do
      get 'mypage_show'
      get 'mypage_edit'
      patch 'mypage_update'
      get 'out'
      patch 'quit'
    end
  end

end
