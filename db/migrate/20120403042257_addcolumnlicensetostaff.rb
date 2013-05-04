class Addcolumnlicensetostaff < ActiveRecord::Migration
  def self.up
    add_column :staffs, :license_A, :boolean
    add_column :staffs, :license_B, :boolean
    add_column :staffs, :license_C, :boolean
    add_column :staffs, :license_D, :boolean
    add_column :staffs, :license_E, :boolean
    add_column :staffs, :license_F, :boolean
  end

  def self.down
    remove_column :staffs, :license_A, :boolean
    remove_column :staffs, :license_B, :boolean
    remove_column :staffs, :license_C, :boolean
    remove_column :staffs, :license_D, :boolean
    remove_column :staffs, :license_E, :boolean
    remove_column :staffs, :license_F, :boolean
  end
end
