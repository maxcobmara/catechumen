class AddColumn2IntoStaffAttendance < ActiveRecord::Migration
  def self.up
    add_column :staff_attendances, :review, :string
  end

  def self.down
    remove_column :staff_attendances, :review
  end
end
