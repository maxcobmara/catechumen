class AddColumnAttColourToStaffAttendance < ActiveRecord::Migration
  def self.up
    add_column :staff_attendances, :att_colour, :integer
  end

  def self.down
    remove_column :staff_attendances, :att_colour
  end
end
