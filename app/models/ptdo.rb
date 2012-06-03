class Ptdo < ActiveRecord::Base
  before_save  :whoami
  
  belongs_to  :ptschedule
  belongs_to  :staff
  has_many    :appraisals, :through => :staff
  
  
  
  def whoami
    self.staff_id = User.current_user.staff.id
    self.ptcourse_id = ptschedule.ptcourse.id
  end
  
  def apply_dept_status
    if unit_approve == nil
      "Awaiting unit approval"
    elsif unit_approve == false || dept_review == false || final_approve == false
      "rejected"
    elsif unit_approve == true && dept_review == nil
      "approved by unit head, awaiting dept approval"
    elsif unit_approve == true && dept_review == true
      "approved by dept head, awaiting pengarah approval"
    elsif final_approve == true
      " All approvals complete"
    else
      "No Status available"
    end
  end
  
  def applicant_details 
       suid = staff_id.to_a
       exists = Staff.find(:all, :select => "id").map(&:id)
       checker = suid & exists     
   
       if staff_id == nil
          "" 
        elsif checker == []
          "Staff No Longer Exists" 
       else
         staff.mykad_with_staff_name
       end
  end
  
  

  
end
