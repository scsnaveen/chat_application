Rails.application.routes.draw do
  # devise_for :admins
  get 'post/new'
  get 'post/index'
  get 'post/delete'
  post 'post/create'
  get 'users/my_profile'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users

  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  devise_for :users,:controllers => {
  	:registrations => "users/registrations",
  	:sessions => "users/sessions",
  	:confirmations => "users/confirmations",
  	:passwords =>"users/passwords"
  }
   post "/friendships/add" => "friendships/add"
  post "/friendships/reject" => "friendships/reject"
  post "/friendships/remove" => "friendships/remove"
  get "/friendships/search" => "friendships/search"
  post "/friendships/search" => "friendships/search"
  post "/friendships/block"=>"friendships/block"
  post "/friendships/unblock"=>"friendships/unblock"
    resources :friendships, only: [:index, :create]
    resources :conversations, only: [:create] do
      member do
          post :close
      end
    resources :messages, only: [:create]
  end
   get 'users/show',as: :user
  # get "friendships/index"
  # post "friendships/create" 
  namespace :admin do
    get 'dashboard/index'
    get 'users/sign_in'
  end
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
end
end
