Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :entries, only: [:index, :new, :create]
  resources :entries, constraints: { id: /.+/ }, except: [:index, :new, :create], path: "/"
  
  root to: "entries#frontpage"
end
