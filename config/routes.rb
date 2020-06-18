Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users,only:[:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :products
  get '/product/hashtag/:name', to: "products#hashtag"
  resources :comments, only: [:create, :destroy, :update]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :favorites, only: [:create, :destroy]
  resources :notifications, only: :index
end
