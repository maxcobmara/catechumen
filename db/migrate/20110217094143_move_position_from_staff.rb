class MovePositionFromStaff < ActiveRecord::Migration
  def self.up
    add_column :positions, :staff_id, :integer
    rename_column :staffs, :position_id, :position_old
  end

  def self.down
    remove_column :positions, :staff_id, :integer
    rename_column :staffs, :position_old, :position_id
  end
end
