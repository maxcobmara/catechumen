class AddColumnsextra5ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :loandate2, :date
    add_column :assetsearches, :returndate2, :date
    add_column :assetsearches, :expectedreturndate, :date
    add_column :assetsearches, :expectedreturndate2, :date
  end

  def self.down
    remove_column :assetsearches, :expectedreturndate2
    remove_column :assetsearches, :expectedreturndate
    remove_column :assetsearches, :returndate2
    remove_column :assetsearches, :loandate2
  end
end
