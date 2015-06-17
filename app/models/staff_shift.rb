class StaffShift < ActiveRecord::Base
  #has_and_belongs_to_many :staffs
  has_many :staffs
  has_many :shift_histories
  
  def start_end
    "#{start_at.strftime('%l:%M %p')} - #{end_at.strftime('%l:%M %p')}" 
  end
end
