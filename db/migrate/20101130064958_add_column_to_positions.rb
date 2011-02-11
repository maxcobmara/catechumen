class AddColumnToPositions < ActiveRecord::Migration
  def self.up
    add_column :positions, :staffgrade_id, :integer
  end

  def self.down
    remove_column :positions, :staffgrade_id
  end
end
