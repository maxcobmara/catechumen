class Trainingrequest < ActiveRecord::Base
  belongs_to :applicant, :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :approver,  :class_name => 'Staff', :foreign_key => 'approvedby_id'
  belongs_to :staffcourse
  
  validates_presence_of :staff_id, :staffcourse_id
end
