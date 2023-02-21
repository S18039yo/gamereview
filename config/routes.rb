Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: 'homes#top'
  get "/about" => "homes#about"
  
  # 管理者用
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  }
  
  # 会員用
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  registrations: 'customers/registrations'
  }
  
end
