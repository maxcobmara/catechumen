class AddColumnToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :thumb_id, :integer
    add_column :staffs, :time_group_id, :integer
  end

  def self.down
    remove_column :staffs, :time_group_id
    remove_column :staffs, :thumb_id
  end
end
