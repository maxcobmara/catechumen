class Attendance < ActiveRecord::Base
  
 belongs_to :staffthatattend,             :class_name => 'Staff', :foreign_key => 'staff_id'
 belongs_to :approvedby, :class_name => 'Staff', :foreign_key => 'approve_id'
  
 validates_presence_of :staff_id, :attdate, :time_in
 
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

  
   #def self.find_main
     #Staff.find(:all, :condition => ['staff_id IS NULL'])
   #end
   
   
end
