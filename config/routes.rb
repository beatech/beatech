Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :users, only: [:index, :create, :new]
  resources :users, only: [:show, :update], path: '/', constraints: { id: /[a-zA-Z0-9_.]{1,15}/ }

  root to: 'tops#index'
end
