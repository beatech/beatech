Beatech::Application.routes.draw do
  resource :session, only: [:create, :destroy]

  resources :users, constraints: { id: /[a-zA-Z0-9_\-.]+/ }, except: [:edit, :update] do
    resources :blogs
  end
  controller :users, path: 'settings' do
    get   '/:item', constraints: { item: /.+/ }, action: 'edit', as: 'setting'
    patch '/:item', constraints: { item: /.+/ }, action: 'update'
  end

  resources :comments, only: [:create, :destroy]

  get '/auth/twitter/callback' => 'sessions#twitter_create'

  resources :twitter_accounts, only: [:destroy]
  resources :achievements, except: [:new, :show]

  # Contest3rd
  resources :contestdate3rds
  resources :contest3rds
  get '/contest3rd' => 'contest3rds#result'
  get '/contest3rd/tunesedit/:order' => 'contest3rds#tunesedit'
  get '/contest3rd/scoreedit/:order' => 'contest3rds#scoreedit'
  post '/contest3rd/tunesupdate' => 'contest3rds#tunesupdate'
  post '/contest3rd/scoreupdate' => 'contest3rds#scoreupdate'

  resources :entries, only: [:index, :new, :create]
  resources :entries, constraints: { id: /.+/ }, except: [:index, :new, :create], path: '/'

  root to: 'entries#frontpage'
end
