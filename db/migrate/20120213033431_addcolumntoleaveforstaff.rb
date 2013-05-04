class Addcolumntoleaveforstaff < ActiveRecord::Migration
  def self.up
    add_column :leaveforstaffs, :address_on_leave, :string
    add_column :leaveforstaffs, :phone_on_leave, :string
    add_column :leaveforstaffs, :leave_before_app, :string
    add_column :leaveforstaffs, :adminofficer1_id, :integer
    add_column :leaveforstaffs, :date_before_app, :date
    add_column :leaveforstaffs, :proceed, :boolean
    add_column :leaveforstaffs, :leave_after_app, :string
    add_column :leaveforstaffs, :adminofficer2_id, :integer
    add_column :leaveforstaffs, :date_after_leave, :boolean
  end

  def self.down
    remove_column :leaveforstaffs, :address_on_leave, :string
    remove_column :leaveforstaffs, :phone_on_leave, :string
    remove_column :leaveforstaffs, :leave_before_app, :string
    remove_column :leaveforstaffs, :adminofficer1_id, :integer
    remove_column :leaveforstaffs, :date_before_app, :date
    remove_column :leaveforstaffs, :proceed, :boolean
    remove_column :leaveforstaffs, :leave_after_app, :string
    remove_column :leaveforstaffs, :adminofficer2_id, :integer
    remove_column :leaveforstaffs, :date_after_leave, :boolean
  end
end
