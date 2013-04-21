class AddColumnToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :is_disposed,     :boolean
    add_column :assets, :is_maintainable, :boolean
  end

  def self.down
    remove_column :assets, :is_maintainable
    remove_column :assets, :is_disposed
  end
end
