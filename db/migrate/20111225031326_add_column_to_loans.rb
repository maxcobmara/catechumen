class AddColumnToLoans < ActiveRecord::Migration
  def self.up
    add_column :loans, :amount, :decimal
  end

  def self.down
    remove_column :loans, :amount
  end
end
