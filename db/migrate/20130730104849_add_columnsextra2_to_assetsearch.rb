class AddColumnsextra2ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :alldefectasset, :integer
  end

  def self.down
    remove_column :assetsearches, :alldefectasset
  end
end
