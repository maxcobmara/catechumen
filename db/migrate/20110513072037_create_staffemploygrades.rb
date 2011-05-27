class CreateStaffemploygrades < ActiveRecord::Migration
  def self.up
    create_table :staffemploygrades do |t|
      t.integer :staffemployscheme_id
      t.integer :employgrade_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :staffemploygrades
  end
end
