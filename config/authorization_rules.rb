authorization do
  
  role :administration do
    has_omnipotence
    has_permission_on :authorization_rules, :to => :read
    #Staff Menu Items
    #has_permission_on :staffs,          :to => [:manage, :borang_maklumat_staff]
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
    #has_permission_on :documents,   :to => :manage                                #e-filing items
    
    #Student Menu Items
    #has_permission_on :students,        :to => [:manage, :formforstudent, :maklumat_pelatih_intake]
    #has_permission_on [:leaveforstudents],  :to => :manage #
    
    #Exam Menu Items
    has_permission_on :examquestions,   :to => :manage
    
    #Training Menu Items
    has_permission_on :programmes, :to => :manage
    has_permission_on :timetables, :to => :manage
    
    #Library Menu Items
    has_permission_on [:librarytransactions, :books], :to => :manage
    
    #Administration Menu Items
    has_permission_on [:users, :roles, :pages],  :to => :manage #stuff in admin menu
  end
  
  
  #Group Staff
  
  role :staff do
    has_permission_on :authorization_rules, :to => :read
    has_permission_on [:attendances, :assets, :documents],     :to => :menu              # Access for Menus
    has_permission_on :books, :to => :core
    has_permission_on :ptdos, :to => :create
    has_permission_on :ptdos, :to => :index do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :staffs, :to => [:show, :menu]
    has_permission_on :staffs, :to => [:edit, :update, :menu] do
      if_attribute :id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
        if_attribute :approve_id => is {User.current_user.staff_id}
    end
    
    has_permission_on :staff_appraisals, :to => :create
    has_permission_on :staff_appraisals, :to => :manage, :join_by => :or do 
        if_attribute :staff_id => is {User.current_user.staff_id}
        if_attribute :eval1_by => is {User.current_user.staff_id}
        if_attribute :eval2_by => is {User.current_user.staff_id}
    end
    
    has_permission_on :leaveforstaffs, :to => :create
    has_permission_on :leaveforstaffs, :to => [:index, :show, :edit, :update] do
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
    
    has_permission_on :asset_defects, :to => :create
    has_permission_on :asset_defects, :to => [:read, :update]  do
        if_attribute :reported_by => is {User.current_user.staff_id}
    end
    has_permission_on :asset_defects, :to => [:manage]  do
        if_attribute :decision_by => is {User.current_user.staff_id}
    end
    
    has_permission_on :documents, :to => :approve, :join_by => :or do 
        if_attribute :stafffiled_id => is {User.current_user.staff_id}
        if_attribute :cc1staff_id => is {User.current_user.staff_id}
        if_attribute :cc2staff_id => is {User.current_user.staff_id}
    end  
    
    has_permission_on :sdiciplines, :to => :create
    has_permission_on :sdiciplines, :to => :approve do
      if_attribute :reportedby_id => is {User.current_user.staff_id}
    end
    
    has_permission_on :student_discipline_cases, :to => :create
    has_permission_on :student_discipline_cases, :to => :approve do
      if_attribute :assigned_to => is {User.current_user.staff_id}
    end
    has_permission_on :student_discipline_cases, :to => :read do
      if_attribute :reported_by => is {User.current_user.staff_id}
    end

    has_permission_on :librarytransactions, :to => :read do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
  end
  
  role :staff_administrator do
     has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff]
  end
  
  role :training_manager do
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules], :to => :manage
  end
  
  role :training_administration do
    has_permission_on [:ptcourses, :ptschedules], :to => :manage
    has_permission_on :ptdos, :to => :approve
  end
  
  #Group Assets  -------------------------------------------------------------------------------
  role :asset_administrator do
    has_permission_on :assets, :to => :manage
    has_permission_on :asset_defects, :to => :manage
  end

  
  #Group Locations  -------------------------------------------------------------------------------
  role :facilities_administrator do
    has_permission_on :locations, :to => :manage
  end
  
  role :warden do
    has_permission_on :locations, :to => :core
    has_permission_on :leaveforstudents, :to => [:index, :show, :update, :approve] do
      if_attribute :studentsubmit => true
    end
  end
  
  #Group E-Filing ------------------------------------------------------------------------------- 
  role :e_filing do
    has_permission_on :cofiles, :to => :manage
    has_permission_on :documents, :to => :manage
  end
  
  #Group Student --------------------------------------------------------------------------------
  role :student do
    
      has_permission_on :locations, :to => :menu
    
      has_permission_on :tenants, :to => :read do
        if_attribute :student_id => is {User.current_user.student_id}
      end
      
      has_permission_on :student_counseling_sessions, :to => :create
      has_permission_on :student_counseling_sessions, :to => :show do
        if_attribute :student_id => is {User.current_user.student_id}
      end
    
      has_permission_on :programmes, :to => :menu
      has_permission_on :books, :to => :core
      has_permission_on :students, :to => [:read, :update, :menu] do
        if_attribute :student_id => is {User.current_user.student_id}
      end
      has_permission_on :leaveforstudents, :to => [:read, :update] do
        if_attribute :student_id => is {User.current_user.student_id}
      end
      has_permission_on :leaveforstudents, :to => [:create]
  end
  
  role :student_administrator do
     has_permission_on :students, :to => [:manage, :formforstudent, :maklumat_pelatih_intake]
  end
  
  role :disciplinary_officer do
    has_permission_on :Student_discipline_cases, :to => :manage
  end
  
  role :student_counsellor do
    has_permission_on :student_counseling_sessions, :to => :manage
    has_permission_on :students, :to => :core
  end
  
  #Group Training  -------------------------------------------------------------------------------

  role :programme_manager do
    has_permission_on :programmes, :to => :manage
    has_permission_on :timetables, :to => [:index, :show, :edit, :update, :menu, :calendar]
    has_permission_on :topics, :to => :manage
  end
  
  role :lecturer do
    has_permission_on :examquestions, :to => :manage
    has_permission_on :programmes, :to => :core
    has_permission_on :topics, :to => :manage
    has_permission_on :timetables, :to => [:index, :show, :edit, :update, :menu, :calendar] do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :trainingreports, :to => :manage do
      if_attribute :staff_id => is {User.current_user.staff_id}
    end
    has_permission_on :timetables, :to => [:create]
  end
  
  
  #Group Exams   -------------------------------------------------------------------------------
  
  #Group Library   -------------------------------------------------------------------------------
  
  role :librarian do
    has_permission_on :books, :to => [:manage, :extend, :return]
    has_permission_on :librarytransactions , :to => [:manage, :extend, :return]
  end 
  
  role :guest do
    has_permission_on :users, :to => :create
    has_permission_on :books, :to => :core
  end
  
end
  
  privileges do
    privilege :approve,:includes => [:read, :update]
    privilege :manage, :includes => [:create, :read, :update, :delete, :core, :approve, :menu]
    privilege :menu,   :includes => [:index]
    privilege :read,   :includes => [:index, :show]
    privilege :create, :includes => :new
    privilege :update, :includes => :edit
    privilege :delete, :includes => :destroy
  end