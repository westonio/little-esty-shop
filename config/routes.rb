Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :merchants, only: :index do
    resources :dashboard, only: :index
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show]
  end

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
