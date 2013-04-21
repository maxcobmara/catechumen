class CreateStaffgrades < ActiveRecord::Migration
  def self.up
    create_table :staffgrades do |t|
      t.string :classification_id
      t.string :group_id
      t.string :grade
      t.string :level

      t.timestamps
    end
  end

  def self.down
    drop_table :staffgrades
  end
end
