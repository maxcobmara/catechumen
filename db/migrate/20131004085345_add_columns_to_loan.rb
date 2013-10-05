class AddColumnsToLoan < ActiveRecord::Migration
  def self.up
    add_column :loans, :firstdate, :date
    add_column :loans, :enddate, :date
    add_column :loans, :enddeduction, :decimal
  end

  def self.down
    remove_column :loans, :enddeduction
    remove_column :loans, :enddate
    remove_column :loans, :firstdate
  end
end
