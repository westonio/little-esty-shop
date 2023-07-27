Rails.application.routes.draw do
  resources :merchants, only: [] do
    resources :dashboard, only: :index
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
end
