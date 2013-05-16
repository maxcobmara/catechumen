class AddShiftToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :staff_shift_id, :integer
  end

  def self.down
    remove_column :staffs, :staff_shift_id
  end
end
