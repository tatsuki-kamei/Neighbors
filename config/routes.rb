Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users,only:[:show, :index, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :products
  get '/product/hashtag/:name', to: "products#hashtag"
  get 'hashtag', to: "products#hashtag"
  get '/product/rank' =>  "products#rank"
  get '/product/category' => "products#category"
  resources :comments, only: [:create, :destroy, :update]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :favorites, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
  resources :questions do
    resources :votes, only: [:create, :destroy]
  end
  get 'question/rank' => "questions#rank"
  get "/" => "tops#top"
  get "tops/top" => "tops#top"
end
