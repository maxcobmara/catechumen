ActionController::Routing::Routes.draw do |map|
  map.resources :examquestionanalyses
  map.resource :exammakeranalysis
  map.resources :exammakeranalyses

  map.resources :marks

  map.resources :exammarks

  map.resources :resultlines

  map.connect '/examresults/index_summary', :controller => 'examresults', :action => 'index_summary'
  map.connect '/examresults/index_stat', :controller => 'examresults', :action => 'index_stat'
  map.resources :examresults

  map.resources :removetargets

  map.resources :reviewtargets

  map.resources :settargets

  #map.connect : '/annual_work_targets/new/', :controller => 'annual_work_targets', :action => 'new'#, :collection => {:method => :get}    #:id => appraisal.id
  map.resources :annual_work_targets

  map.resources :trainingnotes

  map.resources :trainingreports

  map.resources :studentattendances

  map.resources :exammakers
 
  map.connect '/events/calendar/', :controller => 'events', :action => 'calendar' 
  map.connect '/timetables/calendar/', :controller => 'timetables', :action => 'calendar'
  map.resources :timetables#, :collection => { :calendar => :get }

  map.resources :stationeries

  map.resources :messages

  map.resources :banks

  map.resources :accessions

  map.resources :tenants

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

  map.resources :grades, :collection => { :edit_multiple => :post, :update_multiple => :put }   #-- 17 May 2012--
  map.resources :grades, :collection => { :new_multiple => :post}#, :create_multiple => :post }  #-- 17 May 2012--
  map.connect '/grades/index_by_subject', :controller => 'grades', :action => 'index_by_subject'
  #map.connect '/grades/new_multiple', :controller => 'grades', :action => 'new_multiple'#, :collection => {:method => :get}
  #map.connect '/grades/grade_by_programme', :controller => 'grades', :action => 'grade_by_programme'
  #map.resources :grades, :collection => { :grade_by_programme=> :get }
    map.connect '/grades/new_multiple', :controller => 'grades', :action => 'new_multiple'
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

  map.resources :librarytransactions

  map.connect '/leaveforstaffs/approve1', :controller => 'leaveforstaffs', :action => 'approve1'
  map.connect '/leaveforstaffs/approve2', :controller => 'leaveforstaffs', :action => 'approve2'
  map.resources :leaveforstaffs

  map.resources :staffgrades

  map.resources :topics

  map.resources :subjects

  map.connect '/leaveforstudents/approve', :controller => 'leaveforstaffs', :action => 'approve'
  map.resources :leaveforstudents

  map.resources :courses

  map.resources :travelclaims, :collection => { :claimprint => :get }

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

  map.resources :docs

  map.resources :documents

  map.resources :curriculums
  
  map.connect '/attendances/approve', :controller => 'attendances', :action => 'approve'
  map.resources :attendances

  map.resources :loans

  map.resources :addbooks

  map.resources :maints

  map.resources :assetnums

  map.connect '/assets/registerinventory', :controller => 'assets', :action => 'registerinventory'
  map.resources :assets, :collection => { :kewpa3 => :get, :kewpa2 => :get, :kewpa4 => :get, :kewpa8 => :get }

  map.resources :books

  map.connect '/residences/addasset', :controller => 'residences', :action => 'addasset'
  map.resources :residences

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

  map.resources :stafftitles
  
  #map.connect '/staffs.json', :controller => 'staffs', :action => 'index' , :collection => {:method => :get}
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
