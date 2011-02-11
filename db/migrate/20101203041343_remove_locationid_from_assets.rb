class RemoveLocationidFromAssets < ActiveRecord::Migration
  def self.up
    remove_column :assets, :location_id
  end

  def self.down
    add_column :assets, :location_id, :integer
  end
end
