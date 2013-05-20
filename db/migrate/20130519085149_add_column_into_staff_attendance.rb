class AddColumnIntoStaffAttendance < ActiveRecord::Migration
  def self.up
    add_column :staff_attendances, :status, :integer    
  end

  def self.down
    remove_column :staff_attendances, :status
  end
end
