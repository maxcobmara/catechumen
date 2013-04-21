class AddMarkAsLostToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :mark_as_lost, :boolean
  end

  def self.down
    remove_column :assets, :mark_as_lost
  end
end
