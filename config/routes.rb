Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :merchants, only: :index do
    resources :dashboard, only: :index
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show]
    patch '/invoice_items/:invoice_item_id', to: 'invoices#update_status', as: 'invoice_item_update'
  end

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :update]
  end
end
