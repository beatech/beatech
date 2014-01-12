Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]
  resources :users

  root to: 'tops#index'
end
