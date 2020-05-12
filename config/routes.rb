Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index,:new,:create,:show,:destroy] do
    member do
      get 'purchase'
     end
     
  
  #Ajaxで動くアクションのルート
  collection do
    get 'get_category_children', defaults: { format: 'json' }
    get 'get_category_grandchildren', defaults: { format: 'json' }
  end
  end 
  resources :users, only: [:show] do
    resources :addresses, only: [:new, :create, :edit, :update]
  end
  resources :cards, only: [:index, :new]
  resources :categories, only: [:index, :show]
  
end
