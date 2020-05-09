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

  get 'about/', to: 'about#index'

  get 'admin/', to: 'admin#index'

  get 'admin/article_edit/', to: 'article_edit#index'
  post 'admin/article_edit/', to: 'article_edit#create'
  put 'admin/article_edit/:id', to: 'article_edit#update'
  patch 'admin/article_edit/:id', to: 'article_edit#update'
  delete 'admin/article_edit/:id', to: 'article_edit#destroy'
  get 'admin/article_edit/:id/edit', to: 'article_edit#edit'
  get 'admin/article_edit/new', to: 'article_edit#new'
  post 'adamin/article_edit/attach/', to: 'article_edit#attach'

  get 'admin/area/', to: 'area#index'
  post 'admin/area/', to: 'area#create'
  put 'admin/area/:id', to: 'area#update'
  patch 'admin/area/:id', to: 'area#update'
  delete 'admin/area/:id', to: 'area#destroy'
  get 'admin/area/:id/edit', to: 'area#edit'
  get 'admin/area/new', to: 'area#new'

  get 'admin/category/', to: 'category#index'
  post 'admin/category/', to: 'category#create'
  put 'admin/category/:id', to: 'category#update'
  patch 'admin/category/:id', to: 'category#update'
  delete 'admin/category/:id', to: 'category#destroy'
  get 'admin/category/:id/edit', to: 'category#edit'
  get 'admin/category/new', to: 'category#new'
end
