Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  }
  
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  registrations: 'customers/registrations'
  }
  
  #管理側ルーティング
  namespace :admins do
    root to: 'homes#top'
    resources :genres,    only: [:index, :create, :edit, :update]
    resources :posts,     only: [:index, :show, :edit, :update]
    resources :customer,  only: [:index, :show, :edit, :update]
  end
  
  #会員側ルーティング
  scope module: :customers do
    root to: 'homes#top'
    get "/about" => "homes#about"
    resources :posts,    only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resource :bookmarks, only: [:create, :destroy]
    end
    resources :customer, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    patch 'customers/:id' => 'customers#update'
  end
  
  # ゲストログイン機能
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end
  
end
