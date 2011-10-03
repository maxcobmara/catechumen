class Message < ActiveRecord::Base
  belongs_to  :staff, :foreign_key => 'to_id'
  belongs_to  :from, :class_name => 'User', :foreign_key => 'from_id'
  
  before_save :varmyass
  
  def varmyass
    self.from_id	= current_user.id
  end
  
  def to_name
    staff.name if staff
  end
  
  def to_name=(name)
    self.staff = Staff.find_by_name(name) unless name.blank?
  end
end
