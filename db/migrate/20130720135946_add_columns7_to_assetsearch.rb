class AddColumns7ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :disposal, :integer
    add_column :assetsearches, :disposaltype, :string
    add_column :assetsearches, :discardoption, :string
  end

  def self.down
    remove_column :assetsearches, :discardoption
    remove_column :assetsearches, :disposaltype
    remove_column :assetsearches, :disposal
  end
end
