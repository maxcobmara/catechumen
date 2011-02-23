ActionController::Routing::Routes.draw do |map|
  map.resources :staffcourses

  map.resources :grades

  map.connect '/time_table_entries/select_intake', :controller => 'time_table_entries', :action => 'select_intake'
  map.resources :time_table_entries

  map.resources :period_timings

  map.resources :intakes

  map.resources :klasses

  map.resources :suppliers

  map.resources :suppliers

  map.resources :usesupplies

  map.resources :addsupplies

  map.resources :supplies
 
  map.connect '/assettracks/register', :controller => 'assettracks', :action => 'register'
  map.resources :assettracks

  map.resources :roles

  map.resources :roles

  map.resources :roles

  map.resources :courseevaluations

  map.resources :programmes

  map.resources :librarytransactions

  map.resources :leaveforstaffs

  map.resources :staffgrades

  map.resources :topics

  map.resources :subjects

  map.resources :leaveforstudents

  map.resources :courses

  map.resources :travelclaims

  map.resources :appraisals

  map.resources :appraisals

  map.resources :disposals

  map.resources :travelrequests

  map.resources :examquestions

  map.resources :assetlosses

  map.resources :counsellings

  map.resources :sdiciplines

  map.resources :bulletins

  map.resources :news

  map.resources :parts

  map.resources :trainneeds

  map.resources :strainings

  map.resources :evactivities

  map.resources :appraisals

  map.resources :curriculums

  map.resources :curriculums

  map.resources :docs

  map.resources :documents

  map.resources :curriculums

  map.resources :attendances

  map.resources :loans

  map.resources :addbooks

  map.resources :maints

  map.resources :assetnums

  map.connect '/assets/registerinventory', :controller => 'assets', :action => 'registerinventory'
  map.resources :assets

  map.resources :books

  map.connect '/residences/addasset', :controller => 'residences', :action => 'addasset'
  map.resources :residences

  map.connect '/students/formforstudent', :controller => 'students', :action => 'formforstudent'
  map.resources :students

  map.connect '/position/maklumat_perjawatan_LA', :controller => 'positions', :action => 'maklumat_perjawatan_LA'
  map.resources :positions

  map.resources :cofiles

  map.resources :documents

  map.resources :events

  map.resources :titles

  map.resources :stafftitles
  
  map.connect '/staffs/reportforstaff', :controller => 'staffs', :action => 'reportforstaff'
  map.resources :staffs
  
  
  
  

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.resources :pages
  
  map.view_page ':name', :controller => 'viewer', :action => 'show'

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
  map.root :controller => "viewer", :action => 'show', :name => 'home'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
