class Addcolumntobookingvehicle < ActiveRecord::Migration
  def self.up
	add_column :bookingvehicles, :endorse_name, :integer
	add_column :bookingvehicles, :endorse_date, :date
	add_column :bookingvehicles, :endorsed, :integer
  end

  def self.down
	remove_column :bookingvehicles, :endorse_name
	remove_column :bookingvehicles, :endorse_date
	remove_column :bookingvehicles, :endorsed
  end
end
