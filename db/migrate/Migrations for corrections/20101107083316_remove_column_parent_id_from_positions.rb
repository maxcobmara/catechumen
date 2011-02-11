class RemoveColumnParentIdFromPositions < ActiveRecord::Migration
  def self.up
    remove_column :positions, :parent_id
  end

  def self.down
    add_column :positions, :parent_id, :integer
  end
end
