class AddColumnParentIdToPositions < ActiveRecord::Migration
  def self.up
    add_column :positions, :parent_id, :integer
  end

  def self.down
    remove_column :positions, :parent_id
  end
end
