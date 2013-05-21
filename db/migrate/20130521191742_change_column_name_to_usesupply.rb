class ChangeColumnNameToUsesupply < ActiveRecord::Migration
  def self.up
    add_column :usesupplies, :supplier_id, :integer
    remove_column :usesupplies, :supplies_id
  end
  def self.down
    remove_column :usesupplies, :supplier_id
    add_column :usesupplies, :supplies_id, :integer
  end
end
