class AddColumns6ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :maintname, :string
    add_column :assetsearches, :maintcode, :string
  end

  def self.down
    remove_column :assetsearches, :maintcode
    remove_column :assetsearches, :maintname
  end
end
