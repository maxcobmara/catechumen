class AssetLoan < ActiveRecord::Base
  # befores, relationships, validations, before logic, validation logic, 
  #controller searches, variables, lists, relationship checking
  before_save :set_staff_when_blank, :set_loaned_by
  
  belongs_to :asset
  belongs_to :staff
  belongs_to :owner, :class_name => 'Staff', :foreign_key => 'loaned_by'
  belongs_to :hod,   :class_name => 'Staff', :foreign_key => 'loan_officer'
  
  
  def self.borrowings
    find(:all, :conditions => ['is_returned !=? OR is_approved IS NOT ?', true, nil])
  end
  
  
  def set_staff_when_blank
    if staff_id.blank?
      self.staff_id = User.current_user.staff_id
    end
  end
  
  def set_loaned_by
    if loaned_by.blank?
      self.loaned_by = asset.assignedto_id
    end
  end
  
  def loaner
     if staff_id.blank?
       User.current_user.staff.staff_name_with_position
     else
       staff.staff_name_with_position
     end
  end
  
  def status
    if is_approved == true
      "tick.png"
    elsif is_approved == false
      "cross.png"
    else
      "new.png"
    end
  end
  
end
