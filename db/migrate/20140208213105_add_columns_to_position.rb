class AddColumnsToPosition < ActiveRecord::Migration
  def self.up
    add_column :positions, :postinfo_id, :integer
    add_column :positions, :status, :integer
  end

  def self.down
    remove_column :positions, :status
    remove_column :positions, :postinfo_id
  end
end
