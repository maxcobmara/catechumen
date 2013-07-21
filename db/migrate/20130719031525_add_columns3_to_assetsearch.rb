class AddColumns3ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :location, :integer
  end

  def self.down
    remove_column :assetsearches, :location
  end
end
