ActionController::Routing::Routes.draw do |map|
  map.resources :instructors, :collection => { :appraisal_score => :get, :qc_checked => :get}

  map.resources :marks

  map.resources :analysispaperexams

  map.resources :average_lecturers, :collection => { :average_score => :get}

  map.resources :weeklyprogrammes


  map.resources :downloads, :collection => { :exam_attendance => :get, :check_form => :get, :penilaian_kursus => :get, 
  :analisa_kursus => :get, :laporan_kursus => :get, :aduan_q => :get, :aduan_q_bulanan => :get, :feedback_customer => :get,
  :penilaian_latihan => :get, :laporan_penilaian_latihan => :get, :penilai_jurulatih => :get, :skor_purata_jurulatih => :get,
  :penilaian_pensyarah => :get, :black_list_pensyarah => :get , :analisa_exam => :get, :final_exam => :get, :amaran_komandan => :get,
  :amaran_pengarah => :get, :simpanan_pelatih => :get, :kediaman_asrama => :get, :maklumat_pelatih => :get, :aduan_sajian => :get,
:ujian_cergas => :get, :rancangan_latihan => :get, :bbm => :get, :feedback_lawatan => :get, :rekod_latihan => :get,
:analisa_kejurulatihan => :get, :hadir_kursus => :get, :kaji_selidik => :get, :matrik_jurulatih => :get, :pinjam_kereta => :get,
:tempahan_pesanan => :get, :penilaian_pembekal => :get, :doc_upload_kkm => :get, :doc_upload_tbl => :get, :doc_upload_ran => :get,
:doc_upload_ks => :get, :doc_upload_wp => :get}

  map.resources :bookingvehicles, :collection => { :vehicle_form => :get, :endorse => :get, :approve => :get }

  map.resources :officecars

  map.resources :analysis_grades, :collection => {:analysis_form => :get}

  map.resources :skt_staffs, :collection => {:skt => :get}

  map.resources :klasses

  map.resources :klasses

  map.resources :trainingreports

  map.resources :stocks, :collection => { :kewpa11 => :get, :approve => :get, :store => :get }

  map.resources :training_notes

  map.resources :messages

  map.resources :studentattendances

  
  map.connect '/bookingfacilities/bookingfacility', :controller => 'bookingfacilities', :action => 'bookingfacility'
  map.resources :bookingfacilities, :collection => {:approve => :get, :facility => :get}
  
  map.connect '/exammakers/exampaper', :controller => 'exammakers', :action => 'exampaper'
  map.resources :exammakers

  map.resources :mentors

  map.resources :classrooms

  map.resources :klasses

  map.connect '/timetables/calendar/', :controller => 'timetables', :action => 'calendar'
  map.resources :timetables
  
  map.connect '/evaluate_coaches/report_evaluate_instructor', :controller => 'evaluate_coaches', :action => 'report_evaluate_instructor'
  map.connect '/evaluate_coaches/penilaijurulatih', :controller => 'evaluate_coaches', :action => 'penilaijurulatih'
  map.resources :evaluate_coaches

  #map.resources :evaluate_lecturers
  map.connect '/evaluate_lecturers/penilaipensyarah', :controller => 'evaluate_lecturers', :action => 'penilaipensyarah'
  map.resources :evaluate_lecturers

  map.resources :banks

  map.resources :accessions

  map.resources :tenants, :collection => { :borang_kuarter => :get, :borang_asrama => :get }

  map.resources :assetcategories

  map.resources :ptdos, :collection => { :approve1 => :get, :approve2 => :get  }

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

  map.connect '/grades/report_grade', :controller => 'grades', :action => 'report_grade'
  map.resources :grades

  map.connect '/time_table_entries/timetable_view', :controller => 'time_table_entries', :action => 'timetable_view'
  map.resources :time_table_entries

  map.resources :period_timings

  map.resources :intakes

  map.resources :suppliers, :collection => {:card_stock => :get}

  map.resources :usesupplies

  map.resources :addsupplies

  map.resources :supplies
 
  map.connect '/assettracks/vehicle_booking', :controller => 'assetracks', :action => 'vehicle_booking' 
  map.connect '/assettracks/register', :controller => 'assettracks', :action => 'register'
  map.resources :assettracks

  map.resources :roles

  map.resources :roles

  map.resources :roles

  map.resources :courseevaluations

  map.resources :programmes
  
  map.connect '/librarytransactions/return', :controller => 'librarytransactions', :action => 'return'
  map.connect '/librarytransactions/extend', :controller => 'librarytransactions', :action => 'extend'
  map.connect '/librarytransactions/report_overdue', :controller => 'librarytransactions', :action => 'report_overdue'
  map.resources :librarytransactions
  
  map.connect '/leaveforstaffs/laporan_cuti', :controller => 'leaveforstaffs', :action => 'laporan_cuti'
  map.connect '/leaveforstaffs/cuti_rehat', :controller => 'leaveforstaffs', :action => 'cuti_rehat'
  map.connect '/leaveforstaffs/leavefourhours', :controller => 'leaveforstaffs', :action => 'leavefourhours'
  map.connect '/leaveforstaffs/approve1', :controller => 'leaveforstaffs', :action => 'approve1'
  map.connect '/leaveforstaffs/approve2', :controller => 'leaveforstaffs', :action => 'approve2'
  map.resources :leaveforstaffs, :collection => { :office => :get, :list => :get  }

  map.resources :staffgrades

  map.resources :topics, :collection => { :lesson_plan => :get}

  map.resources :subjects
  
  map.connect '/leaveforstudents/borang_cuti_pelatih', :controller => 'leaveforstudents', :action => 'borang_cuti_pelatih'
  map.connect '/leaveforstudents/approve', :controller => 'leaveforstaffs', :action => 'approve'
  map.resources :leaveforstudents

  map.resources :courses

  map.resources :travelclaims, :collection => { :claimprint => :get }

  #map.resources :appraisals

  map.resources :appraisals, :collection => { :spe_form => :get }

  map.resources :disposals

  map.resources :travelrequests, :collection => { :approve => :get, :travelrequest_form => :get }

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
  
  map.connect '/documents/action2', :controller => 'documents', :action => 'action2'
  map.connect '/documents/action1', :controller => 'documents', :action => 'action1'
  map.resources :documents, :collection => { :feedback => :get}

  map.resources :curriculums
  
  map.connect '/attendances/kedatangan_harian', :controller => 'attendances', :action => 'kedatangan_harian'
  map.connect '/attendances/approve', :controller => 'attendances', :action => 'approve'
  map.resources :attendances

  map.resources :loans

  map.resources :addbooks

  map.resources :maints

  map.resources :assetnums

  map.connect '/assets/registerinventory', :controller => 'assets', :action => 'registerinventory'
  map.resources :assets, :collection => { :kewpa3 => :get, :kewpa2 => :get, :kewpa4 => :get, :list_asset => :get }

  map.resources :books, :collection => { :help => :get, :rules => :get}

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
  
  map.connect '/staffs.js', :controller => 'staffs', :action => 'index' , :collection => {:method => :get}
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
