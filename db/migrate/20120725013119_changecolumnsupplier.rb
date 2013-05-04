class Changecolumnsupplier < ActiveRecord::Migration
  def self.up
    change_column :addsuppliers,  :quantity,    :integer
    change_column :usesupplies,   :quantity,    :integer
    change_column :suppliers,     :maxquantity,    :integer
    change_column :suppliers,     :minquantity,    :integer
  end

  def self.down
    change_column :addsuppliers,   :quantity,    :integer
    change_column :usesupplies,   :quantity,    :integer
    change_column :suppliers,     :maxquantity,    :integer
    change_column :suppliers,     :minquantity,    :integer
  end
end
