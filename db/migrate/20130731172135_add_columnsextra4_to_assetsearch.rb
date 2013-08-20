class AddColumnsextra4ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :receiveddate, :date
    add_column :assetsearches, :receiveddate2, :date
  end

  def self.down
    remove_column :assetsearches, :receiveddate2
    remove_column :assetsearches, :receiveddate
  end
end
