authorization do
  
  role :administration do
    #Staff Menu Items
    has_permission_on :staffs,             :to => [:manage,:borang_maklumat_staff]        #Staff Information
    has_permission_on :attendances,        :to => [:manage, :approve, :kedatangan_harian] #Staff Attendance
    has_permission_on :evaluate_coaches,   :to => [:manage, :penilaijurulatih, :report_evaluate_instructor]            #Instructor Appraisal
    has_permission_on :evaluate_lecturers, :to => [:manage, :penilaipensyarah] #Lecturer Appraisal
    has_permission_on :positions,          :to => [:manage, :maklumat_perjawatan_LA] #Task & Responsibilities
    has_permission_on :leaveforstaffs,     :to => [:manage, :approve1, :approve2, :leavefourhours, :cuti_rehat,:laporan_cuti] #Staff Leave
    has_permission_on :bookingvehicles,    :to => [:manage, :endorse, :approve, :vehicle_form] #Staff Claim Submission / Bookingvehicle
    has_permission_on :travelrequests,     :to => [:manage, :approve, :travelrequest_form] #Staff Claim Submission / Travelrequest
    has_permission_on :travelclaims,       :to => [:manage, :claimprint] #Staff Claim Submission 
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules, :ptdos],  :to => :manage   #Professional Development
    
    #Asset Menu Items
    has_permission_on :suppliers,          :to => [:manage, :card_stock] #Office Supplies
    has_permission_on :stocks,             :to => [:manage, :kewpa11] #Stock Application
     
                            
    #Location Menu Items
    has_permission_on :locations,          :to => :manage #Location Management
    has_permission_on :tenants,            :to => [:manage, :borang_asrama, :borang_kuarter] #Tenants   
    has_permission_on :bookingfacilities,  :to => [:manage, :bookingfacility]  #Booking Facilities                        
    
    #E-Filing Menu Items
    has_permission_on [:events, :bulletins, :messages],        :to => :manage #Events, Bulletin Board, Local Messaging
    has_permission_on :cofiles,                                :to => :manage #File Registry
    has_permission_on :documents,                              :to => [:manage, :delete, :edit, :action1, :action2]  #Document Management                        
    
    #Student Menu Items
    has_permission_on :students,                               :to => [:manage, :formforstudent] #Student Information
    has_permission_on :leaveforstudents,                       :to => [:manage, :approve,  :borang_cuti_pelatih]#Student Leave
    has_permission_on [:studentattendances, :sdiciplines, :counsellings, :mentors],    :to => :manage #Student Attendance,Dicipline,Counselling,Mentor-Mentee 
    
    #Exam Menu Items
    has_permission_on :examquestions,   :to => :manage  #Examinations Question Bank
    
    #Training Menu Items
    has_permission_on [:programmes, :subjects, :topics, :trainingnotes, :klasses],  :to => :manage #Programe, Subject, Topic, Training Note, Student & Class 
    has_permission_on :timetables, :to => [:manage, :calendar]
    
    #Library Menu Items
    has_permission_on [:librarytransactions, :books], :to => [:manage, :report_overdue] #Library Catalog, Library Transactions 
    
    #Administration Menu Items
    has_permission_on [:users, :roles, :pages],  :to => :manage #User, Roles
  end
  
# Staff
  role :staff do
    
	#Staff Information
    has_permission_on [:staffs, :students, :downloads], :to => [:show,:menu] 
    
    has_permission_on :staffs, :to => [:edit, :update, :borang_maklumat_staff] do 
      if_attribute :id => is {User.current_user.staff_id}
    end
    
	#Staff Attendance
    
    has_permission_on :attendances, :to => [:create]
     
    has_permission_on :attendances, :to => [:read, :create] do  # Apply Leave
        if_attribute :staff_id => is {User.current_user.staff_id}
    end

    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do   #Approver
        if_attribute :approve_id => is {User.current_user.staff_id}
    end
    

	# Staff Leave
    has_permission_on :leaveforstaffs, :to => [:create, :edit, :update, :leavefourhours, :cuti_rehat,:delete] do #Applicant
        if_attribute :staff_id => is {User.current_user.staff_id}
    end
    
    has_permission_on :leaveforstaffs, :to => [:approve1, :edit, :delete] do # Endorser
      if_attribute :approval1 => is {User.current_user.staff_id}
    end
    
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve2] do # Approver
      if_attribute :approval2 => is {User.current_user.staff_id}
    end
    
    
	#Booking Office Vehicle
    
     has_permission_on :bookingvehicles, :to => [:index, :show, :vehicle_form, :create, :update, :delete] do  # Applicant
          if_attribute :applicant => is {User.current_user.staff_id}
     end

     has_permission_on :bookingvehicles, :to => [:index, :show, :endorse, :delete] do # Endorser
            if_attribute :endorse_name => is {User.current_user.staff_id}
      end

      has_permission_on :bookingvehicles, :to => [:index, :show, :approve, :delete] do # Approver
          if_attribute :approver_name => is {User.current_user.staff_id}
      end
      
	#Travel Request
      has_permission_on :travelrequests, :to => [:show, :create, :update, :delete, :travelrequest_form] do  # Applicant
          if_attribute :staff_id => is {User.current_user.staff_id}
     end
     
      has_permission_on :travelrequests, :to => [:show, :update, :delete, :approve, :travelrequest_form] do  # Approver
           if_attribute :hod_id => is {User.current_user.staff_id}
      end
    
	#Travel Claim
      has_permission_on :travelclaims, :to => [:index, :show, :create, :update, :claimprint] do  # Applicant
        if_attribute :staff_id => is {User.current_user.staff_id}
      end
      
      has_permission_on :travelclaims, :to => [:index, :show, :create, :update, :delete, :claimprint] do  # Applicant
        if_attribute :hod_id => is {User.current_user.staff_id}
      end
    
      
	# Professional Development
      has_permission_on [:ptdos, :ptschedules], :to => [:create, :delete, :apply, :show, :update, :index] do       # Applicant Training
          if_attribute :staff_id => is {User.current_user.staff_id}
      end

      has_permission_on :ptdos, :to => [:index, :approve1] do     # Approver 1
          if_attribute :approver_1 => is {User.current_user.staff_id}
      end

      has_permission_on :ptdos, :to => [:index, :approve2, :show, :update] do            # Approver2
          if_attribute :approver_2 => is {User.current_user.staff_id}
      end
    
	# Stock Application
     has_permission_on :suppliers, :to => [:show,:menu]
     
      has_permission_on :stocks, :to => [:create, :kewpa11, :update, :delete] do  # Applicant
          if_attribute :staff_id => is {User.current_user.staff_id}
      end
      
      has_permission_on :stocks, :to => [:index, :show, :approve, :delete, :kewpa11] do # Approver
          if_attribute :approver_id => is {User.current_user.staff_id}
      end
      
      has_permission_on :stocks, :to => [:index, :show, :store, :kewpa11] do # Storeman
          if_attribute :storeman_id => is {User.current_user.staff_id}
      end
      
	# Reservation Facility
     has_permission_on :locations, :to => [:show,:menu]
     
    	has_permission_on :bookingfacilities, :to => [:read, :create, :edit, :update, :delete, :bookingfacility] do # Applicant
    		  if_attribute :staff_id => is {User.current_user.staff_id}
    	end 

    	has_permission_on :bookingfacilities, :to => [:approve] do  # Approver
    		  if_attribute :approver_id => is {User.current_user.staff_id}
    	end 

    	has_permission_on :bookingfacilities, :to => [:facility, :bookingfacility] do  # Facility Officer
    		if_attribute :facility_officer => is {User.current_user.staff_id}
    	end
    	
	# File Registry (Loan File)
      has_permission_on :pages, :to => [:index, :menu]  # Facility Officer
  		has_permission_on :cofiles, :to => :index  
    
    
	#Documents Management
    
    has_permission_on :documents, :to => [:menu, :create] 
    
    has_permission_on :documents, :to => [:action1, :edit, :delete, :feedback] do 
      if_attribute :cc1staff_id => is {User.current_user.staff_id}
    end
      
    has_permission_on :documents, :to => [:action2, :edit, :delete] do 
      if_attribute :cc2action => nil
    end
   
 
    
  #Student Dicipline
    has_permission_on :sdiciplines, :to => [:index, :show, :create, :update] do 
      if_attribute :staff_id => is {User.current_user.staff_id}
    end

  end

role :head_officer do
    has_permission_on :users, :to => :create
    has_permission_on :books, :to => :core
    has_permission_on :instructors,   :to => [:menu, :show] 
	  has_permission_on :examquestions, :to => [:menu, :show]
	  has_permission_on :locations, :to => [:menu, :show]
	  has_permission_on :grades, :to => [:menu, :show]
	  has_permission_on :analysis_grades, :to => [:menu, :show, :analysis_form]
	  has_permission_on [:programmes, :timetables], :to => [:menu, :show]
end
  
  # Staff Administration
  role :staff_administrator do
     
# Staff Information
     has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff]  
     
# Events, Bulletins, Campus Info
     has_permission_on :pages, :to => [:show,:menu]
     has_permission_on [:events, :bulletins, :pages], :to => :manage
     
     has_permission_on :leaveforstaffs, :to => [:index, :show, :update, :destroy, :office, :cuti_rehat, :leaveforhours] do
       if_attribute :submit => true
     
     
     end
  end
  
  # Asset Administrator
    role :asset_administrator do
      
# Suppliers
      has_permission_on :suppliers,          :to => [:manage, :card_stock] 
    end
  
# Training Manager
   role :training_manager do
     has_permission_on [:ptbudgets, :ptcourses], :to => :manage
   end

# Training Administration
   role :training_administration do
    # has_permission_on :ptschedules, :to => :manage
     has_permission_on :ptbudgets, :to => :manage
	   has_permission_on :timetables, :to => :manage
	   has_permission_on :ptdo, :to => :manage
   end
   
   role :file_administration do
     has_permission_on :pages, :to => [:show,:menu]
     
# File Registry
     has_permission_on :cofiles, :to => [:manage, :update, :delete]
     has_permission_on :documents, :to => [:update, :delete, :create]
   end
  
# Students
role :student do
 # has_permission_on :examquestions, :to => [:show,:menu]
  
 # has_permission_on :staffs, :to => [:read, :menu]
  has_permission_on [:students, :programmes, :timetables,:books,:librarytransactions], :to => :menu
  
# Student Information  
  has_permission_on :students, :to => [:index, :read, :update, :create, :formforstudent] do
    if_attribute :id => is {User.current_user.student_id}
  end
   
# Student Leave 
  has_permission_on :leaveforstudents, :to => [:create, :index, :show] 
  
# Mentor Mentee 
  has_permission_on :mentors, :to => [:show] 
  
# Lecturer Appraisal   
  
  has_permission_on :evaluate_lecturers, :to => [:read, :update, :show, :create] do
      if_attribute :student_id => is {User.current_user.student_id}
  end
   
end
  
# Student Administration
  role :student_administrator do
    
     # Student Information
     has_permission_on :students, :to => [:manage, :formforstudent]  
end
  
# Mentor
  role :mentor do
    
    # Student Discipline
    has_permission_on :sdiciplines, :to => [:manage] do
       if_attribute :mentor_id => is {User.current_user.staff_id}
     end   
     
  end
  
# Quality Control
 role :quality_control do
    has_permission_on :students, :to => :menu
    
   # Lecturer Appraisal
   has_permission_on :evaluate_lecturers, :to => [:menu, :show, :penilaipensyarah] 
   
   # Instructor Appraisal
   #has_permission_on :evaluate_coaches, :to => [:manage, :penilaijurulatih] 
  
   # Examination Question Bank
   has_permission_on :examquestions, :to => :manage 
   
   has_permission_on :instructors, :to => :manage 
   
   # Examination Maker 
  # has_permission_on :exammakers, :to => :manage
   
   # Examination Grading
   has_permission_on :grades, :to => :index  
   
   # Analysis Result Exam
   has_permission_on :analysis_grades, :to => [:menu, :index, :analysis_form]  
end

#Exam Maker
  role :exammaker do
    
    # Examination Paper
    has_permission_on :exammakers, :to => :manage
end  
 
#Facilities Administrator
  role :facilities_administrator do
    
    # Location Management & Tenants
    has_permission_on [:locations, :tenants], :to => :manage
end
  
  
# Principal
  role :principal do
  has_permission_on :students, :to => [:read, :menu]
  
  
  
  # Mentor Mentee
  has_permission_on :mentors, :to => :manage
  end
  
# Lecturer
  role :lecturer do
     has_permission_on :programmes, :to => [:read, :menu]
	 
    # Student Attendances
    has_permission_on  :studentattendances, :to => :manage  
    
    # Student Topic
    has_permission_on [:topics, :trainingreports, :training_notes],  :to => :manage
    
    # Timetable / Schedulling
    # has_permission_on :timetables, :to => [:create, :index, :show, :edit, :update, :menu, :calendar] 
    
    # Instructor Appraisal
     has_permission_on :instructors, :to => [:menu, :index, :create, :edit, :update, :delete]  do #Applicant
         if_attribute :staff_id => is {User.current_user.staff_id}
     end
     
    # Examination Question Bank
    has_permission_on :examquestions, :to =>  [:index, :show, :edit, :update, :manage, :analysis_form] do  
           if_attribute :creator_id => is {User.current_user.staff_id}
    end
    
    # Examination Grading 
    has_permission_on :grades, :to => [:create, :delete, :update, :show, :manage]  
    
    # Analysis Result Exam
    has_permission_on :analysis_grades, :to => [:index, :show, :edit, :update, :manage] do     
       if_attribute :staff_id => is {User.current_user.staff_id}
     end        
end

# Academic Administration
  role :academic_administration do
  has_permission_on :programmes, :to => [:read, :menu]
  
  # Cources & Subject
   has_permission_on [:programmes, :subjects], :to => [:manage] 
  # Classes & Students
    has_permission_on :klasses, :to => [:create, :delete, :update, :show, :manage] 
end
	
# Librarian
role :librarian do
    # Library Catalog Book
    has_permission_on :books, :to => [:manage, :update, :delete]
    
    # Library Transaction 
    has_permission_on :librarytransactions, :to => :manage  
  end 
  
# student_counsellor
role :student_counsellor do
   has_permission_on :students, :to => :core
   # Student Counselling
   has_permission_on :counsellings, :to => :manage
   
end  
  
role :warden do
    # has_permission_on :locations, :to => :core
    has_permission_on :students, :to => :core
    has_permission_on :sdiciplines, :to => :manage do
      if_attribute :warden_id => is {User.current_user.staff_id}
    end  
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