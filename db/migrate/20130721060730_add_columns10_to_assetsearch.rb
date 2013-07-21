class AddColumns10ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :disposalreport2, :string
  end

  def self.down
    remove_column :assetsearches, :disposalreport2
  end
end
