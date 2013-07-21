class AddColumns11ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :loss_start, :integer
    add_column :assetsearches, :loss_end, :integer
    add_column :assetsearches, :loss_cert, :integer
  end

  def self.down
    remove_column :assetsearches, :loss_cert
    remove_column :assetsearches, :loss_end
    remove_column :assetsearches, :loss_start
  end
end
