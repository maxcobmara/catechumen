ActionController::Routing::Routes.draw do |map|
  map.resources :trainings

  
  map.connect '/asset_defects/dispose/', :controller => 'asset_disposals', :action => 'dispose'
  map.connect '/asset_defects/revalue/', :controller => 'asset_disposals', :action => 'revalue'
  map.resources :asset_disposals, :collection => { :kewpa16 => :get, :kewpa18 => :get, :kewpa19 => :get  }

  map.connect '/asset_defects/kewpa13', :controller => 'asset_defects', :action => 'kewpa13'
  map.connect '/asset_defects/approve/', :controller => 'asset_defects', :action => 'approve'
  map.resources :asset_defects, :collection => { :kewpa9 => :get }
  
  map.connect '/attendance/approve/', :controller => 'asset_loans', :action => 'approve'
  map.resources :asset_loans, :collection => { :lampiran => :get}

  
  map.resources :travel_claims, :collection => { :claimprint => :get }

  map.connect '/attendance/status/', :controller => 'staff_attendances', :action => 'status' 
  map.connect '/attendance/approve/', :controller => 'staff_attendances', :action => 'approve' 
  map.connect '/attendance/manage/', :controller => 'staff_attendances', :action => 'manage' 
  map.resources :staff_attendances, :collection => { :actionable => :put }

  map.resources :staff_appraisals, :collection => { :appraisal_form => :get }

  map.resources :travel_requests

  map.resources :student_counseling_sessions

  map.resources :asset_losses, :collection => { :kewpa28 => :get, :kewpa29 => :get, :kewpa30 => :get }

  
  map.connect '/exams/exampaper', :controller => 'exams', :action => 'exampaper'
  map.resources :exams

  map.resources :student_discipline_cases

  map.resources :trainingnotes, :collection => { :D09 => :get }

  map.resources :trainingreports

  map.resources :studentattendances

  map.resources :exammakers
 
  map.connect '/events/calendar/', :controller => 'events', :action => 'calendar' 
  map.connect '/timetables/calendar/', :controller => 'timetables', :action => 'calendar'
  map.resources :timetables#, :collection => { :calendar => :get }

  map.resources :stationeries, :collection => { :kewpa11 => :get }

  map.resources :messages

  map.resources :banks

  map.resources :accessions

  map.resources :tenants, :collection => { :borang_asrama => :get }

  map.resources :assetcategories

  map.resources :ptdos

  map.resources :ptschedules, :collection => { :apply => :get }

  map.resources :ptcourses

  map.resources :ptbudgets

  map.resources :locations, :collection => { :indextree => :get, :kewpa7 => :get  }

  map.resources :employgrades

  map.resources :staffemployschemes

  map.resources :staffclassifications

  map.resources :staffserveschemes

  map.resources :staffgrades

  map.resources :staff_serviceschemes

  map.resources :trainingrequests

  map.resources :timetable_week_days

  map.resources :staffcourses, :collection => { :indexapply => :get }

  map.resources :grades

  #map.connect '/time_table_entries/timetable_view', :controller => 'time_table_entries', :action => 'timetable_view'
  #map.resources :time_table_entries

  map.resources :period_timings

  map.resources :intakes

  map.resources :klasses

  map.resources :suppliers, :collection => { :kewpa11 => :get }
  map.resources :suppliers

  map.resources :usesupplies

  map.resources :addsupplies

  map.resources :supplies
 
  map.connect '/assettracks/register', :controller => 'assettracks', :action => 'register'
  map.resources :assettracks

  map.resources :roles

  map.resources :courseevaluations

  map.resources :programmes

  map.connect '/librarytransactions/return', :controller => 'librarytransactions', :action => 'return'
  map.connect '/librarytransactions/extend', :controller => 'librarytransactions', :action => 'extend'
  map.resources :librarytransactions

  map.connect '/leaveforstaffs/approve1', :controller => 'leaveforstaffs', :action => 'approve1'
  map.connect '/leaveforstaffs/approve2', :controller => 'leaveforstaffs', :action => 'approve2'
  map.resources :leaveforstaffs

  map.resources :staffgrades

  map.connect '/leaveforstudents/approve', :controller => 'leaveforstaffs', :action => 'approve'
  map.resources :leaveforstudents

  map.resources :disposals

  map.resources :examquestions

  map.resources :assetlosses

  map.resources :counsellings

  map.resources :bulletins

  map.resources :news

  map.resources :parts

  map.resources :trainneeds

  map.resources :evactivities

  map.resources :curriculums

  map.resources :docs

  map.resources :documents

  map.resources :curriculums
  
  map.connect '/attendances/approve', :controller => 'attendances', :action => 'approve'
  map.resources :attendances

  map.resources :loans

  map.resources :addbooks

  map.resources :maints

  map.resources :assetnums

  map.connect '/asset_autocomplete', :controller => 'assets', :action => 'asset_autocomplete'
  map.connect '/assets/registerinventory', :controller => 'assets', :action => 'registerinventory'
  map.connect '/assets/placement', :controller => 'assets', :action => 'asset_placement'
  map.connect '/assets/maintenance', :controller => 'assets', :action => 'maintenance'
  map.resources :assets, :collection => { :kewpa3 => :get, :kewpa2 => :get, :kewpa4 => :get, :kewpa8 => :get, :kewpa13 => :get, :kewpa14 => :get,:loanables => :get}

  map.resources :books

  map.connect '/residences/addasset', :controller => 'residences', :action => 'addasset'
  map.connect '/students/maklumat_pelatih_intake', :controller => 'students', :action => 'maklumat_pelatih_intake'
  map.connect '/students/formforstudent', :controller => 'students', :action => 'formforstudent'
  map.resources :students

  map.connect '/position/maklumat_perjawatan_LA', :controller => 'positions', :action => 'maklumat_perjawatan_LA'
  map.resources :positions

  map.resources :cofiles

  map.resources :documents

  #map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'event', :requirements => {:year => /\d{4}/, :month => /\d{1,2}/}, :year => nil, :month => nil
  map.resources :events

  map.resources :titles
  
  map.connect '/staffs.js', :controller => 'staffs', :action => 'index' , :collection => {:method => :get}
  map.connect '/staffs/reportforstaff', :controller => 'staffs', :action => 'reportforstaff'
  map.resources :staffs
  
  #map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :requirements => {:year => /\d{4}/, :month => /\d{1,2}/}, :year => nil, :month => ni
  
  

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.resources :pages
  
  map.with_options :controller => 'viewer' do |viewer|
    viewer.librarystats 'librarystats', :action => 'librarystats'
    viewer.librarystats 'asset_reports', :action => 'assetreports'
  end
  
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
