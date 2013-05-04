class Ptdo < ActiveRecord::Base
  before_save  :whoami
  
  belongs_to  :ptschedule, :foreign_key => 'ptschedule_id'
  belongs_to  :approver1, :class_name => 'Staff', :foreign_key => 'approver_1'
  belongs_to  :approver2, :class_name => 'Position', :foreign_key => 'approver_2'
  belongs_to  :replacementstaff, :class_name => 'Staff', :foreign_key => 'replacement_id'
  belongs_to  :staff
  has_many    :appraisals, :through => :staff
  
  def whoami
  #  self.staff_id = User.current_user.staff_id
  self.ptschedule_id = ptschedule.id
  end
   
  def apply_dept_status
    if unit_approve == nil
      "Awaiting 1st Approval"
    elsif unit_approve == false || dept_review == false 
      "Rejected"
    elsif unit_approve == true && dept_review == nil
      "Approved by 1st Approval, Awaiting 2nd Approval"
    elsif unit_approve == true && dept_approve == true
      " All Approvals Complete"
    else
      "No Status available"
    end
  end
  
  def staff_details 
          suid = staff_id.to_a
          exists = Staff.find(:all, :select => "id").map(&:id)
          checker = suid & exists     

          if staff_id == nil
             "" 
           elsif checker == []
             "Staff No Longer Exists" 
          else
            staff.staff_name_with_title
          end
  end
	
	def course_details 
      suid = ptcourse_id.to_a
      exists = Ptschedule.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if ptcourse_id == nil
        "" 
      elsif checker == []
        "Course No Longer Exists" 
      else
        ptschedule.id.coursename
    end
  end
  
  def approver1_details 
      suid = approver_1.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if approver_1 == nil
        "" 
      elsif checker == []
        "-" 
      else
        approver1.staff_name_with_title
    end
  end
  
  def approver2_details 
      suid = approver_2.to_a
      exists = Position.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if approver_2 == nil
        "" 
      elsif checker == []
        "-" 
      else
        approver2.position_with_boss
    end
  end
  
  def replacement_details 
      suid = replacement_id.to_a
      exists = Staff.find(:all, :select => "id").map(&:id)
      checker = suid & exists     

      if replacement_id == nil
        "" 
      elsif checker == []
        "-" 
      else
        replacementstaff.staff_name_with_title
    end
  end
  
end
