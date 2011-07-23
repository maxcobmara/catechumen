authorization do
  
  role :administration do
    #Staff Menu Items
    has_permission_on :staffs,          :to => [:manage, :borang_maklumat_staff]
    has_permission_on :attendances,     :to => [:manage, :approve]
    #appraisals
    #positions
    has_permission_on :leaveforstaffs,  :to => [:manage, :approve1, :approve2]
    #claims
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules, :ptdos],  :to => :manage   #Professional Development
    #status & movement
    #reports
    
    #Asset Menu Items
    has_permission_on :assets,      :to => :manage                              #asset items
    
    #Location Menu Items
    has_permission_on :locations,   :to => :manage                              #location items
    
    #E-Filing Menu Items
    has_permission_on :documents,   :to => :manage                                #e-filing items
    
    #Student Menu Items
    has_permission_on :students,        :to => [:manage, :formforstudent]
    has_permission_on [:leaveforstudents],  :to => :manage #
    
    #Exam Menu Items
    has_permission_on :examquestions,   :to => :manage
    
    #Training Menu Items
    has_permission_on :programmes, :to => :core
    
    #Library Menu Items
    has_permission_on [:librarytransactions, :books], :to => :manage
    
    #Administration Menu Items
    has_permission_on [:users, :roles, :pages],  :to => :manage #stuff in admin menu
  end
  
  
  role :staff do
    has_permission_on [:attendances, :assets, :documents],     :to => :menu              # Access for Menus
    has_permission_on :books, :to => :core
    has_permission_on :ptdos, :to => :create
    has_permission_on :ptdos, :to => :index do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :staffs, :to => [:index, :show, :edit, :update, :menu] do
      if_attribute :id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
        if_attribute :approve_id => is {User.current_user.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve1, :update] do
        if_attribute :approval1_id => is {User.current_user.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve2, :update] do
        if_attribute :approval2_id => is {User.current_user.staff_id}
    end
    has_permission_on :ptdos, :to => :delete do
        if_attribute :staff_id => is {User.current_user.staff_id}
    end
  end
  
  role :staff_administrator do
     has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff]
  end
  
  role :student do
    has_permission_on :programmes, :to => :core
    has_permission_on :books, :to => :core
    has_permission_on :students, :to => [:read, :update, :core] do
      if_attribute :id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:manage] do
      if_attribute :student_id => is {User.current_user.student_id}
    end
    has_permission_on :leaveforstudents, :to => [:create]
  end
  
  role :student_administrator do
     has_permission_on :students, :to => [:manage, :formforstudent]
  end
  

  
  role :training_manager do
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules], :to => :manage
  end
  
  role :training_administration do
    has_permission_on [:ptcourses, :ptschedules], :to => :manage
    has_permission_on :ptdos, :to => :approve
  end
  
  role :asset_administrator do
    has_permission_on :assets, :to => :manage
  end
  
  role :facilities_administrator do
    has_permission_on :locations, :to => :manage
  end
  
  role :lecturer do
    has_permission_on :examquestions, :to => :manage
    has_permission_on :programmes, :to => :core
  end
  
  role :librarian do
    has_permission_on :books, :to => :manage
    has_permission_on :librarytransactions, :to => :manage
  end 
  
  
  
  role :warden do
    has_permission_on :locations, :to => :core
    has_permission_on :leaveforstudents, :to => [:index, :show, :update, :approve] do
      if_attribute :studentsubmit => true
    end
  end
  
  role :student_counsellor do
    has_permission_on :counsellings, :to => :manage
    has_permission_on :students, :to => :core
  end
  
  role :guest do
    has_permission_on :users, :to => :create
    has_permission_on :books, :to => :core
  end
  
end
  
  privileges do
    privilege :approve,:includes => [:read, :update]
    privilege :manage, :includes => [:create, :read, :update, :delete, :core, :approve, :menu]
    privilege :menu,   :includes => [:read]
    privilege :core,   :includes => [:read]
    privilege :read,   :includes => [:index, :show]
    privilege :create, :includes => :new
    privilege :update, :includes => :edit
    privilege :delete, :includes => :destroy
  end