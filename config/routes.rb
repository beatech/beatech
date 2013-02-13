Beatech::Application.routes.draw do
  resources :contest2nds


  root :to => 'pages#frontpage'

  # Overrides
  match "/registration" => "users#new"
  match "/registration/create" => "users#create_user"
   
  resources :pages
  resources :users
  resources :sessions

  # Users
  match "/users/:account" => "users#showprofile"

  # Settings
  match "/settings/profile" => "users#editprofile"
  match "/settings/password" => "users#editpassword"
  match "/settings/update/profile" => "users#update_profile"
  match "/settings/update/password" => "users#update_password"

  # Authentication
  match "/auth/twitter/callback" => "sessions#twitter_create"

  # Wiki
  match 'edit/:url' => 'pages#edit_page'
  match 'newpage' => 'pages#new'
  match ':url' => 'pages#show_page'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
