# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # map onlyfor login/logout
  # devise_for :users, skip: :all
  # devise_scope :user do
  #  get 'users/login' => 'devise/sessions#new', as: :new_user_session
  #  post 'users/login' => 'devise/sessions#create', as: :user_session
  #  delete 'users/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'articles#index'
  get 'articles/', to: 'articles#index'
  get 'articles/pages/:page', to: 'articles#index'
  get 'articles/:id', to: 'articles#show'
end
