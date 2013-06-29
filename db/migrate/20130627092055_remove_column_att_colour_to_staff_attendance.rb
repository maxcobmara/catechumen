class RemoveColumnAttColourToStaffAttendance < ActiveRecord::Migration
  def self.up
    remove_column :staff_attendances, :att_colour
  end
  
  def self.down
    add_column :staff_attendances, :att_colour, :integer
  end
end
