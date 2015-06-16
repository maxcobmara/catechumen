class ShiftHistory < ActiveRecord::Base
  belongs_to :staff, :foreign_key => 'staff_id'
  belongs_to :staff_shift, :foreign_key => 'shift_id' 
  validates_presence_of :deactivate_date
end