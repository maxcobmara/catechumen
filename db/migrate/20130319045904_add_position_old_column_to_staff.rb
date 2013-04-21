class AddPositionOldColumnToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :position_old, :integer
  end

  def self.down
    remove_column :staffs, :position_old
  end
end
