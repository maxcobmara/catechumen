class AddColumnToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :mark_disposal, :boolean
  end

  def self.down
    remove_column :assets, :mark_disposal
  end
end
