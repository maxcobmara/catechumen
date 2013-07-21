class AddColumnToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :purchaseprice, :decimal
    add_column :assetsearches, :purchasedate, :date
    add_column :assetsearches, :startdate, :date
    add_column :assetsearches, :enddate, :date
  end

  def self.down
    remove_column :assetsearches, :enddate
    remove_column :assetsearches, :startdate
    remove_column :assetsearches, :purchasedate
    remove_column :assetsearches, :purchaseprice
  end
end
