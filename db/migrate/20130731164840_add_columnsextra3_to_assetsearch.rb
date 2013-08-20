class AddColumnsextra3ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :purchaseprice2, :decimal
    add_column :assetsearches, :purchasedate2, :date
  end

  def self.down
    remove_column :assetsearches, :purchasedate2
    remove_column :assetsearches, :purchaseprice2
  end
end
