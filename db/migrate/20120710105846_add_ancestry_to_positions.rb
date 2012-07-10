class AddAncestryToPositions < ActiveRecord::Migration
  def self.up
    add_column :positions, :ancestry, :string
    add_index :positions, :ancestry
  end

  def self.down
    remove_index :positions, :ancestry
    remove_column :positions, :ancestry
  end
end
