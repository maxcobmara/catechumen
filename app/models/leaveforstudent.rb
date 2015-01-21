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

  def self.search(search)
     if search
       @leaveforstudent = Leaveforstudent.find(:all, :conditions => ['leavetype LIKE ?' , "%#{search}%"], :order=>'leave_startdate DESC')
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
  
      if staff_id == nil
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