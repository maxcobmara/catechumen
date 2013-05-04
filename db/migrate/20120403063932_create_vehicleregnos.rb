class CreateVehicleregnos < ActiveRecord::Migration
  def self.up
    create_table :vehicleregnos do |t|
      t.integer :staff_id
      t.string :reg_no
      t.string :vehicle_type
      t.timestamps
    end
  end

  def self.down
    drop_table :vehicleregnos
  end
end
