class Leaveforstudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :staff
  belongs_to :second_approver, :class_name=>'Staff', :foreign_key=>"staff_id2"

  validates_presence_of :student_id, :leavetype, :leave_startdate, :leave_enddate
  validates_numericality_of :telno
  validate :validate_kin_exist
  validate :validate_end_date_before_start_date
  
  def self.find_main
    Student.find(:all, :condition => ['student_id IS NULL'])
  end
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  named_scope :all
  named_scope :completed, :conditions => ['approved=? and approved2=?', true, true]
  named_scope :expired, :conditions => ['studentsubmit=? and leave_startdate<? and id not in(?)', true, Date.tomorrow, Leaveforstudent.completed.map(&:id)]
  named_scope :approved_coordinator, :conditions => ['studentsubmit=? and approved=?', true, true]
  named_scope :approved_warden, :conditions => ['studentsubmit=? and approved2=?', true, true]
  named_scope :pending_coordinator, :conditions => ['studentsubmit=? and id not in(?)', true, Leaveforstudent.approved_coordinator.map(&:id)]
  named_scope :pending_warden, :conditions => ['studentsubmit=? and id not in(?)', true, Leaveforstudent.approved_warden.map(&:id)]
  
  FILTERS = [
    {:scope => "all", :label => I18n.t('asset.all')},
    {:scope => "pending_coordinator",    :label => I18n.t('leaveforstudent.pending_coordinator')},
    {:scope => "pending_warden",  :label => I18n.t('leaveforstudent.pending_warden')},
    {:scope => "approved_coordinator",    :label => I18n.t('leaveforstudent.approved_coordinator')},
    {:scope => "approved_warden",  :label => I18n.t('leaveforstudent.approved_warden')},
    {:scope => "completed", :label => I18n.t('leaveforstudent.completed')},
    {:scope => "expired", :label => I18n.t('leaveforstudent.expired')}
  ]

  def self.search(search)
     if search
       prod_ids=Programme.find(:all, :conditions => ['name ILIKE ? and ancestry_depth=?', "%#{search}%", 0]).map(&:id)
       student_ids=Student.find(:all, :conditions =>['name ILIKE ? or course_id IN(?)',"%#{search}%", prod_ids]).map(&:id)
       @leaveforstudent = Leaveforstudent.find(:all, :conditions => ['leavetype ILIKE ? or student_id IN(?)' , "%#{search}%", student_ids], :order=>'leave_startdate DESC')
     else
      @leaveforstudent = Leaveforstudent.find(:all, :order=>'leave_startdate DESC')
     end
  end

  #<07/10/2011 - Shaliza fixed for error when staff no longer exists>
  def approver_details 
      suid = staff_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     
  
      if staff_id == nil
         "" 
       elsif checker == []
         "Staff No Longer Exists" 
      else
        staff.name
      end
  end

  def approver_details2
      suid = staff_id2.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     
  
      if staff_id2 == nil
         "" 
      elsif checker == []
         "Staff No Longer Exists" 
      else
        second_approver.name
      end
  end

  #<18/10/2011 - Shaliza fixed for error when student no longer exists>
  def student_details 
      suid = student_id.to_a
      exists = Student.find(:all, :select => "id").map(&:id)
      checker = suid & exists     
  
      if student_id == nil
         "" 
       elsif checker == []
         "Student No Longer Exists" 
      else
        student.formatted_mykad_and_student_name
      end
  end
    
  def student_intake
    Intake.find(:all, :conditions=>['monthyear_intake=? and programme_id=?', student.intake, student.course_id]).first
  end
  
  def group_intake
     if student_intake
       student_intake.group_with_intake_name
     else
       " - ("+I18n.t('student.leaveforstudent.intake')+" : "+student.intake.strftime('%b %Y').to_s+")"
     end
  end
  
  def group_coordinator
    if student_intake
      group_no = student_intake.description
      group_name = "Penyelaras Kumpulan "+group_no
      coordinator = Staff.find(:all, :joins=>:position, :conditions=>['tasks_main ILIKE (?)', "%#{group_name}%"]).first
    end
    coordinator
  end
  
  def warden_list
    staff_ids = Login.find(:all, :joins=>:roles, :conditions=>['roles.name=?', "Warden"]).map(&:staff_id).compact.uniq
  end
    
  #validation logic
  def validate_end_date_before_start_date
    if leave_enddate && leave_startdate
      errors.add(:end_date, "Your leave must begin before it ends") if leave_enddate < leave_startdate || leave_startdate < DateTime.now
    end
  end
  
  def validate_kin_exist
     if student.kins.count < 1
      errors.add( I18n.t('leaveforstudent.has_no_kin'), I18n.t('leaveforstudent.update_student_kin')) 
     end
  end
  
  STUDENTLEAVETYPE = [
        #  Displayed       stored in db
        [ I18n.t("leaveforstudent.weekend_day"),"Weekend Day" ],
        [ I18n.t("leaveforstudent.weekend_overnight"),"Weekend Overnight" ],
        [ I18n.t("leaveforstudent.emergency"),"Emergency" ],
        [ I18n.t("leaveforstudent.festive_leave"),"Cuti Perayaan" ],
        [ I18n.t("leaveforstudent.midterm_break"),"Mid Term Break" ],
        [ I18n.t("leaveforstudent.end_of_semester"),"End of Semester" ]
   ]

end