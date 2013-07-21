class AddColumns4ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :defect_asset, :integer
    add_column :assetsearches, :defect_reporter, :integer
    add_column :assetsearches, :defect_processor, :integer
  end

  def self.down
    remove_column :assetsearches, :defect_processor
    remove_column :assetsearches, :defect_reporter
    remove_column :assetsearches, :defect_asset
  end
end
