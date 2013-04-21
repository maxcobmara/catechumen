class CreateStaffclassifications < ActiveRecord::Migration
  def self.up
    create_table :staffclassifications do |t|
      t.integer :staffgrade_id
      t.integer :staffservescheme_id

      t.timestamps
    end
  end

  def self.down
    drop_table :staffclassifications
  end
end
