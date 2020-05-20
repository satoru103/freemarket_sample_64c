Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    member do
      get 'purchase',to: 'items#purchase'
      post 'done',to: 'items#done'
     end
     
    #Ajaxで動くアクションのルート
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'development',to: 'items#development'
    end
  end 

  resources :users, only: [:edit, :update, :show] do
    resources :addresses, only: [:new, :create, :edit, :update]
  end


  resources :cards, only: [:index,:new,:show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'buy', to: 'cards#buy'
      post 'delete', to: 'cards#delete'
    end
  end

  resources :categories, only: [:index, :show]

end
