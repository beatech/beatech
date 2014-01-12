Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :users, only: [:index]
  resources :users, only: [:show], path: '/', constraints: { id: /[a-zA-Z0-9_.]{1,15}/ } do
    collection do
      get  :registration, action: 'new'
      post :registration, action: 'create'
      post :deactivate,   action: 'destroy'
    end
  end
  resource :user, only: [], path: 'settings', constraints: { item: /[a-z]+/ } do
    get  '/:item', action: 'edit', as: 'setting'
    post '/:item', action: 'update'
  end

  root to: 'tops#index'
end
