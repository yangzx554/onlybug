ActionController::Routing::Routes.draw do |map|
  map.resources :page_histories
  map.resources :seleniumlogs
  map.resources :builds
  map.resources :pages
  map.resources :versions
  map.resources :photos
  map.resources :milestones
  map.resources :users
  map.resources :projects do |projects|
    projects.resources :pages
    projects.resources :builds do |builds|
      builds.resources :seleniumlogs
    end
    projects.resources :testcases
    projects.resources :tickets do |tickets|
      tickets.resources :versions
    end
    projects.resources :users
  #  projects.resources :seleniumlogs
  end

  map.with_options :controller => 'users'  do |user|
    user.join     '/projects/:project_id/users/:id/join' ,:action =>"join"
    user.signup   '/signup',        :action => 'new'
    user.login    '/login' ,        :action => "login"
    user.profile  '/profile',       :action => "edit"
    user.logout   '/logout',        :action => "logout"
  end
   
  map.with_options :controller => 'builds'  do |build|
     build.tlogs     '/projects/:project_id/builds/:id/tlogs' ,:action =>"tlogs"
     build.flogs     '/projects/:project_id/builds/:id/flogs' ,:action =>"flogs"
  end
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"
  map.show   "/show",   :controller=>'welcome', :action => 'show'
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
