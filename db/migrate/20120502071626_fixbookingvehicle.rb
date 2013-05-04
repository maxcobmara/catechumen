class Fixbookingvehicle < ActiveRecord::Migration
  def self.up
	add_column :bookingvehicles, :remark_approver, :string
	add_column :bookingvehicles, :driver_name, :integer
  end

  def self.down
	remove_column :bookingvehicles, :remark_approver
	remove_column :bookingvehicles, :driver_name
  end
end
