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

    resources :orders, only: [:new, :create] do
      collection do
        get 'states', defaults: { format: :json }
        get 'cities', defaults: { format: :json }
        post 'add_coupon'
        patch 'customer_info'
      end
    end

    resources :orders, only: [:new, :create] do
      collection do
        get 'states'
        get 'cities'
        post 'add_coupon'
        patch 'customer_info'
      end
    end

    resources :orders, only: [:new, :create] do
      collection do
        get 'states'
        get 'cities'
        post 'add_coupon'
        patch 'customer_info'
      end
    end
  end

  resources :products, only: [:index, :show]

  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
    resources :orders, only: [:index]
  end

  namespace 'api'do
    scope module: 'v1' do
      resources :products, except: [:edit, :new]
    end
  end
end
