class AddColumns8ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :disposalreport, :string
  end

  def self.down
    remove_column :assetsearches, :disposalreport
  end
end
