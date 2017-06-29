Rails.application.routes.draw do
  resources :wikis do
    resources :collaborators, only: [:index, :create, :destroy]
  end

  resources :charges, only: [:new, :create, :destroy]

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'welcome#index'
end
