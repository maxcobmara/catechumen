class Leaveforstudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :approver, :class_name => 'Position', :foreign_key => 'staff_id'

  validates_presence_of :student_id, :leavetype, :leave_startdate, :leave_enddate, :studentsubmit
  validates_numericality_of :telno
  
  
  def self.find_main
    Student.find(:all, :condition => ['student_id IS NULL'])
  end
  
  def self.find_main
    Staff.find(:all, :condition => ['staff_id IS NULL'])
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
 def leave_for
    if leave_enddate == 'null' || leave_startdate == 'null' || (leave_enddate - leave_startdate) == 0
      1
    else
      ((leave_enddate - leave_startdate).to_i) + 1
    end
  end
  
  def show_to_day
    if (leave_enddate - leave_startdate) == 0
      ""
    else
      "  " + (leave_enddate.strftime("%d %b %Y")).to_s
    end
  end
    
  
def self.search(search)
     if search
       @leaveforstudent = Leaveforstudent.find(:all, :conditions => ['leavetype LIKE ?' , "%#{search}%"])
     else
      @leaveforstudent = Leaveforstudent.find(:all)
     end
end

def approver_details 
      suid = staff_id.to_a
      exists = Position.find(:all, :select => "id").map(&:id)
      checker = suid & exists     
  
      if staff_id == nil
         "" 
       elsif checker == []
         "-" 
      else
        approver.position_with_boss
      end
end

def apply_leave_status
  if approved == nil
    "Awaiting for Approver"
  elsif approved == false 
    "Not Approved"
  else
    "Approved"
  end
end

def bil
   v=1
end

end
