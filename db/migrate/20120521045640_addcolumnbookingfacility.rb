class Addcolumnbookingfacility < ActiveRecord::Migration
  def self.up
  add_column :bookingfacilities, :facility_officer, :integer
  add_column :bookingfacilities, :approver2, :boolean
  add_column :bookingfacilities, :remark_officer, :string
  add_column :bookingfacilities, :date_approver2, :date
  end

  def self.down
   remove_column :bookingfacilities, :facility_officer
   remove_column :bookingfacilities, :approver2
   remove_column :bookingfacilities, :remark_officer
   remove_column :bookingfacilities, :date_approver2
  end
end
