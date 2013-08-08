Beatech::Application.routes.draw do
  #
  # Entries
  #
  resources :entries, only: [:index, :new, :create]
  resources :entries, constraints: { id: /[^\/]+/ }, except: [:index, :new, :create], path: "/"
  
  root to: "entries#frontpage"
end
