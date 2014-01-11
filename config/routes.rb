Beatech::Application.routes.draw do
  resource :session
  resources :users
  root to: 'tops#index'
end
