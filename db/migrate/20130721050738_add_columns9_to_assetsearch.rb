class AddColumns9ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :disposalcert, :integer
  end

  def self.down
    remove_column :assetsearches, :disposalcert
  end
end
