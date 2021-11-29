Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    root 'devise/sessions#new'
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :user, only: :show do
    member do
      get 'set_password'
      patch 'update_password'
    end
    resource :cart
    resources :line_items do
      post 'update_quantity', on: :member, defaults: { format: :json }
    end
  end

  resources :products, only: [:index, :show]

  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
  end
end
