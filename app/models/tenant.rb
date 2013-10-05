class Tenant < ActiveRecord::Base
  belongs_to :location, :foreign_key => 'location_id'
  belongs_to :staff, :foreign_key => 'staff_id'
  belongs_to :student, :foreign_key => 'student_id'
  
  
  def student_tenants
    tenants = Tenant.find(:all, :select => "student_id", :conditions => ["student_id IS NOT ?", nil]).map(&:student_id)
    if tenants == []
      [9999999]
    else
      tenants
    end
  end
  
  def available_students
    all_students = Student.find(:all, :select => :id)
    current_tenants = Tenant.find(:all, :select => :student_id)
    available_students = all_students - current_tenants
  end
  
  
  
  def student_name #16/11/2011 - Shaliza added code for student if no longer exist.
    check_kin {student.student_name_with_programme}
    #student.student_name_with_programme
  end

  def staff_name #16/11/2011 - Shaliza added code for staff if no longer exist.
    staff.staff_name_with_position
    #check_kin {staff.staff_name_with_position}
  end

  def location_name #16/11/2011 - Shaliza added code for location if no longer exist.
    check_kin {location.location_list}
  end

  def location_typename #16/11/2011 - Shaliza added code for typename if no longer exist.
    check_kin {location.typename}
  end

  def course_details
    check_kin {student.programme_for_student}
  end
  
  

end
