class Bookingfacility < ActiveRecord::Base
  belongs_to :staffbooked, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :reservefac, :class_name => 'Location', :foreign_key => 'location_id'
  belongs_to :approvebooked, :class_name => 'Staff', :foreign_key => 'approver_id'
  
  belongs_to :officer, :class_name => 'Staff', :foreign_key => 'facility_officer'
  
  validates_presence_of     :start_date, :end_date
  
 
end
