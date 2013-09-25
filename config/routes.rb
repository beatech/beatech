Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :users, except: [:edit, :update]
  controller :users, path: 'settings' do
    get  '/:item', action: 'edit', as: 'setting'
    post '/:item', action: 'update'
  end

  resources :achievements, except: [:new, :show]

  resources :entries, only: [:index, :new, :create]
  resources :entries, constraints: { id: /.+/ }, except: [:index, :new, :create], path: '/'

  root to: 'entries#frontpage'
end
