class CreatePassengers < ActiveRecord::Migration
  def self.up
    create_table :passengers do |t|
	  t.integer :staff_id
	  t.integer :bookingvehicle_id
      t.timestamps
    end
  end

  def self.down
    drop_table :passengers
  end
end
