class CreateOfficecars < ActiveRecord::Migration
  def self.up
    create_table :officecars do |t|
	  t.string :car_regno
	  t.string :car_name
	  t.integer :car_type
	  t.integer :power_car
	  t.string :modelcar
	  t.integer :class_car
      t.timestamps
    end
  end

  def self.down
    drop_table :officecars
  end
end
