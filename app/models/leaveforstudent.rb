class Leaveforstudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :staff

  validates_presence_of :student_id, :leavetype, :leave_startdate, :leave_enddate
  validates_numericality_of :telno
  
  def self.find_main
    Student.find(:all, :condition => ['student_id IS NULL'])
  end
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
  end
  
  validate :validate_end_date_before_start_date

  def validate_end_date_before_start_date
    if leave_enddate && leave_startdate
      errors.add(:end_date, "Your leave must begin before it ends") if leave_enddate < leave_startdate || leave_startdate < DateTime.now
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

  def self.search(search)
     if search
       @leaveforstudent = Leaveforstudent.find(:all, :conditions => ['leavetype LIKE ?' , "%#{search}%"])
     else
      @leaveforstudent = Leaveforstudent.find(:all)
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

end