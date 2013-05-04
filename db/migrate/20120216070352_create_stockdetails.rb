class CreateStockdetails < ActiveRecord::Migration
  def self.up
    create_table :stockdetails do |t|
      t.integer :stock_id
      t.integer :supplier_id
      t.integer :quantity_order
      t.integer :quantity_approve

      t.timestamps
    end
  end

  def self.down
    drop_table :stockdetails
  end
end
