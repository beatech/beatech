Beatech::Application.routes.draw do
  #
  # Session
  #
  resource :session, only: [:create, :destroy]

  #
  # Entries
  #
  resources :entries, only: [:index, :new, :create]
  resources :entries, constraints: { id: /[^\/]+/ }, except: [:index, :new, :create], path: "/"
  
  root to: "entries#frontpage"
end
