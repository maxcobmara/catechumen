class StaffShift < ActiveRecord::Base
  has_and_belongs_to_many :staffs
  
  def start_end
    "#{start_at.strftime('%l:%M %p')} - #{end_at.strftime('%l:%M %p')}" 
  end
end
