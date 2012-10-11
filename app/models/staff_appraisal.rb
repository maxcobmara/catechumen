class StaffAppraisal < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_to_nil_where_false
  
  belongs_to :appraised,      :class_name => 'Staff', :foreign_key => 'staff_id'
  belongs_to :eval1_officer,  :class_name => 'Staff', :foreign_key => 'evaluation1_by'
  
  has_many :evactivities, :foreign_key => 'appraisal_id', :dependent => :destroy
  accepts_nested_attributes_for :evactivities, :reject_if => lambda { |a| a[:evactivity].blank? }
  
  #before logic
  def set_to_nil_where_false
    if submit_for_evaluation1 == false
      self.submit_for_appraisal1_on	= nil
    end
    
    if submit_for_evaluation2 == false
      self.submit_for_evaluation2_on	= nil
    end
  end
  
  
  
  
  #logic to set editable
  def editable_page
    if submit_for_evaluation1 == false && staff_id == User.current_user.staff_id
      "edit"
    elsif submit_for_evaluation1 == true && evaluation1_by == User.current_user.staff_id
      "edit"
    elsif submit_for_evaluation2 == true && evaluation2_by == User.current_user.staff_id
      "edit"
    end
  end
  
  
end
