class Attendance < ActiveRecord::Base
  
 belongs_to :staffthatattend,             :class_name => 'Staff', :foreign_key => 'staff_id'
 belongs_to :staffthatapprovesattendance, :class_name => 'Staff', :foreign_key => 'approve_id'
  
 validates_presence_of :staff_id
  
   #def self.find_main
     #Staff.find(:all, :condition => ['staff_id IS NULL'])
   #end
   
   
end
