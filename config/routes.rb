Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resource :user, only: :show

  namespace :admin do
    resources :users
    resources :products
    resources :categories
  end
end
