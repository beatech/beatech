Beatech::Application.routes.draw do
  resources :users
  root to: 'tops#index'
end
