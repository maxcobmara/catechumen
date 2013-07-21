class AddColumns2ToAssetsearch < ActiveRecord::Migration
  def self.up
    add_column :assetsearches, :category, :integer
    add_column :assetsearches, :assignedto, :integer
    add_column :assetsearches, :bookable, :boolean
    add_column :assetsearches, :loandate, :date
    add_column :assetsearches, :returndate, :date
  end

  def self.down
    remove_column :assetsearches, :returndate
    remove_column :assetsearches, :loandate
    remove_column :assetsearches, :bookable
    remove_column :assetsearches, :assignedto
    remove_column :assetsearches, :category
  end
end
