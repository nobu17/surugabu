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

  get 'admin/', to: 'admin#index'

  get 'admin/article_edit/', to: 'article_edit#index'
  post 'admin/article_edit/', to: 'article_edit#create'
  put 'admin/article_edit/:id', to: 'article_edit#update'
  patch 'admin/article_edit/:id', to: 'article_edit#update'
  delete 'admin/article_edit/:id', to: 'article_edit#destroy'
  get 'admin/article_edit/:id/edit', to: 'article_edit#edit'
  get 'admin/article_edit/new', to: 'article_edit#new'
end
