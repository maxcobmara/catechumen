class RemoveSchemesForUpdate < ActiveRecord::Migration
  def self.up
    drop_table :staffgrades
    drop_table :staffserveschemes
    drop_table :staffclassifications
  end

  def self.down
  end
end
