Rails.application.routes.draw do
  resources :wikis

  resources :charges, only: [:new, :create, :destroy]

  devise_for :users

  root 'welcome#index'
end
