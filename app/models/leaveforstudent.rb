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
        [ "Weekend Day","Weekend Day" ],
        [ "Weekend Overnight","Weekend Overnight" ],
        [ "Emergency","Emergency" ],
        [ "Cuti Perayaan","Cuti Perayaan" ],
        [ "Mid Term Break","Mid Term Break" ],
        [ "End of Semester","End of Semester" ]
  ]
  
  
  def self.search(search)
    if search
      @leaveforstudent = Leaveforstudent.find(:all, :conditions => ['leavetype LIKE ?' , "%#{search}%"])
    else
      @leaveforstudent = Leaveforstudent.find(:all)
    end
  end

  def approver_details 
    staff.name#17Jul2013-check_kin{staff.name}
  end

  def student_details 
    check_kin{student.formatted_mykad_and_student_name}
  end

end
