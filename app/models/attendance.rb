class Attendance < ActiveRecord::Base
  
  before_save :save_my_approvers
	
	belongs_to :staffthatattend,             :class_name => 'Staff', :foreign_key => 'staff_id'
 belongs_to :approvedby, :class_name => 'Staff', :foreign_key => 'approve_id'
  
 validates_presence_of :staff_id, :attdate, :time_in
 
 
 #------------------------------------code initiliazation------------------------------------------------------------
  def mineore
      suid = subject.id
      Subject.find(:all, :select => "name", :conditions => {:id => suid}).map(&:name)
  end
 
  def self.find_mylate
    find(:all, :conditions => ["staff_id=? AND time_in > ?", User.current_user.staff_id, "8:30"])
  end
  
  def self.find_approvelate
    find(:all, :conditions => ["approve_id=? AND approvestatus IS ?", User.current_user.staff_id, nil])
  end
  
  def late_to_be_approved
      Attendance.count(:all, :conditions => ["approve_id=? AND approvestatus IS ?", User.current_user.staff_id, nil])
  end
  
  def save_my_approvers
   self.approve_id = staffthatattend.position.bosses.staff.id
  end

  def bil
     v=1
  end 
#------------------------------------Search for Attendance---------------------------------
  def self.search(search)
     if search
      @attendance = Attendance.find(:all, :conditions => ['attdate ILIKE ?', "params[:stdate]"])
     else
      @attendance = Attendance.find(:all)
     end
  end
 #-------------------------------------code for data no longer exist in database------------------------------------------ 

   def staffname_details
    suid = staff_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if staff_id == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      staffthatattend.staff_name_with_title
    end
  end
  
  def staffposition_details
    suid = staff_id.to_a
    exists = Staff.find(:all, :select => "id").map(&:id)
    checker = suid & exists
    
    if staff_id == nil
      ""
    elsif checker == []
      "Staff No Longer Exists"
    else
      staffthatattend.position_for_staff
    end
  end
   
end
