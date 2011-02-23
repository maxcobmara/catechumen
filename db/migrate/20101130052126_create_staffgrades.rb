class CreateStaffgrades < ActiveRecord::Migration
  def self.up
    create_table :staffgrades do |t|
      t.string :sgname
      t.string :sgshortname
      t.integer :sglevel

      t.timestamps
    end
  end

  def self.down
    drop_table :staffgrades
  end
end
