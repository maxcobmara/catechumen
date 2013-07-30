class AddColumnsextraToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :loanedasset, :integer
  end

  def self.down
    remove_column :assetsearches, :loanedasset
  end
end
