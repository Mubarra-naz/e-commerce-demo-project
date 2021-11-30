Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resource :user, only: :show do
    resource :cart
    resources :line_items do
      post 'update_qty', on: :member
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
