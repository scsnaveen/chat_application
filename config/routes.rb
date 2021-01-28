Rails.application.routes.draw do
  get 'post/new'
  get 'post/index'
  get 'post/delete'
  post 'post/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users
 get 'friendships/create'
 get 'friendships/accept_friend'
 get 'friendships/decline_friend'

  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  devise_for :users,:controllers => {
  	:registrations => "users/registrations",
  	:sessions => "users/sessions",
  	:confirmations => "users/confirmations",
  	:passwords =>"users/passwords"
  }
  namespace :admin do
    get 'dashboard/index'
    get 'users/sign_in'
  end
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
end
end
