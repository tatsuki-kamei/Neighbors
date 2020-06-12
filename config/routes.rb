Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users,only:[:show, :edit, :update]
  resources :products　do
  	resources :comments, only: [:create, :destroy, :update]
  end
  get '/product/hashtag/:name', to: "products#hashtag"
end
