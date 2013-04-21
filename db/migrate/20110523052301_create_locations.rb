class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string  :code
      t.string  :name
      t.integer :lclass
      t.integer :type
      t.boolean :allocatable
      t.boolean :occupied
      t.integer :staffadmin_id
      t.string  :ancestry
      t.index   :ancestry

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
