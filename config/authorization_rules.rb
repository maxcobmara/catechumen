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
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules],  :to => :manage   #Professional Development
    has_permission_on :ptdos, :to => :manage
    #status & movement
    has_permission_on [:travel_requests, :travel_claims], :to => :manage
    #reports
    
    #Asset Menu Items
    has_permission_on :assets,      :to => :manage                              #asset items
    has_permission_on :asset_loans, :to => [:manage, :approve, :lampiran]
    has_permission_on :asset_disposals, :to =>[ :manage, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :revalue, :dispose]
    
    #Location Menu Items
    has_permission_on :locations,   :to => :manage                              #location items
    
    #E-Filing Menu Items
    has_permission_on :documents, :to => [:manage, :generate_report]                 #e-filing items
    has_permission_on :events, :to => [:manage, :calendar]
    
    #Student Menu Items
    #has_permission_on :students,        :to => [:manage, :formforstudent, :maklumat_pelatih_intake]
    has_permission_on [:leaveforstudents],  :to => [:manage, :approve_coordinator, :approve_warden]
    
    #Exam Menu Items
    has_permission_on :examquestions,   :to => :manage
    
    #Training Menu Items
    has_permission_on :programmes, :to => :manage
    has_permission_on :timetables, :to => :manage
    has_permission_on :weeklytimetables, :to => :manage
    has_permission_on :trainingnotes, :to => :manage
    has_permission_on :evaluate_courses, :to => :manage
    
    #Library Menu Items
    has_permission_on [:librarytransactions, :books], :to => :manage
    
    #Administration Menu Items
    has_permission_on [:users, :roles, :pages],  :to => :manage #stuff in admin menu
    
    #Equery Menu Items
    has_permission_on :staffsearch2s, :to => :read
    has_permission_on :staffattendancesearches, :to => :read
    has_permission_on :assetsearches, :to => :read
    has_permission_on :documentsearches, :to => :read
    has_permission_on :studentsearches, :to => :read
    has_permission_on :studentattendancesearches, :to => :read
    has_permission_on :studentdisciplinesearches, :to => :read
    has_permission_on :studentcounselingsearches, :to => :read
    has_permission_on :weeklytimetablesearches, :to => :read
    has_permission_on :curriculumsearches, :to => :read
    has_permission_on :lessonplansearches, :to => :read
    has_permission_on :personalizetimetablesearches, :to => :read
    has_permission_on :examsearches, :to => :read
    has_permission_on :examresultsearches, :to => :read
    has_permission_on :evaluatecoursesearches, :to => :read
    has_permission_on :examanalysissearches, :to => :read
    has_permission_on :booksearches, :to => :read
    has_permission_on :librarytransactionsearches, :to => :read
    has_permission_on :stationerysearches, :to => :read
    has_permission_on :ptdosearches, :to => :read
  end
  
  
  #Group Staff
  
  role :staff do
    has_permission_on :authorization_rules, :to => :read
    has_permission_on [:attendances, :documents],     :to => :menu              # Access for Menus
    has_permission_on :assets, :to => [:menu, :loanables]                              # Access for Menus, items available for loans
    has_permission_on :books, :to => :core
    has_permission_on :ptdos, :to => :create
    has_permission_on :ptdos, :to => :index do 
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :ptschedules, :to => :apply
    
    has_permission_on :staffs, :to => [:show, :menu]
    has_permission_on :staffs, :to => [:edit, :update, :menu, :borang_maklumat_staff] do
      if_attribute :id => is {Login.current_login.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
        if_attribute :approve_id => is {Login.current_login.staff_id}
    end
    
    has_permission_on :staff_appraisals, :to => :create
    has_permission_on :staff_appraisals, :to => [:manage, :appraisal_form], :join_by => :or do 
        if_attribute :staff_id => is {Login.current_login.staff_id}
        if_attribute :eval1_by => is {Login.current_login.staff_id}
        if_attribute :eval2_by => is {Login.current_login.staff_id}
    end
    
    has_permission_on :leaveforstaffs, :to => :create
    has_permission_on :leaveforstaffs, :to => [:index, :show, :edit, :update] do
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve1, :update] do
        if_attribute :approval1_id => is {Login.current_login.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:index, :show, :approve2, :update] do
        if_attribute :approval2_id => is {Login.current_login.staff_id}
    end
    has_permission_on :ptdos, :to => [:delete, :show_total_days] do
        if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    
    has_permission_on :travel_claims, :to => :create
    has_permission_on [:travel_claims, :travel_claim_allowances, :travel_claim_receipts, :travel_claim_logs], :to => [:index, :show, :update, :claimprint]do 
        if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    
    has_permission_on :asset_defects, :to => :create
    has_permission_on :asset_defects, :to => [:read, :update]  do
        if_attribute :reported_by => is {Login.current_login.staff_id}
    end
    has_permission_on :asset_defects, :to => [:manage]  do
        if_attribute :decision_by => is {Login.current_login.staff_id}
    end
    
    has_permission_on :locations, :to => :read
    
    has_permission_on :events, :to => [:create, :read, :calendar]
    has_permission_on :events, :to => :update do
      if_attribute :createdby => is {Login.current_login.staff_id}
    end
    has_permission_on :bulletins, :to => :read
    
    has_permission_on :documents, :to => [:approve,:menu], :join_by => :or do 
        if_attribute :stafffiled_id => is {Login.current_login.staff_id}
        if_attribute :cc1staff_id => is {Login.current_login.staff_id}
        if_attribute :cc2staff_id => is {Login.current_login.staff_id}
    end
   
    has_permission_on :student_discipline_cases, :to => :create
    has_permission_on :student_discipline_cases, :to => :approve do
      if_attribute :assigned_to => is {Login.current_login.staff_id}
    end
    has_permission_on :student_discipline_cases, :to => :manage do
      if_attribute :assigned2_to => is {Login.current_login.staff_id}
    end
    has_permission_on :student_discipline_cases, :to => :read, :join_by => :or do
      if_attribute :reported_by => is {Login.current_login.staff_id}
      if_attribute :assigned_to => is {Login.current_login.staff_id}
      if_attribute :assigned2_to => is {Login.current_login.staff_id}
    end

#     has_permission_on :librarytransactions, :to => :read do
#       if_attribute :staff_id => is {Login.current_login.staff_id}
#     end
    has_permission_on :librarytransactions, :to => :analysis_statistic
    
    has_permission_on :asset_loans, :to => [:read, :update, :approve, :lampiran] do
      if_attribute :loaned_by => is_in {AssetLoan.find(asset_id).unit_members}
    end
    has_permission_on :asset_loans, :to => :create
    has_permission_on :asset_disposals, :to =>[ :read, :update, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19] do
      if_attribute :verified_by => is {Login.current_login.staff_id}
    end

    #TODO : Set permissions on HOD, Set Notifications and only enable HOD to view when done (as in asset_losses/_endorse_hod)
    has_permission_on :asset_losses, :to => [:read, :kewpa28] do  #  :edit,:update, 
      if_attribute :endorsed_hod_by => is {Login.current_login.staff_id}
    end
    
    has_permission_on :asset_losses, :to => [:kewpa30, :kewpa31], :join_by => :and do  
      if_attribute :endorsed_hod_by => is {Login.current_login.staff_id}
      if_attribute :is_submit_to_hod => true
    end
  end
  
  role :staffs_module do
     has_permission_on :student_discipline_cases, :to =>[ :index, :read]
  end
  
  role :staff_administrator do
     has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff]
     has_permission_on :attendances, :to => :manage
     has_permission_on :staff_attendances, :to => :manage   #29Apr2013-refer routes.rb
     has_permission_on :staffsearch2s, :to => :read
     has_permission_on :staffattendancesearches, :to => :read
     has_permission_on :positions, :to => [:manage, :maklumat_perjawatan_LA]
  end
  
  role :finance_unit do
    has_permission_on [:travel_claims, :travel_claim_allowances, :travel_claim_receipts, :travel_claim_logs], :to => [:manage, :check, :approve, :claimprint]
    has_permission_on :ptbudgets, :to => :manage
  end
  
  role :training_manager do
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules], :to => :manage
    has_permission_on :ptdos, :to =>:approve
    has_permission_on :ptdosearches, :to => :read
  end
  
  role :training_administration do
    has_permission_on [:ptbudgets, :ptcourses, :ptschedules], :to => :manage
    has_permission_on :ptdos, :to =>:approve #do
      #if_attribute :staff_id => is_not_in {Login.current_login.staff.unit_members}  #En Zahar can't see Fazrina's ptdo at all in index
    #end
    has_permission_on :ptdosearches, :to => :read
  end
  
  #Group Assets  -------------------------------------------------------------------------------
  role :asset_administrator do
    has_permission_on :assets, :to => :manage
    has_permission_on :asset_defects, :to =>[:manage, :kewpa9] #3nov2013
    has_permission_on :assetsearches, :to => :read
    has_permission_on :locations, :to => [:manage, :kewpa7]
    has_permission_on :stationeries, :to => [:manage, :supplies]
    has_permission_on :stationerysearches, :to => :manage
    has_permission_on :asset_loans, :to=>[:manage, :approve, :lampiran]
    has_permission_on :asset_disposals, :to =>[ :manage, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :revalue, :dispose]
    has_permission_on :asset_losses, :to => [:manage, :kewpa28, :kewpa30, :kewpa31, :edit_multiple, :update_multiple] 
  end

  
  #Group Locations  -------------------------------------------------------------------------------
  role :facilities_administrator do
    has_permission_on :locations, :to => [:manage, :indextree]
    has_permission_on :tenants, :to => :manage
  end
  
  role :warden do
    has_permission_on :locations, :to => :read #:core
    has_permission_on :tenants, :to => :read #:manage
    has_permission_on :students, :to => [:menu, :show, :formforstudent]
    #has_permission_on :student_attendances, :to => :read #override by role: lecturer - but not ok if commonsubject lecturer is also a warden
    #all wardens have access - [relationship: second_approver, FK: staff_id2, page: aptdprove_warden]
    has_permission_on :leaveforstudents, :to => [:index,:create, :show, :update, :approve_warden] do
      if_attribute :studentsubmit => true
    end
    #both-below not ok in Ogma
    #has_permission_on :student_discipline_cases, :to => :read  #when activated, syst running correctly but permission checking fail (icon display)in Index not ok
    #has_permission_on :student_counseling_sessions, :to => :read 
  end
  
  #Group E-Filing ------------------------------------------------------------------------------- 
  role :e_filing do
    has_permission_on :cofiles, :to => :manage
    has_permission_on :documents, :to => [:manage, :generate_report] #do
        #if_attribute :prepared_by => is {Login.current_login.staff_id}
        #if_attribute :stafffiled_id => is {Login.current_login.staff_id}
    #end
    has_permission_on :documentsearches, :to => :read
  end
  
  #Group Student --------------------------------------------------------------------------------
  role :student do
    
      has_permission_on :locations, :to => :menu
      
      has_permission_on :tenants, :to => :read do
        if_attribute :student_id => is {Login.current_login.student_id}
      end
      
      #has_permission_on :student_counseling_sessions, :to => :create
      #has_permission_on :student_counseling_sessions, :to => :show do
        #if_attribute :student_id => is {Login.current_login.student_id}
      #end
    
      has_permission_on :trainingnotes, :to => :menu
      has_permission_on :books, :to => :core
      has_permission_on :students, :to => [:read, :update, :menu, :show, :formforstudent] do
        if_attribute :student_id => is {Login.current_login.student_id}
      end
      has_permission_on :leaveforstudents, :to => [:read, :update, :menu] do
        if_attribute :student_id => is {Login.current_login.student_id}
      end
      has_permission_on :leaveforstudents, :to => [:create]
      has_permission_on :evaluate_courses, :to => :create
      has_permission_on :evaluate_courses, :to => [:read, :update, :courseevaluation] do
        if_attribute :student_id => is {Login.current_login.student_id}
      end
  end
  
  role :student_administrator do
     has_permission_on :students, :to => [:manage, :formforstudent, :maklumat_pelatih_intake, :ethnic_listing]
     has_permission_on :studentsearches, :to => :read
  end
  
  role :disciplinary_officer do
    has_permission_on :student_discipline_cases, :to => :manage
    has_permission_on :student_counseling_sessions, :to => :feedback_referrer
    has_permission_on :studentdisciplinesearches, :to => :read    
  end
  
  role :student_counsellor do
    has_permission_on :student_counseling_sessions, :to => [:manage, :feedback_referrer]
    has_permission_on :students, :to => :core
    has_permission_on :studentcounselingsearches, :to => :read
  end
  
  #Group Training  -------------------------------------------------------------------------------

  role :programme_manager do
    has_permission_on :programmes, :to => :manage
    has_permission_on :timetables, :to => :manage#:to => [:index, :show, :edit, :update, :menu, :calendar]
    has_permission_on :intakes, :to => :manage
    has_permission_on :topics, :to => :manage
    has_permission_on :weeklytimetables, :to => :read 
    has_permission_on :weeklytimetables, :to => :update do #:manage #21March2013 added
      if_attribute :endorsed_by => is {Login.current_login.staff_id}
    end
    has_permission_on :ptdos, :to => :approve do
      if_attribute :staff_id => is_in {Login.current_login.staff.unit_members}
    end
    has_permission_on :evaluate_courses, :to => [:read, :courseevaluation] do
      if_attribute :course_id => is_in {Position.my_programmeid(Login.current_login.staff_id)} # is_in {[5]}
    end
    has_permission_on :evaluatecoursesearches, :to => :manage
  end
#--21march2013-new role added  
  role :coordinator do
#     has_permission_on :programmes, :to => :manage
#     has_permission_on :timetables, :to => :manage
#     #below - manage or just edit, update (can approve?), Penyelaras Kumpulan (of each Intake, of each Programme)
#     has_permission_on :weeklytimetables, :to => :manage do
#       if_attribute :prepared_by => is {Login.current_login.staff_id}
#     end
    #all above removed to role : lecturer
    has_permission_on :curriculumsearches, :to => :read
 end
#--21march2013-new role added    
#note for Coordinator : previously, this role is required for Penyelaras Kumpulan to manage :(1) programme, timetable, weeklytimetable.(just tick role),
#but no exact group/restrict which group to manage.
 
#but for 'leaveforstudents', need to specify the exact group to manage - use 'tasks_main' field in Positions table.
  role :lecturer do
    
    #restricted access for penyelaras - [relationship: approver, FK: staff_id, page: approve], in case of non-exist of penyelaras other lecturer fr the same programme
    has_permission_on :leaveforstudents, :to => [:index,:create, :show, :update, :approve_coordinator], :join_by => :and do
      if_attribute :studentsubmit => true
      if_attribute :student_id => is_in {Login.current_login.staff.under_my_supervision}
    end
    
    has_permission_on :examquestions, :to => :manage
    
    has_permission_on :students, :to => [:menu, :index, :show, :formforstudent]
    has_permission_on :student_attendances, :to => :create
    has_permission_on :student_attendances, :to => :manage do
      if_attribute :weeklytimetable_id => is_in {Login.current_login.classes_taughtby}
    end
    
    #TRAININGs - START
#     has_permission_on :timetables, :to => [:index, :show, :edit, :update, :menu, :calendar] do
#       if_attribute :staff_id => is {Login.current_login.staff_id}
#     end   
    has_permission_on :programmes, :to => :read
    has_permission_on :topics, :to => :manage
    
    #HACK : restrict commonsubject lecturer fr accessing in menu, but gives programme/postbasic lecturer access (if they ARE in prepared_by(WTs) or staff_id(Intakes))
    has_permission_on [:timetables, :intakes], :to => :manage

    has_permission_on :trainingreports, :to => :manage, :join_by => :or do
      if_attribute :staff_id => is {Login.current_login.staff_id}
      if_attribute :tpa_id => is {Login.current_login.staff_id}
    end
    Programme
    #HACK : weeklytimetables - CREATE restricted in Index (if exist in Intakes)
     has_permission_on :weeklytimetables, :to => [:read, :update] , :join_by => :or do
       if_attribute :prepared_by => is_in {Login.current_login.staff_id} 
       if_attribute :intake_id => is_in {Intake.find(:all, :conditions => ['staff_id=?', Login.current_login.staff_id]).map(&:id)} #should include those being coordinate by me
     end
    
    has_permission_on :weeklytimetables, :to => :personalize_index do
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end

#removed to Unit Leader role    
#     #giving full access to Pengajar Subjek Asas on Weeklytimetable (of ALL programmes) - refer authorization rules under LECTURER role
#     #related to this comment (1) 2.1.2 Student Attendance, item no.3, (2) 2.3.1 Scheduling, comment no.11 (part B)
#     has_permission_on :weeklytimetables, :to => [:read, :update] do
#       if_attribute :programme_id => is_in {Login.current_login.staff.commonsubject_lecturer_programmeid_list}
#     end

    #from Ogma
    has_permission_on :trainingnotes, :to => :manage, :join_by => :or do
     if_attribute :topicdetail_id => is_in {Login.current_login.topicdetails_of_programme}
     if_attribute :timetable_id => is_in {Login.current_login.timetables_of_programme} 
    end
    
    has_permission_on :trainingnotes, :to => :manage, :join_by => :and do
      if_attribute :topicdetail_id => is {nil}
      if_attribute :timetable_id => is {nil}
    end
    #TRAININGs - END
    
    has_permission_on :studentsearches, :to => :read
    has_permission_on :studentattendancesearches, :to => :read
    has_permission_on :weeklytimetablesearches, :to => :read
    has_permission_on :lessonplansearches, :to => :read
    has_permission_on :personalizetimetablesearches, :to => :read
    has_permission_on :examsearches, :to => :read
    has_permission_on :examresultsearches, :to => :read
    has_permission_on :examanalysissearches, :to => :read
  end
  
  
  #Group Exams   -------------------------------------------------------------------------------
  
  #Group Library   -------------------------------------------------------------------------------
  
  role :librarian do
    has_permission_on :books, :to => [:manage, :extend, :return]
    has_permission_on :librarytransactions , :to => [:manage, :extend, :extend2,:return,:return2, :check_availability, :form_try, :multiple_edit,:check_availability2,:multiple_update]#,:accession_list]  
    has_permission_on :students, :to => [:index, :show, :formforstudent]
    has_permission_on :booksearches, :to => :read
    has_permission_on :librarytransactionsearches, :to => :read
    has_permission_on :photos, :to => :manage
  end 
  
  role :guest do
    has_permission_on :users, :to => :create
    has_permission_on :books, :to => :core
  end
  
  role :unit_leader do
    has_permission_on :ptdos, :to => :approve do
      if_attribute :staff_id => is_in { Login.current_login.staff.unit_members}
    end
    #giving full access to Pengajar Subjek Asas on Weeklytimetable (of ALL programmes) - refer authorization rules under LECTURER role
    #related to this comment (1) 2.1.2 Student Attendance, item no.3, (2) 2.3.1 Scheduling, comment no.11 (part B)
    has_permission_on :weeklytimetables, :to => [:read, :update] do
      if_attribute :programme_id => is_in {Login.current_login.staff.commonsubject_lecturer_programmeid_list}
    end
  end
  
  role :administration_staff do
    has_permission_on :ptdos, :to => :approve do
      if_attribute :staff_id => is_in { Login.current_login.staff.admin_subordinates}
    end
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