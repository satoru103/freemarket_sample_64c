Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index,:new,:create,:show,:destroy] do
    member do
      get 'purchase',to: 'items#purchase'
      post 'done',to: 'items#done'
     end
  end 
  resources :users, only: [:show] do
    resources :addresses, only: [:new, :create, :edit, :update]
  end

  resources :cards, only: [:index,:new,:show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'buy', to: 'cards#buy'
      post 'delete', to: 'cards#delete'
    end
  end

end
