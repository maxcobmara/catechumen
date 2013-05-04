class Addcolumnusesupply < ActiveRecord::Migration
  def self.up
	add_column :usesupplies, :stock_detail, :integer
	add_column :suppliers, :stationery_id, :integer
  end

  def self.down
  remove_column :usesupplies, :stock_detail
  remove_column :suppliers, :stationery_id, :integer
  end
end
