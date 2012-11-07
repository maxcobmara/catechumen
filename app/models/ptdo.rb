class Ptdo < ActiveRecord::Base
  before_save  :whoami
  
  belongs_to  :ptschedule
  belongs_to  :staff
  belongs_to  :applicant, :class_name => 'Staff',   :foreign_key => 'staff_id'
  belongs_to  :replacement, :class_name => 'Staff', :foreign_key => 'replacement_id'
  
  
  has_many    :staff_appraisals, :through => :staff
  
  
  
  def whoami
    #self.staff_id = User.current_user.staff.id
    self.ptcourse_id = ptschedule.ptcourse.id
  end
  
  def apply_dept_status
    if (unit_approve == false || dept_approve == false || final_approve == false)
      "Application Rejected"
    elsif unit_approve.nil? == true
      "Awaiting Unit Approval"
    elsif unit_approve == true && dept_approve.nil? == true
      "Approved by Unit head, awaiting Dept approval"
    elsif dept_approve == true && dept_approve == true && final_approve.nil? == true
      "Approved by Dept head, awaiting Pengarah approval"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == true
      "All approvals complete"
    elsif dept_approve == true && dept_approve == true && final_approve == true && trainee_report.nil? == false
      "Report Submitted"
    else
      "Status Not Available"
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
