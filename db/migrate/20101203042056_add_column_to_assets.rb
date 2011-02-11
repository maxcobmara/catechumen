class AddColumnToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :location_id, :integer
  end

  def self.down
    remove_column :assets, :location_id
  end
end
