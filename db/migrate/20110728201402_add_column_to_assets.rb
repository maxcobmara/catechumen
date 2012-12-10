class AddColumnToAssets < ActiveRecord::Migration
  def self.up
    #add_column :assets, :mark_disposal, :boolean
    add_column :assets, :mark_as_maintainable, :boolean
  end

  def self.down
    #remove_column :assets, :mark_disposal
    #remove_column :assets, :mark_as_maintainable
  end
end
