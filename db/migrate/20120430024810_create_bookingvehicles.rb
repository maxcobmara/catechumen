class CreateBookingvehicles < ActiveRecord::Migration
  def self.up
    create_table :bookingvehicles do |t|
	t.integer :applicant
	t.date :used_date
	t.date :returned_date
	t.string :location
	t.date :apply_date
	t.integer :approved
	t.integer :approver_name
	t.date :approved_date
	t.string :remark
	t.integer :vehicle_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bookingvehicles
  end
end
