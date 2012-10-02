class AddColumnToPosition < ActiveRecord::Migration
  def self.up
    add_column :positions, :ancestry_depth, :integer, :default => 0
  end

  def self.down
    remove_column :positions, :ancestry_depth
  end
end
