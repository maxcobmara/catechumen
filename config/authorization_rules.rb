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
    has_permission_on [:examquestions, :exams, :exammarks, :grades, :examresults, :examanalyses, :evaluate_courses],  :to => :manage
   
    #Training Menu Items
    has_permission_on :programmes, :to => :manage
    has_permission_on :timetables, :to => :manage
    has_permission_on :intakes, :to => :manage
    has_permission_on :academic_sessions, :to => :manage
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
    has_permission_on :assets, :to => [:read, :loanables]                              # Access for Menus, items available for loans
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
#     has_permission_on :attendances, :to => [:index, :show, :new, :create, :edit, :update] do
#       if_attribute :staff_id => is {Login.current_login.staff_id}
#     end
#     has_permission_on :attendances, :to => [:index, :show, :approve, :update] do
#         if_attribute :approve_id => is {Login.current_login.staff_id}
#     end

    #applicable for all staff for OWN record, BUT for approval - use Unit Leader, Programme Manager or Administration Staff role accordingly.
    has_permission_on :staff_attendances, :to => :manager                                  
    has_permission_on :staff_attendances, :to => [:show, :update] do                                         # show & update - to enter reason
      if_attribute :thumb_id => is {Login.current_login.staff.thumb_id}
    end
    has_permission_on :fingerprints, :to => [:read, :update] do                                   
      if_attribute :thumb_id => is {Login.current_login.staff.thumb_id}
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

    #restrictions between applicant & approver done in Edit page
    has_permission_on :travel_requests, :to => [:menu, :create, :travel_log_index]
    has_permission_on :travel_requests, :to => [:read, :update, :travel_log] do                                    #status_movement (PDF form in Ogma)
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :travel_requests, :to => [:read, :update] do
      if_attribute :hod_id => is {Login.current_login.staff_id}
    end

    has_permission_on :travel_claims, :to => :create
    has_permission_on [:travel_claims, :travel_claim_allowances, :travel_claim_receipts, :travel_claim_logs], :to => [:index, :show, :update, :claimprint]do 
        if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :travel_claims, :to => :read, :join_by => :and do
       if_attribute :approved_by => is {Login.current_login.staff_id}
    end
    has_permission_on :travel_claims, :to =>  :update, :join_by => :and do        # Approver may approve if not yet approve (approve=read+update)
      if_attribute :approved_by => is {Login.current_login.staff_id}
      if_attribute :is_checked => is {true}
      if_attribute :is_approved => is_not {true}
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
  
  role :staff_administrator do
     has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff]
     has_permission_on [:titles, :banks], :to => :manage
     #has_permission_on :attendances, :to => :manage
     has_permission_on [:staff_attendances, :staff_shifts], :to => :manage   #29Apr2013-refer routes.rb
     has_permission_on :staffsearch2s, :to => :manage
     has_permission_on :staffattendancesearches, :to => :manage
     has_permission_on [:employgrades, :postinfos], :to => :manage
     has_permission_on :positions, :to => [:manage, :maklumat_perjawatan_LA]
  end
  
  role :finance_unit do
    has_permission_on [:travel_claims, :travel_claim_allowances, :travel_claim_receipts, :travel_claim_logs], :to => [:manage, :check, :approve, :claimprint]
    has_permission_on [:travel_claims_transport_groups, :travel_claim_mileage_rates], :to => :manage
    has_permission_on :ptbudgets, :to => :manage
  end
  
  role :training_manager do
    has_permission_on [:ptbudgets, :ptcourses], :to => :manage
    has_permission_on :ptschedules, :to => [:manage, :organized_course_manager]
    has_permission_on :ptdos, :to =>:approve
    has_permission_on :ptdosearches, :to => :read
  end
  
  role :training_administration do
    has_permission_on [:ptbudgets, :ptcourses], :to => :manage
    has_permission_on :ptschedules, :to => [:manage, :organized_course_manager]
    has_permission_on :ptdos, :to =>:approve #do
      #if_attribute :staff_id => is_not_in {Login.current_login.staff.unit_members}  #En Zahar can't see Fazrina's ptdo at all in index
    #end
    has_permission_on :ptdosearches, :to => :read
  end
  
  #Group Assets  -------------------------------------------------------------------------------
  role :asset_administrator do
    has_permission_on [:assets, :assetcategories], :to => :manage
    has_permission_on :asset_defects, :to =>[:manage, :kewpa9] #3nov2013
    has_permission_on :assetsearches, :to => :manage
    has_permission_on :locations, :to => [:manage, :kewpa7]
    #has_permission_on :stationeries, :to => [:manage, :supplies]
    #has_permission_on :stationerysearches, :to => :manage
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
    has_permission_on :students, :to => :read
    has_permission_on :studentcounselingsearches, :to => :read
  end
  
  #Group Training  -------------------------------------------------------------------------------

  role :programme_manager do
    has_permission_on [:programmes, :timetables, :intakes, :academic_sessions, :topics, :lesson_plans], :to => :manage
    has_permission_on :weeklytimetables, :to => :read 
    has_permission_on :weeklytimetables, :to => :update do #:manage #21March2013 added
      if_attribute :endorsed_by => is {Login.current_login.staff_id}
    end
    has_permission_on [:examresults, :examanalyses], :to => :core
    has_permission_on :ptdos, :to => :approve do
      if_attribute :staff_id => is_in {Login.current_login.staff.unit_members}
    end
    has_permission_on :evaluate_courses, :to => [:read, :courseevaluation] do
      if_attribute :course_id => is_in {Position.my_programmeid(Login.current_login.staff_id)}
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
    #has_permission_on :curriculumsearches, :to => :read
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
    
    #has_permission_on :examquestions, :to => :manage
    has_permission_on :examquestions, :to => [:menu, :create] #[:menu, :read, :index, :create]
    has_permission_on :examquestions, :to => [:read,  :update] do
      if_attribute :programme_id => is_in {Login.current_login.lecturers_programme}
    end
    
    
    has_permission_on :students, :to => [:menu, :index, :show, :formforstudent]
    has_permission_on :student_attendances, :to => :create
    has_permission_on :student_attendances, :to => :manage do
      if_attribute :weeklytimetable_id => is_in {Login.current_login.classes_taughtby}
    end
    
    #TRAININGs - START
#     has_permission_on :timetables, :to => [:index, :show, :edit, :update, :menu, :calendar] do
#       if_attribute :staff_id => is {Login.current_login.staff_id}
#     end   
    
    # TODO - to remove below 2 lines - once access by modules for --> timetables, intakes & academic sessions are added (User other than Programme MGR may use these module access ie. Coordinator, Ketua Subjek, Pos Basic prog Mgr?)
    #HACK : restrict commonsubject lecturer fr accessing in menu, but gives programme/postbasic lecturer access (if they ARE in prepared_by(WTs) or staff_id(Intakes))
    #has_permission_on [:timetables, :intakes], :to => :manage ##academic_sessions too

    # TODO - to remove below 1 line - once access by modules 4 programmes & topic details added (User other than Programme MGR may use these module access ie. Coordinator, Ketua Subjek, Pos Basic prog Mgr?)
    #has_permission_on :topics, :to => :manage

    has_permission_on :programmes, :to => :read 
    
    has_permission_on :lesson_plans, :to => :create
    has_permission_on :lesson_plans, :to => [:read, :update] do
      if_attribute :lecturer => is {Login.current_login.staff_id}
    end
    has_permission_on :lesson_plans, :to => :update, :join_by => :and do
      if_attribute :lecturer => is {Login.current_login.staff_id}
      if_attribute :is_submitted => is_not {true}
    end
    has_permission_on :lesson_plans, :to => [:lesson_plan, :lessonplan_reporting, :lesson_plan_report, :update], :join_by => :and do
      if_attribute :lecturer => is {Login.current_login.staff_id}
      if_attribute :is_submitted => is {true}
      if_attribute :hod_approved => is {true}
      if_attribute :report_submit => is_not {true}
    end
    
    

    has_permission_on :trainingreports, :to => :manage, :join_by => :or do
      if_attribute :staff_id => is {Login.current_login.staff_id}
      if_attribute :tpa_id => is {Login.current_login.staff_id}
    end
 
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
  role :exam_administration do
    has_permission_on [:examquestions, :examresults], :to => :manage
    has_permission_on [:exams, :exammarks, :grades, :examanalyses], :to => :menu
  end
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
  
  ##Access by Modules starts here
  #(CRUD/A), (R/A), (RU/A), (CRUD/O)
  #Admin : can do everything (CRUD/A)
  #Viewer(Read) : can list, print & reports only (R/A)
  #User : can view everything & update data (RU/A)
  #Member(Owner) : should only see his own record & be able to edit it (CRUD/O)
  #####start of Staff Module#######################################
  #1)OK - all 4 - 16Feb2016
  role :staffs_module_admin do
    has_permission_on :staffs, :to => [:manage, :borang_maklumat_staff] #1) OK - if read (for all), Own data - can update / pdf, if manage also OK
  end
  role :staffs_module_viewer do
    has_permission_on :staffs, :to => [:menu, :read, :borang_maklumat_staff]
  end
  role :staffs_module_user do
    has_permission_on :staffs, :to => [:menu, :read, :update, :borang_maklumat_staff]
  end
  role :staffs_module_member do
    has_permission_on :staffs, :to => :menu
    has_permission_on :staffs, :to => [:read, :update, :borang_maklumat_staff] do
      if_attribute :id => is {Login.current_login.staff_id}
    end
  end
  
  #2)OK - all 4 - 16Feb2016, NOTE - activate employgrades & postinfos as well
  role :positions_module_admin do
     has_permission_on :staffsearch2s, :to => :manage
     has_permission_on :positions, :to => [:manage, :maklumat_perjawatan_LA]
     has_permission_on [:employgrades, :postinfos], :to => :manage
  end
  role :positions_module_viewer do
     has_permission_on :staffsearch2s, :to => :manage
     has_permission_on :positions, :to => [:read, :maklumat_perjawatan_LA]
     has_permission_on [:employgrades, :postinfos], :to => :read
  end
  role :positions_module_user do
     has_permission_on :staffsearch2s, :to => :manage
     has_permission_on :positions, :to => [:read, :update, :maklumat_perjawatan_LA]
     has_permission_on [:employgrades, :postinfos], :to => [:read, :update]
  end
  role :positions_module_member do
    has_permission_on :staffsearch2s, :to => :manage
    has_permission_on :positions, :to =>  [:read, :update, :maklumat_perjawatan_LA] do
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on [:employgrades, :postinfos], :to => :read
  end
  
  #3)OK - all 4 - 16Feb2016
  # NOTE - a) Staff Attendance should come with Fingerprints, + support table : StaffShifts
  # NOTE - Staff Attendance in Catechumen is deprecated, should rely on Ogma
  role :staff_attendances_module_admin do
    has_permission_on :staff_attendances, :to => [:manager, :manage]
    has_permission_on :staffattendancesearches, :to => :manage
  end
  role :staff_attendances_module_viewer do
    #1) OK, but if READ only - can only read attendance list for all staff +manage own lateness/early (MANAGER) - as this is default for all staff UNLESS if MANAGE given.
    has_permission_on :staff_attendances, :to =>[:manager, :read]
    has_permission_on :staffattendancesearches, :to => :manage
  end
  role :staff_attendances_module_user do 
    has_permission_on :staff_attendances, :to => [:read, :update, :manager]
    has_permission_on :staffattendancesearches, :to => :manage
  end
  role :staff_attendances_module_member do
    has_permission_on :staffattendancesearches, :to => :manage
    #own records
    has_permission_on :staff_attendances, :to => :manager
    has_permission_on :staff_attendances, :to => [:show, :update] do                        # show & update - to enter reason
      if_attribute :thumb_id => is {Login.current_login.staff.thumb_id}
    end
    #own (approver) #refer Administration Staff role(Timbalans) & Programme Manager
    #own (approver) - refer Unit Leader role
    has_permission_on :staff_attendances, :to => [:approval, :update, :show], :join_by => :or do
      if_attribute :thumb_id => is_in {Login.current_login.admin_unitleaders_thumb}
      if_attribute :thumb_id => is_in {Login.current_login.unit_members_thumb}
    end
  end
 
  #4-OK - all 4 - 16Feb2016
  #4-OK - for read, but manage - requires role: MANAGE for staff_attendances to be activated as well
  #restriction - INDEX - @fingerprints restricted to own record, @approvefingerprints restricted to unit members, BUT INDEX_ADMIN OK
  # NOTE - menu items ONLY requires READ access for all kind of access(Index), keep below to avoid confusion, refer Ogma for actual workable application of access by module
  role :fingerprints_module_admin do
    has_permission_on :fingerprints, :to =>[:manage, :approval, :index_admin]
  end
  role :fingerprints_module_viewer do
    has_permission_on :fingerprints, :to => [:read, :index_admin]
  end
  role :fingerprints_module_user do
    has_permission_on :fingerprints, :to => [:read, :index_admin, :approval, :update]
  end
  role :fingerprints_module_member do
    #own record
    has_permission_on :fingerprints, :to => [:read, :update] do                                   
      if_attribute :thumb_id => is {Login.current_login.staff.thumb_id}
    end
    #own (approver) - Timbalans / HOD - refer Administration Staff roles
    has_permission_on :fingerprints, :to => [:read, :index_admin, :approval, :update] do
      if_attribute :thumb_id => is_in {Login.current_login.admin_unitleaders_thumb}
    end
  end

  #5-OK - all 4 - 17Feb2016
  #5-OK - for read, but for manage with restrictions as of super admin (PYD, PPP, PPK)
  role :staff_appraisals_module_admin do
    has_permission_on :staff_appraisals, :to => [:manage, :appraisal_form]
  end
  role :staff_appraisals_module_viewer do
    has_permission_on :staff_appraisals, :to => [:read, :appraisal_form]
  end
  role :staff_appraisals_module_user do
    has_permission_on :staff_appraisals, :to => [:create, :read, :update, :appraisal_form]
  end
  role :staff_appraisals_module_member do
    has_permission_on :staff_appraisals, :to => :create
    has_permission_on :staff_appraisals, :to => [:manage, :appraisal_form], :join_by => :or do 
        if_attribute :staff_id => is {Login.current_login.staff_id}
        if_attribute :eval1_by => is {Login.current_login.staff_id}
        if_attribute :eval2_by => is {Login.current_login.staff_id}
    end
  end
  
  #6-OK - Member only, other type of access are disable
#   role :staff_leaves_module_admin do
#      has_permission_on :leaveforstaffs, :to => [:manage, :approve1, :approve2]
#   end
#   role :staff_leaves_module_viewer do
#     has_permission_on :leaveforstaffs, :to => :read
#   end
#   role :staff_leaves_module_user do
#     has_permission_on :leaveforstaffs, :to => [:read, :update, :approve1, :approve2]
#   end
  role :staff_leaves_module_member do
    has_permission_on :leaveforstaffs, :to => :create
    has_permission_on :leaveforstaffs, :to => [:read, :edit, :update] do
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:read, :approve1, :update] do
        if_attribute :approval1_id => is {Login.current_login.staff_id}
    end
    has_permission_on :leaveforstaffs, :to => [:read, :approve2, :update] do
        if_attribute :approval2_id => is {Login.current_login.staff_id}
    end
  end
  
  #7-Ogma:OK - 3/4 (Admin, Viewer & User), Member : applicable only for applicant & final approver (To assign user with Finance Check, use 'Finance Unit' role instead, which will disable all type of module access for Travel Claims Module & Training Budget Module)
  #7-Catechumen - , Admin & User not applicable at all, except for Member (access same as Ogma) & Viewer (but NOTE - read only)
  # NOTE Travel Claim should come with Travel Request
  role :travel_claims_module_viewer do
    has_permission_on :travel_claims, :to => :read
  end
  role :travel_claims_module_member do
    #owner
    has_permission_on :travel_claims, :to => :create
    has_permission_on [:travel_claims, :travel_claim_allowances, :travel_claim_receipts, :travel_claim_logs], :to => [:index, :show, :update, :claimprint]do 
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    #own (Final Approver)
    has_permission_on :travel_claims, :to => :approve, :join_by => :and do        # Approver may approve if not yet approve  (approve=read+update)
      if_attribute :approved_by => is {Login.current_login.staff_id}
      if_attribute :is_checked => is {true}
      if_attribute :is_approved => is_not {true}
    end
  end

  #8-OK only for Member
  # NOTE - Restriction as of in Catechumen - INDEX page shall personalize to current user, containing 2 listing ie. 'in_need_of_approval' & 'my_travel_request',
  #whereas Admin, Viewer & User requires listing for ALL travel requests records.????then what's the use of hvg these 3??? Member already enough! to discuss!
  # TODO TODO TODO- To confirm / discuss / revise upon completion of these Auth Rules (access by module : Admin, Viewer, User & Member)
  role :travel_requests_module_admin do
    has_permission_on :travel_requests, :to => [:manage, :travel_log_index, :travel_log]
  end                                                                                                                                                     # Admin - can do everything (restrictions: own recs only)
  role :travel_requests_module_viewer do
    has_permission_on :travel_requests, :to => [:read, :travel_log_index] 
  end                                                                                                                                                     # Viewer - can view everything (restrictions : own recs only)
  role :travel_requests_module_user do
    has_permission_on :travel_requests, :to => [:approve, :travel_log, :travel_log_index]     # NOTE - approve : Read+Update
  end   
  role :travel_requests_module_member do
    #own records
    has_permission_on :travel_requests, :to => [:menu, :create, :travel_log_index]
    has_permission_on :travel_requests, :to => [:read, :update, :travel_log] do                                    #status_movement (PDF form in Ogma)
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    #own (Approver)
    has_permission_on :travel_requests, :to => [:read, :update] do                                    
      if_attribute :hod_id => is {Login.current_login.staff_id}
    end
  end

  #9-OK - 2/4 OK (Manage & User) whereas Viewer & Member access are similar? - 6Feb2016
  # NOTE - for access by 'Training Budget Module'/'Training Courses Module' (Admin/Viewer/User/Member), must activate at least 'Training Attendance Module'(Member/Viewer)
  # NOTE 'Training Budget Module' - Viewer & Member access are similar?, Member (disable) - as records has no ownership data
  role :training_budget_module_admin do
     has_permission_on :ptbudgets, :to => :manage
  end
  role :training_budget_module_viewer do
     has_permission_on :ptbudgets, :to => :read
  end
  role :training_budget_module_user do
     has_permission_on :ptbudgets, :to => [:read, :update]
  end
#   role :training_budget_module_member do
#      has_permission_on :ptbudgets, :to => :read
#   end 

  #10 - 2/4 OK (Manage & Viewer) 
  # NOTE - for access by 'Training Budget Module'/'Training Courses Module' (Admin/Viewer/User/Member), must activate at least 'Training Attendance Module'(Member/Viewer)
  # NOTE 'Training Courses Module' - Viewer & Member access are similar?, Member (disable) - as records has no ownership data
  #10-OK, in show - link 'schedule a course' requires manage for ptschedules
  role :training_courses_module_admin do
     has_permission_on :ptcourses, :to =>:manage
  end
  role :training_courses_module_viewer do
     has_permission_on :ptcourses, :to =>:read
  end
  role :training_courses_module_user do
     has_permission_on :ptcourses, :to =>[:read, :update]
  end
#   role :training_courses_module_member do
#      has_permission_on :ptcourses, :to =>[:read, :update]
#   end
  
  #11 - 2/4 OK (Manage & Viewer) 
  #11-OK - note pending 'Apply for Training' menu link
  # NOTE 'Training Schedule Module' - Viewer & Member access are similar?, Member (disable) - as records has no ownership data
  role :training_schedule_module_admin do
     has_permission_on :ptschedules, :to => [:manage, :apply, :organized_course_manager]
  end
  role :training_schedule_module_viewer do
     has_permission_on :ptschedules, :to => [:read, :participants_expenses]
  end
  role :training_schedule_module_user do
     has_permission_on :ptschedules, :to => [:read, :organized_course_manager, :apply, :update]
  end
#   role :training_schedule_module_member do
#      has_permission_on :ptschedules, :to => [:read, :participants_expenses, :apply, :update]
#   end 

  #12-OK, but 'Show Total Days' restricted to own record only.
  #12 - 3/4 OK (Admin, Viewer & User)
  role :training_attendance_module_admin do
    has_permission_on :ptdos, :to => [:manage, :show_total_days]   
    has_permission_on :ptdosearches, :to => :manage
  end
  role :training_attendance_module_viewer do
     has_permission_on :ptdos, :to => [:read, :show_total_days]
     has_permission_on :ptdosearches, :to => :manage
  end
   role :training_attendance_module_user do
     has_permission_on :ptdos, :to => [:read, :update, :show_total_days]
     has_permission_on :ptdosearches, :to => :manage
  end
  role :training_attendance_module_member do
    has_permission_on :ptdosearches, :to => :manage
    #own record
    has_permission_on :ptdos, :to =>:create
    has_permission_on :ptdos, :to => :index do 
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :ptdos, :to => [:delete, :show_total_days] do
        if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    # NOTE - 'Training Attendance Module' (Member) should come with Programme Manager role(Dept Approval-Academician section) in order to get Dept Approval (Academics) works,
    # NOTE - 'Training Attendance Module' (Member) is not available for Unit Approval(Management) & Department Approval(Timb Pengarah Pengurusan) & Final Approval(Director) - use 'Administration Staff' role instead. 'Administration Staff' role already covers these 3 positions functions in staff Training Attendance
  end
  
  #####end for STAFF modules#######################################
  #####starts of Student's related modules###############################
  
  #13-OK, but note - lecturers & warden has related access rules too, use other user for checking
  #13 - 3/4 OK (Admin, Viewer, User)
  role :student_leaves_module_admin do
     has_permission_on :leaveforstudents, :to => [:manage, :approve_coordinator, :approve_warden]
  end
  role :student_leaves_module_viewer do
     has_permission_on :leaveforstudents, :to => :read
  end
  role :student_leaves_module_user do
     has_permission_on :leaveforstudents, :to => [:read, :approve_coordinator, :approve_warden, :update]
  end
  role :student_leaves_module_member do
    #own records (student)
    has_permission_on :leaveforstudents, :to =>[:menu, :create]
    has_permission_on :leaveforstudents, :to => :read do
      if_attribute :student_id => is {Login.current_login.staff_id}
    end
    # NOTE approver (Warden & Lecturer[penyelaras]) not applicable, activate Warden and / or Lecturer role accordingly
  end
  
  #14-OK, but note - in controller, ':attribute_check => true' only applicable for show, edit, update & destroy of SINGLE record
  #14 - 3/4 OK (Admin, Viewer, User) OK - 8Feb2016
  role :student_attendances_module_admin do
    has_permission_on :student_attendances, :to =>[:manage, :new_multiple, :create_multiple, :edit_multiple, :update_multiple, :borang_kehadiran]
    has_permission_on :studentattendancesearches, :to => :manage
  end
  role :student_attendances_module_viewer do
    has_permission_on :student_attendances, :to =>[:read, :borang_kehadiran]
    has_permission_on :studentattendancesearches, :to => :manage
  end
  role :student_attendances_module_user do
    has_permission_on :student_attendances, :to =>[:read, :update, :edit_multiple, :update_multiple, :borang_kehadiran]
    has_permission_on :studentattendancesearches, :to => :manage
  end
# NOTE - DISABLE(in EACH radio buttons - studentown[1].disabled=true) as the one & only owner of this module is Lecturer, use 'Lecturer' role instead.
#   role :student_attendances_module_member do
#      has_permission_on :studentattendancesearches, :to => :read
#      has_permission_on :student_attendances, :to => [:create, :new_multiple, :new_multiple_intake] do
#        if_attribute :student_id => is_in {Student.where(course_id: Programme.where(name: user.userable.positions.first.unit).first.id).pluck(:id)}
#      end
#      has_permission_on :student_attendances, :to => [:update, :create_multiple, :edit_multiple, :update_multiple, :student_attendan_form] do
#        if_attribute :weeklytimetable_details_id => is_in {WeeklytimetableDetail.where(lecturer_id: user.userable.id).pluck(:id)}
#      end
#   end
    
  #15-OK 
  #15 - 3/4 (Admin, Viewer, User) OK - 8Feb2016
  role :student_counseling_module_admin do
     has_permission_on :student_counseling_sessions, :to => [:manage, :feedback_referrer] 
     has_permission_on :studentcounselingsearches, :to =>  :manage
  end
  role :student_counseling_module_viewer do
     has_permission_on :student_counseling_sessions, :to =>[:read, :feedback_referrer]
     has_permission_on :studentcounselingsearches, :to =>  :manage
  end
  role :student_counseling_module_user do
     has_permission_on :student_counseling_sessions, :to =>[:read, :update, :feedback_referrer]
     has_permission_on :studentcounselingsearches, :to =>  :manage
  end
# NOTE - DISABLE(in EACH radio buttons - studentown[2].disabled=true) as the one & only owner of this module is Counsellor, use 'Student Counsellor' role instead.  
#   role :student_counseling_module_member do
#   end

  #16-OK - 1) for READ & Manage, note 'discipline_report' & 'anacdotal_report' accessibility is same as INDEX pg, 2) New - open for all staff
  #3) additional report - fr menu, Students | Reporting -- (i) Discipline Case Listing by Students, (ii) Student Discipline Case Listing
  role :student_discipline_module_admin do
     has_permission_on :student_discipline_cases, :to => :manage
     has_permission_on :studentdisciplinesearches, :to => :manage
  end
  role :student_discipline_module_viewer do
     has_permission_on :student_discipline_cases, :to => :read
     has_permission_on :studentdisciplinesearches, :to =>  :manage
  end
  role :student_discipline_module_user do
     has_permission_on :student_discipline_cases, :to => [:read, :update] 
     has_permission_on :studentdisciplinesearches, :to => :manage
  end
  # NOTE workable SELECTION of auth rules for members: (positions data must complete) 
  #1) Reporter, Programme Manager & TPHEP - 'Staff' role / Student Discipline Module Member
  #2) Discipline Officer - must activate 'Disciplinary Officer 'role
  role :student_discipline_module_member do
    has_permission_on :studentdisciplinesearches, :to =>  :manage
    #own records
    has_permission_on :student_discipline_cases, :to => :create
    has_permission_on :student_discipline_cases, :to => :read, :join_by => :or do
      if_attribute :reported_by => is {Login.current_login.staff_id}
      if_attribute :assigned_to => is {Login.current_login.staff_id}
      if_attribute :assigned2_to => is {Login.current_login.staff_id}
    end
    #own (programme mgr)
    has_permission_on :student_discipline_cases, :to => :approve do
      if_attribute :assigned_to => is {Login.current_login.staff_id}
    end
    #own (approver - TPHEP)
    has_permission_on :student_discipline_cases, :to => :manage do
      if_attribute :assigned2_to => is {Login.current_login.staff_id}
    end
  end
  
  #Modules : Tenants & Locations
  #laporan_penginapan(PDF)==statistic_level(xls),  laporan_penginapan2(PDF)==statistic_block(xls), census_level(haml)->census(PDF)==census_level2(xls)
 
  #17-OK - but note read/manage - xls links accessible via INDEX pg, when index accessible(index.xls)
  #17 - 3/4 OK(Admin, Viewer, User) - 18Feb2016
  role :tenants_module_admin do
     has_permission_on :tenants, :to =>:manage
  end
  role :tenants_module_viewer do
     has_permission_on :tenants, :to => :read
  end
  role :tenants_module_user do
     has_permission_on :tenants, :to => [:read, :update]
  end
# NOTE - DISABLE(in EACH radio buttons - locationown[0].disabled=true) as the owner of this module requires 'Facilities Administrator' role + warden requires read only
#   role :tenants_module_member do
#   end

  #18-OK
  #18 - 3/4 OK (Admin, Viewer, User) - 18Feb2016
  role :locations_module_admin do
    has_permission_on :locations, :to => :manage
  end
  role :locations_module_viewer do
    has_permission_on :locations, :to => :read
  end
  role :locations_module_user do
    has_permission_on :locations, :to => [:read, :update]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - locationown[1].disabled=true) as the owner of this module requires 'Asset Administrator' / 'Facilities Administrator' role & 'Staff' / 'Warden' requires read only
#   role :locations_module_member do
#   end
  
  #19-OK
  #19 - 3/4 OK (Admin, Viewer, User) - 18Feb2016
  # NOTE - Location Damages - never exist in Catechumen, refer Ogma
   role :location_damages_module_admin do
    has_permission_on :location_damages, :to => :manage
  end
  role :location_damages_module_viewer do
    has_permission_on :location_damages, :to => :read
  end
  role :location_damages_module_user do
    has_permission_on :location_damages, :to => [:read, :update]
  end
    
  #20-OK -  but note read/manage - xls links accessible via INDEX pg, when index accessible(index.xls)
  #kumpulan_etnik_main->kumpulan_etnik(PDF)==kumpulan_etnik_excel(xls)
  role :student_infos_module_admin do
     has_permission_on :students, :to => [:manage, :report, :formforstudent, :ethnic_listing, :maklumat_pelatih_intake] 
     has_permission_on :studentsearches, :to => :manage
  end
  role :student_infos_module_viewer do
     has_permission_on :students, :to => [:read, :report, :formforstudent, :ethnic_listing, :maklumat_pelatih_intake]
     has_permission_on :studentsearches, :to => :manage
  end
  role :student_infos_module_user do
     has_permission_on :students, :to => [:read, :update, :formforstudent, :report, :ethnic_listing, :maklumat_pelatih_intake]
     has_permission_on :studentsearches, :to =>  :manage
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - studentown[4].disabled=true as the owner of this module requires 'Student' or 'Student Administration'
# Note too, most roles have at least READ access for this module
#   role :student_infos_module_member do
#     has_permission_on :studentsearches, :to =>  :manage
#     #own record
#      has_permission_on :students, :to => [:update, :show, :formforstudent] do 
#        if_attribute :id => is {Login.current_login.staff_id}
#      end
#      #own (Student Administrator)
#      has_permission_on :students, :to => [:manage, :report, :formforstudent, :ethnic_listing, :maklumat_pelatih_intake]
#      #own (read only)
#      #Warden, Counselor, Disciplinary Officer, Student, Student Admnistrator, Librarian, Lecturer
#   end
  #####end for Student's related modules################################# 
  #####starts of Training modules####################################
  #Training menus require - training notes (menu) access 
  #21-OK
  #21 - 3/4 OK - 9Feb2016
  role :training_notes_module_admin do
     has_permission_on :trainingnotes, :to => [:menu, :manage]
  end
  role :training_notes_module_viewer do
     has_permission_on :trainingnotes, :to => [:menu, :read]
  end
  role :training_notes_module_user do
     has_permission_on :trainingnotes, :to => [:menu, :read, :update]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - training[0].disabled=true as the only owner of this module requires 'Lecturer' role 
#   role :training_notes_module_member do
#     #own records (lecturer only)
#     has_permission_on :trainingnotes, :to => :manage, :join_by => :or do
#       if_attribute :topicdetail_id => is_in {user.topicdetails_of_programme}
#       if_attribute :timetable_id => is_in {user.timetables_of_programme} 
#     end
#     has_permission_on :trainingnotes, :to => :manage, :join_by => :and do
#       if_attribute :topicdetail_id => is {nil}
#       if_attribute :timetable_id => is {nil}
#     end
#   end

  #22-OK
  #22 - 3/4 OK - 9Feb2016
  role :academic_session_module_admin do
     has_permission_on :academic_sessions, :to => :manage
  end
  role :academic_session_module_viewer do
     has_permission_on :academic_sessions, :to => :read
  end
  role :academic_session_module_user do
     has_permission_on :academic_sessions, :to =>[:read, :update]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - training[1].disabled=true as the only owner of this module requires 'Programme Manager' role 

  #23-OK 
  role :student_intake_module_admin do
     has_permission_on :intakes, :to => :manage
  end
  role :student_intake_module_viewer do
     has_permission_on :intakes, :to => :read
  end
  role :student_intake_module_user do
    has_permission_on :intakes, :to => [:read, :update]
  end
  role :student_intake_module_member do
    has_permission_on :intakes, :to => :read
    # NOTE - restriction on updates - lecturers of the same programme only
    has_permission_on :intakes, :to => :update do
      if_attribute :programme_id => is_in {Programme.find(:all, :conditions => ['name=?', Position.find(:first, :conditions => ['staff_id=?', Login.current_login.staff_id]).unit]).map(&:id)}
    end
  end

  #24-OK
  role :timetables_module_admin do
     has_permission_on :timetables, :to => :manage
  end
  role :timetables_module_viewer do
     has_permission_on :timetables, :to => :read
  end
  role :timetables_module_user do
     has_permission_on :timetables, :to => [:read, :update]
  end
  role :timetables_module_member do
     has_permission_on :timetables, :to => :manage do
       if_attribute :created_by => is {Login.current_login.staff_id}
     end
  end
      
  #25-OK
  #25 - 3/4 OK (Admin/Viewer/User)
  role :lesson_plans_module_admin do
     has_permission_on :lesson_plans, :to => [:manage, :lesson_plan, :lessonplan_reporting, :lesson_plan_report]
  end
  role :lesson_plans_module_viewer do
     has_permission_on :lesson_plans, :to => [:read, :lesson_plan, :lesson_plan_report]
  end
  role :lesson_plans_module_user do
     has_permission_on :lesson_plans, :to => [:read, :update, :lessonplan_reporting, :lesson_plan, :lesson_plan_report]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - training[0].disabled=true as the only owner of this module requires 'Lecturer' & 'Programme Manager' role 
  
  #26-OK
  #26 - 3/4 OK (Admin/Viewer/User) - 9Feb2016
  role :topic_details_module_admin do
    has_permission_on :topicdetails, :to => :manage
  end
  role :topic_details_module_viewer do
    has_permission_on :topicdetails, :to => :read
  end
  role :topic_details_module_user do
    has_permission_on :topicdetails, :to => [:read, :update]
  end
  # NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - training[5].disabled=true as the only owner of this module requires 'Programme Manager' role
  
  #27-OK
  #27 - 3/4 OK (Admin/Viewer/User) - 9Feb2016
  role :programmes_module_admin do
    has_permission_on :programmes, :to => :manage
  end
  role :programmes_module_viewer do
    has_permission_on :programmes, :to => :read
  end
  role :programmes_module_user do
    has_permission_on :programmes, :to => [:read, :update]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - training[6].disabled=true as the only owner of this module requires 'Programme Manager' role
  
  # TODO - owner of time slot, but may ignore too - to discuss
  #28-OK but requires additional rules as personalize pages is based on logged-in user (existing one requires lecturer's role)
  #should rely on Ogma
  role :weeklytimetables_module_admin do
     has_permission_on :weeklytimetables, :to => :manage
     has_permission_on :weeklytimetables, :to => :personalize_index #do
     #  if_attribute :id => is_in{WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq}
     #end
  end
  role :weeklytimetables_module_viewer do
     has_permission_on :weeklytimetables, :to => :read
     has_permission_on :weeklytimetables, :to => :personalize_index #do
     #  if_attribute :id => is_in{WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq}
     #end
  end
  role :weeklytimetables_module_user do
    has_permission_on :weeklytimetables, :to => [:read, :update]
    has_permission_on :weeklytimetables, :to => :personalize_index #do
    #  if_attribute :id => is_in{WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id).uniq}
    #end
  end
  role :weeklytimetables_module_member do
    #1-own records (creator of WT)
    has_permission_on :weeklytimetables, :to => [:menu, :read, :create]
    has_permission_on :weeklytimetables, :to => [:manage, :weekly_timetable], :join_by => :or do
      if_attribute :prepared_by => is {Login.current_login.staff_id}
    end
    #2-own records (owner of a SLOT of WT)
    #wt_ids=WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id)
    has_permission_on :weeklytimetables, :to => [:personalize_index, :personalize_show, :personalize_timetable, :personalizetimetable] do
      if_attribute :id => is_in{WeeklytimetableDetail.find(:all, :conditions => ['lecturer_id=?', Login.current_login.staff_id]).map(&:weeklytimetable_id)}
    end
#     # TODO - approval for KP -  Not applicable at this moment - temp solution in Ogma (hack in Show), advise user use 'Programme Mgr' role.
#     #3-own (approver KP - SHOW (approval button) & approval action) - Diploma ONLY?
#     has_permission_on :weeklytimetables, :to => :approval, :join_by => :and do
#       if_attribute :is_submitted => is {true}
#       if_attribute :programme_id => is {Login.current_login.same_programme}
#     end
  end
  #####end for Training modules####################################
  #####start of Library modules####################################
  #29-OK, but note pending extend, extend2, return & return2
  #29 - 3/4 OK (Admin/Viewer/User)
  role :library_transactions_module_admin do
    has_permission_on :librarytransactions, :to => [:manage, :check_availability, :multiple_edit, :check_availability2, :multiple_update, :form_try, :extend2, :extend, :return, :analysis_statistic]
    # TODO extend, extend2, return, return2 in Ogma
  end
  role :library_transactions_module_viewer do
    has_permission_on :librarytransactions, :to => [:read, :analysis_statistic]
    # TODO extend, extend2, return, return2 in Ogma
  end
  role :library_transactions_module_user do
    has_permission_on :librarytransactions, :to => [:read, :update, :check_availability, :multiple_edit, :check_availability2, :multiple_update, :form_try, :extend2, :extend, :return, :analysis_statistic]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - lbrary[0].disabled=true as the only owner of this module requires 'Librarian' role
#   role :library_transactions_module_member do
#   end
  
  #30-OK
  role :library_books_module_admin do
     has_permission_on :books, :to => :manage
     has_permission_on :booksearches, :to => :manage
  end
  role :library_books_module_viewer do
     has_permission_on :books, :to => [:core, :read]
     has_permission_on :booksearches, :to => :manage
  end
  role :library_books_module_user do
    has_permission_on :books, :to => [:core, :read, :update]
    has_permission_on :booksearches, :to => :manage
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - lbrary[0].disabled=true as the only owner of this module requires 'Librarian' role
#   role :library_books_module_member do
#   end
  #####end for Library modules####################################
  #start of Examination modules####################################
  # NOTE - Catechumen : Examquestions only, other exam modules should rely on Ogma 
  # TODO - to check & remove Exam parts
  #31-OK
  #31 OK - 19Feb2016
  role :exam_templates_module_admin do
     has_permission_on :exam_templates, :to => :manage
  end
  role :exam_templates_module_viewer do
     has_permission_on :exam_templates, :to => :read
  end
  role :exam_templates_module_user do
    has_permission_on :exam_templates, :to => [:read, :update]
  end
  role :exam_templates_module_member do
    has_permission_on :exam_templates, :to => [:read, :update] do
      if_attribute :created_by => is_in {Login.current_login.unit_members}
    end
  end
  
  #32-OK
  #32-OK - 19Feb2016
  role :examresults_module_admin do
     has_permission_on :examresults, :to => [:manage, :examination_slip]
  end
  role :examresults_module_viewer do
     has_permission_on :examresults, :to => [:menu, :read, :examination_slip]
  end
  role :examresults_module_user do
    has_permission_on :examresults, :to => [:menu, :read, :update, :examination_slip]
  end
  role :examresults_module_member do
    has_permission_on :examresults, :to => [:manage, :examination_slip] do
      if_attribute :programme_id => is_in {Programme.find(:all, :conditions => ['name=?', Position.find(:first, :conditions => ['staff_id=?', Login.current_login.staff_id]).unit]).map(&:id)}
    end
  end
  
  #33-OK
  #33 OK - 19Feb2016
  role :exam_grade_module_admin do
     has_permission_on :grades, :to => :manage
  end
  role :exam_grade_module_viewer do
     has_permission_on :grades, :to =>[:menu, :read]
  end
  role :exam_grade_module_user do
     has_permission_on :grades, :to =>[:menu, :read, :update]
  end
  role :exam_grade_module_member do
    ###own (of same programme)
    has_permission_on :grades, :to => [:menu, :read, :create]
    has_permission_on :grades, :to => [:update, :delete] do
      #if_attribute :id => is_in {user.grades_of_programme}
    end
  end

  #34-OK
  #34 OK - 19Feb2016
  role :exammarks_module_admin do
     has_permission_on :exammarks, :to => :manage
  end
  role :exammarks_module_viewer do
     has_permission_on :exammarks, :to => [:menu, :read]
  end
  role :exammarks_module_user do
     has_permission_on :exammarks, :to => [:menu, :read, :update]
  end
  role :exammarks_module_member do
    ###own (of same programme)
    has_permission_on :exammarks, :to => [:menu, :read, :create]
    has_permission_on :exammarks, :to =>[:update, :delete] do
      #if_attribute :exam_id => is_in {user.exams_of_programme}
    end
  end
  
  #35-OK
  #35 OK - 19Feb2016
  role :exam_analysis_module_admin do
     has_permission_on :examanalyses, :to => [:manage, :analysis_data]
  end
  role :exam_analysis_module_viewer do
     has_permission_on :examanalyses, :to => [:menu, :read, :analysis_data]
  end
  role :exam_analysis_module_user do
     has_permission_on :examanalyses, :to => [:menu, :read, :update, :analysis_data]
  end
  role :exam_analysis_module_member do
    #own (exam admin - creator)
    has_permission_on :examanalyses, :to => [:menu, :read, :create]
    has_permission_on :examanalyses, :to => [:edit, :update, :delete, :analysis_data] do
     # if_attribute :exam_id => is_in {user.by_programme_exams}  
    end
    #own (programme mgr)
    has_permission_on :examanalyses, :to => [:menu, :read] do
      #if_attribute :exam_id => is_in {user.by_programme_exams}  
    end
  end
  
  #36-OK - 19Feb2016
  role :exampaper_module_admin do
     has_permission_on :exams, :to => :manage
  end
  role :exampaper_module_viewer do
     has_permission_on :exams, :to => [:menu, :read]
  end
  role :exampaper_module_user do
    has_permission_on :exams, :to => [:menu, :read, :update]
  end
  role :exampaper_module_member do
    has_permission_on :exams, :to => [:menu, :read, :update] do
     # if_attribute :created_by => is_in {user.unit_members}
    end
  end
  
  #37-OK - 3/4 OK, except for Member
  role :examquestions_module_admin do
     has_permission_on :examquestions, :to => :manage
  end
  role :examquestions_module_viewer do
     has_permission_on :examquestions, :to => [:menu, :read]
  end
  role :examquestions_module_user do
     has_permission_on :examquestions, :to => [:menu, :read, :update]
  end
  # NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - examown[6].disabled=true as the only owner of this module requires 'Lecturer' role
  #role :examquestions_module_member do
  #end

  #50-added 10Feb2016
  #50 OK but (Admin/Viewer/User-may be assigned to anybody-All records whereas MEMBER - must be assigned to lecturers to get this programme mgr's access)
  role :course_evaluation_module_admin do
    has_permission_on :evaluate_courses, :to => [:manage, :courseevaluation]
    has_permission_on :evaluatecoursesearches, :to => :manage
  end
  role :course_evaluation_module_viewer do
    has_permission_on :evaluate_courses, :to => [:read, :courseevaluation]
    has_permission_on :evaluatecoursesearches, :to => :manage
  end
  role :course_evaluation_module_user do
    has_permission_on :evaluate_courses, :to => [:read, :courseevaluation, :update]
    has_permission_on :evaluatecoursesearches, :to => :manage
  end
  role :course_evaluation_module_member do
    has_permission_on :evaluatecoursesearches, :to => :manage
    #own record (student)
    has_permission_on :evaluate_courses, :to => [:index, :create] do
      has_permission_on :evaluate_courses, :to => [:read, :update, :courseevaluation] do
        if_attribute :student_id => is {Login.current_login.staff_id}
      end
    end
    #own (programme manager-reader)
    has_permission_on :evaluate_courses, :to => [:read, :courseevaluation] do
      if_attribute :course_id => is_in {Position.my_programmeid(Login.current_login.staff_id)}
    end
  end
  #end for Examination modules####################################
  #start of Assets modules#######################################
  
  #38-OK - 19Feb2016
  role :stationeries_module_admin do
     has_permission_on :stationeries, :to => [:manage, :supplies]
     has_permission_on :stationerysearches, :to => :manage
  end
  role :stationeries_module_viewer do
     has_permission_on :stationeries, :to => [:read, :supplies]
     has_permission_on :stationerysearches, :to => :manage
  end
  role :stationeries_module_user do
     has_permission_on :stationeries, :to => [:read, :update, :supplies]
     has_permission_on :stationerysearches, :to => :manage
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - assetown[0].disabled=true as there's no specific role & above 3 access are adequate
#   role :stationeries_module_member do
#      has_permission_on :asset_stationeries, :to => [:read, :update, :kewps13]
#   end
 
  #39-OK for Catechumen 19Feb2016 - but Ogma - kewpa31 link not ready (write-off) - TODO - to check kewpa29?
  role :asset_losses_module_admin do
     has_permission_on :asset_losses, :to => [:manage, :edit_multiple, :update_multiple, :kewpa28, :kewpa30, :kewpa31]
  end
  role :asset_losses_module_viewer do
     has_permission_on :asset_losses, :to => [:read, :kewpa28, :kewpa30, :kewpa31] 
  end
  role :asset_losses_module_user do
    has_permission_on :asset_losses, :to => [:read, :update, :edit_multiple, :update_multiple, :kewpa28, :kewpa30, :kewpa31] 
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - assetown[1].disabled=true as the only owner is asset_administrator

  #40-OK
  #40 - OK 19Feb2016, 3/4 OK (Admin, Viewer, User), Member - only applicable to member of responsible Unit (of loaned asset)
  role :asset_loans_module_admin do
     has_permission_on :asset_loans, :to => [:manage, :approval, :lampiran]
  end
  role :asset_loans_module_viewer do
     has_permission_on :asset_loans, :to => [:read, :lampiran]
  end
  role :asset_loans_module_user do
    has_permission_on :asset_loans, :to => [:read, :approval, :update, :lampiran]
  end
  role :asset_loans_module_member do
    #own record (staff - loaner / unit members)
    has_permission_on :asset_loans, :to => :create                                                          # A staff can create loan
    has_permission_on :asset_loans, :to =>:read do 
      if_attribute :staff_id => is {Login.current_login.staff_id}
    end
    has_permission_on :asset_loans, :to =>:update, :join_by => :and do                         # applicant can update unless loan is approved
      if_attribute :staff_id => is {Login.current_login.staff_id}
      if_attribute :is_approved => is_not {true}
    end
    has_permission_on :asset_loans, :to => [:read, :lampiran] do                                 # loan can be viewed by Unit Members
      if_attribute :loaned_by => is_in {Login.current_login.unit_members}
    end
    has_permission_on :asset_loans, :to => [:update, :approval], :join_by => :and do     # loan can be approved by Unit Members when not yet approved 
      if_attribute :loaned_by => is_in {Login.current_login.unit_members}
      if_attribute :is_approved => is_not {true}
    end
    has_permission_on :asset_loans, :to => :update, :join_by => :and do                         # As of Travel Request,Claim, AssetDefect - loaner must not hv access to EDIT 
      if_attribute :loaned_by => is_in {Login.current_login.unit_members}                                                           # temp - hide in Edit as of Travel Claim & AssetDefect
      if_attribute :is_approved => is {true}
      if_attribute :is_returned => is_not {true}
    end
# NOTE - similar to Admin (this module) & Asset Admin access
#     #own (approval - asset admin)
#     has_permission_on :asset_loans, :to => [:read, :lampiran]
#     has_permission_on :asset_loans, :to => [:update, :approval] , :join_by => :and do
#       if_attribute :is_returned => is_not {true}
#     end
  end
  
  #41-OK
  role :asset_disposals_module_admin do
     has_permission_on :asset_disposals, :to => [:manage, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :revalue, :dispose]
     #[:manage, :kewpa17_20, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :dispose, :revalue, :verify, :view_close]
  end
  role :asset_disposals_module_viewer do
     has_permission_on :asset_disposals, :to => [:read, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :revalue, :dispose]
  end
  role :asset_disposals_module_user do
     has_permission_on :asset_disposals, :to =>[:read, :update, :kewpa17, :kewpa20, :kewpa16, :kewpa18, :kewpa19, :dispose, :revalue]
  end
# NOTE - DISABLE(in EACH radio buttons/click : radio & checkbox - assetown[1].disabled=true as the only owner is asset_administrator

  #42-OK
  #42 3/4 OK (Admin/Viewer/User) - Member : workable for reporter & decisioner only
  role :asset_defect_module_admin do
    has_permission_on :asset_defects, :to => [:manage, :kewpa9]
  end
  role :asset_defect_module_viewer do
    has_permission_on :asset_defects, :to => [:read, :kewpa9]
  end
  role :asset_defect_module_user do
    has_permission_on :asset_defects, :to => [:read, :update, :kewpa9]
  end
  # NOTE - workable only for defect reporter & decisioner, still require 'Asset Administrator' role for 1st time access of defectives one, for processing purpose.
  role :asset_defect_module_member do
    #own records (Staff role)
    has_permission_on :asset_defects, :to => :create                                                        # A staff can register & update defect
    has_permission_on :asset_defects, :to => :read do
      if_attribute :reported_by => is {user.userable.id}
    end
    has_permission_on :asset_defects, :to => :update, :join_by => :and do                     # Applicant may update unless defect processed
      if_attribute :reported_by => is {user.userable.id}
      if_attribute :is_processed => is_not {true}
    end
    #own (processor or decisioner)
    has_permission_on :asset_defects, :to => [:read, :kewpa9], :join_by => :and do        # Processor & decision maker may show / pdf
      if_attribute :processed_by => is {user.userable.id}
      if_attribute :decision_by => is {user.userable.id}
    end
    #own (processor)
    has_permission_on :asset_defects, :to => [:update, :kewpa9], :join_by => :and do  # previous Asset Admin - pending - may process unless defect processed
      if_attribute :processed_by => is {user.userable.id}
      if_attribute :is_processed => is_not {true}
    end
    #own (decisioner)
    has_permission_on :asset_defects, :to => [:update, :kewpa9], :join_by => :and do   # Decision maker may decide unless decision has been made
      if_attribute :decision_by => is {user.userable.id}
      if_attribute :decision => is_not {true}
    end
    #own (processor - use of 'Asset Administrator' role)
    has_permission_on :asset_defects, :to =>[:read, :kewpa9]
    has_permission_on :asset_defects, :to =>:update, :join_by => :and do #3nov2013, 21Jan2016
      if_attribute :is_processed => is_not {true}
    end
  end
  
  #43-OK, but for read - price is hidden & visible only to those with update access
  #43 3/4 OK (Admin/User/Member), Viewer - restricted access for document containing pricing details : cost/maintenance
  role :asset_list_module_admin do
    has_permission_on :assets, :to => [:manage, :kewpa2, :kewpa3, :kewpa4, :kewpa5, :kewpa6, :kewpa8, :kewpa13, :kewpa14, :loanables]
    has_permission_on :assetsearches, :to => :manage
  end
  #restriction - no PDF allowed : contains pricing details 2, 3, 4, 5 & 8 (kos perolehan) 13 & 14 (maintenance) 
  role :asset_list_module_viewer do
    has_permission_on :assets, :to => [:read, :kewpa6, :loanables] 
    has_permission_on :assetsearches, :to => :manage
  end
  role :asset_list_module_user do
    has_permission_on :assets, :to => [:read, :update, :kewpa2, :kewpa3, :kewpa4, :kewpa5, :kewpa6, :kewpa8, :kewpa13, :kewpa14, :loanables]
    has_permission_on :assetsearches, :to => :manage
  end
  role :asset_list_module_member do
    has_permission_on :assets, :to => [:read, :loanables]
    has_permission_on :assetsearches, :to => :manage
  end
  #end for Assets modules#######################################
  #start of Support table / E FIlling modules##################################
  #44-OK - 20Feb2016
  role :events_module_admin do
     has_permission_on :events, :to => :manage
  end
  role :events_module_viewer do
     has_permission_on :events, :to => :read
  end
  role :events_module_user do
     has_permission_on :events, :to => [:read, :update]
  end
  role :events_module_member do
    has_permission_on :events, :to => [:create, :read]                                                             # A staff can read, create but update own
    has_permission_on :events, :to => :update do
      if_attribute :createdby => is {Login.current_login.staff_id}
    end
  end
  
  #45-OK - 20Feb2016
  role :bulletins_module_admin do
     has_permission_on :bulletins, :to =>:manage
  end
  role :bulletins_module_viewer do
     has_permission_on :bulletins, :to => :read
  end
  role :bulletins_module_user do
    has_permission_on :bulletins, :to => [:read, :update]
  end
  role :bulletins_module_member do
    has_permission_on :bulletins, :to => [:create, :read]                                                             # A staff can read, create but update own
    has_permission_on :bulletins, :to => :update do
      if_attribute :postedby_id => is {Login.current_login.staff_id}
    end
  end

  #46-OK - 20Feb2016
  role :files_module_admin do
     has_permission_on :cofiles, :to => :manage
  end
  role :files_module_viewer do
     has_permission_on :cofiles, :to => :read
  end
  role :files_module_user do
    has_permission_on :cofiles, :to => [:read, :update]
  end
  role :files_module_member do
    has_permission_on :cofiles, :to => [:read, :create]
    has_permission_on :cofiles, :to => :update do
      if_attribute :owner_id => is {Login.current_login.staff_id}
    end
  end

  #47-OK, but create & restrictions - 20Feb2016
  #Restriction : Update (Admin/User) - may edit document BUT cannot insert action taken by each recipient of circulation
  role :documents_module_admin do
    has_permission_on :documents, :to => [:manage, :generate_report]
    has_permission_on :documentsearches, :to => :manage
  end
  # NOTE shall override owner (recipient) access (cannot enter action taken)
  role :documents_module_viewer do
    has_permission_on :documents, :to => [:menu, :read, :generate_report]
    has_permission_on :documentsearches, :to => :manage
  end
  role :documents_module_user do
    has_permission_on :documents, :to => [:menu, :read, :update, :generate_report]
    has_permission_on :documentsearches, :to => :manage
  end
  role :documents_module_member do
    has_permission_on :documentsearches, :to => :manage
    #own (document creator)
    has_permission_on :documents, :to => [:menu, :read, :create]
    # TODO - updates will let user update (as creator / filer) & update (as circulations recepient) simultaneously?
#     has_permission_on :documents, :to => [:update] do 
#       if_attribute :stafffiled_id => is {163}#{Login.current_login.staff_id}
#     end
#     #own (recipient of circulations)
#     has_permission_on :circulations, :to => :update do
#        #if_attribute :document_id => is_in {Document.find(:all, :joins => :staffs, :conditions => ['staffs.id=?',163]).map(&:id)}
#        if_attribute :staff_id => is {Login.current_login.staff_id}
#     end
    has_permission_on :documents, :to => :update do
      if_attribute :id => is_in {Document.find(:all, :joins => :staffs, :conditions => ['staffs.id=?',163]).map(&:id)}  
      if_attribute :stafffiled_id => is {Login.current_login.staff_id}
      if_attribute :prepared_by => is {Login.current_login.staff_id}
    end
  end

  #48-OK
  role :banks_module_admin do
     has_permission_on :banks, :to => :manage
  end
  role :banks_module_viewer do
     has_permission_on :banks, :to => :read
  end
  
  #49-OK
  role :address_book_module_admin do
     has_permission_on :address_books, :to => :manage
  end
  role :address_book_module_viewer do
     has_permission_on :address_books, :to => :read
  end
  
  #50-OK
  role :titles_module_admin do
     has_permission_on :titles, :to => :manage
  end
  role :titles_module_viewer do
     has_permission_on :titles, :to => :read
  end
  
  #51-OK
  role :staff_shifts_module_admin do
     has_permission_on :staff_shifts, :to => :manage
  end
  role :staff_shifts_module_viewer do
     has_permission_on :staff_shifts, :to => :read
  end
  
  #52-OK
  role :travel_claims_transport_groups_module_admin do
     has_permission_on :travel_claims_transport_groups, :to => :manage
  end
  role :travel_claims_transport_groups_module_viewer do
     has_permission_on :travel_claims_transport_groups, :to => :read
  end
  
  #53-OK
  role :travel_claim_mileage_rates_module_admin do
     has_permission_on :travel_claim_mileage_rates, :to => :manage
  end
  role :travel_claim_mileage_rates_module_viewer do
     has_permission_on :travel_claim_mileage_rates, :to => :read
  end
  
  #54-OK
  role :asset_categories_module_admin do
     has_permission_on :asset_categories, :to => :manage
  end
  role :asset_categories_module_viewer do
     has_permission_on :asset_categories, :to => :read
  end
  ##Access by Modules ended here
  
  
  #Catechumen
  #OK until here - 20Feb2016
  ###############
  # NOTE 
  # 1) Staff Attendances 
  #(a) All staffs : Staff role, Approvers : Unit Leader / Programme Manager / Administration Staff role
  #(b) Approvers only (CRUD/A) : Staff Attendance Module (Admin)
  #(c) Approvers only (RU/A) : Staff Attendance Module (User)
  #(d) All staffs & Approvers - Staff Attendance Module (Member)
  
  #############
    
  
  
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