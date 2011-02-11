class AddStaffgradeToStaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :staffgrade_id, :integer
  end

  def self.down
    remove_column :staffs, :staffgrade_id
  end
end
