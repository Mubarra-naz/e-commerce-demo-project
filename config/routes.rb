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

    resources :orders, only: [:new, :create]
    post '/add_coupon', to: 'orders#add_coupon'
    patch '/customer_info', to: 'orders#update_user'
    get '/states', to: 'orders#states'
    get '/cities', to: 'orders#cities'
  end

  resources :products, only: [:index, :show]

  namespace :admin do
    resources :users
    resources :products
    resources :categories
    resources :coupons
  end
end
